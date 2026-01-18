# Del Command


## Windows XP

### Delete invalid filename "mshdmd.sys."

```bash
C:\WINDOWS\system32\drivers>dir /x
01/25/2013  10:36 PM                32 MSHDMD~1     mshdmd.sys.

```
Dir /x will produce the usual Directory listing, but with an extra column
showing the SFN (Short File Name, also called the 8.3 filename) before the
LFN.

Many LFNs appear to be valid SFNs, but are not, because they use
undisplayable characters or some other technique. Dir /x forces the display
of a valid SFN. Then you can use that SFN with the Del or other DOS
command. (As usual in a "DOS" window, of course, type the command name
followed by /? to see a mini-help file listing all the switches and
parameters available for that command.) 

```bash
del MSHDMD~1
```
