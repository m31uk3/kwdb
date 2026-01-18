#!/bin/bash
# Fetch raw wiki content with retry logic
# Bash 3.2 compatible

WIKI_BASE="http://wiki.ljackson.us"
MAX_RETRIES=3
RETRY_DELAYS="1 5 15"

# Convert title to URL format
url_encode_title() {
    local title="$1"
    echo "$title" | sed 's/ /_/g; s/(/%28/g; s/)/%29/g'
}

# Fetch single article with retries
fetch_article() {
    local title="$1"
    local url_title
    url_title=$(url_encode_title "$title")
    local url="${WIKI_BASE}/index.php?title=${url_title}&action=raw"

    local i=0
    local delay
    for delay in $RETRY_DELAYS; do
        local content
        local http_code

        # Fetch with timeout
        content=$(curl -s --max-time 30 -w "\n%{http_code}" "$url" 2>/dev/null)
        http_code=$(echo "$content" | tail -n1)
        content=$(echo "$content" | sed '$d')

        if [ "$http_code" = "200" ] && [ -n "$content" ]; then
            echo "$content"
            return 0
        fi

        i=$((i + 1))
        if [ $i -lt $MAX_RETRIES ]; then
            sleep "$delay"
        fi
    done

    echo "ERROR: Failed to fetch '$title' after $MAX_RETRIES attempts (HTTP $http_code)" >&2
    return 1
}

# Fetch and save to temp file (for large articles)
fetch_to_file() {
    local title="$1"
    local output="$2"
    local content

    if content=$(fetch_article "$title"); then
        echo "$content" > "$output"
        return 0
    fi
    return 1
}

# Check if wiki is accessible
check_wiki_accessible() {
    local http_code
    http_code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "${WIKI_BASE}/Main_Page" 2>/dev/null)
    if [ "$http_code" = "200" ]; then
        return 0
    else
        echo "Wiki not accessible (HTTP $http_code)" >&2
        return 1
    fi
}
