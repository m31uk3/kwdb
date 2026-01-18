# Send Attachments From Terminal


## Using Mail and Uuencode

Install sharutils with yum.

```bash
uuencode secure.1 secure.1 | mail -s `uname -r` person@gmail.com

uuencode test.tar.gz space.txt.tar.gz | mail -s "`uname -a`" person@gmail.com

```
http://www.linuxquestions.org/questions/linux-software-2/sending-mail-with-some-attached-files-using-mail-command-448588/
ftp://mirrors.kernel.org/fedora/core/3/i386/os/Fedora/RPMS/sharutils-4.2.1-22.i386.rpm

