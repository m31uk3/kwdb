#!/bin/bash
# Convert wiki markup to markdown
# Bash 3.2 compatible

# Main conversion function
# Usage: echo "$wiki_content" | convert_wiki_to_markdown "Article Title"
convert_wiki_to_markdown() {
    local title="$1"

    # Add title as H1
    echo "# $title"
    echo ""

    # Process content through awk for main conversions
    awk '
    BEGIN {
        in_pre = 0
        in_code = 0
        code_buffer = ""
    }

    # Handle <pre> blocks
    /<pre>/ {
        in_pre = 1
        print "```"
        gsub(/<pre>/, "")
        if (length($0) > 0) print
        next
    }
    /<\/pre>/ {
        in_pre = 0
        gsub(/<\/pre>/, "")
        if (length($0) > 0) print
        print "```"
        next
    }
    in_pre {
        print
        next
    }

    # Handle indented code blocks (lines starting with space)
    /^[ \t]+[^ \t]/ && !in_pre {
        if (!in_code) {
            print "```bash"
            in_code = 1
        }
        sub(/^[ \t]/, "")
        print
        next
    }

    # End code block when non-indented line found
    in_code && !/^[ \t]/ && !/^$/ {
        print "```"
        in_code = 0
    }

    # Skip empty lines inside code blocks consideration
    in_code && /^$/ {
        print ""
        next
    }

    # Headers (must check from most = to least)
    /^======[^=].*[^=]======$/ {
        gsub(/^======[ \t]*/, "")
        gsub(/[ \t]*======$/, "")
        print "###### " $0
        next
    }
    /^=====[^=].*[^=]=====$/ {
        gsub(/^=====[ \t]*/, "")
        gsub(/[ \t]*=====$/, "")
        print "##### " $0
        next
    }
    /^====[^=].*[^=]====$/ {
        gsub(/^====[ \t]*/, "")
        gsub(/[ \t]*====$/, "")
        print "#### " $0
        next
    }
    /^===[^=].*[^=]===$/ {
        gsub(/^===[ \t]*/, "")
        gsub(/[ \t]*===$/, "")
        print "### " $0
        next
    }
    /^==[^=].*[^=]==$/ {
        gsub(/^==[ \t]*/, "")
        gsub(/[ \t]*==$/, "")
        print "## " $0
        next
    }

    # Bold: '\'''\'''\''text'\'''\'''\'' -> **text**
    {
        while (match($0, /\047\047\047[^\047]+\047\047\047/)) {
            before = substr($0, 1, RSTART-1)
            matched = substr($0, RSTART, RLENGTH)
            after = substr($0, RSTART+RLENGTH)
            gsub(/\047\047\047/, "", matched)
            $0 = before "**" matched "**" after
        }
    }

    # Italic: '\'''\''text'\'''\'' -> *text*
    {
        while (match($0, /\047\047[^\047]+\047\047/)) {
            before = substr($0, 1, RSTART-1)
            matched = substr($0, RSTART, RLENGTH)
            after = substr($0, RSTART+RLENGTH)
            gsub(/\047\047/, "", matched)
            $0 = before "*" matched "*" after
        }
    }

    # Unordered lists: * item -> - item
    /^\*+[ \t]/ {
        gsub(/^\*+/, "-")
        print
        next
    }

    # Ordered lists: # item -> 1. item
    /^#+[ \t]/ {
        gsub(/^#+/, "1.")
        print
        next
    }

    # External links: [http://url text] -> [text](http://url)
    {
        while (match($0, /\[[a-zA-Z]+:\/\/[^ \]]+[ \t]+[^\]]+\]/)) {
            before = substr($0, 1, RSTART-1)
            matched = substr($0, RSTART, RLENGTH)
            after = substr($0, RSTART+RLENGTH)
            # Extract URL and text
            gsub(/^\[/, "", matched)
            gsub(/\]$/, "", matched)
            split(matched, parts, /[ \t]+/)
            url = parts[1]
            text = ""
            for (i=2; i<=length(parts); i++) {
                text = text (i>2?" ":"") parts[i]
            }
            $0 = before "[" text "](" url ")" after
        }
    }

    # Remove category tags
    /^\[\[Category:/ { next }

    # Horizontal rules
    /^----+$/ {
        print "---"
        next
    }

    # Pass through everything else
    { print }

    END {
        if (in_code) print "```"
    }
    '
}

# Add standard footer
add_footer() {
    echo ""
    echo "---"
    echo ""
    echo "*Migrated from wiki.ljackson.us*"
}

# Clean up common wiki artifacts
cleanup_content() {
    sed '
        # Remove empty code blocks
        /^```$/,/^```$/{
            /^$/d
        }
        # Fix double blank lines
        /^$/N;/^\n$/d
        # Remove trailing whitespace
        s/[[:space:]]*$//
    '
}
