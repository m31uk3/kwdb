# Wireless Configuration


## Summary
This page will deal with manually connecting to a wireless access point using iwconfig and ifconfig. For those of you running linux on laptops, I highly suggest using the Kubuntu Distribution [http://www.kubuntu.org/]. Out of the box, it supports pretty much all hardware (soundcards, wificards, usb), it is made to be very user friendly (ex: when you put a CD in it appears on your desktop, no need to "mount" it through the command line), and it connects well to other machines (Windows, OSX, and other linux distributions).

## Hardware Compatibility
If you plan on purchasing a wifi card, or have a wifi card that is not working, check this list for compatibility:
[http://www.linux-wlan.org/docs/wlan_adapters.html.gz]

All wifi drivers and the way each distribution implements them is a little different. I would suggest using Google to find more information about driver installation.

If you think your WiFi card is installed, try this:
```bash
lspci | grep 802.11

```
If you don't see anything, try just lspci by itself:
```bash
lspci

```
And look through for a wireless card.

## My setup
- **My laptop:** Acer TravelMate 2420
- **O/S:** Kubuntu Linux (Edgy Elf) 
- **Wifi Card:** Atheros AR5005G 802.11abg (Internal)
- **Wifi Driver:** madwifi

Kubuntu automatically detected and installed my wifi card, so I didn't have to go through any driver installations. It also automatically connects me to wifi networks, so I don't usually have to manually connect to an access point by command line. However, if there is more than once access point it sometimes connects me to the wrong one. The only way I have found to fix this was to learn how to manually connect.

## Log in as Root
If you are not already root, you need to log in as root. Either *su* or *sudo bash*. Use *su* only if *sudo* doesn't work

```bash
sudo bash
```
or
```bash
su

```
## Shut down wifi0
Run ifconfig, you should see a wifi0 connection (or someting similar). Ignore wlan0, ath0, eth0 and their variants (different numbers).
```bash
ifconfig


```
And look in the output for something like:
```bash
wifi0     Link encap:UNSPEC  HWaddr 00-14-A4-66-08-74-00-00-00-00-00-00-00-00-00-00
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:34439 errors:0 dropped:0 overruns:0 frame:155
          TX packets:2632 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:199
          RX bytes:3751033 (3.5 MiB)  TX bytes:366747 (358.1 KiB)
          Interrupt:177 Memory:d0300000-d0310000

```
If you can't find it, it may already be off. Go to the next section. It may also be that your linux distribution is different than mine, I have only tested this on my setup...


We are going to turn that off. Enter the following command, modify it if you need to (example: if you have wifi1 instead of wifi0):
```bash
ifconfig wifi0 down

```
If you do it correctly it shouldn't output anything back.

## Gathering Access Point Information
If you run the Access Point and know what channel and ESSID you are broadcasting on, you can skip to the next section. Otherwise, you will need that information. There are a few ways to get it.

- Using another computer that is already connected to the wireless access point. It should say the name of the wireless network (the ESSID) and if you get the properties of the network it should also tell you the channel it's on. If this is the case you are in luck, write it down and go to the next step. NOTE: if there are mutliple access points using the same ESSID, you will have to use the other method.
- Using a program called "kismet" to locate all wireless access points around you. Copy down the ESSID, BSSID (MAC ADDR), and Channel. Move on to the next section.

You should be able to find information online to help you install/use kismet. I will be writing a guide eventually for this wiki as well.

## Understanding iwconfig
Run iwconfig to see what is going on
```bash
iwconfig

```
If you are using the madwifi driver, you should see something like this:
```bash
lo        no wireless extensions.
  
wifi0     no wireless extensions.
  
ath0      IEEE 802.11g  ESSID:"belkin54g"
          Mode:Managed  Frequency:2.462 GHz  Access Point: 00:11:50:06:E6:3B
          Bit Rate:36 Mb/s   Tx-Power:9 dBm   Sensitivity=0/3
          Retry:off   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:off
          Link Quality=29/94  Signal level=-66 dBm  Noise level=-95 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0
  
eth0      no wireless extensions.
  
sit0      no wireless extensions.

```
## iwconfig Syntax
The syntax to set up iwconfig is very simple.
```bash
iwconfig INTERFACE essid YOUR_ESSID
iwconfig INTERFACE channel YOUR_CHANNEL
iwconfig INTERFACE ap YOUR_BSSID

```
Please note that unless there is more than one Access Point with the same ESSID and Channel, **you will NOT need to enter the last line**.

An example, to connect via interface ath0, using the ESSID "belkin54g", Channel 11, BSSID 00:11:50:06:E6:3B would be:
```bash
iwconfig ath0 essid belkin54g
iwconfig ath0 channel 11
iwconfig ath0 ap 00:11:50:06:E6:3B

```
Now view iwconfig to see if it comes up. If all goes well it should even give you the signal quality (*link quality*).

## Bringing wifi0 back up
You're not done yet, you need to bring wifi0 back up. Here's how:
```bash
ifconfig wifi0 up

```
That's it. Everything should work fine. Sometimes I have problems with DNS when I do it this way, but for the most part I'm fine. To test it out, try pinging my webserver: gtwy.net

This is a successful ping:
```bash
ping gtwy.net
    PING gtwy.net (65.111.166.56) 56(84) bytes of data.
    64 bytes from 56-166-111-65.serverpronto.com (65.111.166.56): icmp_seq=1 ttl=48 time=46.6 ms
    64 bytes from 56-166-111-65.serverpronto.com (65.111.166.56): icmp_seq=2 ttl=48 time=46.7 ms
    64 bytes from 56-166-111-65.serverpronto.com (65.111.166.56): icmp_seq=3 ttl=48 time=46.9 ms
    64 bytes from 56-166-111-65.serverpronto.com (65.111.166.56): icmp_seq=4 ttl=48 time=47.4 ms
  
    --- gtwy.net ping statistics ---
    4 packets transmitted, 4 received, 0% packet loss, time 3002ms
    rtt min/avg/max/mdev = 46.672/46.961/47.436/0.393 ms

```
Here is an example of domain name resolving failing (problems with DNS):
```bash
ping gtwy.net
    ping: unknown host gtwy.net

```
If that fails, try pinging 65.111.166.56. That is one of the IPs to the server. This is an example of the internet working even if the DNS is not:
```bash
ping 65.111.166.56
    PING 65.111.166.56 (65.111.166.56) 56(84) bytes of data.
    64 bytes from 65.111.166.56: icmp_seq=1 ttl=48 time=46.7 ms
    64 bytes from 65.111.166.56: icmp_seq=2 ttl=48 time=46.5 ms
  
    --- 65.111.166.56 ping statistics ---
    2 packets transmitted, 2 received, 0% packet loss, time 999ms
    rtt min/avg/max/mdev = 46.586/46.682/46.779/0.236 ms


```
The WORST CASE scenario is when the internet flat out doesn't work. The last command will either give a "destination host unreachable" error message or not give any messages at all. If this is your situation, I would suggest rebooting and trying again. I have noticed my wifi card sometimes fails to connect but works fine after a reboot.

## Still having trouble?
All I can suggest now is reading the manual pages about wireless configuration. Try the following commands.

```bash
man wireless
man iwconfig
man ifconfig

```
