# Bluetooth


## Mac OS X

### How to delete the blued.plist file

Launch Terminal (usually in the Applications/Utilities folder).

At the prompt, type

```bash
sudo killall blued

```
You will be prompted for your administrator's password; enter it and press return.

Type or paste

```bash
sudo rm -f /private/var/root/Library/Preferences/blued.plist

```
Then restart your Mac, then re-pair the device.

