# Logonscript.vbs


By Mark D. MacLachlan, The Spiders Parlor
http://www.thespidersparlor.com

## Summary

After posting an uncountable number of versions of my ever evolving login script, I finally promised myself to make an FAQ out of it, so here it is.  That's right, I am spilling all my best kept secrets right here!

Login scripts in Windows 2000 and Windows 2003 are leaps and bounds ahead of the old BAT files and **KIXTART** that were often used back in the NT 4 days.  If you are still using batch files, it is time for you to move ahead and see what vbscript can do for you.

Through the use of login scripts, administrators can have a central location to configure all the users in an environment.

What kind of things can you do?  How about:

1. Disconnect network drives
1. Map network drives
1. Map network drives based on a group membership
1. Disconnect network printers
1. Connect network printers
1. Set the default printer
1. Modify the registry
1. Have the PC say good morning

OK, you get the idea. Almost anything is possible.  Over time I have been evolving a login script that seems to be quite popular in the forums.  I've rather heavily documented it, look for the green text, so it should be easy for you to follow and modify.

I've decided that rather than replace the entire script when I add new functionality, I'm going to provide Add On code.  You'll then be able to more easily pick and choose which Add Ons to incorporate into your script.  You will find the Add On section near the end of the main script, just look for the red text.  Paste any Add On code in this section.  

If you use my script(s) please give credit where it is due and leave my name on it.  Thanks.

## Logon Script

```

'==========================================================================
'
' NAME: LogonScript.vbs
'
' AUTHOR:  Mark D. MacLachlan, The Spider's Parlor
' URL   : http://www.thespidersparlor.com
' Copyright (c) 2003-2007
' DATE  : 4/10/2003
'
' COMMENT: Enumerates current users' group memberships in given domain.
'          Maps and disconnects drives and printers
'
'==========================================================================


ON ERROR RESUME NEXT

Dim WSHShell, WSHNetwork, objDomain, DomainString, UserString, UserObj, Path


Set WSHShell = CreateObject("WScript.Shell")
Set WSHNetwork = CreateObject("WScript.Network")
'Automatically find the domain name
Set objDomain = getObject("LDAP://rootDse")
DomainString = objDomain.Get("dnsHostName")
'Find the Windows Directory
WinDir = WshShell.ExpandEnvironmentStrings("%WinDir%")

'Grab the user name
UserString = WSHNetwork.UserName
'Bind to the user object to get user name and check for group memberships later
Set UserObj = GetObject("WinNT://" & DomainString & "/" & UserString)

'Grab the computer name for use in add-on code later
strComputer = WSHNetwork.ComputerName


'Disconnect any drive mappings as needed.
WSHNetwork.RemoveNetworkDrive "F:", True, True

'Disconnect ALL mapped drives
Set clDrives = WshNetwork.EnumNetworkDrives
For i = 0 to clDrives.Count -1 Step 2
    WSHNetwork.RemoveNetworkDrive clDrives.Item(i), True, True
Next

'Give the PC time to do the disconnect, wait 300 milliseconds
wscript.sleep 300

'Map drives needed by all
'Note the first command uses the user name as a variable to map to a user share.
WSHNetwork.MapNetworkDrive "H:", "\\server\users\" & UserString,True
WSHNetwork.MapNetworkDrive "U:", "\\server\users",True
WSHNetwork.MapNetworkDrive "X:", "\\server\executables",True

'Now check for group memberships and map appropriate drives
'Note that this checks Global Groups and not domain local groups.
For Each GroupObj In UserObj.Groups
'Force upper case comparison of the group names, otherwise this is case sensitive.
    Select Case UCase(GroupObj.Name)
    'Check for group memberships and take needed action
    'In this example below, ADMIN and WORKERB are groups.
    'Note the use of all upper case letters as mentioned above.
    'Note also that the groups must be Global Groups.
        Case "ADMIN"
            WSHNetwork.MapNetworkDrive "w:", "\\Server\Admin Stuff",True
        Case "WORKERB"
            WSHNetwork.MapNetworkDrive "w:", "\\Server\Shared Documents",True
            'Below is an example of how to set the default printer
            WSHNetwork.SetDefaultPrinter "\\ServerName\PrinterName"
    End Select
Next

'Remove ALL old printers
'Enumerate all printers first, after that you can select the printers you want by performing some string checks
Set WSHPrinters = WSHNetwork.EnumPrinterConnections
For LOOP_COUNTER = 0 To WSHPrinters.Count - 1 Step 2
'To remove only networked printers use this If Statement
    If Left(WSHPrinters.Item(LOOP_COUNTER +1),2) = "\\" Then
      WSHNetwork.RemovePrinterConnection WSHPrinters.Item(LOOP_COUNTER +1),True,True
    End If
'To remove all printers incuding LOCAL printers use this statement and comment out the If Statement above
'WSHNetwork.RemovePrinterConnection WSHPrinters.Item(LOOP_COUNTER +1),True,True
Next

'Remove a specific printer
WSHNetwork.RemovePrinterConnection "\\ServerOld\HP5si",True,True
                                
'Install Printers
WSHNetwork.AddWindowsPrinterConnection "\\Server\HP5si"

'Add On Code goes below this line
'=====================================



'=====================================
'Add On Code goes above this line

'Clean Up Memory We Used
set UserObj = Nothing
set GroupObj = Nothing
set WSHNetwork = Nothing
set DomainString = Nothing
set WSHSHell = Nothing
Set WSHPrinters = Nothing
  

'Quit the Script
wscript.quit
```

