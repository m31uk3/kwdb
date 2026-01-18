# Microsoft Outlook


## Create New E-Mail Account

### Summary



If this is a new installation of Microsoft Outlook on first launch you see the Outlook Startup screen. (As pictured on the left) Click Next to proceeded to the next screen where you will be asked if you would like to setup a Mail Account. Answer Yes and then click Next to proceed.

If it is not the first time you have started outlook or you would just like to add an additional account you will need to access the E-Mail Accounts Wizard by selecting the Tools sub-menu from the menu bar and choosing E-mail Accounts...

### Step 1 - E-Mail Protocols

Deciding on which protocol to use can sometimes be an overwhelming task. Below are some short descriptions of the most commonly used protocols, hopefully this will help you choose the best one for your needs.



**POP3**

If you are **not** always connected to the internet and would like to store you eMail messsages on your local machine choose POP3 on this screen.

**IMAP**

If you are **always** connected to the internet and would rather store your eMail messages on the remote server choose IMAP on this screen.

**Microsoft Exchange**

If you are using an Exchange server and are a member of a domain choose Microsoft Exchange on this screen.

### Step 2 - Account Information &amp; Settings



Complete all of the requested information (As shown on right) with the correct settings supplied by your provider.

Also you should be aware on whether or not your provider supports Secure Password Authentication. If this option is configured incorrectly it is likely that you may not be able to send or receive E-Mails. 

- E-mail Address: email@domain.ext
- Mail Servers: mail.server.com
- User Name: username@domain.ext - This can be different from your email address if you are using an alias.
- Password: yourpassword - Example: "i1ov31inux"

Click on More Settings... to continue with Step 3.

### Step 3 - More Account Settings

<gallery caption="Account Settings Tabs">
Image:Ms outlook settings general.jpg|General
Image:Ms outlook settings outgoing.jpg|Outgoing Server
Image:Ms outlook settings connect.jpg|Connection
Image:Ms outlook settings adv std pop3.jpg|Advanced (POP3)
Image:Ms outlook settings adv std imap.jpg|Advanced (IMAP)
</gallery>

After you clicked on More Settings... it should have launched a window similar to the one(s) above.

**General Tab**

If you would like you can change the name of the mail account by simply typing your desired name in the Mail Account box as shown above. This is not necessary but it helps organize your accounts if you have more than one. - (By default your account takes the name of the mail server)

**Outgoing Server Tab**

If your provider (Hopefully) offers SMTP Authentication then it is required that you authenticate with the server prior to sending messages to users not on the local system.

You will have to check the following options. (Displayed on the left)

- My outgoing server (SMTP) requires authentication
- Use same settings as my incoming mail server

If your provider uses a different authentication database you may have to change the settings on this screen for everything to work correctly.

Now Outlook will pass the same Username and Password you provided earlier and allow messages to be sent externally.

**Connection Tab**

This tab is for configuring a modem to connect you to the internet when outlook is off line or in other words you are not connected to the Local Area Network. This option is pretty much outdated as WiFi and LANs become more common. However it still has a practical use for road warriors with cellular cards.

**Advanced Tab**

The Advanced Tab is by far the most complex and confusing, but thankfully the last tab you have to configure. Depending on which account type you chose in Step 1 you will have to choose the same type here.

***POP3**

**Standard Port: 110
**Secure Port: 995
**Server Timeouts: 1 Minute - The default of 1 Minute should be good for most situations.
**Leave a copy of messages on the server: This enables you to use multiple computers with POP3.
**Remove from server after 10 days: Sets the default lifetime of a message.
**Remove from server when deleted from 'Deleted Items': Determines if a message is deleted when it is removed from the 'Deleted Items' folder.

***IMAP**

**Standard Port: 143
**Secure Port: 993
**Server Timeouts: 1 Minute 30 Seconds - The default of 1 Minute is sometimes to short for large attachments so I recommend 1 Minute 30 Seconds
**Root folder Path: Allows you to specify a different starting path for your IMAP folder. This would be required to be configured on the server.

