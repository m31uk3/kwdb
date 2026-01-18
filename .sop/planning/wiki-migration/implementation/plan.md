# Wiki Migration - Implementation Plan

**Version:** 1.0
**Date:** 2026-01-18
**Status:** COMPLETE

---

## Progress Checklist

- [x] **Step 1:** Create project structure and data files
- [x] **Step 2:** Implement fetch engine
- [x] **Step 3:** Implement wiki-to-markdown converter
- [x] **Step 4:** Implement link resolver
- [x] **Step 5:** Implement merger for article clusters
- [x] **Step 6:** Implement state tracker
- [x] **Step 7:** Implement batch controller
- [x] **Step 8:** Implement validation system
- [x] **Step 9:** Execute migration (all batches)
- [x] **Step 10:** Final validation and cleanup

## Migration Results

- **Total files created:** 143 markdown files
- **Articles merged:** 24 (into 8 cluster documents)
- **Failures:** 0
- **Total content:** 22,427 lines / 113,876 words

### Files by Category
- shell: 13
- filesystem: 9
- networking: 10
- security: 7
- voip: 4
- windows: 24
- web: 6
- database: 2
- media: 10
- graphics: 12
- config: 13
- misc: 33

---

## Step 1: Create Project Structure and Data Files

### Objective
Set up directory structure and generate data files from research documents.

### Implementation

1. Create directory structure:
```bash
mkdir -p .sop/planning/wiki-migration/scripts/lib
mkdir -p .sop/planning/wiki-migration/scripts/data
mkdir -p .sop/planning/wiki-migration/state
mkdir -p wiki
```

2. Create `scripts/data/article-list.txt` - one article per line from wiki

3. Create `scripts/data/category-map.sh` - associative array mapping article → category:
```bash
declare -A CATEGORY_MAP=(
    ["Awk Command"]="shell"
    ["SSH"]="security"
    # ... all 152 articles
)
```

4. Create `scripts/data/merge-clusters.sh` - merge cluster definitions:
```bash
declare -A MERGE_CLUSTERS=(
    ["voip--asterisk"]="Asterisk Asterisk_Dialplan ..."
    # ... all 8 clusters
)
```

5. Create `scripts/data/link-map.sh` - link resolution map:
```bash
declare -A LINK_MAP=(
    ["SSH"]="security--ssh.md"
    ["Asterisk Dialplan"]="voip--asterisk.md#dialplan"
    # ... all articles
)
```

### Test
```bash
# Verify files exist and are valid bash
source scripts/data/category-map.sh && echo "Articles: ${#CATEGORY_MAP[@]}"
source scripts/data/merge-clusters.sh && echo "Clusters: ${#MERGE_CLUSTERS[@]}"
```

### Demo
Run `ls -la .sop/planning/wiki-migration/scripts/` showing complete structure. Source data files and echo counts.

---

## Step 2: Implement Fetch Engine

### Objective
Create reliable HTTP fetcher for wiki raw content with retry logic.

### Implementation

Create `scripts/lib/fetch.sh`:

```bash
#!/bin/bash
# Fetch raw wiki content with retry logic

WIKI_BASE="http://wiki.ljackson.us"
MAX_RETRIES=3
RETRY_DELAYS=(1 5 15)

# Convert title to URL format
url_encode_title() {
    echo "$1" | sed 's/ /_/g; s/(/%28/g; s/)/%29/g'
}

# Fetch single article with retries
fetch_article() {
    local title="$1"
    local url_title=$(url_encode_title "$title")
    local url="${WIKI_BASE}/index.php?title=${url_title}&action=raw"

    for ((i=0; i<MAX_RETRIES; i++)); do
        local content
        local http_code

        content=$(curl -s -w "\n%{http_code}" "$url" 2>/dev/null)
        http_code=$(echo "$content" | tail -n1)
        content=$(echo "$content" | sed '$d')

        if [[ "$http_code" == "200" && -n "$content" ]]; then
            echo "$content"
            return 0
        fi

        [[ $i -lt $((MAX_RETRIES-1)) ]] && sleep "${RETRY_DELAYS[$i]}"
    done

    echo "ERROR: Failed to fetch '$title' after $MAX_RETRIES attempts" >&2
    return 1
}

# Fetch and save to temp file (for large articles)
fetch_to_file() {
    local title="$1"
    local output="$2"

    if content=$(fetch_article "$title"); then
        echo "$content" > "$output"
        return 0
    fi
    return 1
}
```