## Add on Code

I've had a number of users ask me about taking specific actions based on an individual user name rather than a group.  This scenario only plays out well in very small organizations.  Any organization with over 25 users I recommend creating groups and using the code posted above.  But to help out the users in that Small IT space, here is some sample code for taking action based just on login name.

### Take Action Based On Login Name
```

' Map drives based on login name

Select Case UserString
    Case "Username1"
         WSHNetwork.MapNetworkDrive "P:", "\\Computer or server\share",True

    Case "Username2"
         WSHNetwork.MapNetworkDrive "P:", "\\Computer or server\share",True

    Case "Username3"
         WSHNetwork.MapNetworkDrive "P:", "\\Computer or server\share",True

    Case "Username4"
         WSHNetwork.MapNetworkDrive "P:", "\\Computer or server\share",True
End Select
```

### Set Local Printer to Default
Be careful with this one.  This works great if the user has only a single local printer, but if they have more than one,  for example Adobe PDF Writer then you may not get the results you are looking for.  Whichever local printer is enumerated last will be set as the default.

```
Set WSHPrinters = WSHNetwork.EnumPrinterConnections
For LOOP_COUNTER = 0 To WSHPrinters.Count - 1 Step 2
'Find local printers
    If Left(WSHPrinters.Item(LOOP_COUNTER +1),2) <> "\\" Then
      WSHNetwork.SetDefaultPrinter _              
              (WSHPrinters.Item(LOOP_COUNTER +1))
    End If
Next
```

After applying Windows XP SP2, network printers will notify you every time a print job has completed. The notification seems to drive most people crazy, so here is how to turn it off.

### Turn Off Network Printer Notification Add On
```

' This section of script will prevent the balloon window
' that appears when printing to a network shared printer
' after XP Service Pack 2 is installed.
'=====================================

Path = "HKCU\Printers\Settings\EnableBalloonNotificationsRemote"
WshShell.RegWrite Path, 0 ,"REG_DWORD"
```


OK, so you don't see anything above to make the computer talk and your thinking.. this MARKDMAC guy is such a liar, well yee of little faith....

You can add this code in the Add On section to make the computer say good morning to your users if you like.  smile

### Speak User Name Add On
```
' This Add On demonstates the Microsoft Speach API (SAPI)
'=====================================
Dim oVo
Set oVo = Wscript.CreateObject("SAPI.SpVoice")
oVo.speak "Good Morning " & WSHNetwork.username
```

Response to the speach API has been greater than I had expected.  So I am enhancing the original posting to make it more friendly and less tongue in cheek. (No pun intended)


