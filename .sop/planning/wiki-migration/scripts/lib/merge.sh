#!/bin/bash
# Merge related wiki articles into comprehensive documents
# Bash 3.2 compatible

# Get the directory where this script lives
if [ -n "${BASH_SOURCE[0]}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    MERGE_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    MERGE_SCRIPT_DIR="$(pwd)/.sop/planning/wiki-migration/scripts/lib"
fi

# Source dependencies
source "${MERGE_SCRIPT_DIR}/../data/merge-clusters.sh"
source "${MERGE_SCRIPT_DIR}/fetch.sh"
source "${MERGE_SCRIPT_DIR}/convert.sh"
source "${MERGE_SCRIPT_DIR}/links.sh"

# Convert URL-style title to display title
url_to_display_title() {
    echo "$1" | tr '_' ' '
}

# Process a single cluster and output merged markdown
# Usage: merge_cluster "cluster_id"
merge_cluster() {
    local cluster_id="$1"
    local articles output_file primary_article

    articles=$(get_cluster_articles "$cluster_id")
    output_file=$(get_cluster_filename "$cluster_id")

    if [ -z "$articles" ] || [ -z "$output_file" ]; then
        echo "ERROR: Invalid cluster ID: $cluster_id" >&2
        return 1
    fi

    # Get primary article (first in list)
    primary_article=$(echo "$articles" | awk '{print $1}')
    local primary_title
    primary_title=$(url_to_display_title "$primary_article")

    # Fetch and convert primary article (this becomes the main document)
    local primary_content
    primary_content=$(fetch_article "$primary_title" 2>/dev/null)
    if [ -z "$primary_content" ]; then
        echo "ERROR: Failed to fetch primary article: $primary_title" >&2
        return 1
    fi

    # Convert primary to markdown
    echo "$primary_content" | convert_wiki_to_markdown "$primary_title"

    # Process each sub-article
    local article display_title sub_content
    for article in $articles; do
        # Skip primary (already processed)
        if [ "$article" = "$primary_article" ]; then
            continue
        fi

        display_title=$(url_to_display_title "$article")

        echo ""
        echo "---"
        echo ""

        # Create section header from sub-article title
        # Remove primary prefix if present for cleaner headers
        local section_header="$display_title"
        case "$section_header" in
            "${primary_title} "*)
                section_header="${section_header#${primary_title} }"
                ;;
        esac

        echo "## $section_header"
        echo ""

        # Fetch sub-article
        sub_content=$(fetch_article "$display_title" 2>/dev/null)
        if [ -z "$sub_content" ]; then
            echo "*Content not available*"
            echo ""
            continue
        fi

        # Convert and output (skip the title since we added section header)
        echo "$sub_content" | awk '
        BEGIN { skip_first_header = 1 }
        {
            # Skip the first header line (== Title ==)
            if (skip_first_header && /^==+[^=]/) {
                skip_first_header = 0
                next
            }
            # Demote remaining headers by one level
            if (/^======/) {
                gsub(/^======/, "#######")
                gsub(/======$/, "")
                print
                next
            }
            if (/^=====/) {
                gsub(/^=====/, "######")
                gsub(/=====$/, "")
                print
                next
            }
            if (/^====/) {
                gsub(/^====/, "#####")
                gsub(/====$/, "")
                print
                next
            }
            if (/^===/) {
                gsub(/^===/, "####")
                gsub(/===$/, "")
                print
                next
            }
            if (/^==/) {
                gsub(/^==/, "###")
                gsub(/==$/, "")
                print
                next
            }
            print
        }
        ' | convert_wiki_to_markdown "" | tail -n +3  # Skip generated title
    done
}

# Process a cluster and save to output directory
# Usage: process_cluster "cluster_id" "/path/to/wiki/output"
process_cluster() {
    local cluster_id="$1"
    local output_dir="$2"
    local output_file

    output_file=$(get_cluster_filename "$cluster_id")
    if [ -z "$output_file" ]; then
        echo "ERROR: Unknown cluster: $cluster_id" >&2
        return 1
    fi

    local full_path="${output_dir}/${output_file}"

    echo "Merging cluster: $cluster_id -> $output_file"

    if merge_cluster "$cluster_id" | resolve_links > "$full_path"; then
        local word_count line_count
        word_count=$(wc -w < "$full_path" | tr -d ' ')
        line_count=$(wc -l < "$full_path" | tr -d ' ')
        echo "  Created: $output_file ($line_count lines, $word_count words)"
        return 0
    else
        echo "  ERROR: Failed to merge cluster $cluster_id" >&2
        rm -f "$full_path"
        return 1
    fi
}

# Process all clusters
# Usage: process_all_clusters "/path/to/wiki/output"
process_all_clusters() {
    local output_dir="$1"
    local success=0 failed=0

    for cluster_id in $CLUSTER_IDS; do
        if process_cluster "$cluster_id" "$output_dir"; then
            success=$((success + 1))
        else
            failed=$((failed + 1))
        fi
    done

    echo ""
    echo "Cluster processing complete: $success succeeded, $failed failed"
    return $failed
}

# Check if an article should be skipped (it's a merge target)
# Usage: should_skip_article "Article Title"
should_skip_article() {
    local title="$1"
    is_merge_target "$title" >/dev/null 2>&1
}

# Check if an article needs merge processing (it's a cluster primary)
# Usage: needs_merge_processing "Article Title"
needs_merge_processing() {
    local title="$1"
    is_cluster_primary "$title" >/dev/null 2>&1
}
