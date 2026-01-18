# Wiki Content Analysis: wiki.ljackson.us

**Research Date:** 2026-01-17
**Status:** Partial - Wiki server currently unavailable (ECONNREFUSED)
**Data Sources:**
- Article index from `/Users/ljack/Library/Mobile Documents/iCloud~md~obsidian/Documents/m31uk3/Clippings/All articles - Luke Jackson.md`
- Target format analysis from existing KWDB markdown files

---

## Server Status

The MediaWiki instance at `wiki.ljackson.us` was unavailable during this research session. Both HTTP and HTTPS connections returned `ECONNREFUSED` errors. Internet Archive (Wayback Machine) access was also not available.

**Recommendation:** Retry content fetching when server is restored, or consider local database export if available.

---

## Wiki Content Overview (from Index)

### Total Article Count
Approximately **152 articles** identified from the "All articles" index page.

### Content Categories

Based on article titles, the content spans these major categories:

#### 1. Unix/Linux Commands (~40 articles)
| Topic | Count | Examples |
|-------|-------|----------|
| Shell/Bash | 5+ | Bash, Bash Scripts, Bash Random Word, Bash Rename File Extensions, Bash Sort IP Addresses |
| File Operations | 10+ | Find Command, Grep Command, Awk Command, Sed Command, Ls Command, Du Command, Chmod |
| Text Processing | 5+ | Tr Command, Xargs Command, Regular Expressions |
| System Admin | 10+ | Crontab, Mount Command, History Command, Proc, SELinux, Tune2fs |

#### 2. Asterisk VoIP (~12 articles)
- Asterisk (main)
- Asterisk Dialplan
- Asterisk Echo
- Asterisk Firewall
- Asterisk Front End
- Asterisk Install
- Asterisk Logs
- Asterisk Queue
- Asterisk Sipgate
- Asterisk Tutorial
- Asterisk Voice Changer
- FreeBPX, QueueMetrics, Eyebeam (related tools)

#### 3. Networking & Security (~15 articles)
- SSH, Public Key Authentication, Secure Copy (SCP), Secure Copy SCP
- Fail2ban, OpenSSL, Firewall ipfw, Windows XP Firewall
- DHCPd, Linux DNS, Linux Network Config, Network Time Protocol
- Rsync, Wget Command, Curl

#### 4. Windows Administration (~20 articles)
- Command Prompt, DiskPart, Del Command, For Command, Net Use Command
- Group Policy, Group Policy 1085, GPO Error 1085
- Remote Desktop, Remote Shutdown, Remote User Discovery
- Windows 2003 Shares, Windows 7, Windows Vista, Windows XP Firewall
- Control Userpasswords2, Defrag Tool Windows XP, Disk Clean Up Tool Windows XP

#### 5. Version Control
- Git
- Subversion

#### 6. Web/Database Technologies (~10 articles)
- Apache, PHP, PHP Install
- MySQL, PostgreSQL
- JavaScript, Java
- Postfix

#### 7. Media Tools (~15 articles)
- Ffmpeg, MEncoder, MPlayer, Vlc
- ImageMagick, Sips Command
- Ivtv, Ivtv-channel, WinTV, Lirc

#### 8. Design/Graphics Software (~10 articles)
- Adobe Illustrator, Adobe LiveCycle Designer
- Photoshop, CorelDraw
- EPS Optimization, Ps2svg

#### 9. Configuration Files (~5 articles)
- .profile
- Crontab
- Samba
- Vsftpd
- Webmin

#### 10. Miscellaneous
- WikiMarkUp (meta documentation)
- Internet Slang, Quotes
- Temperature Conversion, Special Characters
- Various hardware/device topics (E61i, Bluetooth, Apple TV, Android OS)

---

## Content Structure Patterns (Inferred)

Based on MediaWiki conventions and article naming patterns:

### Likely Article Structures

#### Command Reference Articles
Pattern: `[Command Name] Command` (e.g., "Find Command", "Grep Command")
Expected structure:
- Basic usage/syntax
- Common flags and options
- Examples
- Related commands

