# Ivtv


## Install

Install the ATrpms driver repository:

```bash
rpm --import http://ATrpms.net/RPM-GPG-KEY.atrpms

```
Install drivers using kernel version from uname -r:

```bash
yum install ivtv ivtv-devel ivtv-kmdl-`uname -r`

```
Rather than rebooting to get ivtv loaded, load it up by hand right now:

```bash
depmod -a
modprobe ivtv

```
Check dmesg to make sure everything loaded correctly:

```
ivtv:  Start initialization, version 1.0.0
ivtv0: Initializing card #0
ivtv0: Autodetected Hauppauge card (cx23416 based)
ivtv0: Unreasonably low latency timer, setting to 64 (was 32)
ivtv0: Loaded v4l-cx2341x-enc.fw firmware (376836 bytes)
ivtv0: Encoder revision: 0x02060039
ivtv0: Autodetected Hauppauge WinTV PVR-150
ivtv0: Reopen i2c bus for IR-blaster support
tuner 2-0061: chip found @ 0xc2 (ivtv i2c driver #0)
cx25840 2-0044: cx25841-23 found @ 0x88 (ivtv i2c driver #0)
wm8775 2-001b: chip found @ 0x36 (ivtv i2c driver #0)
ivtv0: Registered device video0 for encoder MPEG (4 MB)
ivtv0: Registered device video32 for encoder YUV (2 MB)
ivtv0: Registered device vbi0 for encoder VBI (1 MB)
ivtv0: Registered device video24 for encoder PCM audio (1 MB)
ivtv0: Initialized card #0: Hauppauge WinTV PVR-150
ivtv:  End initialization
```


---

## Ivtv-channel



**ivtv-channel** is an utility to change channels with a remote control. It is designed to work along with [Lirc](media--lirc.md). It is very useful for watching ivtv in standalone applications such as VLC or MPlayer.

1. Requirements 

- Python >= **2.4**
- Ivtv utilities >= 0.4

''As far as I know it's compatible all the way back to 0.4, either way, it detects the major API change in 0.8 and works automatically across all recent versions.''

1. Download 

The latest version of the script can be downloaded from the link below:

- https://www.jardinpresente.com.ar/svn/utiles/tags/scripts/ivtv-channel

Only tagged (final) released versions should be used, but the trunk development version is also available in that repository.

An RSS feed of releases can be found at the link below:
- https://www.jardinpresente.com.ar/websvn/rss.php?repname=utiles&path=%2Ftags%2Fscripts%2Fivtv-channel%2F&rev=0&sc=0&isdir=1

1. Install 

Save ivtv-channel.py to a folder in your current environment path and ensure it has execute permissions:

```bash
cd /usr/bin/
wget --no-check-certificate https://www.jardinpresente.com.ar/svn/utiles/tags/scripts/ivtv-channel/0.5.2.1/ivtv-channel.py
chmod +x ivtv-channel.py

```
1. Lirc 

**Note**: Fedora Core 7's init script for Lirc will automatically launch irexec if the **/etc/irexec.conf** file exists.

Create the /etc/irexec.conf file and then copy the sample configuration below into this file:

```bash
vi /etc/irexec.conf

```
**Note**: Make sure the button names match with those specific to your remote's configuration. (See Config Below)

```
# The following is an example into how to integrate this script with Lirc.
#--------------------------------------------------
# File: /etc/irexec.conf (This works with the '''Hauppage 150 Silver & Black Remote''')
#--------------------------------------------------

begin
	button = Ch+
	prog = irexec
	config = python /usr/bin/ivtv-channel.py up
end
begin
 	button = Ch-
 	prog = irexec
	config = python /usr/bin/ivtv-channel.py down
end
begin
	button = OK
 	prog = irexec
        config = python /usr/bin/ivtv-channel.py enter
end
begin
 	button = Prev.Ch
 	prog = irexec
	config = python /usr/bin/ivtv-channel.py last
end
begin
 	button = 0
	prog = irexec
	config = python /usr/bin/ivtv-channel.py 0 &
end
begin
 	button = 1
	prog = irexec
	config = python /usr/bin/ivtv-channel.py 1 &
end
begin
 	button = 2
	prog = irexec
	config = python /usr/bin/ivtv-channel.py 2 &
end
begin
	button = 3
	prog = irexec
	config = python /usr/bin/ivtv-channel.py 3 &
end
begin
 	button = 4
	prog = irexec
	config = python /usr/bin/ivtv-channel.py 4 &
end
begin
 	button = 5
	prog = irexec
	config = python /usr/bin/ivtv-channel.py 5 &
end
begin
 	button = 6
        prog = irexec
        config = python /usr/bin/ivtv-channel.py 6 &
end
begin
 	button = 7
	prog = irexec
	config = python /usr/bin/ivtv-channel.py 7 &
end
begin
 	button = 8
	prog = ireec
	config = python /usr/bin/ivtv-channel.py 8 &
end
begin
 	button = 9
	prog = irexec
	config = python /usr/bin/ivtv-channel.py 9 &
end
```

1. Standalone Usage 

```bash
ivtv-channel (up|down|last|enter|channel number)

```

1. See Also 

- [Lirc](media--lirc.md)

1. Sources 

- http://ivtvdriver.org/index.php/Ivtv-channel
