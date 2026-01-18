# Server Backup


= Mac OSX =

```bash
tar zcvf h9mj4guj.default.tar.gz /Users/ljackson/Library/Application\ Support/Firefox/Profiles/h9mj4guj.default/
tar zcvf 7xfyev89.default.tar.gz /Users/ljackson/Library/Thunderbird/Profiles/7xfyev89.default/

```
= Windows =

= Linux =

## Cron

Simply copy one of the scripts below into a file in the **/etc/cron.weekly** directory.

## Named (Bind), Apache, MySQL, Postfix, WWW Data

Below is a simple backup script which saves the configuration files for the following applications:

- Named (Bind)
- Apache
- MySQL
- Postfix

**Note:** It is assumed that the default install paths have been used and all web contend has a base of **/www**.

### Shell Script

```
#! /bin/sh

TODAY=`date +%m_%d_%Y`
SERVER=`hostname`

cd /home/juser/backups/

### Backup Apache Config ###
tar zcvf $SERVER.httpd.tar.gz /etc/httpd/ >>/dev/null

echo "Completed Apache Config Backup on $SERVER for $TODAY......"

#### Backup Named Config ####
tar zcvf $SERVER.named.tar.gz /var/named/ >>/dev/null

echo "Completed Named Config Backup on $SERVER for $TODAY......"

#### Backup Postfix Config ####
tar zcvf $SERVER.postfix.tar.gz /etc/postfix/ >>/dev/null

echo "Completed Postfix Config Backup on $SERVER for $TODAY......"

### Backup MySQL Server ###
mysqldump --user=mysqlbackup --password=backup --all-databases | gzip -c > $SERVER.sql.gz

echo "Completed MySQL Server Backup on $SERVER for $TODAY......"

### Backup Data ###
tar zcvf $SERVER.server.tar.gz /www/ >>/dev/null

echo "Completed Data Backup on $SERVER for $TODAY....."
```

## Asterisk, MySQL, FreePBX

Below is a simple backup script which saves the configuration files for the following applications:

- Asterisk
- MySQL
- FreePBX

**Note:** It is assumed that the default install paths have been used.

### Shell Script

```
! /bin/sh

TODAY=`date +%m_%d_%Y`
SERVER=asterisk.us.root.prv

mkdir /root/backups
cd /root/backups/

### Backup Asterisk Config  ###
tar zcvf $SERVER.config.tar.gz /etc/asterisk/ >>/dev/null

echo "Completed Asterisk Config Backup on $SERVER for $TODAY......"

#### Backup Sounds ####
tar zcvf $SERVER.sounds.tar.gz /var/lib/asterisk/ >>/dev/null

echo "Completed Sounds Backup on $SERVER for $TODAY......"

#### Backup Modules ####
tar zcvf $SERVER.modules.tar.gz /usr/lib/asterisk/ >>/dev/null

echo "Completed Modules Backup on $SERVER for $TODAY......"

### Backup MySQL Server ###
mysqldump --user=root --password=passw0rd --all-databases | gzip -c > $SERVER.sql.gz

echo "Completed MySQL Server Backup on $SERVER for $TODAY......"

### Backup Logs ###
tar zcvf $SERVER.logs.tar.gz /var/log/asterisk/ >>/dev/null

echo "Completed Logs Backup on $SERVER for $TODAY....."

## Backup Voicemail ##
tar zcvf $SERVER.voicemail.tar.gz /var/spool/asterisk/ >>/dev/null

echo "Completed Voicemail Backup on $SERVER for $TODAY....."

## Backup FreePBX ##
tar zcvf $SERVER.freepbx.tar.gz /usr/src/ >>/dev/null

echo "Completed FreePBX Backup on $SERVER for $TODAY....."

## Backup HTML ##
tar zcvf $SERVER.html.tar.gz /var/www/html/ >>/dev/null

echo "Completed HTML Backup on $SERVER for $TODAY....."
```