### Test
```bash
source scripts/lib/fetch.sh
fetch_article "Awk Command" | head -20
fetch_article "SSH" | wc -l
fetch_article "Nonexistent_Page_12345"  # Should fail gracefully
```

### Demo
Fetch 3 different articles (small, medium, large) and display first 10 lines of each.

---

## Step 3: Implement Wiki-to-Markdown Converter

### Objective
Transform wiki markup to clean markdown format.

### Implementation

Create `scripts/lib/convert.sh`:

```bash
#!/bin/bash
# Convert wiki markup to markdown

convert_wiki_to_markdown() {
    local title="$1"

    # Read from stdin
    local content
    content=$(cat)

    # Add title as H1
    echo "# $title"
    echo ""

    # Process content
    echo "$content" | awk '
    BEGIN { in_pre = 0; in_code = 0 }

    # Handle <pre> blocks
    /<pre>/ { in_pre = 1; print "```"; next }
    /<\/pre>/ { in_pre = 0; print "```"; next }
    in_pre { print; next }

    # Handle indented code blocks (lines starting with space)
    /^[ \t]+[^ \t]/ {
        if (!in_code) { print "```"; in_code = 1 }
        sub(/^[ \t]/, "")
        print
        next
    }
    in_code && !/^[ \t]/ { print "```"; in_code = 0 }

    # Headers
    /^======.*======$/ { gsub(/^======\s*|\s*======$/, ""); print "###### " $0; next }
    /^=====.*=====$/ { gsub(/^=====\s*|\s*=====$/, ""); print "##### " $0; next }
    /^====.*====$/ { gsub(/^====\s*|\s*====$/, ""); print "#### " $0; next }
    /^===.*===$/ { gsub(/^===\s*|\s*===$/, ""); print "### " $0; next }
    /^==.*==$/ { gsub(/^==\s*|\s*==$/, ""); print "## " $0; next }

    # Bold and italic
    { gsub(/\047\047\047([^\047]+)\047\047\047/, "**\\1**") }  # '\'''\'''\'' -> **
    { gsub(/\047\047([^\047]+)\047\047/, "*\\1*") }            # '\'''\'' -> *

    # Lists
    /^\*+ / { sub(/^\*+/, "-"); print; next }
    /^#+ / { sub(/^#+/, "1."); print; next }

    # External links [url text] -> [text](url)
    { gsub(/\[([^ \]]+) ([^\]]+)\]/, "[\\2](\\1)") }

    # Remove category tags (capture for validation)
    /^\[\[Category:/ { next }

    # Horizontal rules
    /^----/ { print "---"; next }

    # Pass through everything else
    { print }

    END { if (in_code) print "```" }
    '
}

# Add footer
add_footer() {
    echo ""
    echo "---"
    echo ""
    echo "*Migrated from wiki.ljackson.us*"
}
```

### Test
```bash
source scripts/lib/fetch.sh
source scripts/lib/convert.sh

# Test conversion
fetch_article "SSH" | convert_wiki_to_markdown "SSH"

# Test code block handling
fetch_article "Awk Command" | convert_wiki_to_markdown "Awk Command" | head -50
```

### Demo
Convert "Grep Command" article and display the result, showing proper header conversion, code blocks, and formatting.

---

## Step 4: Implement Link Resolver

### Objective
Convert wiki internal links to markdown relative links.

### Implementation

Create `scripts/lib/links.sh`:

```bash
#!/bin/bash
# Resolve wiki links to markdown links

source "$(dirname "${BASH_SOURCE[0]}")/../data/link-map.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../data/category-map.sh"

# Generate target filename from article title
get_target_filename() {
    local title="$1"
    local category="${CATEGORY_MAP[$title]}"

    if [[ -z "$category" ]]; then
        echo "misc--$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g; s/[^a-z0-9-]//g').md"
    else
        echo "${category}--$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g; s/[^a-z0-9-]//g').md"
    fi
}

# Resolve links in content
resolve_links() {
    local content
    content=$(cat)

    # Process [[Link]] and [[Link|Text]] patterns
    echo "$content" | sed -E '
        # [[Link|Text]] -> [Text](target.md)
        s/\[\[([^]|]+)\|([^]]+)\]\]/[[\2||RESOLVE||\1]]/g

        # [[Link]] -> [Link](target.md)
        s/\[\[([^]|]+)\]\]/[[\1||RESOLVE||\1]]/g
    ' | while IFS= read -r line; do
        # Resolve each RESOLVE marker
        while [[ "$line" =~ \[\[([^|]+)\|\|RESOLVE\|\|([^\]]+)\]\] ]]; do
            local display="${BASH_REMATCH[1]}"
            local target="${BASH_REMATCH[2]}"
            local resolved="${LINK_MAP[$target]}"

            if [[ -z "$resolved" ]]; then
                resolved=$(get_target_filename "$target")
                echo "WARNING: Unresolved link '$target' -> $resolved" >&2
            fi

            line="${line/\[\[$display||RESOLVE||$target\]\]/[$display]($resolved)}"
        done
        echo "$line"
    done
}

