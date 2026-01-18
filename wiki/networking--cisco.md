# Cisco


## Error 51 unable to communicate with vpn subsystem

Older Versions

```bash
sudo /System/Library/StartupItems/CiscoVPN/CiscoVPN restart

```
Newer Versions

```bash
sudo kextload /System/Library/Extensions/CiscoVPN.kext
```
