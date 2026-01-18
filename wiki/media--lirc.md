# Lirc


## Summary

LIRC is a package that allows you to decode and send infra-red signals of many (but not all) commonly used remote controls.

## Install: Fedora Core 7 (Yum)

For Fedora Core 7 I used the atrpms repository. They have already built all the necessary binaries we will need for the installation. You can checkout their install page or follow the condensed instructions.

- http://atrpms.net/install.html

-or-

Install the GPG-Key:

```bash
rpm --import http://ATrpms.net/RPM-GPG-KEY.atrpms

```
Copy the text below into the following file:

```bash
/etc/yum.repos.d/atrpms.repo

```
[atrpms]
name=Fedora Core $releasever - $basearch - ATrpms
baseurl=http://dl.atrpms.net/f$releasever-$basearch/atrpms/stable
gpgkey=http://ATrpms.net/RPM-GPG-KEY.atrpms
gpgcheck=1
enabled=1
```

```
Install the needed packages with yum:

```bash
yum install lirc-lib-devel lirc-lib lirc lirc-kmdl-`uname -r` lirc-devices

```
### Hauppauge WinTV-PVR-150, WinTV-PVR-350 Cards

Load the module for Hauppuage 150 and 350 PVR cards with the commands below and then restart lircd:

```bash
depmod -a
modprobe lirc_i2c
/etc/init.d/lircd restart

```
### Enable Lircd on Startup