### Speach API With Greeting
```

'=======================================================
' Determine the appropriate greeting for the time of day.
'=======================================================
Dim HourNow, Greeting
HourNow = Hour(Now)
If HourNow >5 And  HourNow <12 Then
       Greeting = "Good Morning "
Elseif HourNow =>12 And HourNow <16 Then
       Greeting = "Good Afternoon "
Else
       Greeting = "Good Evening "
End If
'=======================================================
'Find the Users Name

Dim GreetName
GreetName = SearchGivenName(objDomain,UserString)

' Use the Microsoft Speach API (SAPI)
'=====================================
Dim oVo
Set oVo = Wscript.CreateObject("SAPI.SpVoice")
oVo.speak Greeting & GreetName

'Modify This Function To Change Name Format
Public Function SearchGivenName(oRootDSE, ByVal vSAN)
    ' Function:     SearchGivenName
    ' Description:  Searches the Given Name for a given SamAccountName
    ' Parameters:   RootDSE, ByVal vSAN - The SamAccountName to search
    ' Returns:      First, Last or Full Name
    ' Thanks To:    Kob3 Tek-Tips FAQ:FAQ329-5688

    Dim oConnection, oCommand, oRecordSet
    
    Set oConnection = CreateObject("ADODB.Connection")
    oConnection.Open "Provider=ADsDSOObject;"
    Set oCommand = CreateObject("ADODB.Command")
    oCommand.ActiveConnection = oConnection
    oCommand.CommandText = "<LDAP://" & oRootDSE.get("defaultNamingContext") & _
        ">;(&(objectCategory=User)(samAccountName=" & vSAN & "));givenName,sn,name;subtree"
    Set oRecordSet = oCommand.Execute
    On Error Resume Next
    'Decide which name format to return and uncomment out
    'that line.  Default is first name.
    'Return First Name
    SearchGivenName = oRecordSet.Fields("givenName")
    'Return Last Name
    'SearchGivenName = oRecordSet.Fields("sn")
    'Return First and Last Name
    'SearchGivenName = oRecordSet.Fields("name")
    On Error GoTo 0
    oConnection.Close
    Set oRecordSet = Nothing
    Set oCommand = Nothing
    Set oConnection = Nothing
    Set oRootDSE = Nothing
End Function
```

### Windows Version Overlay Add On
This is one of my personal favorites.  Its function is to add the Windows Version as an overlay above the system tray.  Makes it really easy to know what kind of system you are dealing with.  Place this code in the add on section.

Note: This section won't take affect until the user logs out and back in.

```

'Configure the PC to show the Windows Version and Service Pack
'as an overlay to the desktop above the System Tray
'=====================================
HKEY_CURRENT_USER = &H80000001
strComputer = WSHNetwork.Computername
Set objReg = GetObject("winmgmts:\\" & strComputer & "\root\default:StdRegProv")
strKeyPath = "Control Panel\Desktop"
objReg.CreateKey HKEY_CURRENT_USER, strKeyPath
ValueName = "PaintDesktopVersion"
dwValue = 1
objReg.SetDWORDValue HKEY_CURRENT_USER, strKeyPath, ValueName, dwValue
```

### Start Menu Require Click Add On

Do you hate your Start menu popping open and closing while you move the mouse within it?  I prefer to have to click to open or close an applicaiton folder under my Start Menu.  If you are like me, then this Add On is for you.

```
Dim smpath
smpath = "HKCU\Control Panel\Desktop\"
'the following line will REQUIRE a click in the start menu
'=====================================
WSHShell.RegWrite smpath & "MenuShowDelay","65535","REG_SZ"
'the following line will reverse what this Add On has set.
'to undo what this script has done, comment out the above line and uncomment the following
'WSHShell.RegWrite smpath & "MenuShowDelay","400","REG_SZ"
Set smpath = nothing
```

### Clear Temporary Internet Files on Exit Add On

```
' This code will empty the Temp Internet Files on Exit
'=====================================
Dim tempiepath
tempiepath = "HKCU\Software\Microsoft\Windows\"

WSHShell.RegWrite tempiepath & "ShellNoRoam\MUICache\@inetcplc.dll,-4750","Empty Temporary Internet Files folder when browser is closed","REG_SZ"

WSHShell.RegWrite tempiepath & "CurrentVersion\Internet Settings\Cache\Persistent","0","REG_DWORD"
Set tempiepath = nothing
```

