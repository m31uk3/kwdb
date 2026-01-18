# Firefox


## Summary

Firefox is the next generation web browser from Mozilla.

## Requirements

### Linux

Supported

### Mac OS X

Supported

### Windows XP

Supported

## How To Manage Profiles

Mozilla Firefox stores all your personal settings, such as bookmarks, passwords and extensions, in a profile. The profile is stored on your hard drive in a profile folder.

**Multiple profiles and profile management is an advanced feature, mainly intended for developers. Unless you are an extension developer or an advanced user, you should probably not be trying to use multiple profiles.**

### Locate your profile folder

Knowing where your profile folder is stored can be useful if, for example, you want to make a backup of your personal data.

- On Windows Vista/XP/2000, the path is usually %AppData%\Mozilla\Firefox\Profiles\xxxxxxxx.default\, where xxxxxxxx is a random string of 8 characters. Just browse to C:\Documents and Settings\[User Name]\Application Data\Mozilla\Firefox\Profiles\ on Windows XP/2000 or C:\users\[User Name]\AppData\Roaming\Mozilla\Firefox\Profiles\ on Windows Vista, and the rest should be obvious.

- On Windows 95/98/Me, the path is usually C:\WINDOWS\Application Data\Mozilla\Firefox\Profiles\xxxxxxxx.default\
- On Linux, the path is usually ~/.mozilla/firefox/xxxxxxxx.default/
- On Mac OS X, the path is usually ~/Library/Application Support/Firefox/Profiles/xxxxxxxx.default/

%AppData% is a shorthand for the Application Data path on Windows 2000/XP/Vista. To use it, click Start > Run... (use the search box on Vista), enter %AppData% and press Enter. You will be taken to the "real" folder, which is normally C:\Documents and Settings\[User Name]\Application Data on Windows XP/2000, C:\users\[User Name]\AppData\Roaming on Windows Vista.

**JavaScript Snippet for Error Console**

You can use the following technique to find the location of the profile that you are currently using. This is useful, for example, if you are using a profile that is not in the default location.

From the Firefox menu bar, choose "Tools -> Error Console" (Firefox 2 and above) or "Tools -> JavaScript Console" (Firefox 1.5). Copy the following code. It is one very long line ending in path—make sure that you get all of it:

```bash
Components.classes["@mozilla.org/file/directory_service;1"].getService(Components.interfaces.nsIProperties).get("ProfD", Components.interfaces.nsIFile).path 

```
In the Error Console or JavaScript Console window, paste the code in the field near the top. Click the Evaluate button. The console should display the location of the profile that is currently in use. If you don't see it, make sure you have the "All" button pushed.

### Create a new profile

In order to create a new profile, you use the Profile Manager. To start the Profile Manager in Windows, follow these steps:

1. Close Firefox completely (select File > Exit from the main menu of Firefox).
1. Select Start > Run... from the Windows Start menu (use the search box on Vista).
1. Enter **firefox.exe -ProfileManager** and press OK.