#### Software/Tool Articles
Pattern: `[Tool Name]` (e.g., "Asterisk", "Git", "SSH")
Expected structure:
- Overview/description
- Installation (some have dedicated install pages like "Asterisk Install", "PHP Install")
- Configuration
- Common tasks/usage

#### Troubleshooting Articles
Pattern: `[Topic] [Error]` (e.g., "GPO Error 1085", "Group Policy 1085", "Negative Ping Time")
Expected structure:
- Problem description
- Cause
- Solution steps

#### Tutorial/Howto Articles
Pattern: `[Topic] Tutorial` or task-oriented names
Expected structure:
- Prerequisites
- Step-by-step instructions
- Verification steps

---

## Topic Relationships

Several topics have related sub-articles suggesting depth:

### Asterisk Cluster (12 articles)
```
Asterisk (main)
├── Asterisk Install
├── Asterisk Dialplan
├── Asterisk Queue
├── Asterisk Logs
├── Asterisk Firewall
├── Asterisk Echo
├── Asterisk Front End
├── Asterisk Sipgate
├── Asterisk Tutorial
└── Asterisk Voice Changer
```

### Bash Cluster (5 articles)
```
Bash (main)
├── Bash Scripts
├── Bash Random Word
├── Bash Rename File Extensions
└── Bash Sort IP Addresses
```

### Firefox Cluster (4 articles)
```
Firefox (main)
├── Firefox Printing
├── Firefox Profiles
└── Firefox SVG
```

### Windows Terminal Cluster (3 articles)
```
Terminal Linux
Terminal Mac OS X
Terminal Windows XP
```

### SSH/SCP Cluster (4 articles)
```
SSH
├── Public Key Authentication
├── Secure Copy (SCP)
├── Secure Copy SCP
└── Mac OS X SCP (GUI)
```

---

## Target Format Analysis (KWDB Repository)

Existing markdown files in the repository demonstrate the target format:

### Format Characteristics

#### 1. Document Structure
- Clear title as H1 header
- Metadata/context section at top
- Logical section hierarchy with H2/H3 headers
- Horizontal rules (`---`) to separate major sections

#### 2. Content Elements
- **Tables** for quick reference (keyboard shortcuts, comparisons)
- **Code blocks** with language specification (```bash, ```yaml, etc.)
- **Inline code** for commands and file paths
- **Bold text** for emphasis on key terms
- **Bullet lists** for enumerated items

#### 3. Section Patterns Observed

From `tmux-knowledge.md`:
- Quick Reference (tables)
- Workflow sections (narrative with commands)
- FAQ section
- Source Validation section

From `dev-tools--git-best-practices.md`:
- Context (issue identification)
- Solutions with code examples
- Priority Recommendations
- Quick Reference Commands
- Setup Checklist

From `shell-basics-taxonomy.md`:
- Conceptual explanations
- Taxonomy/categorization
- Mental models
- Session metadata

#### 4. Writing Style
- Direct, instructional tone
- Command explanations follow pattern: "Do X with `command`"
- Workflow descriptions explain "why" not just "how"
- FAQ format for common questions

---

## Migration Considerations

### Content Quality Assessment (Estimated)

| Category | Article Count | Expected Depth | Migration Priority |
|----------|--------------|----------------|-------------------|
| Unix/Linux Commands | ~40 | Medium-High | High |
| Asterisk VoIP | ~12 | High (specialized) | Medium |
| Windows Admin | ~20 | Low-Medium | Low |
| Networking/Security | ~15 | Medium | High |
| Version Control | 2 | Medium | High |
| Web/DB Tech | ~10 | Low-Medium | Medium |
| Obsolete Topics | ~20+ | N/A | Skip |

### Potential Issues

1. **Duplicate content**: "Secure Copy (SCP)" and "Secure Copy SCP" appear to be duplicates
2. **Outdated content**: Windows XP, Windows Vista topics may be obsolete
3. **Varying quality**: Article depth likely varies significantly
4. **MediaWiki markup**: Will need conversion to standard markdown

### Content Requiring Manual Review

- Articles with parentheses in titles (MediaWiki URL encoding)
- Error/troubleshooting articles (may be time-sensitive)
- Hardware-specific articles (E61i, Apple TV - may be obsolete)

