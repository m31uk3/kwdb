# Change MTU Size


## Windows XP

## Linux

## Mac OS X

### Summary

You may run into situations where the internet connection has a high rate of error or has a lower MTU size enforced than the Mac OS X default. By altering the MTU size on the active local interface it is possible to overcome such problems. This tutorial will walk you through changing your MTU size temporarily.

### Requirements

- Mac OS X - [Terminal](misc--terminal-macos.md)

### Procedure

- Enter the command below to gain root privileges:

```bash
sudo -s

```
- Enter your administrator password when prompted and press return

- Determine the interface you would like to change the MTU on with the command below:

```bash
ipconfig

```
- Set the MTU on the interface you chose with the command below:

```bash
ifconfig <interface> mtu <size>

```
- Default MTU Size (Ethernet): 1500
- Recommended Change (Ethernet): 1480 

- To check that everything worked correctly type the command below:

```bash
ifconfig <interface> ¦ grep mtu

```
- If a line is returned with the MTU size you set in the step above then everything worked correctly.

### External Links

[Change MTU Size Mac OS X Permanently](http://docs.info.apple.com/article.html?artnum=107474|)