On Linux or Mac, start Firefox with the -ProfileManager switch, e.g. ./firefox -ProfileManager (this assumes that you're in the firefox directory).

You should now see the Profile Manager window, shown in the screenshot to the right.

From the Profile Manager you are also able to remove and rename profiles. Be very careful when deleting profiles; if you created the profile in an directory that already existed, the entire directory will be removed!

Click on the Create Profile... button to start the Create Profile Wizard. Click Next and enter the name of the profile, e.g. your name or something descriptive.

You can also choose where on the disk you want the profile to be stored, which is useful if you plan on exporting your settings to another computer or setup in the future. If you choose a custom location for the profile, always create a new/clean directory and select that directory.

Finally, click Finish to have Firefox create the new profile.
You should now be taken back to the Profile Manager and the newly created profile should be listed. Select it and click Start Firefox. That's it!

You are now running Firefox with the new profile, which means all settings are reset to default. If you want to switch back to your old profile, just start the Profile Manager again (instructions above) and select the old profile.

You can also have Firefox start a selected profile automatically, so you don't have to pick one each time the browser is launched. Do this by checking the Don't ask at startup option.

### Backing up your profile

Backing up your profile folder in Firefox is easy. Just follow these steps (which assumes you know how to manage files on your computer):

1. Optional: Empty the browser cache, to reduce the amount of data to backup. Go to Tools > Options... (Edit > Preferences... on Linux/Mac), select Privacy and click the Clear button next to the Cache item in the list.
1. Shut down Firefox completely (File > Exit).
1. Make a copy of your profile folder to, for example, a CD-RW disc or a separate hard disk for backup purposes.

### Move an existing profile or restore a backed up profile

It's possible to move the location of a profile folder. This could be useful if you have a backed up profile folder somewhere on your hard drive and want to tell Firefox to use that as your profile. This section explains how to do this.

1. Shut down Firefox completely (File > Exit).
1. Move the profile folder to the desired location. For example, on Windows XP, move the profile from C:\Documents and Settings\[username]\Application Data\Mozilla\Firefox\Profiles\xxxxxxxx.default to D:\Stuff\MyProfile. If you are reading these instructions because you want to restore a previously backed up profile, this step isn't necessary. Just note the current location of the profile you want to restore.
1. Open up profiles.ini in a text editor. The file is located in the application data folder for Firefox:
- On Windows Vista/XP/2000, the path is %AppData%\Mozilla\Firefox\
- On Windows 95/98/Me, the path is usually C:\WINDOWS\Application Data\Mozilla\Firefox\
- On Linux, the path is ~/.mozilla/firefox/
- On Mac OS X, the path is ~/Library/Application Support/Firefox/
1. In profiles.ini, locate the entry for the profile you've just moved. Change the Path= line to the new location. If you are using a non-relative pathname, the direction of the slashes may be relevant (this is true for Windows XP).
1. Change IsRelative=1 to IsRelative=0.
1. Save profiles.ini and restart Firefox.

	
### Installing ASV plugin into Firefox

- Install Adobe SVG Viewer 3.03 on your computer.
- Open: C:\Program Files\Common Files\Adobe\SVG Viewer 3.0\Plugins\
- Copy NPSVG3.dll and NPSVG3.zip from there to your browser's plugins folder. 

By default Firefox will use its native support of SVG and not the Adobe Viewer plugin. To change this:

- In the firefox location bar, type: about:config
- Search for: svg
- Set 'svg.enabled' to 'false' (you can do this by double clicking on the row. )

This turns off Firefox's native SVG renderer thus leaving SVG rendering up to the Adobe SVG Viewer.

## FAQs

### Remember what I type in forms and fields (Form History)



### Delete Multiple History Records

Selecting multiple entries in the side bar with Shift+Up/Down should select that block.
You can select the first item with a right click and close the context menu with ESC.
You can then delete it with the Delete key.

### Create Customized Search Engine Plugins

- http://www.searchplugins.net/generate.aspx
- http://kb.mozillazine.org/Profile_folder_-_Firefox

**Example**

```
<SearchPlugin xmlns="http://www.mozilla.org/2006/browser/search/">
<ShortName>Google</ShortName>
<Description>Google Search</Description>
<InputEncoding>UTF-8</InputEncoding>
<Image width="16" height="16">data:image/x-icon;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAIAAACQkWg2AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAaRJREFUeNpiVIg5JRURw0A0YAHio943kYV%2B%2Ff33%2BdvvX7%2F%2FMjEx8nKycrGzwKXOiPKzICvdeezLhCV3jp15%2Bfv%2FX0YGhv8MDDxMX2qKTIw0RK10eYD6QYqATvoPBkt3f5K0W9Ew4fjTFz%2F%2Bw8Dm3W8UPeZxqFa%2BevsFyD0twgfVsOfkRxHrtfV9u5BVQ8Crd98%2FffkGYQM1QJ20%2FfSPv79eNxQGYfpSVJADmcvEAHbr7oOX2dj%2FERNKIA2%2F%2F%2Fz%2FxfCDhYVoDUDw5P6vf9%2B5iY0HVmZGQWm%2BN3fff%2Fn2k4eLHS739x%2FDiRs%2Ff%2F%2F5x8HO%2FOHzN3djfqgNjIwMgc6qzLx%2Fpy47j2zY%2Feff06tXhOUucgxeun33AUZGpHh4%2Bvo7t8EyIJqz%2FhpasD59%2B5dNrqdnznZIsEL9ICXCsWuBCwvTv%2FymS5PWPP32ExEALz%2F%2BB5r848cPCJcRaMP9xaYQzofPPzfuvrnj0Jst%2B5%2F8%2Bc4sLPeDkYlRgJc93VPE18NIXkYUmJYQSQMZ%2FP3379uPH7%2F%2F%2FEETBzqJ0WqLGvFpe2LCC4AAAwAyjg7ENzDDWAAAAABJRU5ErkJggg%3D%3D</Image>
<Url type="application/x-suggestions+json" method="GET" template="http://suggestqueries.google.com/complete/search?output=firefox&amp;client=firefox&amp;hl={moz:locale}&amp;q={searchTerms}"/>
<Url type="text/html" method="GET" template="http://www.google.com/search">
  <Param name="q" value="{searchTerms}"/>
  <Param name="ie" value="utf-8"/>
  <Param name="oe" value="utf-8"/>
  <Param name="aq" value="t"/>
  <!-- Dynamic parameters -->
  <Param name="rls" value="{moz:distributionID}:{moz:locale}:{moz:official}"/>
  <MozParam name="client" condition="defaultEngine" trueValue="firefox-a" falseValue="firefox"/>
</Url>
<SearchForm>http://www.google.com/firefox</SearchForm>
</SearchPlugin>
```

## See Also

- [Firefox Printing](misc--firefox.md#printing)
- [Firefox SVG](misc--firefox.md#svg)

## Sources

- http://www.mozilla.org/support/firefox/profile

## External Links

- http://getfirefox.com - Download Firefox


---

## Printing



Supported

1. Mac OS X 

1. Printing Background Images & Colors 



To enable printing of background images and colors you have to select Firefox from the Copies & Pages drop down menu after clicking print.

**Note:** Version 2.0.0.7 had this option missing from the dropdown menu. Thus these option were unavailable.

1. Windows XP 

Supported


1. Links 

- http://www.mintprintables.com/print-tips/adjust-margins-osx.php


---

## Profiles



First, open up your source (the original one, where you want to copy the profile from) profile in Windows Explorer. Let’s assume you only use one profile on your system, which is automatically named by Firefox as default, and that you use Windows XP. Point Explorer to:

```bash
%HOMEDRIVE%:\Documents and Settings\%USERNAME%\Application Data\Mozilla\Firefox\Profiles

```
You might have to first enable viewing of hidden files and folders and system files at TOOLS - FOLDER OPTIONS - VIEW. Simply uncheck the boxes that say “Hide protected system files …” and select the radio button for “Show hidden files and folders.”

You will see at least one folder inside, with this format:

**XXXXXXXX.default**

where XXXXXXXX is an eight-character code for your Firefox installation on that particular machine.

This folder contains all your Firefox information, including bookmarks, history, extensions, form auto-fill, passwords, and cache. You can already ZIP/compress and copy this onto a USB flashdrive or any other recordable media, or transfer via the network. Remember that this folder could get very large if you have a large cache of temporary Internet files, so you might want to clear your browser’s cache first.

Then, in the destination computer, make sure you’ve already installed Firefox, and opened it up at least once, so that the application would automatically create a new default profile for you. Then open up Windows Explorer and then browse to:

```bash
%HOMEDRIVE%:\Documents and Settings\%USERNAME%\Application Data\Mozilla\Firefox\Profiles

```
where you will see a folder named

**YYYYYYYY.default**

where YYYYYYYY is the eight-character code for that firefox installation.

Simply copy or uncompress the folder containing the original profile into this \Profiles folder.

Now copy the YYYYYYYY string onto your clipboard (so you won’t forget), and then rename that folder as you please (i.e., YYYYYYYY.default.backup). Then rename XXXXXXXX.default into YYYYYYYY.default. Make sure Firefox is not running while you do this, or you’ll get file access conflict errors.

Now open up Firefox, and voila! Your original settings have been copied. Do check some of the options, though, as some extension and proxy settings may not have been transferred. But what’s important is that your new Firefox installation looks and feels like your old one. Now you can go and browse away to your favorite, bookmarked sites, not having to re-input all your URLs and passwords again.

1. External Links 

- [http://kb.mozillazine.org/Migrating_settings_to_a_new_profile http://kb.mozillazine.org/Migrating_settings_to_a_new_profile]


---

## SVG



First ensure the following:

- Using version 1.5 or greater
- Compiled SVG support (By Default: Enabled)
- File is clean and viewable via another application

If all of the above are true then you have most likely found a bug. The most common issue is corrupt or improperly formated SVG files.

I like to use [IrfanView](http://www.irfanview.com/) to check my SVG files before accusing Firefox of dropping the ball.

1. Tags 

Open SVG with Firefox, Finder, Explorer, Open With

1. Links 

http://www.irfanview.com/ - Download IrfanView