```bash
chkconfig lircd on

```
**Note**: See [Could not get file information for /dev/lirc (Lirc Reboot Errors)](misc--.md#could-not-get-file-information-for-devlirc-lirc-reboot-errors) for a fix when Lirc doesn't work after a reboot.

## Lircd Files

Lircd files map infrared hex singnals to key names.

Add remotes to the lircd configuration file:

```bash
/etc/lircd.conf

```
**Note**: Lircd should be restarted after any modifications to this file.

```bash
/etc/init.d/lircd restart

```
### Hauppauge WinTV-PVR-150, WinTV-PVR-350 Cards

You can browse the remotes folder that is included in the lirc documentation for your remote control's configuration file.

```bash
cp /usr/share/doc/lirc-*/remotes/hauppauge/lircd.conf.hauppauge /etc/lircd.conf

```
I used the file above as a base and removed all the extra remotes as they are not needed.

**Silver and Black Remote**



```
#
# this config file was automatically generated
# using lirc-0.7.0(any) on Sun Nov 28 20:25:09 2004
#
# contributed by 
#
# brand:   Hauppauge_WinTV-PRV-150
# Created: G.J. Werler (The Netherlands)
# Updated: Ljackson (USA) - 2007/11/19
# Project: Mythtv Fedora Pundit-R www.mythtvportal.com
# Date:    2004/11/28
# model no. of remote control: Hauppauge A415-HPG
# devices being controlled by this remote: PVR-150
#

begin remote

  name  Hauppauge_WinTV-PRV-150
  bits           13
  flags RC5|CONST_LENGTH
  eps            30
  aeps          100

  one           969   811
  zero          969   811
  plead        1097
  gap          114605
  toggle_bit      2


      begin codes
          Go                       0x00000000000017BB
          Power                    0x00000000000017BD
          TV                       0x000000000000179C
          Videos                   0x0000000000001798
          Music                    0x0000000000001799
          Pictures                 0x000000000000179A
          Guide                    0x000000000000179B
          Radio                    0x000000000000178C
          Up                       0x0000000000001794
          Left                     0x0000000000001796
          Right                    0x0000000000001797
          Down                     0x0000000000001795
          OK                       0x00000000000017A5
          Back/Exit                0x000000000000179F
          Menu/i                   0x000000000000178D
          Vol+                     0x0000000000001790
          Vol-                     0x0000000000001791
          Prev.Ch                  0x0000000000001792
          Mute                     0x000000000000178F
          Ch+                      0x00000000000017A0
          Ch-                      0x00000000000017A1
          Record                   0x00000000000017B7
          Stop                     0x00000000000017B6
          Rewind                   0x00000000000017B2
          Play                     0x00000000000017B5
          Forward                  0x00000000000017B4
          Replay/SkipBackward      0x00000000000017A4
          Pause                    0x00000000000017B0
          SkipForward              0x000000000000179E
          1                        0x0000000000001781
          2                        0x0000000000001782
          3                        0x0000000000001783
          4                        0x0000000000001784
          5                        0x0000000000001785
          6                        0x0000000000001786
          7                        0x0000000000001787
          8                        0x0000000000001788
          9                        0x0000000000001789
          Asterix                  0x000000000000178A
          0                        0x0000000000001780
          #                        0x000000000000178E
          Red                      0x000000000000178B
          Green                    0x00000000000017AE
          Yellow                   0x00000000000017B8
          Blue                     0x00000000000017A9
      end codes

end remote
```

## Lircrc Files

Add commands to the default configuration file:

```bash
/etc/lircrc

```
Additionally you can use place the configuration file in your home directory:

**Note**: If this file is present it will override the file in /etc/lircrc

```bash
~/.lircrc

```
**Note**: Lircd should be restarted after any modifications to this file.

```bash
/etc/init.d/lircd restart

```
### mplayer

```
#--------------------------------------------------
# File: /etc/lircrc (This works with the '''Hauppage 150 Silver & Black Remote''')
#--------------------------------------------------

#--------------------------------------------------
# mplayer
#--------------------------------------------------

begin
	prog = mplayer
	button = Menu/i
	repeat = 3
	config = osd
end
begin
	button = Vol+
	prog = mplayer
	config = volume +1
	repeat = 1
end
begin
	button = Vol-
	prog = mplayer
	config = volume -1
	repeat = 1
end
begin
	prog = mplayer
	button = Pause
	repeat = 3
	config = pause
end
begin
	prog = mplayer
	button = Play
	repeat = 3
	config = seek +1
end
begin
	prog = mplayer
	button = Stop
	repeat = 3
	config = quit
end
begin
	prog = mplayer
	button = Mute
	repeat = 3
	config = mute
end
begin
	prog = mplayer
	button = Forward
	repeat = 3
	config = seek +10
end
begin
	prog = mplayer
	button = Rewind
	repeat = 3
	config = seek -10
end
begin
	prog = mplayer
	button = SkipForward
	repeat = 3
	config = seek +30
end
begin
	prog = mplayer
	button = Replay/SkipBackward
	repeat = 3
	config = seek -30
end
begin
	prog = mplayer
	button = TV
	repeat = 3
	config = vo_fullscreen
end
begin
	prog = mplayer
	button = Back/Exit
	repeat = 3
	config = quit
end
```

### vlc

```
#--------------------------------------------------
# File: /etc/lircrc (This works with the '''Hauppage 150 Silver & Black Remote''')
#--------------------------------------------------

#--------------------------------------------------
# vlc
#--------------------------------------------------

begin
	prog = vlc
	button = Play
	config = key-play-pause
	repeat = 0
end
begin
	prog = vlc
	button = Pause
	config = key-play-pause
	repeat = 0
end
begin
	prog = vlc
	button = Stop
	config = key-stop
	repeat = 1
end
begin
	prog = vlc
	button = Back/Exit
	config = key-quit
	repeat = 3
end
begin
	prog = vlc
	button = Ch+
	config = key-next
	repeat = 3
end
begin
	prog = vlc
	button = Ch-
	config = key-prev
	repeat = 3
end
begin
	prog = vlc
	button = TV
	config = key-fullscreen
	repeat = 3
end
begin
	prog = vlc
	button = Rewind
	config = key-jump-extrashort
	repeat = 3
end
begin
	prog = vlc
	button = Forward
	config = key-jump+extrashort
	repeat = 3
end
begin
	prog = vlc
	button = Replay/SkipBackward
	config = key-jump-long
	repeat = 3
end
begin
	prog = vlc
	button = SkipForward
	config = key-jump+long
	repeat = 3
end
begin
	prog = vlc
	button = Vol-
	config = key-vol-down
	repeat = 1
end
begin
	prog = vlc
	button = Vol+
	config = key-vol-up
	repeat = 1
end
begin
	prog = vlc
	button = Mute
	config = key-vol-mute
	repeat = 0
end
begin
	prog = vlc
	button = Left
	config = key-nav-left
end
begin
	prog = vlc
	button = Down
	config = key-nav-down
end
begin
	prog = vlc
	button = Up
	config = key-nav-up
end
begin
	prog = vlc
	button = Right
	config = key-nav-right
end
begin
	prog = vlc
	button = Guide
	config = key-nav-activate
end
begin
	prog = vlc
	button = Menu/i
	config = key-disc-menu
end
begin
	prog = vlc
	button = Radio
	config = key-audio-track
end
```

## Irexec Files

Irexec in conjunction with Lirc will run programs with one button press on your remote control.

**Note**: You must create the file **/etc/irexec.conf** file in order for Lircd to start irexec.

```bash
vi /etc/irexec.conf

```
#--------------------------------------------------
# File: /etc/irexec.conf (This works with the '''Hauppage 150 Silver & Black Remote''')
#--------------------------------------------------

begin
	button = Power
	prog = irexec
	config = xset dpms force standby 
end
begin
        button = Red
        prog = irexec
        config = vlc /storage/torrents/csi*
end
begin
        button = Green
        prog = irexec
        config = vlc /storage/torrents/prison*
end
begin
        button = Yellow
        prog = irexec
        config = vlc /storage/torrents/family*
end
begin
        button = Blue
        prog = irexec
        config = mplayer /dev/video0 &
end
```

```
### Force Display Into Standby Mode

If you have a display that supports Energy Star (DPMS) features you can use the following command in your irexec file to force your display into standby mode. This makes it so you don't have to get up to turn off your monitor after your late night movie. :P

Test this command in any terminal window and it should turn your screen black.

**Note**: Simply move your mouse or strike any key to get your display back.

```bash
xset dpms force standby

```
If the above command worked correctly set it to a specific key on your remote control. I chose the green power button, but you can adapt the configuration below (Copied from main irexec config above) to fit your situation.

```
begin
	button = Power
	prog = irexec
	config = xset dpms force standby 
end
```

## FAQ

### Could not get file information for /dev/lirc (Lirc Reboot Errors)

```
[root@server.com rc.d]# tail /var/log/messages | grep lirc
Nov 19 20:17:50 core lircd-0.8.3-CVS[2268]: accepted new client on /dev/lircd
Nov 19 20:17:50 core lircd-0.8.3-CVS[2268]: could not get file information for /dev/lirc
Nov 19 20:17:50 core lircd-0.8.3-CVS[2268]: default_init(): No such file or directory 
Nov 19 20:17:50 core lircd-0.8.3-CVS[2268]: caught signal
```

Some systems will fail to auto load the lirc module. There are various ways to fix this problem but I found editing the **/etc/init.d/lircd** startup script to be the easiest.

**Edit**: First 6 lines in the Start() section.

```
#!/bin/sh
#
# $Id: lircd.init,v 1.1 2002/09/28 11:54:12 dude Exp $
# Startup script for the Linux Infrared Remote Control.
#
# chkconfig: - 90 10
# description: Enables infrared controls through LIRC.
#
# config: /etc/lircd.conf

# Source 'em up
. /etc/init.d/functions

[ -x /usr/sbin/lircd ]  || exit 1
[ -x /usr/sbin/lircmd ] || exit 1
[ -f /etc/lircd.conf ]  || [ -f /etc/lircmd.conf ] || exit 1

[ -f /etc/sysconfig/lircd ] && . /etc/sysconfig/lircd

RETVAL=0

start(){
	if [ '/sbin/lsmod | grep lirc' != "" ]; then
		echo -n $"Reloading lirc_i2c: "
		/sbin/modprobe lirc_i2c
		RETVAL=$?
		echo
	fi 
	if [ -f /etc/lircd.conf ]; then
		echo -n $"Starting infrared remote control daemon: "
		daemon lircd $LIRCD_OPTIONS
		RETVAL=$?
		echo
	fi
	if [ -f /etc/lircmd.conf ]; then
		echo -n $"Starting infrared remote control mouse daemon: "
		daemon lircmd
		RETVAL=$?
		echo
	fi
	if [ -f /etc/irexec.conf ]; then
		echo -n $"Starting infrared command execution daemon: "
		daemon irexec --daemon /etc/irexec.conf
		RETVAL=$?
		echo
	fi
	touch /var/lock/subsys/lircd
	return $RETVAL
}

stop(){
	if [ -f /etc/irexec.conf ]; then
		echo -n $"Stopping infrared command execution daemon: "
		killproc irexec
		echo
	fi
	if [ -f /etc/lircmd.conf ]; then
		echo -n $"Stopping infrared remote control mouse daemon: "
		killproc lircmd
		echo
	fi
	if [ -f /etc/lircd.conf ]; then
		echo -n $"Stopping infrared remote control daemon: "
		killproc lircd
		echo
	fi
	RETVAL=$?
	rm -f /var/lock/subsys/lircd
	return $RETVAL
}

restart(){
	stop
	start
}


# See how we were called.
case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	restart)
		restart
		;;
	status)
		status lircd
		;;
	condrestart)
		[ -e /var/lock/subsys/lircd ] && restart
		;;
	*)
		echo $"Usage: $0 {start|stop|status|restart|condrestart}"
		RETVAL=1
esac

exit $RETVAL
```

**lirc_i2c, WinTV-PVR-150, lircd reboot**

## See Also

- [Vlc#Lirc (Remote_Control)](media--vlc.md#lirc-remotecontrol)
- [Ivtv-channel](media--ivtv.md#channel)

## Sources

- http://www.lirc.org/
- http://www.mythtvtalk.com/forum/viewtopic.php?t=2224&start=0
- http://wilsonet.com/mythtv/fcmyth.php

