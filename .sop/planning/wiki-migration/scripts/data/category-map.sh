#!/bin/bash
# Category mapping: article title -> category prefix
# Bash 3.2 compatible using case statement

get_category() {
    local title="$1"
    case "$title" in
        # Shell
        "Awk Command"|"Bash"|"Bash Random Word"|"Bash Rename File Extensions"|"Bash Scripts"|"Bash Sort IP Addresses"|"Grep Command"|"History Command"|"Regular Expressions"|"Sed Command"|"Tr Command"|"Vi Command"|"Xargs Command"|"Xmlstarlet"|"Screen"|"Curl"|"Wget Command")
            echo "shell" ;;

        # Filesystem
        "Chmod"|"Du Command"|"Find Command"|"Ls Command"|"Mount Command"|"Proc"|"Rsync"|"NTFS"|"Tune2fs")
            echo "filesystem" ;;

        # Networking
        "Change MTU Size"|"Cisco"|"DHCPd"|"Linux DNS"|"Linux Hostname"|"Linux Network Config"|"Network Time Protocol"|"Wireless Configuration"|"Bluetooth"|"Airport Config")
            echo "networking" ;;

        # Security
        "Fail2ban"|"Firewall ipfw"|"OpenSSL"|"Public Key Authentication"|"SELinux"|"SSH"|"Secure Copy (SCP)"|"Secure Copy SCP"|"Mac OS X SCP (GUI)")
            echo "security" ;;

        # VoIP
        "Asterisk"|"Asterisk Dialplan"|"Asterisk Echo"|"Asterisk Firewall"|"Asterisk Front End"|"Asterisk Install"|"Asterisk Logs"|"Asterisk Queue"|"Asterisk Sipgate"|"Asterisk Tutorial"|"Asterisk Voice Changer"|"Eyebeam"|"FreeBPX"|"QueueMetrics")
            echo "voip" ;;

        # Windows
        "CD Burning Windows Domain"|"Command Prompt"|"Control Userpasswords2"|"Defrag Tool Windows XP"|"Del Command"|"Disk Clean Up Tool Windows XP"|"DiskPart"|"For Command"|"GPO Error 1085"|"Group Policy"|"Group Policy 1085"|"Logonscript.vbs"|"Net Use Command"|"Remote Desktop"|"Remote Shutdown"|"Remote User Discovery"|"RoboCopy"|"Terminal Windows XP"|"Using Shared Drives"|"Visual Basic Script"|"Windows 2003 Shares"|"Windows 7"|"Windows Vista"|"Windows XP Firewall"|"XP Registy Shortcuts")
            echo "windows" ;;

        # Web
        "Apache"|"JavaScript"|"PHP"|"PHP Install"|"Postfix"|"Greasemonkey"|"Facebook")
            echo "web" ;;

        # Database
        "Mysql"|"PostgreSQL")
            echo "database" ;;

        # Media
        "DivX Codecs"|"DVD Region Codes"|"Ffmpeg"|"Ivtv"|"Ivtv-channel"|"Lirc"|"MEncoder"|"MPlayer"|"Vlc"|"WinTV"|"Screen Capture")
            echo "media" ;;

        # Graphics
        "Adobe Illustrator"|"Adobe LiveCycle Designer"|"CorelDraw"|"DTG Graphic Process"|"EPS Optimization"|"Ftxdumperfuser"|"Goverts GoBatchGS"|"ImageMagick"|"Photoshop"|"Ps2svg"|"Sips Command"|"True Type Fonts")
            echo "graphics" ;;

        # Config
        ".profile"|"Crontab"|"Samba"|"Vsftpd"|"Webmin"|"Linux Modules"|"Linux Time"|"Linux userdel"|"Time Zone"|"Daylight Savings Time"|"Date"|"Server Backup"|"Printers")
            echo "config" ;;

        # Default to misc
        *)
            echo "misc" ;;
    esac
}

# Function to generate filename from title
get_filename() {
    local title="$1"
    local category
    category=$(get_category "$title")
    local slug
    slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g; s/[^a-z0-9-]//g')
    echo "${category}--${slug}.md"
}
