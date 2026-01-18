# Linux Hostname


## Checking your hostname

First, see if your host name is set correctly using the following commands:

```bash
uname -n
hostname -a
hostname -s
hostname -d
hostname -f
hostname

```
If the above commands return correctly with no errors then all may be well; however, you may want to read on to verify that all settings are correct.

## Configuring /etc/hosts

If your IP address is assigned to you by a DHCP server, then /etc/hosts is configured as follows:

```bash
127.0.0.1	mybox.mydomain.com	localhost.localdomain localhost mybox

```
If you have a static IP address, then /etc/hosts is configured as follows:

```bash
127.0.0.1	localhost.localdomain localhost
192.168.0.10	mybox.mydomain.com	mybox

```
## Setting the Host Name using "hostname"

After updating the /etc/hosts file correctly, the "hostname" command should be run as follows to set your hostname:

```bash
hostname mybox.mydomain.com

```
## Checking /etc/HOSTNAME (if present)

You may or may not have the file /etc/HOSTNAME:

```bash
mybox.mydomain.com

```
## Checking /etc/sysconfig/network

If you have a static IP address, then /etc/sysconfig/network is configured as follows:

```bash
NETWORKING=yes
HOSTNAME="mybox.mydomain.com"

```
If your IP address is assigned to you by a DHCP server, and you wish to update the local DNS server through Dynamic DNS, then /etc/sysconfig/network is configured as follows:

```bash
NETWORKING=yes
HOSTNAME="mybox.mydomain.com"
DHCP_HOSTNAME="mybox.mydomain.com"

```
It makes more sense to move this "DHCP_HOSTNAME" variable into /etc/sysconfig/network-scripts/ifcfg-eth0 (or appropriate NIC cfg file). So the above section has been moved, see below. If you have only 1 NIC, then the above struck section works fine, but with more than 1 NIC it makes no sense. Maybe this is true for the "'HOSTNAME" line too, maybe that line should be moved into /etc/sysconfig/network-scripts/ifcfg-eth0 as well. I will investigate further. By default RHL places HOSTNAME=localhost.localdomain in /etc/sysconfig/network.

## Checking /proc/sys/kernel/hostname

This is checked with the following command:

```bash
cat /proc/sys/kernel/hostname

```
If you need to set this file, you can either reboot or set it now with the following command:

```bash
echo mybox.mydomain.com > /proc/sys/kernel/hostname

```
## Dynamic DNS - Updating the local DNS server with your host name and DHCP IP

For Red Hat Linux if you receive your IP address from a DHCP server, you may update the local DNS server by adding the following line to the correct ifcfg file in /etc/sysconfig/network-scripts, such as ifcfg-eth0 or ifcfg-eth1:

```bash
DHCP_HOSTNAME="mybox.mydomain.com"

```
or if running Debian, edit /etc/network/interfaces as follows (adding the hostname line):

```bash
iface eth0 inet dhcp
hostname mybox.mydomain.com

```
Updated information about ddns:

Kill the dhclient process

```bash
killall dhclient

```
Make sure it is gone

Then restart networking

```bash
service network restart"

```
Updated information for ddns on Gentoo:

```bash
killall dhclient

```
Edit /etc/conf.d/net

uncomment and modify the line as follows:

```bash
dhcpcd_eth0="-h yourhostname"

```
reboot or restart your network subsystem

Thanks to Jack for the Gentoo information!

For more info in Debian, see "man interfaces" and scroll down to"The dhcp Method".

## WINS - Updating the local WINS server with your host name and IP

If you wish to update the local WINS server, then use SAMBA, and configure it to point to the local WINS server. samba.html i.e. update the /etc/samba/smb.conf "wins server = " entry with the WINS server addresses for your network - be sure not to enable "wins support = yes" as that will make Linux a WINS server.

## Changing the hostname while in X-Windows

Changing the hostname while in X-Windows can be problematic. Most often, new windows cannot be opened. Either
1. change the hostname while the X-Windows is not running or
1. in X-Windows change the hostname, then restart X-Windows.

## Sources

- http://www.cpqlinux.com/hostname.html

