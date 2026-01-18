# Remote Desktop


## How to enable Remote Desktop remotely

In a case you want to remote access a Windows XP professional workstation and the computer Remote Desktop is not enabled, or no one over there to help you to enable it, you may have an option to enable Remote Desktop remotely by using regedit.

To enabling Remote Desktop using regedit, follow these steps:

1. Run REGEDIT from Start>Run
1. Click on File, then select Connect Network Registry
1. Type the remote computer IP or host name in the Enter the object name to select and the click OK.

4. If you don't have permission to access the remote computer, the logon screen will show up. Type the username and password for the remote computer. Then click OK.

5. Now, the remote computer is listed in the Registry Editor.

6. Browse to:

```bash
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server

```
in the right panel, seelct **fDenyTSConnection** (REG_DWORD).

Change the value:

- **1** (Remote Desktop disabled)
- **0** (Remote Desktop enabled)

7. Close the regeidt.

### Sources

- http://www.howtonetworking.com/RemoteAccess/enablerdc1.htm
