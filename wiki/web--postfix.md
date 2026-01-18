# Postfix


## FAQ

### Deferred: Connection refused by [127.0.0.1]

Please uninstall sendmail and then restart Postfix.

/etc/mail/access

```
# Check the /usr/share/doc/sendmail/README.cf file for a description
# of the format of this file. (search for access_db in that file)
# The /usr/share/doc/sendmail/README.cf is part of the sendmail-doc
# package.
#
# by default we allow relaying from localhost...
localhost.localdomain           RELAY
localhost                       RELAY
127.0.0.1                       RELAY
mail.server.ext                 RELAY
```

### Comcast requires that all mail servers must have a PTR record with a valid Reverse DNS entry.

"Currently your mail server does not fill that requirement." - For more information, refer to: http://postmaster.comcast.net/smtp-error-codes.php#554

**[Solved] Changing Postfix Outbound IP Address**

Changing Postfix Outbound IP Address

When a server has more than one IP address assigned to it, Postfix randomly selects an IP address for outbound emails. This default Postfix behavior can result in emails being listed as spam due to the sending IP not matching the IP address to which the server hostname is resolving.

The solution is to bind Postfix to the server's primary IP, or the IP to which the server's hostname is resolving.

Using your favorite text editor, open the Postfix configuration file:
```bash
vim /etc/postfix/main.cf
```
Add the line:
```bash
smtp_bind_address = 192.168.0.1
```
Where 192.168.0.1 has to be replaced with the primary IP address of the server.

Then, restart Postfix:
```bash
/etc/init.d/postfix restart



```
### Command To Know

```bash
postfix flush

postmap <file>

mailq

cat /var/log/mail.log

/etc/init.d/postfix reload

```
### Empty Mail Queue

```bash
postsuper -d ALL
postsuper -d ALL deferred

```
### Postfix Script (PHP)

*Create script to parse incoming mail*

```
<?php
  $data = file_get_contents("php://stdin");
?>
```

*Add a new email address to Postfix configuration*

```bash
vi /etc/aliases

```
*Add the following line (everything on one line)*

```bash
email+to+redirect: "| php -q /home/user/full/path/to/your/new/script.php"

```
*Apply the changes to the aliases by running*

```bash
newaliases

```
*Reload Postfix and Restart*

```bash
/etc/init.d/postfix reload
/etc/init.d/postfix restart

```
### Sources

- http://jeroensmeets.net/setup-postfix-to-forward-incoming-email-to-php/
- https://www.cyberciti.biz/tips/howto-postfix-flush-mail-queue.html

