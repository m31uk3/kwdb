#!/bin/bash
# State tracking for wiki migration - track processed articles
# Bash 3.2 compatible

# Default state file location
STATE_FILE="${STATE_FILE:-.sop/planning/wiki-migration/state/progress.txt}"
STATE_DIR="$(dirname "$STATE_FILE")"

# Initialize state directory and file
init_state() {
    if [ ! -d "$STATE_DIR" ]; then
        mkdir -p "$STATE_DIR"
    fi
    if [ ! -f "$STATE_FILE" ]; then
        echo "# Wiki Migration Progress" > "$STATE_FILE"
        echo "# Format: STATUS|TIMESTAMP|TITLE" >> "$STATE_FILE"
        echo "# STATUS: DONE, SKIP, FAIL" >> "$STATE_FILE"
        echo "# ---" >> "$STATE_FILE"
    fi
}

# Mark an article as processed
# Usage: mark_done "Article Title"
mark_done() {
    local title="$1"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    init_state
    echo "DONE|$timestamp|$title" >> "$STATE_FILE"
}

# Mark an article as skipped (merge target)
# Usage: mark_skip "Article Title" "reason"
mark_skip() {
    local title="$1"
    local reason="${2:-merge_target}"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    init_state
    echo "SKIP|$timestamp|$title|$reason" >> "$STATE_FILE"
}

# Mark an article as failed
# Usage: mark_fail "Article Title" "error message"
mark_fail() {
    local title="$1"
    local error="${2:-unknown}"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    init_state
    echo "FAIL|$timestamp|$title|$error" >> "$STATE_FILE"
}

# Check if article has been processed
# Usage: is_processed "Article Title"
is_processed() {
    local title="$1"
    init_state
    grep -q "^DONE|.*|${title}$" "$STATE_FILE" 2>/dev/null || \
    grep -q "^SKIP|.*|${title}|" "$STATE_FILE" 2>/dev/null
}

# Check if article failed previously
# Usage: has_failed "Article Title"
has_failed() {
    local title="$1"
    init_state
    grep -q "^FAIL|.*|${title}|" "$STATE_FILE" 2>/dev/null
}

# Get list of all processed articles
get_processed() {
    init_state
    grep "^DONE|" "$STATE_FILE" 2>/dev/null | cut -d'|' -f3
}

# Get list of all skipped articles
get_skipped() {
    init_state
    grep "^SKIP|" "$STATE_FILE" 2>/dev/null | cut -d'|' -f3
}

# Get list of all failed articles
get_failed() {
    init_state
    grep "^FAIL|" "$STATE_FILE" 2>/dev/null | cut -d'|' -f3
}

# Get counts
count_done() {
    init_state
    local c
    c=$(grep -c "^DONE|" "$STATE_FILE" 2>/dev/null) || c=0
    echo "$c"
}

count_skip() {
    init_state
    local c
    c=$(grep -c "^SKIP|" "$STATE_FILE" 2>/dev/null) || c=0
    echo "$c"
}

count_fail() {
    init_state
    local c
    c=$(grep -c "^FAIL|" "$STATE_FILE" 2>/dev/null) || c=0
    echo "$c"
}

# Show progress summary
show_progress() {
    init_state
    local done skip fail total
    done=$(count_done)
    skip=$(count_skip)
    fail=$(count_fail)
    total=$((done + skip + fail))

    echo "Migration Progress:"
    echo "  Completed: $done"
    echo "  Skipped:   $skip"
    echo "  Failed:    $fail"
    echo "  Total:     $total"
}

# Reset state (use with caution)
reset_state() {
    if [ -f "$STATE_FILE" ]; then
        rm "$STATE_FILE"
    fi
    init_state
    echo "State reset complete"
}

# Get pending articles from a list file
# Usage: get_pending_articles "/path/to/article-list.txt"
get_pending_articles() {
    local article_list="$1"
    init_state

    while IFS= read -r title || [ -n "$title" ]; do
        # Skip empty lines and comments
        case "$title" in
            ""|\#*) continue ;;
        esac

        # Check if already processed
        if ! is_processed "$title"; then
            echo "$title"
        fi
    done < "$article_list"
}

# Create a batch from pending articles
# Usage: create_batch "/path/to/article-list.txt" batch_size
create_batch() {
    local article_list="$1"
    local batch_size="${2:-15}"

    get_pending_articles "$article_list" | head -n "$batch_size"
}

# Save batch state snapshot
# Usage: save_batch_snapshot "batch_name"
save_batch_snapshot() {
    local batch_name="$1"
    local snapshot_file="${STATE_DIR}/batch-${batch_name}.txt"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    echo "# Batch: $batch_name" > "$snapshot_file"
    echo "# Started: $timestamp" >> "$snapshot_file"
    show_progress >> "$snapshot_file"
}
