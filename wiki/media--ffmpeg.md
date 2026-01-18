# Ffmpeg


Direct Download M3U8 file playlist stream and convert into local MP4 video file

```bash
echo "Enter m3u8 link:";read link;echo "Enter output filename:";read filename;ffmpeg -i "$link" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 23 $filename.mp4

```
-bsf:a aac_adtstoasc

    bsf = (bit stream filter)
    use aac_adtstoasc bsf for a audio streams, this is need if .m3u8 file consists with .ts files and output is .mp4
    reference https://ffmpeg.org/ffmpeg-bitstream-filters.html#aac_005fadtstoasc

-c copy -vcodec copy

    skip codec (encode and decode), just demux and mux
    I guess .ts and .mp4, for video stream, they are both H.264 codec, just guess.
    reference https://ffmpeg.org/ffmpeg.html#Stream-copy

-crf 50

    reference https://trac.ffmpeg.org/wiki/Encode/H.264#CRFExample
    the example shows -c:a copy did not re-encode, guess this option is not needed here.
    And 0 is lossless, 23 is the default, and 51 is worst quality possible 😢
```

```
https://gist.github.com/tzmartin/fb1f4a8e95ef5fb79596bd4719671b5d


Add Freshrpms repo

http://ftp.freshrpms.net/pub/freshrpms/fedora/linux/4/freshrpms-release/freshrpms-release-1.1-1.fc.noarch.rpm

```bash
yum install ffmpeg-devel

```
Dependencies Resolved
Transaction Listing:
  Install: ffmpeg-devel.i386 0:0.4.9-0.20050427.1.1.fc3 - freshrpms

Performing the following to resolve dependencies:
  Install: SDL-devel.i386 0:1.2.7-8 - base
  Install: a52dec-devel.i386 0:0.7.4-7.1.fc3.fr - freshrpms
  Install: alsa-lib-devel.i386 0:1.0.6-8.FC3 - updates-released
   Install: faac-devel.i386 0:1.24-1.1.fc3.fr - freshrpms
  Install: faad2-devel.i386 0:2.0-4.1.fc3 - freshrpms
  Install: ffmpeg.i386 0:0.4.9-0.20050427.1.1.fc3 - freshrpms
  Install: fontconfig-devel.i386 0:2.2.3-5 - base
  Install: imlib2-devel.i386 0:1.2.1-2.fc3 - extras
  Install: lame.i386 0:3.96.1-2.1.fc3.fr - freshrpms
  Install: lame-devel.i386 0:3.96.1-2.1.fc3.fr - freshrpms
  Install: libogg-devel.i386 2:1.1.2-1 - base
  Install: libvorbis-devel.i386 1:1.1.0-1 - base
  Install: xorg-x11-devel.i386 0:6.8.2-1.FC3.45.2 - updates-released
  Install: xvidcore-devel.i386 0:1.0.3-1.1.fc3.fr - freshrpms
Total download size: 11 M
Is this ok [y/N]: 
```



```
