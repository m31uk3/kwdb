# Windows 7


Suppose you have connected a device with your computer, Windows 7 / Vista will now automatically search for the driver and install it. If you want to select every driver manually(because you have a manual driver that is better), then you should disable automatic driver installation. To do this you don’t need to install any software at all, you can do this using Windows Driver Settings.

Update: Some people complained that the original method doesn’t work at all. Reader mufuti0815 points out a method to properly disable automatic driver installation. I have tested it and it seems to be working. Here is what you need to do:

```bash
   Go to Start–>Search type in gpedit.msc
   Click the file to open the Local Group Policy Editor and show Windows who is in control!!
   You want to go here: Computer Configuration->Administrative Templates->System->Device Installation. Click on the subfolder Device Installation on the left and on the right side you will see the possible restrictions.
   Right Click on Prevent Installation of Devices not described by other policy settings and edit this option, set it on ENABLED.
   Reboot Windows and enjoy its inability to pollute your system with its standard driver, open gpedit.msc again and revert the change so you will be able to install your driver.

```
## ODBC Connection - Text Driver

```bash
C:\Windows\SysWOW64\odbcad32

```
Windows 7 moved the 32bit support for ODBC Connections (Text Drivers) to a secret location on the system. From the above path you can configure it exactly as you did on Windows XP.

## Tags

Windows XP ODBC Connection, Text Driver, CSV File, UPS Worldship, Shipment Data Map
