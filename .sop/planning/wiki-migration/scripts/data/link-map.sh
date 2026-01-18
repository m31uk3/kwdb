#!/bin/bash
# Link resolution map: wiki article title -> markdown file path
# Bash 3.2 compatible using case statement

resolve_link() {
    local title="$1"
    case "$title" in
        # Shell
        "Awk Command") echo "shell--awk-command.md" ;;
        "Bash") echo "shell--bash.md" ;;
        "Bash Random Word") echo "shell--bash.md#random-word" ;;
        "Bash Rename File Extensions") echo "shell--bash.md#rename-file-extensions" ;;
        "Bash Scripts") echo "shell--bash.md#scripts" ;;
        "Bash Sort IP Addresses") echo "shell--bash.md#sort-ip-addresses" ;;
        "Grep Command") echo "shell--grep-command.md" ;;
        "History Command") echo "shell--history-command.md" ;;
        "Regular Expressions") echo "shell--regular-expressions.md" ;;
        "Sed Command") echo "shell--sed-command.md" ;;
        "Tr Command") echo "shell--tr-command.md" ;;
        "Vi Command") echo "shell--vi-command.md" ;;
        "Xargs Command") echo "shell--xargs-command.md" ;;
        "Xmlstarlet") echo "shell--xmlstarlet.md" ;;
        "Screen") echo "shell--screen.md" ;;
        "Curl") echo "shell--curl.md" ;;
        "Wget Command") echo "shell--wget-command.md" ;;

        # Filesystem
        "Chmod") echo "filesystem--chmod.md" ;;
        "Du Command") echo "filesystem--du-command.md" ;;
        "Find Command") echo "filesystem--find-command.md" ;;
        "Ls Command") echo "filesystem--ls-command.md" ;;
        "Mount Command") echo "filesystem--mount-command.md" ;;
        "Proc") echo "filesystem--proc.md" ;;
        "Rsync") echo "filesystem--rsync.md" ;;
        "NTFS") echo "filesystem--ntfs.md" ;;
        "Tune2fs") echo "filesystem--tune2fs.md" ;;

        # Networking
        "Change MTU Size") echo "networking--change-mtu-size.md" ;;
        "Cisco") echo "networking--cisco.md" ;;
        "DHCPd") echo "networking--dhcpd.md" ;;
        "Linux DNS") echo "networking--linux-dns.md" ;;
        "Linux Hostname") echo "networking--linux-hostname.md" ;;
        "Linux Network Config") echo "networking--linux-network-config.md" ;;
        "Network Time Protocol") echo "networking--ntp.md" ;;
        "Wireless Configuration") echo "networking--wireless-configuration.md" ;;
        "Bluetooth") echo "networking--bluetooth.md" ;;
        "Airport Config") echo "networking--airport-config.md" ;;

        # Security
        "Fail2ban") echo "security--fail2ban.md" ;;
        "Firewall ipfw") echo "security--firewall-ipfw.md" ;;
        "OpenSSL") echo "security--openssl.md" ;;
        "Public Key Authentication") echo "security--public-key-authentication.md" ;;
        "SELinux") echo "security--selinux.md" ;;
        "SSH") echo "security--ssh.md" ;;
        "Secure Copy (SCP)"|"Secure Copy SCP"|"SCP") echo "security--scp.md" ;;
        "Mac OS X SCP (GUI)") echo "security--scp.md#mac-os-x-gui" ;;

        # VoIP
        "Asterisk") echo "voip--asterisk.md" ;;
        "Asterisk Dialplan") echo "voip--asterisk.md#dialplan" ;;
        "Asterisk Echo") echo "voip--asterisk.md#echo" ;;
        "Asterisk Firewall") echo "voip--asterisk.md#firewall" ;;
        "Asterisk Front End") echo "voip--asterisk.md#front-end" ;;
        "Asterisk Install") echo "voip--asterisk.md#install" ;;
        "Asterisk Logs") echo "voip--asterisk.md#logs" ;;
        "Asterisk Queue") echo "voip--asterisk.md#queue" ;;
        "Asterisk Sipgate") echo "voip--asterisk.md#sipgate" ;;
        "Asterisk Tutorial") echo "voip--asterisk.md#tutorial" ;;
        "Asterisk Voice Changer") echo "voip--asterisk.md#voice-changer" ;;
        "Eyebeam") echo "voip--eyebeam.md" ;;
        "FreeBPX"|"FreePBX") echo "voip--freepbx.md" ;;
        "QueueMetrics") echo "voip--queuemetrics.md" ;;

        # Windows
        "CD Burning Windows Domain") echo "windows--cd-burning-domain.md" ;;
        "Command Prompt") echo "windows--command-prompt.md" ;;
        "Control Userpasswords2") echo "windows--control-userpasswords2.md" ;;
        "Defrag Tool Windows XP") echo "windows--defrag-tool.md" ;;
        "Del Command") echo "windows--del-command.md" ;;
        "Disk Clean Up Tool Windows XP") echo "windows--disk-cleanup-tool.md" ;;
        "DiskPart") echo "windows--diskpart.md" ;;
        "For Command") echo "windows--for-command.md" ;;
        "GPO Error 1085"|"Group Policy 1085") echo "windows--gpo-error-1085.md" ;;
        "Group Policy") echo "windows--group-policy.md" ;;
        "Logonscript.vbs") echo "windows--logonscript-vbs.md" ;;
        "Net Use Command") echo "windows--net-use-command.md" ;;
        "Remote Desktop") echo "windows--remote-desktop.md" ;;
        "Remote Shutdown") echo "windows--remote-shutdown.md" ;;
        "Remote User Discovery") echo "windows--remote-user-discovery.md" ;;
        "RoboCopy") echo "windows--robocopy.md" ;;
        "Terminal Windows XP") echo "windows--terminal.md" ;;
        "Using Shared Drives") echo "windows--using-shared-drives.md" ;;
        "Visual Basic Script") echo "windows--visual-basic-script.md" ;;
        "Windows 2003 Shares") echo "windows--windows-2003-shares.md" ;;
        "Windows 7") echo "windows--windows-7.md" ;;
        "Windows Vista") echo "windows--windows-vista.md" ;;
        "Windows XP Firewall") echo "windows--windows-xp-firewall.md" ;;
        "XP Registy Shortcuts") echo "windows--xp-registry-shortcuts.md" ;;

        # Web
        "Apache") echo "web--apache.md" ;;
        "JavaScript") echo "web--javascript.md" ;;
        "PHP") echo "web--php.md" ;;
        "PHP Install") echo "web--php.md#install" ;;
        "Postfix") echo "web--postfix.md" ;;
        "Greasemonkey") echo "web--greasemonkey.md" ;;
        "Facebook") echo "web--facebook.md" ;;

        # Database
        "Mysql"|"MySQL") echo "database--mysql.md" ;;
        "PostgreSQL") echo "database--postgresql.md" ;;

        # Media
        "DivX Codecs") echo "media--divx-codecs.md" ;;
        "DVD Region Codes") echo "media--dvd-region-codes.md" ;;
        "Ffmpeg"|"FFmpeg") echo "media--ffmpeg.md" ;;
        "Ivtv") echo "media--ivtv.md" ;;
        "Ivtv-channel") echo "media--ivtv.md#channel" ;;
        "Lirc") echo "media--lirc.md" ;;
        "MEncoder") echo "media--mencoder.md" ;;
        "MPlayer") echo "media--mplayer.md" ;;
        "Vlc"|"VLC") echo "media--vlc.md" ;;
        "WinTV") echo "media--wintv.md" ;;
        "Screen Capture") echo "media--screen-capture.md" ;;

        # Graphics
        "Adobe Illustrator") echo "graphics--adobe-illustrator.md" ;;
        "Adobe LiveCycle Designer") echo "graphics--adobe-livecycle-designer.md" ;;
        "CorelDraw") echo "graphics--coreldraw.md" ;;
        "DTG Graphic Process") echo "graphics--dtg-graphic-process.md" ;;
        "EPS Optimization") echo "graphics--eps-optimization.md" ;;
        "Ftxdumperfuser") echo "graphics--ftxdumperfuser.md" ;;
        "Goverts GoBatchGS") echo "graphics--goverts-gobatchgs.md" ;;
        "ImageMagick") echo "graphics--imagemagick.md" ;;
        "Photoshop") echo "graphics--photoshop.md" ;;
        "Ps2svg") echo "graphics--ps2svg.md" ;;
        "Sips Command") echo "graphics--sips-command.md" ;;
        "True Type Fonts") echo "graphics--true-type-fonts.md" ;;

        # Config
        ".profile") echo "config--profile.md" ;;
        "Crontab") echo "config--crontab.md" ;;
        "Samba") echo "config--samba.md" ;;
        "Vsftpd") echo "config--vsftpd.md" ;;
        "Webmin") echo "config--webmin.md" ;;
        "Linux Modules") echo "config--linux-modules.md" ;;
        "Linux Time") echo "config--linux-time.md" ;;
        "Linux userdel") echo "config--linux-userdel.md" ;;
        "Time Zone") echo "config--time-zone.md" ;;
        "Daylight Savings Time") echo "config--daylight-savings-time.md" ;;
        "Date") echo "config--date.md" ;;
        "Server Backup") echo "config--server-backup.md" ;;
        "Printers") echo "config--printers.md" ;;

        # Misc (explicit entries)
        "Acronis") echo "misc--acronis.md" ;;
        "Android OS") echo "misc--android-os.md" ;;
        "Apple TV") echo "misc--apple-tv.md" ;;
        "Azureus") echo "misc--azureus.md" ;;
        "CMsort") echo "misc--cmsort.md" ;;
        "Dee Jay Instructions") echo "misc--dee-jay-instructions.md" ;;
        "E61i") echo "misc--e61i.md" ;;
        "Emcast") echo "misc--emcast.md" ;;
        "Excel") echo "misc--excel.md" ;;
        "Excel Mulit File Query") echo "misc--excel.md#multi-file-query" ;;
        "Finder") echo "misc--finder.md" ;;
        "Firefox") echo "misc--firefox.md" ;;
        "Firefox Printing") echo "misc--firefox.md#printing" ;;
        "Firefox Profiles") echo "misc--firefox.md#profiles" ;;
        "Firefox SVG") echo "misc--firefox.md#svg" ;;
        "Flash") echo "misc--flash.md" ;;
        "Git") echo "misc--git.md" ;;
        "Internet Slang") echo "misc--internet-slang.md" ;;
        "Java") echo "misc--java.md" ;;
        "Lookupd Mac OS X") echo "misc--lookupd-macos.md" ;;
        "Mac OS X Preview") echo "misc--macos-preview.md" ;;
        "MediaWiki BreadCrumbs") echo "misc--mediawiki-breadcrumbs.md" ;;
        "Microsoft Outlook") echo "misc--microsoft-outlook.md" ;;
        "Negative Ping Time") echo "misc--negative-ping-time.md" ;;
        "Printful") echo "misc--printful.md" ;;
        "Quotes") echo "misc--quotes.md" ;;
        "Send Attachments From Terminal") echo "misc--send-attachments-terminal.md" ;;
        "Special Characters") echo "misc--special-characters.md" ;;
        "Strototime") echo "misc--strototime.md" ;;
        "Subversion") echo "misc--subversion.md" ;;
        "Temperature Conversion") echo "misc--temperature-conversion.md" ;;
        "Terminal Linux") echo "misc--terminal-linux.md" ;;
        "Terminal Mac OS X") echo "misc--terminal-macos.md" ;;
        "Visio") echo "misc--visio.md" ;;
        "What is this program") echo "misc--what-is-this-program.md" ;;
        "Widgets") echo "misc--widgets.md" ;;
        "WikiMarkUp") echo "misc--wikimarkup.md" ;;

        # Default: generate filename from title
        *)
            local slug
            slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g; s/[^a-z0-9-]//g')
            echo "misc--${slug}.md"
            echo "WARNING: Unknown link target '$title'" >&2
            ;;
    esac
}
