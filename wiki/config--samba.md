# Samba


## FAQ


### Slow Read Mac OS X

There seems to be a problem with the default configuration of the sockets option in the /etc/smb.conf file.

By default it is configured as below:

```bash
socket options = IPTOS_LOWDELAY TCP_NODELAY SO_SNDBUF=4096 SO_RCVBUF=4096

```
To fix the slow read for Mac OS X clients simply replace it with this one:

```bash
socket options = IPTOS_LOWDELAY TCP_NODELAY

```