### Rename My Computer Icon with Machine Name

```
'This add on will rename the My Computer icon with the computer name
MCPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
WSHShell.RegWrite MCPath & "\", strComputer, "REG_SZ"
```

Another of my favorite modifications is to add the Command Prompt Here option to my right click menu.  Add this code to your script and you will be able to right click on a folder and choose Command Prompt here.  A command prompt will open up in that folder.

### Command Prompt Here

```
'=====================================
' Command Prompt Here
'=====================================
On Error Resume Next
Dim cppath, cppath2
cppath = "HKCR\Directory\shell\DosHere\"
WSHShell.RegWrite cppath,"Command &Prompt Here:","REG_SZ"
WSHShell.RegWrite cppath & "command\",WinDir & "\System32\cmd.exe /k cd "& Chr(34) & "%1" &Chr(34),"REG_SZ"

cppath2 = "HKCR\Drive\shell\DosHere"
WSHShell.RegWrite cppath2,"Command &Prompt:","REG_SZ"
WSHShell.RegWrite cppath2,"Command &Prompt Here","REG_SZ"
WSHShell.RegWrite cppath2 & "command\",WinDir & "\System32\cmd.exe /k cd "& Chr(34) & "%1" &Chr(34),"REG_SZ"
'=====================================
```

Tired of copying a file to the clipboard, navigating Windows to another folder and pasting?  Add CopyTo Folder to your right click menu.  Don't want a copy but want to move the file?  MoveTo Folder takes care of that for you.

### CopyTo & MoveTo Folder

```
'=====================================
' Copy To Folder
'=====================================
On Error Resume Next
Dim ctmtpath
ctmtpath = "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\"
WSHShell.RegWrite ctmtpath,"CopyTo"
WSHShell.RegWrite ctmtpath & "\CopyTo\","{C2FBB630-2971-11D1-A18C-00C04FD75D13}"
'=====================================

'=====================================
' Move To Folder
'=====================================
WSHShell.RegWrite ctmtpath,"MoveTo"
WSHShell.RegWrite ctmtpath & "\MoveTo\","{C2FBB631-2971-11d1-A18C-00C04FD75D13}"
```

### Add Notepad To SendTo Menu

I don't know about you, but I've always liked to add Notepad to the SendTo menu to make quick edits to script and hosts files easier.  The following add in will automate that process.  Special mention goes out to 'Grant Dewrance' for this idea, thanks Grant.

```
'Adding the Notepad Application to the SendTo Menu
strSendToFolder = WSHShell.SpecialFolders("SendTo")
strPathToNotepad = WinDir & "\system32\Notepad.exe"
Set objShortcut = WSHShell.CreateShortcut(strSendToFolder & _
 "\Notepad.lnk")
objShortcut.TargetPath = strPathToNotepad
objShortcut.Save
```


### April Fools

OK, so you are feeling playful and are willing to field a plethora of phone calls and have decided to play a little joke on your favorite users.  The following code will eject the CD ROM drive.  Now seriously, don't go abusing this or I will tell your mother on you!

```
'Add On Code To Eject CD ROM Drive
Const CDROM = 4
For Each d in CreateObject("Scripting.FileSystemObject").Drives
  If d.DriveType = CDROM Then
    Eject d.DriveLetter & ":\"
  End If
Next

Sub Eject(CDROM)
  Dim ssfDrives
  ssfDrives = 17
  CreateObject("Shell.Application")_
    .Namespace(ssfDrives).ParseName(CDROM).InvokeVerb("E&ject")
End Sub
```

### Speed Up IE Downloads

Wow really?  Yes!  To do this you need to change the number of simultaneous HTTP sessions.  Windows normally limits the number of simultaneous connections made to a single web server based on RFCs that are now outdated by modern bandwidth.  This behavior can be seen in Internet Explorer when downloading multiple files from a web site and only a certain number will be active at any one time.  Enabling this registry key allows your system to take advantage of todays higher bandwidths.

