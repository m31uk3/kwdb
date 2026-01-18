# MEncoder


## Summary

MEncoder is a free command line video decoding, encoding and filtering tool released under the GNU General Public License. It is a close sibling to MPlayer and can convert all the formats that MPlayer understands into a variety of compressed and uncompressed formats using different codecs.

## Installing

```bash
yum install menencoder

```
## Joining the video clips together

Mencoder doesn't have a fancy gui for you to get used to, but is a command line application, meaning we just type the commands in on a command line.

To join the files "1.avi" and "2.avi" into the joined file "joined.avi" simply type in the following command

```bash
mencoder -oac copy -ovc copy -o "joined.avi" "1.avi" "2.avi"

```
In the above command -oac copy means "copy the audio stream", -ovc copy means "copy the video stream", and -o "joined.avi" means "output to file joined.avi".

If you want to join more than two clips, then just list as many clips as you want, in the order you want them joined. 

**Note:** Files need to be encoded exactly the same, otherwise MEncoder won't work.

If your joined clip is going to be larger that 1024Mb ( 1 gigabyte ) then when you come to play back the joined clips, some media players get confused as to how long the clip lasts, so add -noodml to the command line, eg.

```bash
mencoder -oac copy -ovc copy -noodml -o "joined.avi" "1.avi" "2.avi"

```
Also note that most movie players cannot play videos that are larger than 2GB (2048MB) in size, irrespective of whether they are .avi, .mpg or .vob.

## Trim or split videos with Mencoder

Mencoder makes it easy to trim the end or the beginning of a file, or split it in several parts.

Start from...

```bash
mencoder -ss 01:30:24 -oac copy -ovc copy in.avi -o out.avi

```
Replace 01:30:24 (1 hour, 30 minutes, 24 seconds) with the desired start time position.

End at...

```bash
mencoder -endpos hh:mm:ss -ovc copy -oac copy in.avi -o out.avi

```
Replace 00:45:00 (45 minutes) with the desired end position.

Split the movie

With the two commands above, you can for example split a movie in two bits:

```bash
mencoder -endpos 01:00:00 -ovc copy -oac copy movie.avi -o first_half.avi

mencoder -ss 01:00:00 -oac copy -ovc copy movie.avi -o second_half.avi

```
Replace 01:00:00 (1 hour) with the time when you want the split to occur. 


## Examples

Record from capture card to file for a duration of 1 hour:

```bash
mencoder -vf pp=fd,scale -oac copy -ovc copy /dev/video0 -endpos 01:00:00 -o family_guy.mpg

```
= See Also =

- [Ffmpeg](media--ffmpeg.md)

