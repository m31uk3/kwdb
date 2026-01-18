# Apple TV


## H.264 .MKV

```bash
ffmpeg -y -i test.mkv -pass 1 -f mp4 -vcodec h264 -r 23.976 -sameq 10 -acodec aac -ab 128k -ar 44100 -ac 2 ~/Desktop/test.mp4

```
- http://forum.awkwardtv.org/viewtopic.php?f=11&t=129&start=10&st=0&sk=t&sd=a

## Patchstick Testing

```
        echo "Changing Patchstick-root to Apple TV Mode..."
        #diskutil unmountDisk $THEDISK
        START=$(gpt -r show $THEDISK | grep '1  GPT part' | awk '{print $1}')
        SIZE=$(gpt -r show $THEDISK | grep '1  GPT part' | awk '{print $2}')
        diskutil unmountDisk $THEDISK
        gpt remove -i 1 $THEDISK
        diskutil unmountDisk $THEDISK
        gpt add -b $START -s $SIZE -i 1 -t "5265636F-7665-11AA-AA11-00306543ECAC" $THEDISK
        diskutil unmountDisk $THEDISK
        echo
        echo "Your disk $THEDISK is now unmounted and ready to patch your AppleTV."
```


## Disable Update

If you don't disable the auto-update feature, within a few days your Apple TV will update itself and undo all your hard work!

On your Mac, go to the Terminal and, if not already, connect to your Apple TV:-

```bash
ssh -1 frontrow@AppleTV.local

```
Enter your password as "frontrow" if prompted. Then type:

```bash
sudo bash -c 'echo "127.0.0.1       mesu.apple.com" >> /etc/hosts'

```
## Testing smbfs.kext

The /System/Library/StartupItems directory is reserved for startup items that ship with Mac OS X. All other startup items should be placed in the /Library/StartupItems directory. Note that this directory does not exist by default and may need to be created during installation of the startup item.

It existed on my Apple TV so I just did the following:

```
sudo mkdir /Library/StartupItems/MountSystem
sudo touch /Library/StartupItems/MountSystem/MountSystem
sudo touch /Library/StartupItems/MountSystem/StartupParameters.plist
```

Add the following code to MountSystem executable:

```
#!/bin/sh

. /etc/rc.common

EN0=`ifconfig en0 | grep 'broadcast' | awk '{print $2}' | awk -F . '{print $3}'`
EN1=`ifconfig en1 | grep 'broadcast' | awk '{print $2}' | awk -F . '{print $3}'`

StartService() {
  if [ $EN0 = 85 ] || [ $EN1 = 85 ]; then
      #Load kernel extension and mount share
    /sbin/turbo_kext_enabler.bin
    kextload /System/Library/Extensions/smbfs.kext
    mount_smbfs "//<Username>:<Password>@<IP-Address>/<Share>" /Users/frontrow/Movies/<Share>
  else
    echo 'Not at home!'
  fi
}

StopService() {
    return 0;
}

RestartService() {
    return 0;
}

RunService "$1"
```

Add the following to StartupParameters.plist:

```
{
  Description = "Mount System";
  Provides = ("Network Shares");
  Uses = ("Network");
  Requires = ("Network");
  OrderPreference = "Late";
}
```

Set permissions:

```
sudo chowm -R root:wheel /Library/StartupItems/MountSystem
sudo chmod -R 755 /Library/StartupItems/MountSystem
sudo chmod 744 /Library/StartupItems/MountSystem/StartupParameters.plist
```

## Errors

### mount_smbfs: spnego blob2principal error 1

No idea...

## Sources

- http://docs.info.apple.com/article.html?artnum=305175

