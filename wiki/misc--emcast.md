# Emcast


## Install

Download package:

```bash
wget http://www.gizmolabs.org/~dhelder/junglemonkey/emcast/src/emcast-0.3.2.tar.gz

```
Uncompress and change directory:

```bash
tar zxvf emcast-0.3.2.tar.gz
cd emcast-0.3.2

```
Install glib and glib-devel:

```bash
yum install glib glib-devel

```
Configure, make, and make install:

```bash
./configure --prefix=/usr
make
make install

```
Show usage:

```bash
emcast --help

```
Endhost multicast utility
        -b <size>         buffer size (default is 8192)
        -h                display help
        -l                turn loopback on
        -o<name> <value>  set option <name> to <value>
        -O<name> <value>  set option <name> to <value> before joining
        -q                quiet (no input/output)
        -t <ttl>          time-to-live
```

```
