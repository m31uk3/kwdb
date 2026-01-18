# Subversion


= Installation =

## Debian

### Apache

(The apache2+SSL part was taken from the article Debian, Apache2 and SSL by Ian Miller)

Debian Sarge comes with an apache2 package. I thought I'd give this a go to get it working with a self signed SSL certificate. However, I had little idea of what I was doing. Eventually I worked it out - and it's easy:

- Login or su as root
- Run:

```bash
apt-get install apache2

```
- Run the script apache2-ssl-certificate and tell it what it wants to know.

- Make a copy of '/etc/apache2/sites-available/default' - call it something like 'ssl'

- Make a sym-link to this new site configuration from /etc/apache2/sites-enabled/ You will see this is already done for 'default'.

- Add a

```bash
Listen 443

```
to /etc/apache2/ports.conf

- Edit /etc/apache2/sites-available/ssl (or whatever you called your new ssl site's config) and change port 80 in the name of the site to 443. Also change the virtual host setting. Add the lines "SSLEngine On", "SSLCertificateFile /etc/apache2/ssl/apache.pem" and "LoadModule ssl_module /usr/lib/apache2/modules/mod_ssl.so". My config file reads:

```
NameVirtualHost *:443

<VirtualHost *:443>
 LoadModule ssl_module /usr/lib/apache2/modules/mod_ssl.so
 SSLEngine On
 SSLCertificateFile /etc/apache2/ssl/apache.pem

 ...

</VirtualHost>
```

- Restart apache2

```bash
/etc/init.d/apache2 restart

```
- HTTPS should work.

Try: https://hostname/

### Subversion

```bash
apt-get install libapache2-svn subversion subversion-tools

```
- Create a repository.

```bash
cd /home
mkdir svn
chown www-data svn
su www-data -c "svnadmin create svn/src"

```
- If you let your users run as www-data they will be able to write to your repository!

- Become root again and add the following lines our apache configuration (ssl), inside of the VirtualHost declaration.

```
<Location /svn>
  DAV svn
  SVNParentPath /www/svn

  AuthType Basic
  AuthName "Spreadshirt Repository"
  AuthUserFile /www/svn/.htpasswd
  #Require valid-user

# Use instead of "Require valid-user" no password read-only access
<LimitExcept GET PROPFIND OPTIONS REPORT>
   Require valid-user
</LimitExcept>

</Location>
```

- Let's add some users.

```bash
su www-data -c "htpasswd2 -c -m /home/svn/.dav_svn.passwd galactus"

```
- Add another user (don't use -c or it will recreate the file)

```bash
su www-data -c "htpasswd2 -m /home/svn/.dav_svn.passwd ceruno"
su www-data -c "htpasswd2 -m /home/svn/.dav_svn.passwd n"

```
- Test the repository

1. Using your browser. Load https://hostname/svn/src/ in your browser. Replace hostname with your host name or ip. You will get something like:

Revision 0: /
Powered by Subversion version 1.1.3 (r12730).

1. From the command line:

```bash
svn --username n import checkers https://localhost/svn/src -m "initial import"

```
Authentication realm: <https://localhost:443> My Subversion Repository
Password for 'n':
Adding         checkers/trunk
Adding         checkers/trunk/gendelta.pl
Adding         checkers/site
Adding         checkers/branches
Adding         checkers/tags

Committed revision 1.
```

```
- Load from the browser again.

Revision 1: /
- branches/
- site/
- tags/
- trunk/

Powered by Subversion version 1.1.3 (r12730).

- And that's all so far.

= Quick Reference =

Creating a new repository:
```bash
 mkdir /path/to/new/dir
 svnadmin create /path/to/new/dir

```
Starting svnserve:
```bash
svnserve --daemon --root /path/to/new/repository

```
Importing project into svn repo:
```bash
 $ svn import -m "Wibble initial import" svn://olio/wibble/trunk

```
Creating directory in svn repo:
```bash
 $ svn mkdir -m "Create tags directory" svn://olio/wibble/tags

```
Branching:
```bash
 $ svn copy http://svn.example.com/repos/calc/trunk \
          http://svn.example.com/repos/calc/branches/my-calc-branch \
     -m "Creating a private branch of /calc/trunk."
 Committed revision 341.

```
Diff / Merge:
```bash
$ svn diff -rHEAD filename # changes in repository
$ svn diff -rPREV:BASE filename # most recent change
$ svn diff -r 343:344 http://svn.example.com/repos/calc/trunk
$ svn merge -r 343:344 http://svn.example.com/repos/calc/trunk
U  integer.c
$ svn status
M  integer.c

```
Rollback:
```bash
 $ svn merge -r 100:99 .
 $ svn commit -m "Rollback to revision 99"
 Committed revision 101.

```
Make a patch against the rails source:
```bash
 (in /vendor/rails/) $ svn diff > your_patch_name.diff

```
Edit a dir's ignores:
```bash
$ svn propedit svn:ignore your_dir_name
```
Set a dir's ignores:
```bash
$ svn propset svn:ignore "ignore1 ignore2" your_dir_name

```
Switch a working copy to another URL
```bash
$ svn switch --relocate http://server1:/svn/trunk/ http://server2/svn/trunk/ .

```
Add all unversioned files in your working copy
```bash
$ svn add --force .

```
See all local changes live in a terminal
```bash
$ watch 'svn st --ignore-externals|grep -v ^X'

```
Find all new files, or unversioned files
```bash
$ svn status | grep "^\?" | awk "{print \$2}"
svn stat | grep "^?" | awk '{print $2}' | xargs svn add

```
Find all changes, ignoring unversioned files
```bash
$ svn status -uv 2>/dev/null | egrep "^([^\? ]|       \*)"
(There are 7 spaces before the \*, which don't show up on some browsers)

```
Set up externals dependency
```bash
 $svn propset svn:externals "dataacccess svn://olio/dataaccess/trunk" maitai
$svn commit -m "Added dataaccess project as an external"

```
Log:
```bash
$ svn log -v filename
$ svn log -r6 filename
$ svn log --stop-on-copy

```
File statuses:
```bash
C  - Conflict
G  - Merged our changes with update (locally)
U  - Updated a file
UU - Update to file AND properties
M  - Modified
A  - Added
D  - Deleted

```
Resolve Conflicts:
```bash
$ cp Number.txt.mine Number.txt; svn resolved Number.txt
$ svn revert Number.txt

```
Additional Commands:
```bash
$ svn add --non-recursive directory_name
$ svn co -r7 url directory
$ svn propedit svn:ignore *.bak

```
## Sources

- [http://www.ianmiller.net/article.php?id=13 Debian, Apache2 and SSL by Ian Miller]
- [http://www.xhtml.net/articles/subversion-apache2-debian Debian, Subversion et Apache 2]
- [http://www.ilovett.com/node/98 Setting Up Subversion - blovetts personal notes]
- [http://www.cbcb.duke.edu/%7Efaheem/svn_tutorial/svn.en.html An Introductory Subversion Tutorial for Unix by Faheem Mitha]
- [http://svnbook.red-bean.com Version Control with Subversion - The subversion book]
- http://cheat.errtheblog.com/s/svn/