# Find all unresolved links in content
find_unresolved_links() {
    grep -oE '\[\[[^]]+\]\]' | sort -u
}
```

### Test
```bash
source scripts/lib/links.sh

# Test single link resolution
echo "See [[SSH]] for details" | resolve_links
echo "Check the [[Awk Command|awk reference]]" | resolve_links

# Test with real content
source scripts/lib/fetch.sh
fetch_article "Asterisk" | resolve_links 2>&1 | head -30
```

### Demo
Show link resolution on Asterisk article (has many internal links), display resolved output and any warnings.

---

## Step 5: Implement Merger for Article Clusters

### Objective
Consolidate related articles into single comprehensive documents.

### Implementation

Create `scripts/lib/merge.sh`:

```bash
#!/bin/bash
# Merge related wiki articles into single document

source "$(dirname "${BASH_SOURCE[0]}")/fetch.sh"
source "$(dirname "${BASH_SOURCE[0]}")/convert.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../data/merge-clusters.sh"

# Merge a cluster of articles
merge_cluster() {
    local cluster_id="$1"  # e.g., "voip--asterisk"
    local articles="${MERGE_CLUSTERS[$cluster_id]}"

    if [[ -z "$articles" ]]; then
        echo "ERROR: Unknown cluster '$cluster_id'" >&2
        return 1
    fi

    local primary_title=$(echo "$articles" | awk '{print $1}' | tr '_' ' ')
    local sub_articles=$(echo "$articles" | cut -d' ' -f2-)

    # Fetch and convert primary article
    echo "# $primary_title"
    echo ""

    local primary_content
    primary_content=$(fetch_article "$primary_title")

    if [[ -n "$primary_content" ]]; then
        echo "$primary_content" | convert_wiki_to_markdown "" | tail -n +3
    fi

    # Process sub-articles
    for article in $sub_articles; do
        local title=$(echo "$article" | tr '_' ' ')
        local section_name=$(echo "$title" | sed "s/^${primary_title} //")

        echo ""
        echo "---"
        echo ""
        echo "## $section_name"
        echo ""

        local content
        content=$(fetch_article "$title")

        if [[ -n "$content" ]]; then
            # Convert and demote headers (## -> ###, etc.)
            echo "$content" | convert_wiki_to_markdown "" | tail -n +3 | sed '
                s/^###### /####### /
                s/^##### /###### /
                s/^#### /##### /
                s/^### /#### /
                s/^## /### /
            '
        else
            echo "*Content unavailable*"
        fi
    done

    add_footer
}

# Check if article is part of a merge cluster
is_merge_target() {
    local title="$1"
    local url_title=$(echo "$title" | tr ' ' '_')

    for cluster in "${!MERGE_CLUSTERS[@]}"; do
        if [[ " ${MERGE_CLUSTERS[$cluster]} " =~ " $url_title " ]]; then
            # Return cluster ID if this is NOT the primary article
            local primary=$(echo "${MERGE_CLUSTERS[$cluster]}" | awk '{print $1}')
            if [[ "$url_title" != "$primary" ]]; then
                echo "$cluster"
                return 0
            fi
        fi
    done
    return 1
}

