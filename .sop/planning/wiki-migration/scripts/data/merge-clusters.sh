#!/bin/bash
# Merge cluster definitions - bash 3.2 compatible
# Uses simple string lookups instead of associative arrays

# Cluster definitions as simple strings
# Format: CLUSTER_<id>="Primary_Article Sub1 Sub2 ..."
CLUSTER_voip_asterisk="Asterisk Asterisk_Dialplan Asterisk_Echo Asterisk_Firewall Asterisk_Front_End Asterisk_Install Asterisk_Logs Asterisk_Queue Asterisk_Sipgate Asterisk_Tutorial Asterisk_Voice_Changer"
CLUSTER_shell_bash="Bash Bash_Scripts Bash_Random_Word Bash_Rename_File_Extensions Bash_Sort_IP_Addresses"
CLUSTER_misc_firefox="Firefox Firefox_Printing Firefox_Profiles Firefox_SVG"
CLUSTER_security_scp="Secure_Copy_(SCP) Secure_Copy_SCP Mac_OS_X_SCP_(GUI)"
CLUSTER_windows_gpo="GPO_Error_1085 Group_Policy_1085"
CLUSTER_web_php="PHP PHP_Install"
CLUSTER_media_ivtv="Ivtv Ivtv-channel"
CLUSTER_misc_excel="Excel Excel_Mulit_File_Query"

# List of all cluster IDs
CLUSTER_IDS="voip_asterisk shell_bash misc_firefox security_scp windows_gpo web_php media_ivtv misc_excel"

# Map cluster ID to output filename
get_cluster_filename() {
    local cluster_id="$1"
    case "$cluster_id" in
        voip_asterisk) echo "voip--asterisk.md" ;;
        shell_bash) echo "shell--bash.md" ;;
        misc_firefox) echo "misc--firefox.md" ;;
        security_scp) echo "security--scp.md" ;;
        windows_gpo) echo "windows--gpo-error-1085.md" ;;
        web_php) echo "web--php.md" ;;
        media_ivtv) echo "media--ivtv.md" ;;
        misc_excel) echo "misc--excel.md" ;;
        *) echo "" ;;
    esac
}

# Get articles for a cluster
get_cluster_articles() {
    local cluster_id="$1"
    local var_name="CLUSTER_${cluster_id}"
    eval echo "\$$var_name"
}

# Get primary article of a cluster
get_cluster_primary() {
    local cluster_id="$1"
    get_cluster_articles "$cluster_id" | awk '{print $1}'
}

# Check if article is a merge target (will be merged into another doc)
# Returns cluster ID if article is a non-primary member, empty otherwise
is_merge_target() {
    local title="$1"
    local url_title
    url_title=$(echo "$title" | tr ' ' '_')
    local cluster_id articles primary

    for cluster_id in $CLUSTER_IDS; do
        articles=$(get_cluster_articles "$cluster_id")
        primary=$(echo "$articles" | awk '{print $1}')

        # Check if article is in cluster
        if echo " $articles " | grep -q " $url_title "; then
            # Check if NOT the primary
            if [ "$url_title" != "$primary" ]; then
                echo "$cluster_id"
                return 0
            fi
        fi
    done
    return 1
}

# Check if article is a cluster primary (needs merge processing)
# Returns cluster ID if article is the primary member
is_cluster_primary() {
    local title="$1"
    local url_title
    url_title=$(echo "$title" | tr ' ' '_')
    local cluster_id primary

    for cluster_id in $CLUSTER_IDS; do
        primary=$(get_cluster_primary "$cluster_id")
        if [ "$url_title" = "$primary" ]; then
            echo "$cluster_id"
            return 0
        fi
    done
    return 1
}

# Get all merge target articles (non-primary articles across all clusters)
get_all_merge_targets() {
    for cluster_id in $CLUSTER_IDS; do
        local articles=$(get_cluster_articles "$cluster_id")
        # Skip first (primary), output rest
        echo "$articles" | cut -d' ' -f2- | tr ' ' '\n'
    done
}
