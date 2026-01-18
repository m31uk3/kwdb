# Linux Network Config


## Network Configuration Using the Command Line

### Introduction

Each Linux distribution has its own tool or utility for configuring an Ethernet card and network settings. However, learning how to do this using only an xterm session will allow you to configure the network on almost any Linux box.

### Static IP Address

```bash
  1. Load the proper module(driver) for your ethernet card:
     The list of compiled ethernet card drivers that come with your system are usually located under /lib/modules/2.2.14-5.0/net where 2.2.14-5.0 is your kernel version. The source code for these drivers are usually located at /usr/src/linux-2.2.14/drivers/net again where 2.2.14 is the kernel version you are running. Sometimes the comments at the beginning of the source code file will tell you which ethernet cards the driver is for. Some distributions will find it during installation and automatically load the driver for you. To see if this is the case, view the file /etc/modules.conf or /etc/conf.modules depending on your distribution. If you see a line that looks similar to alias eth0 ne2k-pci, then the third item on the line is the module being used for your ethernet card. In this example, ne2k-pci, the NE2000 driver is being used. To verify the module has been loaded successfully, issue the command /sbin/lsmod. This will display all modules successfully loaded in the system. Once your module is loaded, you are ready to move to the next step.
     If the module is not loaded, but you know what module your network card uses, issue the following steps as root:
         * Make sure the network is stopped by issuing /etc/rc.d/init.d/network stop.
         * Manually load the module by issuing /sbin/insmod ne2k-pci replacing ne2k-pci with whatever your module is. This module must be present in the /lib/modules/2.2.14-5.0/net directory for lsmod to find it.
         * Verify it loaded successfully by issuing /sbin/lsmod.
         * Activate the eth0 device by issuing /etc/rc.d/init.d/network start
         * Configure your network settings with steps 2-6. You must still be root to perform these steps. 
  2. Set the IP address and network mask: /sbin/ifconfig -a eth0 192.168.1.5 netmask 255.255.255.0
     This example gives the machine the IP address 192.168.1.5, but you can use any combination of IP/netmask that will work with your network.
  3. Verify the settings with /sbin/ifconfig eth0.
  4. Add the default gatway: /sbin/route add default gw 192.168.1.254 replacing 192.168.1.254 with your gateway.
  5. Verify the gateway setting: /sbin/route. The line beginning with default should have your gateway under the gateway column.
  6. Alternately, you can edit the file /etc/sysconfig/network-scripts/ifcfg-eth0 to look like (replace with your network numbers)

     DEVICE=eth0
     USERCTL=no
     ONBOOT=yes
     BOOTPROTO=none
     BROADCAST=192.168.1.255
     NETWORK=192.168.1.0
     NETMASK=255.255.255.0
     IPADDR=192.168.1.5

     and the file /etc/sysconfig/network to look like (replace with your network numbers and hostname)

     NETWORKING=yes
     HOSTNAME=name.host.net
     FORWARD_IPV4=yes
     GATEWAYDEV=
     GATEWAY=192.168.1.254

  7. Ping the gateway and a few other computers on the network to verify your settings are correct. 

```
### Dynamically Assigned IP Address

```bash
  1. Load the proper module(driver) for your ethernet card:
     The list of compiled ethernet card drivers that come with your system are usually located under /lib/modules/2.2.14-5.0/net where 2.2.14-5.0 is your kernel version. The source code for these drivers are usually located at /usr/src/linux-2.2.14/drivers/net again where 2.2.14 is the kernel version you are running. Sometimes the comments at the beginning of the source code file will tell you which ethernet cards the driver is for. Some distributions will find it during installation and automatically load the driver for you. To see if this is the case, view the file /etc/modules.conf or /etc/conf.modules depending on your distribution. If you see a line that looks similar to alias eth0 ne2k-pci, then the third item on the line is the module being used for your ethernet card. In this example, ne2k-pci, the NE2000 driver is being used. To verify the module has been loaded successfully, issue the command /sbin/lsmod. This will display all modules successfully loaded in the system. Once your module is loaded, you are ready to move to the next step.
     If the module is not loaded, but you know what module your network card uses, issue the following steps as root:
         * Make sure the network is stopped by issuing /etc/rc.d/init.d/network stop.
         * Manually load the module by issuing /sbin/insmod ne2k-pci replacing ne2k-pci with whatever your module is. This module must be present in the /lib/modules/2.2.14-5.0/net directory for lsmod to find it.
         * Verify it loaded successfully by issuing /sbin/lsmod.
         * Activate the eth0 device by issuing /etc/rc.d/init.d/network start
         * Configure your network settings with steps 2-4. You must still be root to perform these steps. 
  2. Edit/create the file /etc/sysconfig/network-scripts/ifcfg-eth0 to use DHCP.
     Sample ifcfg-eth0 file:

     DEVICE=eth0
     USERCTL=no
     ONBOOT=yes
     BOOTPROTO=dhcp
     BROADCAST=
     NETWORK=
     NETMASK=
     IPADDR=

  3. Replace eth0 above with eth1 if it is the second network card in your system.
  4. Edit/create the file /etc/sysconfig/network to use DHCP.

     NETWORKING=yes
     HOSTNAME=
     FORWARD_IPV4=yes
     GATEWAYDEV=
     GATEWAY=

  5. Restart the network to probe the DHCP server for your network settings with the command /etc/rc.d/init.d/network restart.
  6. Verify your network settings with the command /sbin/ifconfig to make sure you have received an IP address from the DHCP server.
  7. Ping the gateway and a few other computers on the network to verify your connection. 

```
## Sources

http://www.linuxheadquarters.com/howto/networking/networkconfig.shtml