# Get cluster ID for primary article
get_cluster_id() {
    local title="$1"
    local url_title=$(echo "$title" | tr ' ' '_')

    for cluster in "${!MERGE_CLUSTERS[@]}"; do
        local primary=$(echo "${MERGE_CLUSTERS[$cluster]}" | awk '{print $1}')
        if [[ "$url_title" == "$primary" ]]; then
            echo "$cluster"
            return 0
        fi
    done
    return 1
}
```

### Test
```bash
source scripts/lib/merge.sh

# Test cluster detection
is_merge_target "Asterisk Dialplan" && echo "Is merge target"
is_merge_target "SSH" && echo "Is merge target" || echo "Not merge target"

# Test small cluster merge
merge_cluster "shell--bash" | head -100
```

### Demo
Merge the Bash cluster (5 articles) and display the resulting structure with section headers.

---

## Step 6: Implement State Tracker

### Objective
Track migration progress for resume capability and reporting.

### Implementation

Create `scripts/lib/state.sh`:

```bash
#!/bin/bash
# Track migration state for resume and reporting

STATE_FILE=".sop/planning/wiki-migration/state/progress.json"

# Initialize state file
init_state() {
    local total_articles="$1"

    mkdir -p "$(dirname "$STATE_FILE")"

    cat > "$STATE_FILE" << EOF
{
    "version": "1.0",
    "started": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "last_updated": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "current_batch": 0,
    "total_batches": 11,
    "total_articles": $total_articles,
    "articles": {},
    "statistics": {
        "completed": 0,
        "failed": 0,
        "skipped": 0,
        "pending": $total_articles
    }
}
EOF
}

# Update article status
update_article_status() {
    local title="$1"
    local status="$2"      # completed, failed, skipped, pending
    local output="$3"      # output file path (optional)
    local error="$4"       # error message (optional)

    local json_title=$(echo "$title" | sed 's/"/\\"/g')
    local entry="{\"status\": \"$status\""
    [[ -n "$output" ]] && entry="$entry, \"output\": \"$output\""
    [[ -n "$error" ]] && entry="$entry, \"error\": \"$error\""
    entry="$entry}"

    # Update using jq
    local tmp=$(mktemp)
    jq --arg title "$json_title" --argjson entry "$entry" \
        '.articles[$title] = $entry | .last_updated = now | todate' \
        "$STATE_FILE" > "$tmp" && mv "$tmp" "$STATE_FILE"

    # Update statistics
    update_statistics
}

# Update statistics from article statuses
update_statistics() {
    local tmp=$(mktemp)
    jq '.statistics = {
        completed: [.articles[] | select(.status == "completed")] | length,
        failed: [.articles[] | select(.status == "failed")] | length,
        skipped: [.articles[] | select(.status == "skipped")] | length,
        pending: (.total_articles - ([.articles[]] | length))
    }' "$STATE_FILE" > "$tmp" && mv "$tmp" "$STATE_FILE"
}

# Set current batch
set_current_batch() {
    local batch="$1"
    local tmp=$(mktemp)
    jq --argjson batch "$batch" '.current_batch = $batch' "$STATE_FILE" > "$tmp" && mv "$tmp" "$STATE_FILE"
}

# Get article status
get_article_status() {
    local title="$1"
    jq -r --arg title "$title" '.articles[$title].status // "pending"' "$STATE_FILE"
}

# Get list of failed articles
get_failed_articles() {
    jq -r '.articles | to_entries[] | select(.value.status == "failed") | .key' "$STATE_FILE"
}

# Get current batch number
get_current_batch() {
    jq -r '.current_batch' "$STATE_FILE"
}

# Print progress summary
print_progress() {
    jq -r '"Progress: \(.statistics.completed)/\(.total_articles) completed, \(.statistics.failed) failed"' "$STATE_FILE"
}
```

### Test
```bash
source scripts/lib/state.sh

