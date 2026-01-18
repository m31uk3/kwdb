#!/bin/bash
# Resolve wiki internal links to markdown links
# Bash 3.2 compatible

# Get the directory where this script lives
if [ -n "${BASH_SOURCE[0]}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    LINKS_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    # Fallback for interactive sourcing
    LINKS_SCRIPT_DIR="$(pwd)/.sop/planning/wiki-migration/scripts/lib"
fi

# Source link map
source "${LINKS_SCRIPT_DIR}/../data/link-map.sh"

# Resolve wiki links in content using awk for reliable processing
# Usage: echo "$content" | resolve_links
resolve_links() {
    # First pass: use awk to identify and mark links
    awk '
    {
        line = $0

        # Remove image and file links
        gsub(/\[\[Image:[^\]]*\]\]/, "", line)
        gsub(/\[\[File:[^\]]*\]\]/, "", line)

        # Process all links - output special markers for shell to resolve
        # Format: <<WIKILINK:target:display>>

        # [[Link|Display]] pattern
        while (match(line, /\[\[[^\]\|]+\|[^\]]+\]\]/)) {
            before = substr(line, 1, RSTART-1)
            matched = substr(line, RSTART, RLENGTH)
            after = substr(line, RSTART+RLENGTH)

            # Extract inner content
            inner = substr(matched, 3, length(matched)-4)
            pos = index(inner, "|")
            target = substr(inner, 1, pos-1)
            display = substr(inner, pos+1)

            line = before "<<WIKILINK:" target ":" display ">>" after
        }

        # [[Link]] pattern (no display)
        while (match(line, /\[\[[^\]\|]+\]\]/)) {
            before = substr(line, 1, RSTART-1)
            matched = substr(line, RSTART, RLENGTH)
            after = substr(line, RSTART+RLENGTH)

            # Extract target
            target = substr(matched, 3, length(matched)-4)

            line = before "<<WIKILINK:" target ":" target ">>" after
        }

        print line
    }
    ' | while IFS= read -r line || [ -n "$line" ]; do
        # Second pass: resolve the WIKILINK markers using shell
        _result="$line"
        _iter=0

        while [ $_iter -lt 50 ]; do
            _iter=$((_iter + 1))

            # Check if any markers remain
            case "$_result" in
                *"<<WIKILINK:"*">>"*) ;;
                *) break ;;
            esac

            # Extract first marker using parameter expansion
            _prefix="${_result%%<<WIKILINK:*}"
            _rest="${_result#*<<WIKILINK:}"
            _inner="${_rest%%>>*}"
            _suffix="${_rest#*>>}"

            # Parse target and display from inner (format: target:display)
            _target="${_inner%%:*}"
            _display="${_inner#*:}"

            # Handle anchors: split "Page#Section" into page and section
            _anchor=""
            _page="$_target"
            case "$_target" in
                *"#"*)
                    _page="${_target%%#*}"
                    _anchor="#${_target#*#}"
                    # Slugify the anchor
                    _anchor=$(printf '%s' "$_anchor" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g; s/[^a-z0-9#-]//g')
                    ;;
            esac

            # Resolve the link (suppress all output except the result)
            _resolved=$(resolve_link "$_page" 2>/dev/null) || true
            if [ -z "$_resolved" ]; then
                _resolved="misc--$(printf '%s' "$_page" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g; s/[^a-z0-9-]//g').md"
            fi

            # Append anchor if present
            _resolved="${_resolved}${_anchor}"

            # Reconstruct line with markdown link
            _result="${_prefix}[${_display}](${_resolved})${_suffix}"
        done

        printf '%s\n' "$_result"
    done
}

# Count unresolved links in content
count_unresolved_links() {
    grep -o '\[\[' | wc -l | tr -d ' '
}
