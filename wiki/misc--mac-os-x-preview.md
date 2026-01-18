# Mac OS X Preview


## QuickLook thumbnails.data, Flushing thumbnails, Clear recent Exposé thumbnails in Preview, Preview recent files

The file is located under:

```bash
/private/var/folders/<random>/<random>/C/com.apple.QuickLook.thumbnailcache

```
For example on my mac book pro:

```
ljackson@Lukes-MBP 10:51:54 /private/var/folders> sudo find . | grep QuickLook
./zz/zyxvpxvq6csfxvn_n0000000000000/C/com.apple.QuickLook.thumbnailcache
./zz/zyxvpxvq6csfxvn_n0000000000000/C/com.apple.QuickLook.thumbnailcache/exclusive
./zz/zyxvpxvq6csfxvn_n0000000000000/C/com.apple.QuickLook.thumbnailcache/index.sqlite
./zz/zyxvpxvq6csfxvn_n0000000000000/C/com.apple.QuickLook.thumbnailcache/index.sqlite-shm
./zz/zyxvpxvq6csfxvn_n0000000000000/C/com.apple.QuickLook.thumbnailcache/index.sqlite-wal
./zz/zyxvpxvq6csfxvn_n0000000000000/C/com.apple.QuickLook.thumbnailcache/thumbnails.data
./zz/zyxvpxvq6csfxvn_n0000000000000/C/com.apple.QuickLook.thumbnailcache/thumbnails.fraghandler

ljackson@Lukes-MBP 10:52:16 /private/var/folders> sudo su -

Lukes-MBP:~ root# cd /private/var/folders/zz/zyxvpxvq6csfxvn_n0000000000000/C/com.apple.QuickLook.thumbnailcache
Lukes-MBP:com.apple.QuickLook.thumbnailcache root# ll
total 184
-rw-------  1 root  wheel     0B Mar  2  2016 exclusive
-rw-r--r--  1 root  wheel    56K Nov 13  2016 index.sqlite
-rw-r--r--  1 root  wheel    32K Nov 13  2016 index.sqlite-shm
-rw-r--r--  1 root  wheel     0B Nov 13  2016 index.sqlite-wal
-rw-------  1 root  wheel     0B Nov 13  2016 thumbnails.data
-rw-r--r--  1 root  wheel   350B Mar  2  2016 thumbnails.fraghandler
Lukes-MBP:com.apple.QuickLook.thumbnailcache root#
```

1. Clear all recent files in Preview
1. Close Preview Application
1. Execute commands below in Terminal (relative to your randomized location, see above for grep to find your location)

```
mv com.apple.QuickLook.thumbnailcache com.apple.QuickLook.thumbnailcache-DEL
killall Finder
killall Dock
```

## Sources

- http://az4n6.blogspot.com/2016/10/quicklook-thumbnailsdata-parser.html
- https://www.google.com/search?q=clear+QuickLook.thumbnailcache&oq=clear+QuickLook.thumbnailcache
- https://discussions.apple.com/thread/2502292