# Initialize and test
init_state 152
update_article_status "Awk Command" "completed" "wiki/shell--awk-command.md"
update_article_status "Git" "failed" "" "fetch timeout"
print_progress
get_article_status "Awk Command"
get_failed_articles
```

### Demo
Initialize state, simulate processing 5 articles (3 success, 1 fail, 1 skip), display progress summary and state file.

---

## Step 7: Implement Batch Controller

### Objective
Orchestrate the migration process with batch control and user interaction.

### Implementation

Create `scripts/migrate.sh`:

```bash
#!/bin/bash
# Wiki Migration - Batch Controller
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/fetch.sh"
source "$SCRIPT_DIR/lib/convert.sh"
source "$SCRIPT_DIR/lib/links.sh"
source "$SCRIPT_DIR/lib/merge.sh"
source "$SCRIPT_DIR/lib/state.sh"
source "$SCRIPT_DIR/data/category-map.sh"
source "$SCRIPT_DIR/data/merge-clusters.sh"
source "$SCRIPT_DIR/data/link-map.sh"

OUTPUT_DIR="wiki"
BATCH_SIZE=15
DRY_RUN=false
VALIDATE_ONLY=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --batch) BATCH_NUM="$2"; shift 2 ;;
        --resume) RESUME=true; shift ;;
        --dry-run) DRY_RUN=true; shift ;;
        --validate-only) VALIDATE_ONLY=true; shift ;;
        --retry-failed) RETRY_FAILED=true; shift ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

# Load article list into batches
load_batches() {
    local batch_num=1
    local count=0
    declare -gA BATCHES

    while IFS= read -r article; do
        # Skip if part of merge cluster (not primary)
        if cluster=$(is_merge_target "$article"); then
            continue
        fi

        BATCHES[$batch_num]+="$article"$'\n'
        ((count++))

        if [[ $count -ge $BATCH_SIZE ]]; then
            ((batch_num++))
            count=0
        fi
    done < "$SCRIPT_DIR/data/article-list.txt"
}

# Process single article
process_article() {
    local title="$1"
    local category="${CATEGORY_MAP[$title]:-misc}"
    local filename="${category}--$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g; s/[^a-z0-9-]//g').md"
    local output="$OUTPUT_DIR/$filename"

    echo -n "  Processing: $title -> $filename ... "

    # Check for merge cluster
    if cluster_id=$(get_cluster_id "$title"); then
        echo -n "(merge cluster) "
        if $DRY_RUN; then
            echo "[dry-run]"
            return 0
        fi

        if merge_cluster "$cluster_id" | resolve_links > "$output" 2>/dev/null; then
            update_article_status "$title" "completed" "$output"
            echo "✓"
            return 0
        else
            update_article_status "$title" "failed" "" "merge failed"
            echo "✗"
            return 1
        fi
    fi

    # Standard article
    if $DRY_RUN; then
        echo "[dry-run]"
        return 0
    fi

    local content
    if content=$(fetch_article "$title"); then
        echo "$content" | convert_wiki_to_markdown "$title" | resolve_links > "$output" 2>/dev/null
        add_footer >> "$output"
        update_article_status "$title" "completed" "$output"
        echo "✓"
        return 0
    else
        update_article_status "$title" "failed" "" "fetch failed"
        echo "✗"
        return 1
    fi
}

# Process batch
process_batch() {
    local batch_num="$1"
    local articles="${BATCHES[$batch_num]}"
    local total=$(echo -n "$articles" | grep -c '^' || true)
    local count=0
    local failed=0

    echo "========================================"
    echo "Batch $batch_num: $total articles"
    echo "========================================"
    echo ""

    set_current_batch "$batch_num"

    while IFS= read -r article; do
        [[ -z "$article" ]] && continue
        ((count++))
        echo "[$count/$total]"

        if ! process_article "$article"; then
            ((failed++))
        fi
    done <<< "$articles"

    echo ""
    echo "----------------------------------------"
    echo "Batch $batch_num complete: $((count-failed))/$count succeeded"
    print_progress
    echo "----------------------------------------"

    return $failed
}

