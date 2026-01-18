# Vsftpd


## Polycom Phones

Now, we need to set up the repository on your boot server (I use my trixbox machine for this). First, as root, create the polycom user:

useradd polycom

Now, you need to set a password for the polycom user. Be aware that anyone will be able to see this password from any polycom phone (Menu/Status/Platform/Configuration)

passwd polycom yourpolycomuserpassword

Now, limit the polycom account so it cannot be used to login. Edit /etc/passwd, find the line for the polycom user just created (probably the last line), and change the portion of that line after the last colon (which should be something like "/bin/bash", which will be used as the login shell) to "/sbin/nologin"

Now, we need to set up the ftp server for the phones to get thier updated software and configuration. We will use vsftpd. We want the polycom user to only be able to see the files in its directory, and not be able to snoop around the trixbox. Go to /etc/vsftpd/vsftpd.conf and uncomment the line like:

chroot_list_enable=YES

You will also want the following two lines:
userlist_enable=YES
userlist_deny=NO

This will provide that only users listed in the userlist_file will be allowed to login via ftp. You don't want regular users using ftp because the password is sent in clear text over the network (regular users should use secure ftp via ssh)

Now, create a file /etc/vsftpd.chroot_list with the single line with the word "polycom". This will put the polycom user in a "chroot jail"

Now, create or edit /etc/vsftpd.user_list, and list any users that you want to be able to use the insecure ftp protocol. In our case, we just need a single line with the word "polycom", so the phone will be able to
access the files, but no other users will.

Make sure vsftpd is run automatically:
chkconfig vsftpd on

And restart it:
/etc/rc.d/init.d/vsftpd restart

Now, go to the /home/polycom directory and remove write permission for the polycom user, since we don't want the phones to be able to change their configuration files:
chmod u-w .

Now, create three directories for files uploaded from the phones:
mkdir contacts
mkdir log
mkdir overrides

Now, give the polycom user permission to put files into those directories:
chown polycom log
chgrp polycom log
chown polycom contacts
chgrp polycom contacts
chown polycom overrides
chgrp polycom overrides

