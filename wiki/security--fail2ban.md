# Fail2ban


### Filter full text rows on space-padded single digit day-of-month (SDDOM) log files

Zero-padded for last 3 days, sort results by text and filter through more

```
awk '{$2 = sprintf("%02d", $2); print}' secure* | awk -F'[: ]' 'BEGIN{ mths="  JanFebMarAprMayJunJulAugSepOctNovDec"; tt=systime()-(60*60*24*10) } mktime(strftime("%Y")" "index(mths,$1)/3" "$2" "$3" "$4" "$5) >= tt {print $0}' | sort | more
```

### Filter and visualize 7 columns on space-padded single digit day-of-month (SDDOM) log files

Zero-padded for last 3 days, sort results by text and filter through more

```
awk '{$2 = sprintf("%02d", $2); print}' secure* | awk -F'[: ]' 'BEGIN{ mths="  JanFebMarAprMayJunJulAugSepOctNovDec"; tt=systime()-(60*60*24*3) } mktime(strftime("%Y")" "index(mths,$1)/3" "$2" "$3" "$4" "$5) >= tt {for (i=1; i<8; i++) printf $i"\t"; if (i = NF) print "Cols:"NF;}' | sort | more
```

### Extract Frequent Bans from Messages/Fail2ban.log

Extract frequent offender IP addresses 

```bash
cat /var/log/messages | grep Ban | cut -d']' -f 2- | cut -d' ' -f 3 | sort | uniq -c | sort -n | cut -c 9-

```
Logfile excerpt:

```
Sep 17 23:42:40 core fail2ban.actions: WARNING [sasl-iptables] Ban 212.70.149.20
Sep 17 23:43:38 core fail2ban.actions: WARNING [sasl-iptables] Ban 45.142.120.83
Sep 17 23:44:14 core fail2ban.actions: WARNING [sasl-iptables] Ban 212.70.149.83
Sep 17 23:45:40 core fail2ban.actions: WARNING [sasl-iptables] Ban 212.70.149.52
Sep 18 00:02:05 core fail2ban.actions: WARNING [ssh-iptables] Ban 64.235.45.41
Sep 18 00:22:15 core fail2ban.actions: WARNING [sasl-iptables] Ban 193.169.253.168
Sep 18 00:39:59 core fail2ban.actions: WARNING [sasl-iptables] Ban 78.128.113.120
Sep 18 00:55:38 core fail2ban.actions: WARNING [sasl-iptables] Ban 212.70.149.4
 
```

### Extract >6 count offender IP addresses and generate iptables rules to file
 
```bash
cat /var/log/messages* | grep Ban | cut -d']' -f 2- | cut -d' ' -f 3 | sort | uniq -c | sort -rn | awk -F' ' '{if($1>6)print$2}' | xargs -IX echo '-A INPUT -s X -j DROP -m comment --comment "Fail2ban PermaBan!!"' > ips.txt

```
Generate iptables rules (copy/paste IP addresses based on sorted list) [Mac OSX]

```bash
for i in `pbpaste`; do echo '-A INPUT -s '$i' -j DROP -m comment --comment "Fail2ban PermaBan!!"'; done

```
### Service Names and Port Numbers

Lookup via /etc/services
```bash
cat /etc/services | grep -E ' (25|465|110|995|143|993)\/'

```
Service Name Data Table
```
# service-name  port/protocol  [aliases ...]   [# comment]
smtp            25/tcp          mail
smtp            25/udp          mail
pop3            110/tcp         pop-3           # POP version 3
pop3            110/udp         pop-3
imap            143/tcp         imap2           # Interim Mail Access Proto v2
imap            143/udp         imap2
imaps           993/tcp                         # IMAP over SSL
imaps           993/udp                         # IMAP over SSL
pop3s           995/tcp                         # POP-3 over SSL
pop3s           995/udp                         # POP-3 over SSL
urd             465/tcp         smtps   # URL Rendesvous Directory for SSM / SMTP over SSL (TLS)
igmpv3lite      465/udp                 # IGMP over UDP for SSM
```
