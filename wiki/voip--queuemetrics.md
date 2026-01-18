# QueueMetrics


= Install =

```bash
wget -P /etc/yum.repos.d http://yum.loway.ch/loway.repo
yum install queuemetrics

```

If you are installing QM for the first time, run the following
commands to install the database:

cd /usr/local/queuemetrics/webapps/queuemetrics-1.3.4/WEB-INF/README
./installDb.sh

When you are done, point your browser to:
. http://thismachine:8080/queuemetrics
and login as user demoadmin / password demo.

If you are updating from a previous version, just point your
browser to:
. http://thismachine:8080/queuemetrics/dbtest
to check if your database link is working and update the
database to the latest version.
```

```
= Configure MySQL Storage =

You will have to change the configuration of the configuration.properties file to have it default to SQL rather than flat file.

```bash
vi /usr/local/queuemetrics/webapps/queuemetrics-1.3.4/WEB-INF/configuration.properties

```
Change the following line in your configuration.properties file:

```bash
# This is the default queue log file.
#default.queue_log_file=/var/log/asterisk/queue_log
default.queue_log_file=sql:P01

```
## Configure Statistics (Script)

Below is an part of the queueLoader.pl file:

```
! /usr/bin/perl

#
# Upload a given queue_log file to a partition of the queue_log table
# $Id: queueLoader.pl,v 1.10 2006/10/07 16:00:47 lenz Exp $
#
# usage:
# queueLoader.pl /my/queue_log/file partition_name /my/import/log
#
# to allow realtime upload of queue_log data, use:
#  queueLoader.pl /var/log/asterisk/queue_log P01 /var/log/qloader.log
#
#
# ATTENTION  ATTENTION  ATTENTION  ATTENTION  ATTENTION  ATTENTION
# If this file does not seem to work from the shell, do a
#        dos2unix queueLoader.pl
#        chmod +x queueLoader.pl
# to set things right.
# ATTENTION  ATTENTION  ATTENTION  ATTENTION  ATTENTION  ATTENTION
#

use strict;
use DBI;

my $mysql_host = "localhost";
my $mysql_db   = "queuemetrics";
my $mysql_user = "queuemetrics";
my $mysql_pass = "javadude";
my $logonfile  = "";
```

Execute the following line to import your statistics into MySQL. This line can also be ran as a crontab.

```bash
perl /usr/local/queuemetrics/webapps/queuemetrics-1.3.4/WEB-INF/mysql-utils/queueLoader.pl /var/log/asterisk/queue_log P01 >>/dev/null 2>>/dev/null

```
## Configure Statistics (Dameon)

### Create symlink to your version

Use the commands below to create a softlink to reference the qloader directory.

```bash
cd /usr/local/
ln -s queuemetrics/webapps/queuemetrics-1.3.4/WEB-INF/mysql-utils/qloader/ qloader

```
### Ready Configuration File

Below are the important settings you will need to change in the qloader.pl file to get qloader running:

```bash
vi /usr/local/qloader/qloader.pl

```
#! /usr/bin/perl

#
# Upload a given queue_log file to a partition of the queue_log table.
# $Id: qloader.pl,v 1.6 2007/04/01 16:49:02 lenz Exp $
#
# usage:
# queueLoader.pl /my/queue_log/file partition_name /my/activity/log
#
#
# ATTENTION  ATTENTION  ATTENTION  ATTENTION  ATTENTION  ATTENTION
# If this file does not seem to work from the shell, do a
#        dos2unix queueLoader.pl
# to set things right.
# ATTENTION  ATTENTION  ATTENTION  ATTENTION  ATTENTION  ATTENTION
#

use strict;
use DBI;

my $mysql_host = "localhost";
my $mysql_db   = "queuemetrics";
my $mysql_user = "queuemetrics";
my $mysql_pass = "javadude";

my $dbh    = undef;
my $dberr  = 1;       # setto a 0 quando tutto va bene

my $file        = $ARGV[0] || "/var/log/asterisk/queue_log";
my $partition   = $ARGV[1] || "P01";
my $importLog   = $ARGV[2] || "/var/log/asterisk/qloader.log";

my $pidfile   = "/var/run/qloader.pid";

my $log_every_num = 100;

my $timezone_offset  = 0 * 3600;  # in seconds
my $heartbeat_delay  = 15 * 60;   # in seconds
my $use_subqueue     = 1;         # 0 no; 1 yes
my $split_subq_name  = 1;         # turn a subqueue name from 'xxx/yyy" to "xxx"
my $rewriteToAgent   = 1;         # 0 no; 1 yes
my @channelsToAgent  = ( 'Local', 'SIP' );
```

```
### init.d script

Copy over the init.d script:

```bash
cp /usr/local/qloader/RedHat-style-initscripts/qloaderd /etc/init.d/

```
Update script settings:

```bash
vi /etc/init.d/qloaderd

```
#!/bin/bash
#
# Startup script for the QueueMetrics MySQL loader.
#
# chkconfig: 2345 85 15
# description: QueueMetrics MySQl Loader.
# processname: qloader
# pidfile: /var/run/qloader.pid
#

# $Id: qloaderd,v 1.2 2006/08/22 17:24:49 lenz Exp $

# Source function library.
. /etc/rc.d/init.d/functions


qloader=/usr/local/qloader/qloader.pl
partition=P01
queuelog=/var/log/asterisk/queue_log
logfile=/var/log/asterisk/qloader.log
prog=qloader
RETVAL=0
```

```
Convert and Set Executable:

```bash
dos2unix /usr/local/qloader/qloader.pl
chmod +x /usr/local/qloader/qloader.pl
dos2unix /etc/init.d/qloaderd
chmod +x /etc/init.d/qloaderd

```
### Patch the logroate file for qloader

```bash
vi /etc/logrotate.d/asterisk

```
    postrotate
        /usr/sbin/asterisk -rx 'logger reload' >/dev/null 2>/dev/null || true
        /etc/init.d/qloaderd restart > /dev/null 2> /dev/null || true
    endscript
```

```
### Enable qloaderd on boot

```bash
chkconfig qloaderd on

```
### Start daemon and Import Statistics

```bash
[root@localhost qloader]# /etc/init.d/qloaderd start
Starting qloader:

```
= FAQ =

## Errore JDBC:java.lang.ClassNotFoundException: com.mysql.jdbc.Driver

### RPM or Yum

If you installed via yum it is most likely that the symlink to the mysql java connect is broken and will need to be changed. You can find this link in the directory:

```bash
/usr/local/queuemetrics/webapps/queuemetrics-1.3.4/WEB-INF/lib

```
Broken Link

```bash
connector.jar -> /usr/share/java/mysql-connector-java-3.1.12-bin.jar

```
Issue the commands below to fix the symlink and then restart queuemetrics

```bash
cd /usr/local/queuemetrics/webapps/queuemetrics-1.3.4/WEB-INF/lib
unlink connector.jar
ln -s /usr/share/java/mysql-connector-java.jar connector.jar
/etc/init.d/queuemetrics restart

```
### Custom Install

If you have not installed via rpm your situation my differ from what is listed above. If so simply download the [MySQL Java Connector](http://www.mysql.com/products/connector-j/index.html) from the MySQL site.

Extract the MySQL Java Connector you have downloaded and locate a file named mysql-connector-java-X.X.X.jar. Move the file into /usr/share/java and follow the steps above to create a symlink to it. Once completed restart QueueMetrics.

= Sources =

- http://www.mysql.com/products/connector-j/index.html

