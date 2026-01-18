# MPlayer


## Summary

MPlayer is a free and open source media player distributed under the GNU General Public License. The program is available for all major operating systems, including Linux and other Unix-like systems, Microsoft Windows and Mac OS X. Versions for OS/2, AmigaOS and MorphOS are also available. The Windows versions works, with some minor problems, also in DOS using HX DOS Extender. A port of DOS using DJGPP is available too.

## Capture Cards

This is the command I use to watch TV from my WinTV-PVR-150:

```bash
mplayer -vf pp=fd,scale -ao sdl /dev/video0

```
## avitools

```
 aviindex  can convert from and to mplayer-generated index files. Since mplayer-1.0pre3 mplayer
       has the ability to save the index via -saveidx FILE and load it again through  -loadidx  FILE.
       aviindex  is able to convert an mplayer index file to a transcode index file and vice visa. It
       is not able to directly write an mplayer file, though. Example of a toolchain
         mplayer -frames 0 -saveidx mpidx broken.avi
         aviindex -i mpidx -o tcindex
         avimerge -x tcindex -i broken.avi -o fixed.avi
       Or the other way round
         aviindex -i broken.avi -n -o broken.idx
         aviindex -i broken.idx -o mpidx
         mplayer -loadidx mpidx broken.avi
       The major differences between the two index file formats is that the mplayer one is  a  binary
       format  which is an exact copy of an index in the AVI file.  aviindex ´s format is text based.
       See FORMAT for details.
```

