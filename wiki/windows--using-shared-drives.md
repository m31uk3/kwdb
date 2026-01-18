# Using Shared Drives


## Introduction

If you are connected to the local network at one of offices you are able to connect to a shared drive.

Using shares from other locations is a feature which should be used only when needed as they will be a lot slower than local shares. If you are noticing a significant performance degradation, simply [ Disconnect the Shared Drive](misc--.md#disconnect-shared-drive-).

## Map Shared Drive

### Windows XP

- Open My Computer and click on the Tools Sub-Menu from the Menu bar.
- Select **Map Network Drive...**
- A box should appear prompting you for login credentials and desired resource.
- Drive: This is automatically configured by the operating system and should not need to be modified.
- Folder: This is the desired location you wish to access and should be in the form specified below:
```bash
\\<Server>\<Share>
```
Once you have found the correct URI paste it into the Folder box and click **Finish**.
- You should now be prompted for a Username and Password this should be the same password you use to log into your computer (If you are a part of the Windows Domain) otherwise please see IT to have a Domain account created for you. Click **Ok** and the Share should then be mapped and accessible from the **My Computer** window.

### Linux

To mount windows shares in Linux, the SMB client must be installed on the Linux workstation. Connectivity to share can be achieved several ways. The easiest it using KDE Konqueror or Nautilus to connect to the share. Both GUI interfaces have a Location tool bar. Inputting the following will permit a prompt for login 
SMB://servername/share/path 

If the destination server is in a MS Windows Domain, then the user id must be entered in the following syntax.
domainname\userid

This will permit the correct user credentials. 

Other methods for mounting remote shares in a GUI are SMB4K. Which provides a GUI that supports CIFS mounting. 
http://freshmeat.net/projects/smb4k/

Other options would be to modify the /etc/mtab file to mount with smbfs or cifs.

### Mac OS X

Open Finder and from the Go menu select **Connect to Server...** (Apple + K)

A windows should appear prompting you for the server address:

```bash
smb://server/share

```
To save the URI as a favorite click on the plus sign to the right of the text field.
Click **Connect** and it will initiate communications with the server. You may be prompted to authenticate depending on the servers configuration.

### Mac OS X 10.4: Error -36 alert displays when connecting to a Windows server

Mac OS X 10.4: Error -36 alert displays when connecting to a Samba or Windows server

After upgrading from Mac OS X 10.3.x to Mac OS X 10.4, you may get an error message when you try to connect to a Samba or Windows (SMB/CIFS) server. A Samba or Windows (SMB/CIFS) server includes servers operating on Microsoft Windows and other operating systems that use Samba for SMB/CIFS services.

If the connection is unsuccessful, the following error message may appear:

```bash
The Finder cannot complete the operation because some of the data in smb://........ could not be read or written. (Error code -36). 

```
If you check the Console (/Applications/Utilities/), you will also see this error message:

```bash
mount_smbfs: session setup phase failed 

```
This error can occur if your Mac OS X 10.4 client is trying to connect to a Samba or Windows (SMB/CIFS) server that only supports plain text passwords. If you do not see the above message in the Console, you are not experiencing this issue and should try normal troubleshooting to isolate the source of the issue.

Unlike Mac OS X 10.3, the Mac OS X 10.4 SMB/CIFS client by default only supports encrypted passwords. Most modern Samba or Windows (SMB/CIFS) servers use encrypted passwords by default, while some Samba servers might have to be reconfigured.

You should consider contacting the owner or system administrator of the Samba or Windows (SMB/CIFS) server to which you are trying to connect and encourage them to disable plain text passwords and start using encrypted ones. If the server cannot be reconfigured to support encrypted passwords, you can configure Mac OS X 10.4 SMB/CIFS client to send plain text passwords.

Warning: If you configure your computer to allow connections to Samba or Windows (SMB/CIFS) servers using plain text passwords, when you attempt to make any connection to such a Samba or Windows (SMB/CIFS) server, your password will be sent "in the clear". This means that it is possible for someone who is monitoring your connection to see your password. This could lead to someone compromising the Samba or Windows (SMB/CIFS) server. We strongly recommend that you configure your Samba or Windows (SMB/CIFS) servers to exclusively use encrypted passwords.

Follow the steps below to configure your computer to use plain text passwords to make SMB/CIFS connections when the specified Samba or Windows (SMB/CIFS) server does not support encrypted passwords. (You must be an administrator to do these steps.)

1. Make sure that you are not currently connected to any Samba or Windows (SMB/CIFS) servers and that you do not have any Samba or Windows-related error messages open.
1. Open the Terminal (/Applications/Utilities/).
1. At the prompt, type: sudo pico /etc/nsmb.conf
1. Press Return.
1. Enter your password when prompted, then press Return again.
1. You should see an empty file and a "New File" notice at the bottom of the pico window. If you do not see the "New File" notice, this file already exists.
1. Enter the following into the file so that it appears as follows:

```bash
[default]
minauth=none

```
1. Save the file (press Control-O), press Return, then exit pico (Control-X).
1. Type: sudo chmod a+r /etc/nsmb.conf
1. Press Return.
1. Restart your computer.
1. You can also get away with running the following command as root:
```bash
service smbd stop
service smbd start

```
- http://docs.info.apple.com/article.html?artnum=301580

## Disconnect Shared Drive

### Windows XP

- Open My Computer and click on the Tools Sub-Menu from the Menu bar.
- Select **Disconnect Network Drive...**
- A new window should appear which displays the current mapped drives.
- Simply highlight (By Clicking Once) on the desired drive to be disconnected and click **OK**.

### Linux

### Mac OS X

Open Finder and simply click on the **Eject** icon to the right of the share.

## Sharing a Drive or Folder

### Windows XP

**Remove Simple File-sharing**

Double click on My computer to launch File Explorer. From the menu bar choose **Tools >> Folder Options**. This will launch the Folder Options window, click once on the View tab, from the list below locate Use simple file sharing (Recommended) and Un-check this box and click OK to apply the changes.

**Create Share (Simple File-sharing Off)**

- Double click on My computer to launch File Explorer.
- Right click on the folder or drive you wish to share and choose **Sharing and Security**.
- From the Properties window click on the **New Share** button. This will launch the New Share window. Here you should configure the following:
- Share name
- Comment
- Permissions (For Guest / No Password Shares ensure the Everyone group has the level of access you desire)
- User Limit

Click OK on all windows to apply the changes .

### Mac OS X

### Linux

## Configure Guest / No Password Share

### Windows XP

The following 3 steps will configure a share in Windows XP Professional without a password using the built-in Guest account.

- Step 1: Right click on **My Computer** and choose **Manage**. Choose **Local Users and Groups** from the left navigation bar. Double click **Users** in the main frame. Find the Guest account in the list, right click and choose **Properties**. Un-check the check box **Account is Disabled**. Click **OK** to apply the changes. Close all open windows and proceed to Step 2.

- Step 2: Double click on **My computer** to launch File Explorer. From the menu bar choose **Tools >> Folder Options**. This will launch the Folder Options window, click once on the **View** tab, from the list below locate **Use simple file sharing (Recommended)** and Un-check this box and click **OK** to apply the changes. Close all open windows and proceed to Step 3.

- Step 3: Click **Start >> Control Panel**, choose **Administrative Tools**, choose **Local Security Policy**. From the left navigation bar choose **Local Policies**, now from the main frame choose **User Rights Assignment**. Double click on the policy **Deny access to this computer from the network**, Select **Guest** from the window and click **Remove**. Click **OK** to apply the changes. Close all open windows and reboot your computer.

Follow the instructions for creating a regular share and attempt to map this share from another computer without issuing credentials. Windows will automatically map the connection to the guest account.

**Note:** Please remember when creating shares the **Guest** account will inherit the privileges from the **Everyone** group.

**Tags**: 3 step no password share, passwordless share, guest share, windows xp pro share

### Mac OS X

### Linux

