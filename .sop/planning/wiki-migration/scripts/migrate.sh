#!/bin/bash
# Wiki Migration Batch Controller
# Migrates wiki articles to markdown in controlled batches
# Bash 3.2 compatible

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
OUTPUT_DIR="${PROJECT_ROOT}/wiki"
ARTICLE_LIST="${SCRIPT_DIR}/data/article-list.txt"
BATCH_SIZE=15

# Source libraries
source "${SCRIPT_DIR}/lib/fetch.sh"
source "${SCRIPT_DIR}/lib/convert.sh"
source "${SCRIPT_DIR}/lib/links.sh"
source "${SCRIPT_DIR}/lib/merge.sh"
source "${SCRIPT_DIR}/lib/state.sh"
source "${SCRIPT_DIR}/data/category-map.sh"

# Colors for output (if terminal supports it)
if [ -t 1 ]; then
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    RED='\033[0;31m'
    BLUE='\033[0;34m'
    NC='\033[0m'
else
    GREEN='' YELLOW='' RED='' BLUE='' NC=''
fi

# Print colored status
print_status() {
    local color="$1" message="$2"
    printf "${color}%s${NC}\n" "$message"
}

# Process a single article
process_article() {
    local title="$1"

    # Skip if already processed
    if is_processed "$title"; then
        return 0
    fi

    # Check if this is a merge target (should be skipped)
    if should_skip_article "$title"; then
        mark_skip "$title" "merge_target"
        print_status "$YELLOW" "  SKIP (merge target): $title"
        return 0
    fi

    # Check if this needs merge processing
    local cluster_id
    if cluster_id=$(is_cluster_primary "$title" 2>/dev/null) && [ -n "$cluster_id" ]; then
        # Process as merged cluster
        local output_file
        output_file=$(get_cluster_filename "$cluster_id")
        local full_path="${OUTPUT_DIR}/${output_file}"

        print_status "$BLUE" "  MERGE: $title -> $output_file"

        if merge_cluster "$cluster_id" | resolve_links > "$full_path" 2>/dev/null; then
            mark_done "$title"
            # Also mark all sub-articles as done
            local articles sub_article
            articles=$(get_cluster_articles "$cluster_id")
            for sub_article in $articles; do
                local sub_title
                sub_title=$(echo "$sub_article" | tr '_' ' ')
                if [ "$sub_title" != "$title" ]; then
                    mark_skip "$sub_title" "merged_into_$output_file"
                fi
            done
            print_status "$GREEN" "  DONE: $title (merged cluster)"
            return 0
        else
            mark_fail "$title" "merge_failed"
            print_status "$RED" "  FAIL: $title (merge failed)"
            return 1
        fi
    fi

    # Process as single article
    local filename content
    filename=$(get_filename "$title")
    local full_path="${OUTPUT_DIR}/${filename}"

    # Fetch article
    content=$(fetch_article "$title" 2>/dev/null)
    if [ -z "$content" ]; then
        mark_fail "$title" "fetch_failed"
        print_status "$RED" "  FAIL: $title (fetch failed)"
        return 1
    fi

    # Convert and save
    if echo "$content" | convert_wiki_to_markdown "$title" | resolve_links > "$full_path" 2>/dev/null; then
        mark_done "$title"
        print_status "$GREEN" "  DONE: $title -> $filename"
        return 0
    else
        mark_fail "$title" "convert_failed"
        print_status "$RED" "  FAIL: $title (convert failed)"
        return 1
    fi
}

# Run a single batch
run_batch() {
    local batch_num="$1"

    print_status "$BLUE" "=== Batch $batch_num ==="

    # Ensure output directory exists
    mkdir -p "$OUTPUT_DIR"

    # Get pending articles for this batch
    local articles success=0 fail=0
    articles=$(create_batch "$ARTICLE_LIST" "$BATCH_SIZE")

    if [ -z "$articles" ]; then
        print_status "$GREEN" "No pending articles. Migration complete!"
        return 0
    fi

    local count
    count=$(echo "$articles" | wc -l | tr -d ' ')
    echo "Processing $count articles..."
    echo ""

    # Process each article
    while IFS= read -r title || [ -n "$title" ]; do
        if process_article "$title"; then
            success=$((success + 1))
        else
            fail=$((fail + 1))
        fi
    done <<< "$articles"

    echo ""
    echo "Batch $batch_num complete: $success succeeded, $fail failed"
    show_progress
}

