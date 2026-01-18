# RoboCopy


## Examples

```bash
robocopy "F:\Promo Only" "M:\Promo Only" /MIR /XC /XO /XF *.mxm

robocopy "F:\Soundtracks" "M:\Soundtracks" /MIR /XC /XO /XF *.mxm
 
robocopy F:\ Y:\ /MIR /XA:H /XD "Promo Only" "Music To Organize" "Music Organized" "RECYCLER" "Soundtracks" "System Volume Information" /XC /XO /XF *.mxm
 
robocopy.exe "W:\Parameters\QPD Backups" "C:\Users\lujackso\Desktop\setups" *.kst /S /XO /XD "Archive"
```