***SMTP**

**Standard Port: 25
- This server requires an encrypted connection (SSL)

Click OK to apply these settings and be returned to the Account Information &amp; Settings screen.

### Step 4 - Finalize Account Information &amp; Settings



Now you have completed all the required steps to configure Microsoft Outlook with an E-Mail account. Take one last look at the information you provided to ensure everything is accurate and press next to create your account and continue to the final screen.

You should now see a finish screen explaining that you have successfully created your account and can press the Finish button to start using Outlook. (As shown on right)

Once again if this is not the first time you have run Outlook you will be returned to the the E-mail Accounts window where you can simply click Next to complete the wizard and activate your new email account. Lastly click finish and you will be returned to Outlook.

Now you should be looking at the main interface to Outlook and should be able to send and receive E-Mail messages.

## Permanently Delete IMAP eMails

When using IMAP your eMails are stored on the SMTP server rather than on your local disk. Because of this you when you delete a message, it still displays the message but puts a line through it. It will remain on the server until they are “purged,” taking up space and viewable in other clients (such as webmail).

**To permanently remove your deleted emails, choose Edit > Purge Deleted Messages.**

**To add the Purge Deleted Messages button to your Outlook toolbar**

1. Choose View | Toolbars > Customize…
1. Choose the Commands tab and click on the Edit Category.
1. Scroll down the commands list and select Purge Deleted Messages.

## Export E-Mail Account Data

All of the account data is stored in the registry. To export this data simple export to file the following registry key.

```bash
HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles\Outlook

```
To import these account settings on a new machine simple merge the registry file with the active registry and relaunch Outlook.

**Note:** It may be necessary to restart Outlook once again in order for it to update internal linking correctly.

## Export E-Mail Data

All of the eMail data for Outlook is stored in two folders under your profile:

```bash
\Documents and Settings\<username>\Application Data\Microsoft\Outlook

```
and

```bash
\Documents and Settings\<username>\Local Settings\Application Data\Microsoft\Outlook

```
To import this data into a new Outlook installation simply launch Outlook after a fresh install and **DO NOT** configure an email address **BUT** finish the wizard. It will go through creating a .dat file and generating a welcome message. Once this is completed exit Outlook.

Browse to the folder paths listed above and remove and files that were created by Outlook. Now copy your original files into these folders and relaunch outlook. If you are alerted that your .dat file can not be found simply click ok and it will allow you to browse and locate it.

**Note:** You can also use this method to change the location of your .dat file.

**Note:** It may be necessary to restart Outlook in order for it to update internal linking correctly.

## Desktop Notification of New E-Mail Messages

### POP3

This is configured to work by default.

### IMAP

You will have to create a E-Mail Rule in order for this to work.

Under the **Tools** menu select **Rules and Alerts**...

Next click on the **New Rule...** icon and a new window will be launched...

Under the **Stay Up to Date** section choose **Display mail from someone in the New Item Alert Window** and click Next.

You can now choose the conditions (Messages you want to include) you would like to set for this rule.
Because we are trying to mimic the POP3 functionality lets choose only the following options un-checking any others that may have been checked by default.

- On this machine only

Press Next to continue to the next screen...

On this screen we will have to choose the actions (What we want to happen) when a message matches our conditions.

Ensure that only the following option(s) are checked:

- Display a Desktop Alert

Press Next to continue to the next screen...

Now lets set our exceptions (Messages we want to exclude). The default value of all options unchecked should be adequate here.

Press Next to continue...

Finally we can finish the rule setup.

Give your rule a name and make sure it has an interesting name such as **Globally Vital Message Notification Function**. Next ensure that the following options are checked:

- Turn on this rule
- Create this rule on all accounts

Press Finish to apply the rule and enjoy your Desktop Alerts with IMAP.

