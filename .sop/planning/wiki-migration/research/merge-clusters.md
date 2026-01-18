# Merge Clusters

**Research Date:** 2026-01-18

This document identifies groups of related wiki articles that should be consolidated into single comprehensive documents during migration.

---

## Cluster 1: Asterisk VoIP (11 → 1)

**Target File:** `voip--asterisk.md`

| Source Article | Content Type |
|----------------|--------------|
| Asterisk | Main overview, introduction |
| Asterisk Install | Installation guide |
| Asterisk Dialplan | Configuration |
| Asterisk Queue | Feature: call queues |
| Asterisk Logs | Troubleshooting/logging |
| Asterisk Firewall | Security configuration |
| Asterisk Echo | Testing/diagnostics |
| Asterisk Front End | GUI tools |
| Asterisk Sipgate | SIP provider setup |
| Asterisk Tutorial | Getting started |
| Asterisk Voice Changer | Advanced feature |

**Merged Structure:**
```
# Asterisk

## Overview
## Installation
## Configuration
### Dialplan
### Queues
## Logging and Troubleshooting
## Security
### Firewall Configuration
## Integrations
### Sipgate Setup
## Advanced Features
### Voice Changer
### Echo Test
## Front End Tools
## Sources
```

---

## Cluster 2: Bash Shell (5 → 1)

**Target File:** `shell--bash.md`

| Source Article | Content Type |
|----------------|--------------|
| Bash | Main overview |
| Bash Scripts | Scripting examples |
| Bash Random Word | Utility script |
| Bash Rename File Extensions | Utility script |
| Bash Sort IP Addresses | Utility script |

**Merged Structure:**
```
# Bash

## Overview
## Scripting Basics
## Utility Scripts
### Random Word Generator
### File Extension Renaming
### IP Address Sorting
## Sources
```

---

## Cluster 3: Firefox (4 → 1)

**Target File:** `misc--firefox.md`

| Source Article | Content Type |
|----------------|--------------|
| Firefox | Main overview |
| Firefox Printing | Feature/troubleshooting |
| Firefox Profiles | Configuration |
| Firefox SVG | Feature notes |

**Merged Structure:**
```
# Firefox

## Overview
## Profiles
## Printing
## SVG Support
```

---

## Cluster 4: SCP/Secure Copy (3 → 1)

**Target File:** `security--scp.md`

| Source Article | Content Type |
|----------------|--------------|
| Secure Copy (SCP) | Main reference |
| Secure Copy SCP | Duplicate content |
| Mac OS X SCP (GUI) | Platform-specific |

**Merged Structure:**
```
# Secure Copy (SCP)

## Overview
## Basic Usage
## Mac OS X GUI Tools
## Examples
```

---

## Cluster 5: Group Policy (2 → 1)

**Target File:** `windows--gpo-error-1085.md`

| Source Article | Content Type |
|----------------|--------------|
| GPO Error 1085 | Troubleshooting |
| Group Policy 1085 | Same issue, different title |

*Note: "Group Policy" main article stays separate as `windows--group-policy.md`*

---

## Cluster 6: PHP (2 → 1)

**Target File:** `web--php.md`

| Source Article | Content Type |
|----------------|--------------|
| PHP | Main overview |
| PHP Install | Installation guide |

**Merged Structure:**
```
# PHP

## Overview
## Installation
## Configuration
## Examples
```

---

## Cluster 7: Ivtv (2 → 1)

**Target File:** `media--ivtv.md`

| Source Article | Content Type |
|----------------|--------------|
| Ivtv | Main driver info |
| Ivtv-channel | Channel configuration |

---

## Cluster 8: Excel (2 → 1)

**Target File:** `misc--excel.md`

| Source Article | Content Type |
|----------------|--------------|
| Excel | Main reference |
| Excel Mulit File Query | Advanced feature |

---

## Summary

| Cluster | Source Count | Target Count | Net Reduction |
|---------|--------------|--------------|---------------|
| Asterisk | 11 | 1 | -10 |
| Bash | 5 | 1 | -4 |
| Firefox | 4 | 1 | -3 |
| SCP | 3 | 1 | -2 |
| Group Policy | 2 | 1 | -1 |
| PHP | 2 | 1 | -1 |
| Ivtv | 2 | 1 | -1 |
| Excel | 2 | 1 | -1 |
| **Total** | **31** | **8** | **-23** |

---

## Merge Priority

1. **High Priority** (large reduction, high value):
   - Asterisk cluster (11 → 1)
   - Bash cluster (5 → 1)

2. **Medium Priority** (moderate reduction):
   - Firefox cluster (4 → 1)
   - SCP cluster (3 → 1)

3. **Low Priority** (small reduction):
   - PHP, Ivtv, Excel, Group Policy (2 → 1 each)

---

## Merge Guidelines

1. **Section Headers**: Use parent article title as H1, sub-articles become H2/H3 sections
2. **Deduplication**: Remove duplicate content when merging
3. **Cross-references**: Update internal links to point to merged sections with anchors
4. **Source Attribution**: Maintain sources from all merged articles
5. **Content Order**: Logical flow (overview → installation → configuration → usage → troubleshooting)

---

*Analysis completed: 2026-01-18*