---

## Next Steps

1. **Retry server access** - Wiki may be temporarily down
2. **Request database export** - If MediaWiki XML dump is available
3. **Prioritize fetch order** - Start with high-value, evergreen content
4. **Create content templates** - Based on target KWDB format
5. **Establish quality criteria** - For filtering migration candidates

---

## Appendix: Full Article List

### A-B
- .profile
- Acronis
- Adobe Illustrator
- Adobe LiveCycle Designer
- Airport Config
- Android OS
- Apache
- Apple TV
- Asterisk
- Asterisk Dialplan
- Asterisk Echo
- Asterisk Firewall
- Asterisk Front End
- Asterisk Install
- Asterisk Logs
- Asterisk Queue
- Asterisk Sipgate
- Asterisk Tutorial
- Asterisk Voice Changer
- Awk Command
- Azureus
- Bash
- Bash Random Word
- Bash Rename File Extensions
- Bash Scripts
- Bash Sort IP Addresses
- Bluetooth

### C-D
- CD Burning Windows Domain
- CMsort
- Change MTU Size
- Chmod
- Cisco
- Command Prompt
- Control Userpasswords2
- CorelDraw
- Crontab
- Curl
- DHCPd
- DTG Graphic Process
- DVD Region Codes
- Date
- Daylight Savings Time
- Dee Jay Instructions
- Defrag Tool Windows XP
- Del Command
- DiskPart
- Disk Clean Up Tool Windows XP
- DivX Codecs
- Du Command

### E-F
- E61i
- EPS Optimization
- Emcast
- Excel
- Excel Multi File Query
- Eyebeam
- Facebook
- Fail2ban
- Ffmpeg
- Find Command
- Finder
- Firefox
- Firefox Printing
- Firefox Profiles
- Firefox SVG
- Firewall ipfw
- Flash
- For Command
- FreeBPX
- Ftxdumperfuser

### G-L
- GPO Error 1085
- Git
- Goverts GoBatchGS
- Greasemonkey
- Grep Command
- Group Policy
- Group Policy 1085
- History Command
- ImageMagick
- Internet Slang
- Ivtv
- Ivtv-channel
- Java
- JavaScript
- Linux DNS
- Linux Hostname
- Linux Modules
- Linux Network Config
- Linux Time
- Linux userdel
- Lirc
- Logonscript.vbs
- Lookupd Mac OS X
- Ls Command

### M-N
- MEncoder
- MPlayer
- Mac OS X Preview
- Mac OS X SCP (GUI)
- Main Page
- MediaWiki BreadCrumbs
- Microsoft Outlook
- Mount Command
- Mysql
- NTFS
- Negative Ping Time
- Net Use Command
- Network Time Protocol

### O-R
- OpenSSL
- PHP
- PHP Install
- Photoshop
- Postfix
- PostgreSQL
- Printers
- Printful
- Proc
- Ps2svg
- Public Key Authentication
- QueueMetrics
- Quotes
- Regular Expressions
- Remote Desktop
- Remote Shutdown
- Remote User Discovery
- RoboCopy
- Rsync

### S
- SELinux
- SSH
- Samba
- Screen
- Screen Capture
- Secure Copy (SCP)
- Secure Copy SCP
- Sed Command
- Send Attachments From Terminal
- Server Backup
- Sips Command
- Special Characters
- Strototime
- Subversion

### T-Z
- Temperature Conversion
- Terminal Linux
- Terminal Mac OS X
- Terminal Windows XP
- Time Zone
- Tr Command
- True Type Fonts
- Tune2fs
- Using Shared Drives
- Vi Command
- Visio
- Visual Basic Script
- Vlc
- Vsftpd
- Webmin
- Wget Command
- What is this program
- Widgets
- WikiMarkUp
- WinTV
- Windows 2003 Shares
- Windows 7
- Windows Vista
- Windows XP Firewall
- Wireless Configuration
- XP Registry Shortcuts
- Xargs Command
- Xmlstarlet

---

*Analysis completed: 2026-01-17*
*Note: Direct content analysis pending server availability*
