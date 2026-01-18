# Asterisk



To learn more about Asterisk and its partners you can visit their website at [Asterisk.org](http://www.asterisk.org/).

## Introduction

Asterisk is an open source PBX system then runs on the Linux operating system.

I support Asterisk because of its price benefits and ease of expansion.

Some key features of Asterisk are listed below.

- Voicemail to eMail
- Softphone (Computer Based Phone) support
- Analog Phone Support (PSTN)
- ISDN PRI support for DID based routing
- VoIP support

## Download

- http://asterisk.org/downloads

## Hardware

- Digium
- Sangoma

## Software

- FreePBX
- ThirdLane

## Tutorials

- [Asterisk Echo](voip--asterisk.md#echo)
- [Asterisk Install](voip--asterisk.md#install)
- [Asterisk Firewall](voip--asterisk.md#firewall)
- [Asterisk Front End](voip--asterisk.md#front-end)
- [Asterisk Logs](voip--asterisk.md#logs)
- [Asterisk Queue](voip--asterisk.md#queue)
- [Asterisk Sipgate](voip--asterisk.md#sipgate)
- [Server Backup#Asterisk, MySQL, FreePBX](config--server-backup.md#asterisk-mysql-freepbx)

## FAQs

### MeetMe: "That is not a valid conference number."

Ensure your meetme.conf file uses **","** commas and not **"|"** pipes.

meetme.conf:

```bash
conf => 1995,1234

```
### How do I use "Console commands" (transfer, dial, answer, hangup) from the cli?

You'll need chan_oss for that. Chan_oss connects the sound card to the outgoing line.
By default it is disabled to include the module chan_oss, you will need to edit a section of the modules.conf file to match the sample below:

```
; Load either OSS or ALSA, not both
; By default, load OSS only (automatically) and do not load ALSA
;
noload => chan_alsa.so
;noload => chan_oss.so
```

### I configured a new IVR and clicked the check box that states "Enable Directory". When I call in and type # I get "I'm sorry, that's not a valid extension." What did I do wrong?

You must install **Information Services**, It provides a number of applications accessible by feature codes:

- Company directory
- Call Trace (last call information)
- Echo Test
- Speaking Clock
- Speak Current Extension Number

More info: [http://aussievoip.com.au/wiki/freePBX-Features](http://aussievoip.com.au/wiki/freePBX-Features)

### How do I enable Attended Transfer?

Update your features.conf file to reflect the settings below:

```
[featuremap]
blindxfer => #                  ; Blind Transfer
disconnect => *9                ; Disconnect Call
automon => *0                   ; One Touch Record
atxfer => *                     ; Attended Xfer
```

### Unable to connect to remote asterisk (does /var/run/asterisk.ctl exist?)

Check to ensure that the user you are attempting to connect as has full rights to /var/run/asterisk.

Change /etc/asterisk.conf:

```bash
astrundir => /var/run

```
to

```bash
astrundir => /var/run/asterisk


```

---

## Dialplan



The underscore informs Asterisk that the notation following it uses wildcards. Wildcards are symbols that can replace one or more, other symbols. In Asterisk, wildcard symbols that are present are listed below:

- X—Matches any digit from 0 to 9.
- Z—Matches any digit from 1 to 9.
- N—Matches any digit from 2 to 9.
- [15-7]—Matches any digit or range of digits specified. In this case, matches a 1, 5, 6, or 7.
- . (period)—Wildcard match; matches one or more characters.

For instance, the expression _X will match all one-digit numbers from 0 to 9. _2XXXXXXX will match all numbers beginning with the digit 2 (like our MTNL Mumbai and Delhi landline numbers) and _. will match everything.

A word of caution here—make use of wildcards very judiciously and only after you are certain of the outcome.

1. Call Forward (WiFi Phones) 

Because WiFi phones interperate the inital star as a local command it is not possible to enable features such as call-waiting and call-forwarding from such a devices. Therefore I added this application to the dialplan which simply listens on **"double-star"** $VARIABLE. Thus a wifi phone user may dial **91 and their cf-busy-forward would be canceled.

```
[app-cf-busy-off-custom]
exten => **91,1,Answer
exten => **91,n,Wait(1)
exten => **91,n,Macro(user-callerid,)
exten => **91,n,dbDel(CFB/${CALLERID(number)})
exten => **91,n,Playback(call-fwd-on-busy&de-activated)
exten => **91,n,Macro(hangupcall,)
exten => _**91.,1,Answer
exten => _**91.,n,Wait(1)
exten => _**91.,n,Set(fromext=${EXTEN:3})
exten => _**91.,n,dbDel(CFB/${fromext})
exten => _**91.,n,Playback(call-fwd-on-busy&for&extension)
exten => _**91.,n,SayDigits(${fromext})
exten => _**91.,n,Playback(cancelled)
exten => _**91.,n,Macro(hangupcall,)

; end of [app-cf-busy-off-custom]
```


---

## Echo



```bash
[root@asterisk ~]# ztmonitor <channel num> -v

```
1. Record a Zaptel channel: 

```bash
[root@asterisk ~]# ztmonitor <channel num> -f <filename.raw>

```
1. Convert the raw file to a wav file for review. 

```bash
sox -r 8000 -s -w -c 1 <filename.raw> <filename.wav>

```
1. eMail the recording to yourself: 

```bash
uuencode <filename.wav> <filename.wav> | mail -s <filename.wav> <email@server.ext>

```
Next we need to make sure our echo settings, these settings are in /etc/asterisk/zapata.conf

The settings we will be looking at are listed below with typical default settings.

```
echocancel=yes
echocancelwhenbridged=no
echotraining=800
rxgain=0.0
txgain=0.0
```

Let's take a look at what these settings actually do.

echocancel
Obviously this disables or enables echo cancellation, it is recommended to not turn this off. The yes setting sets the value to 128, this is the number of taps that are used. Each tap is one sample from the data stream. You can specify the number of taps to use as 16, 32, 64, 128, or 256. It is very rare that you need anything other than setting this to the yes setting.

echocancelwhenbridged
This enabled or disabled echo cancellation when TDM calls are bridged. TDM calls should not need any echo cancellation but some people report improved call quality with this option turned on.

echotraining
A common echo symptom is that at the beginning of a conversation there is a good deal of echo and then it fades away as it it trains itself. If this delay is too long, you can adjust the training cycle. The setting is represented as milliseconds and can accept any value between 10 to 4000. Making the setting to low will not enable the system to train properly. I find that setting this to 128 is often a good starting point.

rxgain
This adjust the gain of the inbound signal. While Asterisk will accept any number from -100 to 100 (-100% to 100% of capacity) it is recommended to never put the values to more than -11 to +11 and in some case anything outside of the -5 to +5 range will actually cause audio loss (mostly on the TDM400 cards).

txgain
This adjusts the audio gain for the signal being sent out to the phone line. While Asterisk will accept any number from -100 to 100 (-100% to 100% of capacity) it is recommended to never put the values to more than -11 to +11 and in some case anything outside of the -5 to +5 range will actually cause audio loss (mostly on the TDM400 cards).

One of the first questions commonly asked is "what is the best settings for the rxgain/txgain?" and simply put, there is no "best settings" that will work for everyone. Every installation is different as there is no perfect consistency between telephone line quality, impendence, line length, etc. So how do you know what settings to use to make the system work properly? Well, the zaptel developers have created some handy tools to help us with that. The primary tool we will use is ztmonitor This tool allows us to visually see the audio levels on the RX and TX sides allowing us a guide to adjusting the levels in the zapata.conf file.

The command format is:

```bash
ztmonitor <zap channel> -v

```
An example of monitoring zap channel 3 during a conversation is shown here:

```bash
[root@asterisk1 ~]# ztmonitor 3 -v

```
1. Visual Audio Levels 

Use zapata.conf file to adjust the gains if needed.

```bash
( # = Audio Level * = Max Audio Hit )
<-------------(RX)-------------> <-------------(TX)------------->
################   *             #########################  *

```
If those were the maximum levels that we were seeing during a call, we would know that the RX gain is set pretty good but the TX level is way too high. What we are looking for are peaks that don't go past the middle of the meter.

Although this may sound complicated, it is fairly simple to adjust these settings on the fly. My prefered way is to use an SSH client such as Putty to have three sessions open at the same time. One window will have the Asterisk CLI, the second will be running ztmonitor, and the third will have zapata.conf file open in an editor. During the call, if you need to adjust a setting, make the change to the file and save it, then switch to the Asterisk CLI and type the following:

```bash
asterisk1*CLI> reload chan_zap.so

```
This will reload the zap module without hanging up the call. When you have made you adjustment, stop and restart Asterisk just to make sure you have the right settings. With a little practice you should be able to do these basic echo adjustments in just a few minutes.

Again, this will not solve every echo problem, but for the majority of installations we have done, this was all we needed to do to virtually eliminate the echo problems from the TDM and TE connections.


---

## Firewall



our astersik server does not have to be on a public IP, DMZ, or other non-secure positions to be properly implemented. Presented here is one of the most effectively secure implementations of * behind NAT/firewall.

First make sure the linux firewall on your * server is disabled (you will have to rely on the router firewall or at least after everything is up and running you can re-enable the linux firewall and open each needed port). Then you set a static IP address on your * server. On your router NAT/firewall, forward SIP ports (UDP & TCP) 5060 - 5082 and RTP ports (UDP & TCP) 8000 - 20000 to your * server IP address (or 5000 - 31000 for both SIP and RTP).

For a dual NIC configuration, make sure you set eth0 as the NIC for the * WAN. This is usually the NIC that Linux uses to primarily run WAN with. If unsure check your router outbound log you will find the * primary NIC IP address going outbound to your ITSP, web browsing, or remote extension on port 5060 or whatever your VoIP ports are. If this is not done there will either be no audio, one way audio, or dropped calls as the RTP packets will be sent and received on the wrong NIC(s). IN OTHER WORDS, MAKE SURE YOU CONFIGURE YOUR * SERVER WAN NIC ON eth0 AND FORWARD ALL APLICABLE PORTS TO IT (eth0 IP address) and leave the default gateway field on eth1 NIC blank because it will be going online only through eth0.

Then edit the "rtpstart" value in rtp.conf - from rtpstart=10000 to rtpstart=8000 since 8000 is the default RTP port on x-lite softphones and some other phones, or you might totally change it to asterisk default values which are rtpstart=5000 and rtpend=31000, but you will have to also adjust the RTP (UDP & TCP) port forwarding (mentioned above) on your router NAT/firewall to reflect the same port range. Needless to say, if a remote * server is also behind NAT/firewall on the other end all the port ranges (TCP/UDP) mentioned above need to be opened likewise as here for bidirectionally flow of your VoIP traffic. IP phones or VoIP clients in general do not need any ports opened or forwarded to them. Also enter the same externip=xxx.xxx.xxx.xxx and localnet=xxx.xxx.xxx.xxx/xxx.xxx.xxx.xxx info from your sip.conf general settings into sip_nat.conf.

Then in sip.conf under the account authentication settings for each remote extension add nat=yes, and canreinvite=no . Make sure you save the new configurations in each edited file then run 'reload' on the asterisk CLI or stop and restart * again to comletely re-read all config files after the changes. This should get it working flawlessly, it did it for me after much research and troubleshooting. This should mark the end of NAT/firewall issues with asterisk. I would like to see confirmation postings from those that do implement this.
Thanx.


NOTE: For other protocols such as H.323, SCCP(Skiiny), MGCP, etc you just have to make sure on your router firewall/NAT you have their port numbers forwarded to your * server WAN interface and make sure the RTP ports (which carries the actual audio packets) in your rtp.conf is 5000 - 31000 (TCP/UDP) and also forwarded to * WAN interface as well.

Your WAN or externip address from your ISP is usually not permanent so in the case where it changes you will have to edit the "externip=" value in sip.conf general settings and sip_nat.conf to the new value or better yet you can have it automatically renewed by registering with dynamic DNS (dyndns) through your router (I know Linksys and some other routers have DynDNS in them) to receive a constantly updated domain name that will always resolve to whatever IP address is issued by your ISP to your network. Or another option for those with routers without inbuilt DynDNS is to use your dynamic IP address with no-ip.com; you set it just like DynDNS and download a dynamic update client (for windows, apple or linux) that you can install on your * or any box (that is always on) on your local network in general to update the no-ip.com pointer every 30 minutes or however often you want it. So all you need to do is use the domain name you get from no-ip.com or dyndns.org as your externip= on * so that it resolves that domain name to whatever dynamic IP address your ISP assigns to you at anytime.

For other protocols such as IAX, (IAX2 port is 4569. IAX port is 5036) on your router NAT/firewall you should forward ports (UDP & TCP) 4569 and/or 5036 to your asterisk server IP address.

Bottom line remains to make note of the needed and appropriate ports in your config files and have them forwarded on/by your router NAT/firewall to your * server IP address.

And to add, experiments performed just proved Fedora Core to be most compatible with * , as supported by Digium. So in order to cut down on problems and troubleshooting time there is always an option to try FC. REMEMBER, ALL PORT FORWARDINGS TO * SHOULD BE TO THE * SERVER WAN INTERFACE (THE * NIC PRIMARILY ASSIGNED TO WAN COMMUNICATION) AND THIS BY DEFAULT IS/SHOULD BE eth0. IN OTHER WORDS, MAKE SURE TO ASSIGN eth0 AS YOUR * WAN INTERFACE AND FORWARD ALL PORTS TO ITS IP ADDRESS AND LEAVE THE DEFAULT GATEWAY FIELD ON ETH1 BLANK BECAUSE IT WILL BE GOING ONLINE ONLY THROUGH ETH0.

1. Iptables 

```
-A RH-Firewall-1-INPUT -s 10.1.0.0/255.255.0.0 -j ACCEPT
-A RH-Firewall-1-INPUT -i lo -j ACCEPT
-A RH-Firewall-1-INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A RH-Firewall-1-INPUT -p icmp -m icmp --icmp-type any -j ACCEPT
-A RH-Firewall-1-INPUT -p udp -m udp -d 224.0.0.251 --dport 5353 -j ACCEPT
-A RH-Firewall-1-INPUT -p udp -m udp --dport 631 -j ACCEPT
-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 631 -j ACCEPT
-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 2223 -j ACCEPT
-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 5060:5082 -j ACCEPT
-A RH-Firewall-1-INPUT -p udp -m udp --dport 5060:5082 -j ACCEPT
-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 8000:20000 -j ACCEPT
-A RH-Firewall-1-INPUT -p udp -m udp --dport 8000:20000 -j ACCEPT
-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 10000 -j ACCEPT
-A RH-Firewall-1-INPUT -p tcp -m tcp --dport 1:1024 -j DROP
-A RH-Firewall-1-INPUT -p udp -m udp --dport 1:1024 -j DROP
```

1. Sources 

- http://forums.digium.com/viewtopic.php?p=50588&sid=65c66ad19433c01d56c0f3bedf5d0957 - Digium Fourms


---

## Front End



- http://asterisknow.com/

1. FreePBX 

- http://freepbx.org/

!!!FREE!!!

This one is my favorite. Checkout the trixbox website here -> http://www.trixbox.org/ It comes with everything configured and ready to go in an .ISO package.

1. ThirdLane 

- http://www.thirdlane.com/

Some of the modifications made to Asterisk by ThirdLane require a restart and contrary to FreePBX. ThirdLane feels it is better to do a 'restart now' rather than a 'restart gracefully'. Thus once the operator clicks the restart button the system will 'restart now' dropping all channels. Where the 'restart gracefully' waits for all channels to be free before restarting. 'restart gracefully' would work for simple installs but not in a large locations where it is likely for channels to constantly be in use.

If the operator finds the changes they make, in a given session to require a restart, it is possible to wait until after business hours to restart. There is no time constraint on when it needs to be restarted. Only in order for the changes to take effect a restart of the asterisk process needs to complete.

It is good practice to make all of your changes and then perform the restart/reload.  There is no need to perform this after every single change.

So in summary before I get too geeky...

- Reload will NOT drop channels
- Reload is required basic changes
- Restart is required for advanced changes
- Restart WILL drop all channels
- Restart has no time constraint
- Make all changes and restart or reload only once


---

## Install


= Software Install =


1. Summary 

A friend called and asked me for some help installing Asterisk 1.4 on his system so lets begin.

1. Download the tars from digium 

Make yourself a nice little place to place in /usr/src/

```bash
mkdir /usr/src/asterisk
cd /usr/src/asterisk

wget http://ftp1.digium.com/pub/asterisk/asterisk-1.4.4.tar.gz
wget http://ftp1.digium.com/pub/asterisk/asterisk-addons-1.4.1.tar.gz
wget http://ftp1.digium.com/pub/zaptel/zaptel-1.4.2.1.tar.gz
wget http://ftp1.digium.com/pub/libpri/libpri-1.4.0.tar.gz

```
1. Extract the tars 

```bash
tar zxvf asterisk-1.4.4.tar.gz
tar zxvf asterisk-addons-1.4.1.tar.gz
tar zxvf libpri-1.4.0.tar.gz
tar zxvf zaptel-1.4.2.1.tar.gz

```
1. Check the Kernel for compatibility 

This is probably the most complex part so pay attention.

You will need the kernel sources to compile zaptel sounds easy right? Wrong with dual core CPUs being so common these days you need to make sure you have either one core or 1< cores.

For those of you with only one core issue this command:

```bash
yum install kernel-devel

```
For those of you with more than one issue this command:

```bash
yum install kernel-smp-devel

```
1. Compile zaptel 

Some people have issues with linking to there kernel sources. If you get errors like this:

```bash
You do not appear to have the sources for the kernel installed.

```
You need to symlink to the kernel source as stated in the Readme.Linux26

```bash
ln -s /lib/modules/`uname -r`/build/ `uname -r`

```
Now you are ready to configure and compile zaptel. Change to the zaptel directory and lets get dirty!

```bash
cd /usr/src/asterisk/zaptel*

```
Lets check out what it is actually installing and then save the make config by pressing 'x'

```bash
make menuconfig

```
Now you are ready to make if everything goes right you shouldn't see any errors.

```bash
make

```
Now install...

```bash
make install

```
If everything went well you should end up with something like this and your prompt returning below.

```
Building /etc/modprobe.d/zaptel...
***
*** WARNING:
*** If you had custom settings in /etc/modprobe.d/zaptel,
*** they have been moved to /etc/modprobe.d/zaptel.bak.
***
*** In the future, do not edit /etc/modprobe.d/zaptel, but
*** instead put your changes in another file
*** in the same directory so that they will not
*** be overwritten by future Zaptel updates.
***
[root@localhost zaptel-1.4.2.1]# 
```

Last we have to generate the configuration files.

```bash
make config

```
1. Compile libpri 

**If you will be using a Digium or Sangoma telephony card that supports T1/E1 signaling do this step as well.**

```bash
cd /usr/src/asterisk/libpri*
make install

```
1. Compile Asterisk 

Finally you are in the home stretch! Now all thats left is compiling asterisk and its addons.

```bash
cd /usr/src/asterisk/asterisk*

```
Lets configure make and check out the options via menuconfig

```bash
./configure
 
```
More output for fun:

```
configure: creating ./config.status
config.status: creating build_tools/menuselect-deps
config.status: creating makeopts
config.status: creating channels/h323/Makefile
config.status: creating include/asterisk/autoconfig.h

               .$$$$$$$$$$$$$$$=..      
            .$7$7..          .7$$7:.    
          .$$:.                 ,$7.7   
        .$7.     7$$$$           .$$77  
     ..$$.       $$$$$            .$$$7 
    ..7$   .?.   $$$$$   .?.       7$$$.
   $.$.   .$$$7. $$$$7 .7$$$.      .$$$.
 .777.   .$$$$$$77$$$77$$$$$7.      $$$,
 $$$~      .7$$$$$$$$$$$$$7.       .$$$.
.$$7          .7$$$$$$$7:          ?$$$.
$$$          ?7$$$$$$$$$$I        .$$$7 
$$$       .7$$$$$$$$$$$$$$$$      :$$$. 
$$$       $$$$$$7$$$$$$$$$$$$    .$$$.  
$$$        $$$   7$$$7  .$$$    .$$$.   
$$$$             $$$$7         .$$$.    
7$$$7            7$$$$        7$$$      
 $$$$$                        $$$       
  $$$$7.                       $$  (TM)     
   $$$$$$$.           .7$$$$$$  $$      
     $$$$$$$$$$$$7$$$$$$$$$.$$$$$$      
       $$$$$$$$$$$$$$$$.                

configure: Package configured for: 
configure: OS type  : linux-gnu
configure: Host CPU : i686
```

So now lets get into menuconfig where we can see exactly how it will be configured.

```bash
make menuconfig

```
You should end up with a screen like below:

```
*************************************
      Asterisk Module Selection
*************************************

         Press 'h' for help.

   ---> 1.  Applications
        2.  Call Detail Recording
        3.  Channel Drivers
        4.  Codec Translators
        5.  Format Interpreters
        6.  Dialplan Functions
        7.  PBX Modules
        8.  Resource Modules
        9.  Voicemail Build Options
        10. Compiler Flags
        11. Module Embedding
        12. Core Sound Packages
        13. Music On Hold File Packages
        14. Extras Sound Packages
```

Hit 'h' to get a basic idea of how to use menuconfig

```
*************************************
      Asterisk Module Selection
*************************************

         Press 'h' for help.

   scroll              => up/down arrows
   toggle selection    => Enter
   select              => y
   deselect            => n
   select all          => F8
   deselect all        => F7
   back                => left arrow
   quit                => q
   save and quit       => x

   XXX means dependencies have not been met
       or a conflict exists

   < > means a dependency has been deselected
       and will be automatically re-selected
       if this item is selected

   ( ) means a conflicting item has been
       selected
```

Once you are satisfied and done nosing around hit 'x' and it will save and quit. Now lets stop messing around and make + make install

```bash
make

```
 +--------- Asterisk Build Complete ---------+
 + Asterisk has successfully been built, and +
 + can be installed by running:              +
 +                                           +
 +               make install                +
 +-------------------------------------------+
```

make install

```
 +---- Asterisk Installation Complete -------+
 +                                           +
 +    YOU MUST READ THE SECURITY DOCUMENT    +
 +                                           +
 + Asterisk has successfully been installed. +
 + If you would like to install the sample   +
 + configuration files (overwriting any      +
 + existing config files), run:              +
 +                                           +
 +               make samples                +
 +                                           +
 +-----------------  or ---------------------+
 +                                           +
 + You can go ahead and install the asterisk +
 + program documentation now or later run:   +
 +                                           +
 +              make progdocs                +
 +                                           +
 + **Note** This requires that you have      +
 + doxygen installed on your local system    +
 +-------------------------------------------+
```

```
I would recommend reading the security documentation since it is in ALL CAPS.

I usually generate the sample files as they haven't caused me any issues yet but you don't really have to if you know what you are doing.

```bash
make samples

```
Lastly we have to setup and configure the addons.

```bash
cd /usr/src/asterisk/asterisk-addons*
make
make install

```
Thats it you should now have a fully functioning Asterisk box. Check it out by moving yourself to:

```bash
cd /etc/asterisk

```
Only thing left to figure out now is how to administrate it?

= Running =

1. Startup 

1. Standard 

```bash
/usr/sbin/safe_asterisk

```
1. /etc/init.d/ 

Starting processes at boot time are different among the different operating systems so it is best to consult your OS documentation for how to do this.

However there are some sample scripts located in the original asterisk tar. For instance i found mine under:

```bash
/usr/src/asterisk/asterisk-1.4.4/contrib/init.d

```
1. Using screen 

Start Asterisk at boot time with a program called "screen". Include this command in the /etc/rc.local:

```bash
/usr/bin/screen -L -d -m /usr/sbin/asterisk -vvvvvvvvvvvvvvvvvvvvvgc

```
This will launch the very verbose asterisk console detached with screen logging.
You can reattach to it by typing:

```bash
screen -r

```
The screen log is saved to /screenlog.0

= Hardware Install =

1. Sangoma 

http://wiki.sangoma.com/wanpipe-linux-asterisk-install

1. FAQs 

1. configure: error: *** termcap support not found 

```bash
yum install libtermcap libtermcap-devel newt newt-devel ncurses ncurses-devel

```

---

## Logs



```
/var/log/asterisk/messages /var/log/asterisk/*log {
    create 0640 asterisk asterisk
    daily
    extension .txt
#    mail root@localhost
    missingok
    nocompress
#    notifempty
    rotate 32
    sharedscripts
#    size 10M
    postrotate
        /usr/sbin/asterisk -rx 'logger reload' >/dev/null 2>/dev/null || true
    endscript
}

/var/log/asterisk/cdr-csv/*csv /var/log/asterisk/cdr-custom/*csv {
    create 0640 asterisk asterisk
    monthly
    extension .txt
#    mail root@localhost
    missingok
    nocompress
#    notifempty
    rotate 2
    sharedscripts
#    size 10M
    postrotate
        /usr/sbin/asterisk -rx 'logger reload' >/dev/null 2>/dev/null || true
    endscript
}
```

```
/var/log/asterisk/messages /var/log/asterisk/*log {
    create 0640 asterisk asterisk
    daily
    extension .txt
    mail root@localhost
    missingok
    nocompress
    notifempty
    rotate 64
    sharedscripts
#    size 10M
    postrotate
        /usr/sbin/asterisk -rx 'logger reload' >/dev/null 2>/dev/null || true
    endscript
}

/var/log/asterisk/full {
    create 0640 asterisk asterisk
    daily
    extension .txt
#    mail root@localhost
    missingok
    nocompress
#    notifempty
    rotate 32
    sharedscripts
#    size 10M
    postrotate
        /usr/sbin/asterisk -rx 'logger reload' >/dev/null 2>/dev/null || true
    endscript
}

/var/log/asterisk/cdr-csv/*csv /var/log/asterisk/cdr-custom/*csv {
    create 0640 asterisk asterisk
    monthly
    extension .txt
#    mail root@localhost
    missingok
    nocompress
#    notifempty
    rotate 2
    sharedscripts
#    size 10M
    postrotate
        /usr/sbin/asterisk -rx 'logger reload' >/dev/null 2>/dev/null || true
    endscript
}
```


---

## Queue



QueueLog(queuename,uniqueid,agent,event,params):

Allows you to write your own events into the queue log:

```bash
QueueLog(101,${UNIQUEID},${AGENT},WENTONBREAK,600)

```
[http://bugs.digium.com/view.php?id=7368](http://bugs.digium.com/view.php?id=7368)

1. Dynamic Members Extension 

Add the following line to enable the agent-manage macro for a queue into your extensions configuration file.

```bash
exten => 1234*,1,Macro(agent-manage,1234,)

```
1. Dynamic Members Macros 

Add the appropriate macro for your needs and version of asterisk into your macros configuration file.

- **Important:** Ensure that your context for internal calls is the same as **from-internal** if not you will have to change this.

1. Dynamically Manage Agents/Members and log Time-In-Queue (Asterisk 1.4) 

Adds or removes a dynamic member to the queue based on called ID information and logs the time in queue in seconds to /var/log/asterisk/queue_log.

```
; Adds or removes a dynamic agent/member for a queue and logs Time-In-Queue
; arg1 = queue number, arg2 = number
[macro-agent-manage]
exten => s,1,Wait(1)
exten => s,2,Macro(user-callerid)
exten => s,3,Set(CALLBACKNUM=${CALLERID(number)})
exten => s,4,GotoIf($["${CALLBACKNUM}" = ""]?116))      ; if no number, jump to fail.
exten => s,5,AddQueueMember(${ARG1}|Local/${CALLBACKNUM}@from-internal/n||j)       ; using chan_local allows us to have agents over trunks
exten => s,6,QueueLog(${UNIQUEID},${ARG1},${CALLBACKNUM},AGENTLOGIN,0)
exten => s,7,Set(DB(agentlogin/q_${ARG1}_a_${CALLBACKNUM})=${EPOCH})
exten => s,8,UserEvent(Agentlogin|Agent: ${CALLBACKNUM})
exten => s,9,Wait(1)
exten => s,10,Playback(agent-loginok)
exten => s,11,Hangup()
exten => s,106,RemoveQueueMember(${ARG1}|Local/${CALLBACKNUM}@from-internal/n)
exten => s,107,UserEvent(RefreshQueue)
exten => s,108,Set(ORGEPOCH=${DB(agentlogin/q_${ARG1}_a_${CALLBACKNUM})})
exten => s,109,Set(LGNT=$[${EPOCH} - ${ORGEPOCH}])
exten => s,110,GotoIf($["${LGNT}" = "0"]?116:111)
exten => s,111,QueueLog(${UNIQUEID},${ARG1},${CALLBACKNUM},AGENTLOGOFF,${LGNT})
exten => s,112,DBdel(agentlogin/q_${ARG1}_a_${CALLBACKNUM})
exten => s,113,Wait(1)
exten => s,114,Playback(agent-loggedoff)
exten => s,115,Hangup()
exten => s,116,Playback(sorry-cant-let-you-do-that) ; Catch error and give simple notification.
exten => s,117,Hangup()
```

1. Dynamically Manage Agents/Members and log Time-In-Queue (Asterisk 1.2) 

Adds or removes a dynamic member to the queue based on called ID information and logs the time in queue in seconds to /var/log/asterisk/queue_log.

- Requires Queue_Log patch see [Queue Log Function](misc--.md#queue-log-function)

```
; Adds or removes a dynamic agent/member for a queue and logs Time-In-Queue
; arg1 = queue number, arg2 = number
[macro-agent-manage]
exten => s,1,Wait(1)
exten => s,2,Macro(user-callerid)
exten => s,3,Set(CALLBACKNUM=${CALLERID(number)})
exten => s,4,GotoIf($["${CALLBACKNUM}" = ""]?116))      ; if no number, jump to fail.
exten => s,5,AddQueueMember(${ARG1}|Local/${CALLBACKNUM}@from-internal/n)       ; using chan_local allows us to have agents over trunks
exten => s,6,QueueLog(${UNIQUEID},${ARG1},${CALLBACKNUM},AGENTLOGIN,0)
exten => s,7,Set(DB(agentlogin/q_${ARG1}_a_${CALLBACKNUM})=${EPOCH})
exten => s,8,UserEvent(Agentlogin|Agent: ${CALLBACKNUM})
exten => s,9,Wait(1)
exten => s,10,Playback(agent-loginok)
exten => s,11,Hangup()
exten => s,106,RemoveQueueMember(${ARG1}|Local/${CALLBACKNUM}@from-internal/n)
exten => s,107,UserEvent(RefreshQueue)
exten => s,108,Set(ORGEPOCH=${DB(agentlogin/q_${ARG1}_a_${CALLBACKNUM})})
exten => s,109,Set(LGNT=$[${EPOCH} - ${ORGEPOCH}])
exten => s,110,GotoIf($["${LGNT}" = "0"]?116:111)
exten => s,111,QueueLog(${UNIQUEID},${ARG1},${CALLBACKNUM},AGENTLOGOFF,${LGNT})
exten => s,112,DBdel(agentlogin/q_${ARG1}_a_${CALLBACKNUM})
exten => s,113,Wait(1)
exten => s,114,Playback(agent-loggedoff)
exten => s,115,Hangup()
exten => s,116,Playback(sorry-cant-let-you-do-that) ; Catch error and give simple notification.
exten => s,117,Hangup()
```

1. Dynamically Manage Agents/Members (Asterisk 1.4) 

Adds or removes a dynamic member to the queue based on called ID information.

```
; Adds or removes a dynamic agent/member for a queue
; arg1 = queue number, arg2 = number
[macro-agent-manage]
exten => s,1,Wait(1)
exten => s,2,Macro(user-callerid)
exten => s,3,Set(CALLBACKNUM=${CALLERID(number)})
exten => s,4,GotoIf($["${CALLBACKNUM}" = ""]?111))      ; if no number, jump to fail.
exten => s,5,AddQueueMember(${ARG1}|Local/${CALLBACKNUM}@from-internal/n||j)       ; using chan_local allows us to have agents over trunks
exten => s,6,UserEvent(Agentlogin|Agent: ${CALLBACKNUM})
exten => s,7,Wait(1)
exten => s,8,Playback(agent-loginok)
exten => s,9,Hangup()
exten => s,106,RemoveQueueMember(${ARG1}|Local/${CALLBACKNUM}@from-internal/n)
exten => s,107,UserEvent(RefreshQueue)
exten => s,108,Wait(1)
exten => s,109,Playback(agent-loggedoff)
exten => s,110,Hangup()
exten => s,111,Playback(sorry-cant-let-you-do-that) ; Catch error and give simple notification.
exten => s,112,Hangup()
```

1. Dynamically Manage Agents/Members (Asterisk 1.2) 

Adds or removes a dynamic member to the queue based on called ID information.

```
; Adds or removes a dynamic agent/member for a queue
; arg1 = queue number, arg2 = number
[macro-agent-manage]
exten => s,1,Wait(1)
exten => s,2,Macro(user-callerid)
exten => s,3,Set(CALLBACKNUM=${CALLERID(number)})
exten => s,4,GotoIf($["${CALLBACKNUM}" = ""]?111))      ; if no number, jump to fail.
exten => s,5,AddQueueMember(${ARG1}|Local/${CALLBACKNUM}@from-internal/n)       ; using chan_local allows us to have agents over trunks
exten => s,6,UserEvent(Agentlogin|Agent: ${CALLBACKNUM})
exten => s,7,Wait(1)
exten => s,8,Playback(agent-loginok)
exten => s,9,Hangup()
exten => s,106,RemoveQueueMember(${ARG1}|Local/${CALLBACKNUM}@from-internal/n)
exten => s,107,UserEvent(RefreshQueue)
exten => s,108,Wait(1)
exten => s,109,Playback(agent-loggedoff)
exten => s,110,Hangup()
exten => s,111,Playback(sorry-cant-let-you-do-that) ; Catch error and give simple notification.
exten => s,112,Hangup()
```

1. FreePBX 

The above macros are based on macros from the FreePBX front-end to Asterisk. If you choose to implement any of the above macros and are using FreePBX I recommend doing some additional cleanup.

- Remove all references to agent-add and agent-del in extensions_additional.conf as agent-manage will now facilitate this.
```bash
exten => 1234*,1,Macro(agent-add,1234,)
exten => 1234**,1,Macro(agent-del,1234,1234)

```
- Remove agent-add and agent-del from extension.conf as agent-manage will now facilitate this.
```bash
[macro-agent-add]
[macro-agent-del]


```

---

## Sipgate



Wie konfiguriere ich Asterisk? (zurück)

Anbei die notwendigen Einstellungen, um Asterisk für sipgate grundlegend zu konfigurieren.

Ersetzen sie jeweils SIPID durch Ihre SIP-ID und PASSWD durch Ihr SIP-Passwort.

1. sip.conf 

```
[general]
port = 5060
bindaddr = 0.0.0.0
context = sipout
qualify=no
disable=all
allow=alaw
allow=alaw
allow=ulaw
allow=g729
allow=gsm
allow=slinear
srvlookup=yes
canreinvite=yes
language=de
register => SIPID:PASSWD@sipgate.at/SIPID

[sipgate-out]
type=friend
insecure=very ; otherwise I get authentication errors
nat=yes
username=SIPID
fromuser=SIPID
fromdomain=sipgate.at
secret=SIPPW
host=sipgate.at
qualify=yes
```

1. extension.conf 

```

[sipout]
exten => _X.,1,SetCallerId,SIPID
exten => _X.,2,Dial(SIP/${EXTEN}@sipgate-out,30,trg)
exten => _X.,3,Hangup
```

Bitte haben Sie Verständnis, dass wir über diese Angaben hinaus leider keinen Support für Asterisk bieten können.

```
[general]
port = 5060
bindaddr = 0.0.0.0
context = default
register => SIPGATENUM:PASSWD@sipgate.de/SIPGATENUM

[SIPGATENUM]
type=peer
username=SIPGATENUM
fromuser=SIPGATENUM
secret=PASSWD
context=default
host=sipgate.de
fromdomain=sipgate.de
insecure=very
caninvite=no
canreinvite=no
nat=no
disallow=all
allow=ulaw
allow=alaw

[sipgate_de_in]
type=peer
fromdomain=sipgate.de
host=sipgate.de
context=incoming
diallow=all
allow=ulaw
allow=alaw
```

1. Links 

- http://www.geisterstunde.org/drupal/?q=asterisk_sipgate
- https://secure.sipgate.at/faq/index.php?aktion=artikel&rubrik=715&id=540&lang=de&highlight=asterisk


---

## Tutorial



To learn more about Asterisk and its partners you can visit their website at [Asterisk.org](http://www.asterisk.org/).



Displayed on the right is a picture of the Eyebeam softphone with its phone book extended.

For an example of CounterPath's product support click here -> [Eyebeam](voip--eyebeam.md)

For more information on using Eyebeam and the **FREE** X-Lite please visit CounterPath's website.

1. Web 

For your convenience there is a web based system for reviewing and managing your voice messages.

Web based voicemail http://192.168.1.10/recordings/

The IP above should be replaced with that of your server.

You will be prompted for the following information...

- Username: <extension>
- Password: 1234 (Default)

1. eMail 

By default you will receive a eMail message each time you receive a voice mail from the Asterisk system. This eMaill will contain some simple information about the message and a link to retrieve it. Eventually it would be nice to just attach the sound file to the email but this would require a localized eMail server for each Asterisk system and as of current is not a priority.

1. Transferring Calls 


**Softphone**

To transfer a call to any extension press the blue transfer button (XFER) located on the top left of your phone, enter the desired
extension and press the blue transfer button again or enter to transfer the call.

**Hardphone**

To transfer a call to any extension
1. Mute the phone if possible
1. Press the # key and wait for the automated "transfer" response
1. Enter the desired extension number on the keypad

If the call was transferred correctly you will instantly hear a busy tone once you hear this tone it is safe to hang up.

**Direct To Voicemail**

To transfer directly to voicemail use the same procedure as above but prefix the extension
number with a *.

1. Voicemail 

**Setup**

To configure your mailbox for the first time there are 4 things you must do.

1. Record your unavailable message
1. Record your busy message
1. Record your name for the directory
1. Change your password

**Unavailable Message**
This is the message to be played when your computer is on and you are logged into Eyebeam but do not answer your phone. To record this message log into your mailbox and press **0** to configure mailbox options. Choose
*1* to record your unavailable message and follow the automated instructions.

**Busy Message**
This is the message that will be played when you are not logged into Eyebeam. This means that if you shut your computer down this is the message that will be played. To record this message log into your mailbox and press **0** to configure mailbox options. Choose
**2** to record your busy message and follow the automated instructions.

**Record Your Name**
This is the name that will be heard in the company directory. To record your name log into your mailbox and press **0** to configure mailbox options. Choose **3** to record your name and follow the automated instructions.

**Change Your Password**
Your default password is **1234** to change this password log into your mailbox and press **0** to configure mailbox options. Next choose **5** to change your password and follow the automated instructions.

**Internally**

To check your voicemail from *your own extension* simply click on the envelope as displayed in the picture to your right. You can also dial ***97** to reach your mail. Once you are connected you will be prompted for the following information...

- Password: 1234 (Default)

To check your voice mail using *any internal extension* you may call the Message Center at ***98** you will be prompted for the following information...

- Username: <extension>
- Password: 1234 (Default)

**Externally**

Since each Asterisk system operates independent from the others you can only check your voicemail if you are connected internally at your primary location. However with a Cisco VPN client it is possible to bypass this requirement.

1. Conferences 

By default each location is configured with a public conference room at **<LOCATION_CODE>95**.
The location code is simply the first number of your extension.
So if your extension is **100** you would replace the <LOCATION_CODE> with a **1**.

1. FAQs 

'''How do I locate an employee's extension?'''

- Dial *411 from any internal office extension and follow the instructions of the automated system.
- Dial the external number and press the # key when prompted and follow the instructions of the automated system.



---

## Voice Changer



Fedora

```bash
# yum install soundtouch soundtouch-devel

```
General

```
# install SoundTouch 1.3.1-jart
# you can also install it through your package manager
cd /usr/src
wget http://www.lobstertech.com/code/libsoundtouch4c/releases/soundtouch-1.3.1-jart.tar.gz
tar xvzf soundtouch-1.3.1-jart.tar.gz
cd soundtouch-1.3.1-jart/
./configure --enable-integer-samples --prefix=/usr
make
make install

# install libsoundtouch4c
cd /usr/src
wget http://www.lobstertech.com/code/libsoundtouch4c/releases/libsoundtouch4c-0.4.tar.gz
tar -xzvf libsoundtouch4c-0.4.tar.gz
cd libsoundtouch4c-0.4
./configure --prefix=/usr
make
make install

# install the voice changer
cd /usr/src
wget http://www.lobstertech.com/code/voicechanger/releases/voicechanger-0.6.tar.gz
tar -xzvf voicechanger-0.6.tar.gz
cd voicechanger-0.6
make
make install

# load it in to asterisk
make start
```

1. Load 

```bash
asterisk -rx "load $x"

```
1. Sources 

- http://lobstertech.com/2005/oct/31/asterisk_voice_changer/
