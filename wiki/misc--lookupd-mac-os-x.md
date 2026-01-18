# Lookupd Mac OS X


## Examples

### Flush DNS Cache

You can flush the DNS cache on Mac OSX manually by typing the following command into terminal:

```bash
lookupd -flushcache

sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder

```