# Interactive migration mode
run_interactive() {
    local batch_num=1

    echo "Wiki Migration - Interactive Mode"
    echo "================================="
    echo "Output directory: $OUTPUT_DIR"
    echo "Batch size: $BATCH_SIZE articles"
    echo ""

    # Check wiki accessibility first
    if ! check_wiki_accessible; then
        print_status "$RED" "ERROR: Wiki is not accessible. Please check network connection."
        exit 1
    fi
    print_status "$GREEN" "Wiki is accessible."
    echo ""

    show_progress
    echo ""

    while true; do
        local pending
        pending=$(get_pending_articles "$ARTICLE_LIST" | wc -l | tr -d ' ')

        if [ "$pending" -eq 0 ]; then
            print_status "$GREEN" "All articles processed!"
            break
        fi

        echo ""
        echo "Pending articles: $pending"
        echo "Options:"
        echo "  [Enter] - Run next batch ($BATCH_SIZE articles)"
        echo "  [q]     - Quit"
        echo "  [s]     - Show status"
        echo "  [f]     - Show failed articles"
        echo ""
        printf "Choice: "
        read -r choice

        case "$choice" in
            q|Q|quit|exit)
                echo "Exiting. Progress saved."
                break
                ;;
            s|S|status)
                show_progress
                ;;
            f|F|failed)
                echo "Failed articles:"
                get_failed | while read -r line; do echo "  - $line"; done
                ;;
            *)
                run_batch "$batch_num"
                batch_num=$((batch_num + 1))
                ;;
        esac
    done
}

# Run all batches automatically
run_all() {
    local batch_num=1

    echo "Wiki Migration - Automatic Mode"
    echo "================================"
    echo "Output directory: $OUTPUT_DIR"
    echo ""

    # Check wiki accessibility first
    if ! check_wiki_accessible; then
        print_status "$RED" "ERROR: Wiki is not accessible."
        exit 1
    fi

    while true; do
        local pending
        pending=$(get_pending_articles "$ARTICLE_LIST" | wc -l | tr -d ' ')

        if [ "$pending" -eq 0 ]; then
            echo ""
            print_status "$GREEN" "Migration complete!"
            show_progress
            break
        fi

        run_batch "$batch_num"
        batch_num=$((batch_num + 1))

        # Small delay between batches
        sleep 1
    done
}

# Show usage
usage() {
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  interactive  - Run migration interactively (default)"
    echo "  all          - Run all batches automatically"
    echo "  status       - Show current progress"
    echo "  reset        - Reset all progress (use with caution)"
    echo "  validate     - Validate migrated files"
    echo ""
}

# Main
case "${1:-interactive}" in
    interactive)
        run_interactive
        ;;
    all)
        run_all
        ;;
    status)
        show_progress
        ;;
    reset)
        echo "This will reset ALL migration progress."
        printf "Are you sure? (yes/no): "
        read -r confirm
        if [ "$confirm" = "yes" ]; then
            reset_state
            rm -rf "$OUTPUT_DIR"
            echo "Reset complete."
        else
            echo "Cancelled."
        fi
        ;;
    validate)
        echo "Running validation..."
        source "${SCRIPT_DIR}/lib/validate.sh" 2>/dev/null || {
            echo "Validation library not found. Run migration first."
            exit 1
        }
        validate_all "$OUTPUT_DIR"
        ;;
    help|--help|-h)
        usage
        ;;
    *)
        echo "Unknown command: $1"
        usage
        exit 1
        ;;
esac
