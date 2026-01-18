# Vlc


= Linux =

## Install

Use RPM - LIVNA for F7 (available for x86, x86_64 and ppc)
Install livna-release-7.rpm for F7

```bash
$ su -
# rpm -ivh http://rpm.livna.org/livna-release-7.rpm
# yum install vlc vlc-devel

```
## Lirc (Remote Control)

Vlc supports the [ Lirc inrared remote control daemon](misc--lirc-.md). To see if your vlc version was installed with Lirc support issue this command from shell:

```bash
vlc --list | grep lirc

```
If you see a line like the following:

```bash
lirc                  Infrared remote control interface

```
Then your version was compiled with Lirc support otherwise recompile or find another rpm package with it already compiled.

For more information on using remote controls with Vlc visit the [Lirc](media--lirc.md) page.

## Build RPM

### Install dependencies

```
yum install gettext-devel libtool gnome-libs-devel gnutls-devel gtk+-devel hal-devel kdelibs-devel libdvdcss-devel libcddb-devel libgcrypt-devel libtar-devel libtiff-devel libupnp-devel seamonkey-devel qt-devel xvidcore-devel alsa-lib-devel faac-devel ffmpeg-devel flac-devel gnome-vfs2-devel lame-devel libid3tag-devel libmpcdec-devel libogg-devel mpeg2dec-devel openslp-devel vcdimager-devel wxGTK-devel
```

### rpmbuild command

```
rpmbuild -bb vlc.spec \
--without aa \
--without arts \
--without caca \
--without cddax \
--without dvb \
--without dvdread \
--without esd \
--without faad \
--without embedded_ffmpeg \
--without galaktos \
--without goom \
--without jack \
--without live \
--without ncurses \
--without shout \
--without svg \
--without theora \
--without twolame \
--without vcdx \
--without xosd \
--without a52 \
--without daap \
--without dvdnav \
--without dts \
--without freetype \
--without fribidi \
--without mad \
--without modplug \
--without mkv \
--without sdl \
--without speex \
--without svgalib \
--without vorbis \
--without x264
```


### Install dependencies

```
yum install gettext-devel libtool gnome-libs-devel gnutls-devel gtk+-devel hal-devel kdelibs-devel libdvdcss-devel libcddb-devel libgcrypt-devel libtar-devel libtiff-devel libupnp-devel seamonkey-devel qt-devel xvidcore-devel alsa-lib-devel faac-devel ffmpeg-devel flac-devel gnome-vfs2-devel lame-devel libid3tag-devel libmpcdec-devel libogg-devel mpeg2dec-devel openslp-devel vcdimager-devel wxGTK-devel
```

= Stream / Transcode / View Capture Card =

## Http

```
vlc -v pvr:// :pvr-device="/dev/video0" :norm=ntsc :size=720x480 :frequency=91250 :bitrate=3000000 :maxbitrate=4000000 --cr-average 1000 --sout='#transcode{vcodec=DIV3,vb=1024,scale=0.75,cropleft=10,cropright=10,croptop=5,cropbottom=5,acodec=mp3,ab=96,channels=2}:std{access=http,mux=ts,dst=192.168.85.150:8080}'
```

## Http for internet

```
 vlc -v pvr:// :pvr-device="/dev/video0" :norm=ntsc :size=720x480 :frequency=91250 :bitrate=3000000 :maxbitrate=4000000 --cr-average 1000 --sout='#transcode{vcodec=DIV3,vb=386,scale=0.25,cropleft=10,cropright=10,croptop=5,cropbottom=5,acodec=mp3,ab=96,channels=2}:std{access=http,mux=ts,dst=192.168.85.150:8081}'
```

## To File

```
vlc -v pvr:// :pvr-device="/dev/video0" :norm=ntsc :size=720x480 :frequency=91250 :bitrate=3000000 :maxbitrate=4000000 --cr-average 1000 --sout='#transcode{vcodec=DIV3,vb=1024,scale=0.75,cropleft=10,cropright=10,croptop=5,cropbottom=5,acodec=mp3,ab=96,channels=2}:duplicate{dst=std{access=file,mux=ts,dst="family-guy.mpg"},dst=std{access=http,mux=ts,dst=192.168.85.150:8080}}'
```


## Display

```
vlc -v pvr:// :pvr-device="/dev/video0" :norm=ntsc :size=720x480 :frequency=91250 :bitrate=3000000 :maxbitrate=4000000 --cr-average 1000 --sout='#transcode{vcodec=DIV3,vb=1024,scale=0.75,cropleft=10,cropright=10,croptop=5,cropbottom=5,acodec=mp3,ab=96,channels=2}:duplicate{dst=display}'
```