```
Dim IEPath
IEPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\"
'Note you can set these values higher up to around 20 if you like
WSHShell.RegWrite IEPath & "MaxConnectionsPer1_0Server","10","REG_DWORD"
WSHShell.RegWrite IEPath & "MaxConnectionsPerServer","10","REG_DWORD"
```

### Create Desktop Shortcut
I can't believe this one hasn't come up sooner but thankfully a Tek-Tips user asked for this.  So here is the situation.  You have a shared folder on your network and you want everyone to have a shortcut to it on their desktop.  Easy as pie...<insert Homer Simpson voice> Yum pie...  Sorry my brain took a vacation.

You need only edit the text in red.

```
SET oFSO = Wscript.CreateObject("Scripting.FileSystemObject")
    strDsk = WshShell.SpecialFolders("Desktop")
     ' What is the label for the shortcut?
    strshortcut = strDsk & "\CompanyShared.lnk"
If Not oFSO.FileExists(strshortcut) Then
    SET oUrlLink = WshShell.CreateShortcut(strshortcut)
     ' What is the path to the shared folder?
    oUrlLink.TargetPath = "\\server\CompanyShared\"
    oUrlLink.Save
End If
```

### Checking For A Specific Printer

The following code allows you to see if a printer connection exists.  Using this you can then take appropriate action of remaping the printer, changing properties etc.

```
'Check if a specific printer exists already  Returns -1 if printer exists, 0 if printer not present
Set WSHPrinters = WSHNetwork.EnumPrinterConnections
PrinterPath = "\\ServerName\HP LaserJet 6P"
PrinterExists = False
For LOOP_COUNTER = 0 To WSHPrinters.Count - 1 Step 2
    If WSHPrinters.Item(LOOP_COUNTER +1) = PrinterPath Then
      PrinterExists = True
    End If
Next
WScript.Echo PrinterExists
```

OK, so now you have a bunch of nifty code.  So what to do with it right?

OK, first copy the text and put it into notepad.  Save the file as something useful like "loginscript.vbs" and use the quotes around the name as shown here.  Using the quotes in notepad will prevent notepad from adding a TXT extension on the name.

OK, now you are ready to put the script on your server.  If you started navigating to the Netlogon share forget it.  Time to use GPOs!

Creating a new GPO in Windows 2000 and 2003 is a bit different.

In Windows 2000, you want to right click your domain name in AD Users & Computers.  Choose properties.  Click the GPO tab.  

Click New.  Type Login Script.  Click the Edit button.

Windows 2003 users will want to open up the GPMC, Start, Administrative Tools, Group Policy Manangement Console (GPMC).  

Right click your domain and choose Create and Link a GPO here.  Type Login Script.  Right click Login Script and choose Edit.

OK, moving on you want to maximize your performance, so if you are only going to use this GPO for the login script, right click

Administrative Templates under either the Computer or User container. Click Add/Remove Template and remove ALL templates.  

You won't need them and they only beef up the size of your GPO which slows down replication.

OK, now drill down in the User Configuration.  Choose Windows Settings, Scripts, Login.  Double click Login.
Click Show Files.  Paste your script in this location.
Close the explorer window that you just pasted into.  Click the browse button and select your script.  You are now done.

By default your new GPO is applied to All Authenticated Users.  You may wish to modify the security settings as needed in your environment.

All done.

If your environment happens to have multiple locations, please refer to FAQ329-5908 for detailed scenarios that can be added onto the above script.

As stated above, this script is constantly being evolved.  I get some of my best ideas from people on Tek-Tips asking questions, so please feel free to ask how to do something.  You never know, you may just find it posted here soon afterwards.

I wish to thank all who have voted on this FAQ, which is by far the most voted on FAQ in the VBScript forum.  I strive for nothing less than 10s.  Before you vote, if you don't think this FAQ rates a 10 please provide feedback to me first.  Also please check out my other FAQs in this same forum.  This FAQ covers a lot of ground but is not intended to be the answer to ALL scripting needs.  

Some of my other FAQs will help to fill in specific areas that deserved more content than could be included in this FAQ.  An example is scripting for multiple locations.

Happy scripting.

Mark

## Links

[http://www.tek-tips.com/faqs.cfm?fid=5798](http://www.tek-tips.com/faqs.cfm?fid=5798)