# Main
main() {
    mkdir -p "$OUTPUT_DIR"

    # Initialize state if needed
    [[ ! -f "$STATE_FILE" ]] && init_state $(wc -l < "$SCRIPT_DIR/data/article-list.txt")

    load_batches

    if [[ -n "${BATCH_NUM:-}" ]]; then
        process_batch "$BATCH_NUM"
    elif [[ "${RESUME:-false}" == true ]]; then
        local current=$(get_current_batch)
        for ((b=current; b<=${#BATCHES[@]}; b++)); do
            process_batch "$b"
            echo ""
            echo "Press Enter to continue to batch $((b+1)), or Ctrl+C to stop..."
            read -r
        done
    else
        echo "Usage: $0 [--batch N] [--resume] [--dry-run] [--validate-only]"
        exit 1
    fi
}

main "$@"
```

### Test
```bash
chmod +x scripts/migrate.sh

# Dry run first batch
./scripts/migrate.sh --batch 1 --dry-run

# Process first batch
./scripts/migrate.sh --batch 1
```

### Demo
Run batch 1 with dry-run flag, showing what would be processed. Then run actual batch 1 and display 3 resulting files.

---

## Step 8: Implement Validation System

### Objective
Verify migration completeness and correctness.

### Implementation

Create `scripts/lib/validate.sh`:

```bash
#!/bin/bash
# Migration validation

source "$(dirname "${BASH_SOURCE[0]}")/state.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../data/category-map.sh"
source "$(dirname "${BASH_SOURCE[0]}")/../data/link-map.sh"

REPORT_FILE=".sop/planning/wiki-migration/state/validation-report.md"

# Pre-migration validation
validate_pre() {
    local errors=0

    echo "Pre-migration validation..."

    # Check wiki accessibility
    echo -n "  Wiki server: "
    if curl -s -o /dev/null -w "%{http_code}" "http://wiki.ljackson.us" | grep -q "200"; then
        echo "✓ accessible"
    else
        echo "✗ not accessible"
        ((errors++))
    fi

    # Check data files
    echo -n "  Data files: "
    local required_files=(
        "scripts/data/article-list.txt"
        "scripts/data/category-map.sh"
        "scripts/data/merge-clusters.sh"
        "scripts/data/link-map.sh"
    )
    local missing=0
    for f in "${required_files[@]}"; do
        [[ ! -f "$f" ]] && ((missing++))
    done
    if [[ $missing -eq 0 ]]; then
        echo "✓ all present"
    else
        echo "✗ $missing missing"
        ((errors++))
    fi

    # Check output directory
    echo -n "  Output directory: "
    if mkdir -p wiki && [[ -w wiki ]]; then
        echo "✓ writable"
    else
        echo "✗ not writable"
        ((errors++))
    fi

    return $errors
}

# Post-migration validation
validate_post() {
    echo "# Migration Validation Report" > "$REPORT_FILE"
    echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    # Count files
    local file_count=$(find wiki -name "*.md" | wc -l | tr -d ' ')
    local expected=142  # From research

    echo "## Summary" >> "$REPORT_FILE"
    echo "- Files created: $file_count" >> "$REPORT_FILE"
    echo "- Expected: $expected" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    # Check for missing files
    echo "## Missing Files" >> "$REPORT_FILE"
    local missing=0
    for title in "${!CATEGORY_MAP[@]}"; do
        local status=$(get_article_status "$title")
        if [[ "$status" != "completed" && "$status" != "skipped" ]]; then
            echo "- $title ($status)" >> "$REPORT_FILE"
            ((missing++))
        fi
    done
    [[ $missing -eq 0 ]] && echo "None" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    # Check internal links
    echo "## Broken Internal Links" >> "$REPORT_FILE"
    local broken=0
    for f in wiki/*.md; do
        while IFS= read -r link; do
            local target=$(echo "$link" | sed 's/.*](\([^)]*\)).*/\1/')
            if [[ ! -f "wiki/$target" && ! "$target" =~ ^http ]]; then
                echo "- $f: $link" >> "$REPORT_FILE"
                ((broken++))
            fi
        done < <(grep -oE '\[[^]]+\]\([^)]+\.md\)' "$f" 2>/dev/null || true)
    done
    [[ $broken -eq 0 ]] && echo "None" >> "$REPORT_FILE"

    echo ""
    echo "Validation report: $REPORT_FILE"
    echo "Files: $file_count/$expected, Missing: $missing, Broken links: $broken"
}

# Validate single file
validate_file() {
    local file="$1"
    local errors=0

    # Check file exists and non-empty
    [[ ! -s "$file" ]] && return 1

    # Check has H1 header
    grep -q "^# " "$file" || ((errors++))

    # Check no wiki markup remnants
    grep -qE '^\[\[|^==.*==$|\047\047\047' "$file" && ((errors++))

    # Check no HTML tags (except in code blocks)
    grep -qE '<(div|span|table|tr|td)' "$file" && ((errors++))

    return $errors
}
```

### Test
```bash
source scripts/lib/validate.sh

validate_pre
validate_file "wiki/shell--awk-command.md" && echo "File valid" || echo "File has issues"
```

### Demo
Run pre-validation, then after processing some batches, run post-validation and display the report.

---

## Step 9: Execute Migration (All Batches)

### Objective
Run complete migration with review checkpoints.

### Implementation

Execute batches sequentially with review:

```bash
# Run each batch with pause for review
for batch in {1..11}; do
    ./scripts/migrate.sh --batch $batch

    echo ""
    echo "Review files in wiki/ directory"
    echo "Press Enter to continue to batch $((batch+1)), or Ctrl+C to stop"
    read -r
done
```

### Batch Execution Order

| Batch | Focus | Est. Files | Key Merges |
|-------|-------|------------|------------|
| 1 | shell | 13 | Bash (5→1) |
| 2 | filesystem, networking | 19 | - |
| 3 | security | 6 | SCP (3→1) |
| 4 | voip | 4 | Asterisk (11→1) |
| 5-6 | windows | 24 | GPO (2→1) |
| 7 | web, database | 7 | PHP (2→1) |
| 8 | media | 10 | Ivtv (2→1) |
| 9 | graphics | 12 | - |
| 10-11 | config, misc | 47 | Firefox, Excel |

### Review Checklist (per batch)

- [ ] Files created in `wiki/` directory
- [ ] File count matches expected
- [ ] Spot-check 2-3 files for formatting
- [ ] Check merged files have all sections
- [ ] No error messages in output
- [ ] State file updated correctly

### Demo
Complete batch 1-2 execution with actual files created and reviewed.

---

## Step 10: Final Validation and Cleanup

### Objective
Verify complete migration and clean up temporary files.

### Implementation

1. Run post-migration validation:
```bash
source scripts/lib/validate.sh
validate_post
```

2. Review validation report

3. Fix any issues:
```bash
# Retry failed articles
./scripts/migrate.sh --retry-failed

# Manual fixes for stubborn articles
```

4. Generate final inventory:
```bash
echo "# Wiki Migration Inventory" > wiki/INDEX.md
echo "" >> wiki/INDEX.md
echo "Generated: $(date)" >> wiki/INDEX.md
echo "" >> wiki/INDEX.md

for category in shell filesystem networking security voip windows web database media graphics config misc; do
    echo "## ${category^}" >> wiki/INDEX.md
    for f in wiki/${category}--*.md; do
        [[ -f "$f" ]] || continue
        title=$(head -1 "$f" | sed 's/^# //')
        echo "- [$title]($(basename "$f"))" >> wiki/INDEX.md
    done
    echo "" >> wiki/INDEX.md
done
```

5. Cleanup:
```bash
# Archive planning documents (optional)
# Remove state file if desired
# Commit migrated files
```

### Final Checklist

- [ ] All 142 files created
- [ ] Validation report shows no critical issues
- [ ] INDEX.md generated
- [ ] Git commit with all wiki files
- [ ] Update README.md to mention wiki/ directory

### Demo
Show final file count, validation report summary, and INDEX.md preview.

---

## Estimated Effort

| Step | Complexity | Estimated Work |
|------|------------|----------------|
| 1. Project structure | Low | Data file generation |
| 2. Fetch engine | Low | Small function |
| 3. Converter | Medium | Regex tuning |
| 4. Link resolver | Medium | Map generation |
| 5. Merger | Medium | Template logic |
| 6. State tracker | Low | JSON handling |
| 7. Batch controller | Medium | Orchestration |
| 8. Validation | Low | Checks |
| 9. Execution | - | Running batches |
| 10. Cleanup | Low | Review and commit |

---

## Risk Mitigation

| Risk | Mitigation |
|------|------------|
| Wiki goes offline | Checkpoint after each batch, can resume |
| Conversion errors | Validation catches issues, manual fix |
| Merge conflicts | Review checkpoint before continuing |
| Link resolution failures | Warning logs, manual review |
| Large articles timeout | Increased timeout, retry logic |

---

*Implementation plan created: 2026-01-18*
