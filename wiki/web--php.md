# PHP


## Terminal Debug

### Check php.ini loaded location

```bash
php -i | grep 'Configuration File'

```
### Check php.ini loaded mysql config .sock etc.

```bash
php -i | grep 'mysql'
```

---

## Install



```
VERSION="5.3.10"
MVERSION="2.1.5"

echo "--> Installing PHP"
echo $VERSION

rm -rf php-$VERSION
tar xvzf php-$VERSION.tar.gz
tar zxvf mailparse-$MVERSION.tgz --directory=php-$VERSION/ext/
mv php-$VERSION/ext/mailparse-$MVERSION php-$VERSION/ext/mailparse

export PHP_AUTOCONF=/usr/bin/autoconf-2.13
export PHP_AUTOHEADER=/usr/bin/autoheader-2.13

cd php-$VERSION

rm configure
./buildconf --force
./configure --help | grep mail
./configure \
        --prefix=/usr/local/php5 \
        --build=i386-redhat-linux \
        --host=i386-redhat-linux \
        --target=i386-redhat-linux-gnu \
        --with-config-file-path=/www \
        --enable-force-cgi-redirect \
        --disable-safe-mode \
        --enable-versioning \
        --with-mysql=/usr/local \
        --with-dbase \
        --with-curl \
        --enable-ftp \
        --enable-sysvsem \
        --enable-sysvshm \
        --enable-shmop \
        --with-gd \
        --enable-gd-native-ttf \
        --with-ttf \
        --with-freetype-dir \
        --with-jpeg-dir=/usr/local \
        --with-zlib \
        --enable-libgcc \
        --enable-mbstring \
        --enable-mailparse \
        --enable-xslt \
        --with-xslt-sablot \
        --with-gettext \
        --with-zip \
        --with-bz2 \
        --with-iconv \
        --enable-exif \
        --enable-bcmath \
        --with-openssl \
        --enable-sockets \
        --with-xmlrpc \

make
make install
mkdir /www/cgi-bin/php
install /usr/local/php5/bin/php-cgi /www/cgi-bin/php/php5-cgi
```

1. Satisfy Dependencies 

```bash
yum install gcc gcc-c++ flex libxml2 libxml2-devel openssl openssl-devel bzip2 bzip2-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel

```
1. Security Exploits 

- http://www.linuxquestions.org/questions/linux-security-4/mystery-apache-log-entry-has-anyone-seen-this-one-947804/
- http://www.php.net/archive/2012.php#id2012-05-03-1

```
#PHP Remote Code Injection Fix
<IfModule mod_rewrite.c>
RewriteCond %{QUERY_STRING} ^[^=]*$
RewriteCond %{QUERY_STRING} %2d|\- [NC]
RewriteRule .? - [F,L]
</IfModule>
```


1. Common Errors 

1. If you do not have gcc installed 

```bash
configure: error: no acceptable cc found in $PATH

```
1. If you do not have gcc-c++ installed 

```bash
configure: error: installation or configuration problem: C++ compiler cannot create executables.

```
1. If you do not have flex installed 

```bash
configure: error: cannot find output from lex; giving up

```
1. If you do not have libxml2 libxml2-devel installed 

```bash
configure: error: xml2-config not found. Please check your libxml2 installation.

```
1. If you do not have bzip2 bzip2-devel installed 

```bash
configure: error: Please reinstall the BZip2 distribution

```
1. If you do not have openssl, openssl-devel installed 

```bash
configure: error: Cannot find OpenSSL's <evp.h>

```
1. If you do not have libjpeg, libjpeg-devel installed 

```bash
configure: error: libjpeg.(a|so) not found.

```
1. If you do not have libpng, libpng-devel installed 

```bash
configure: error: libpng.(a|so) not found.

```
1. If you do not have freetype, freetype-devel installed 

```bash
configure: error: freetype2 not found!

```
1. If you do not have mysql-client, mysql-devel, mysql-server, mysql-shared-compat installed 

```bash
configure: error: Cannot find MySQL header files under /usr/local.

```
1. Cannot find autoconf. Please check your autoconf installation and the $PHP_AUTOCONF environment variable. Then, rerun this script. 

This problem is caused by missing couple variables at the shell level: PHP_AUTOCONF, PHP_AUTOHEADER. It is very easy to solve this problem:

**Note**: Autoconf 2.13 may be required to build older versions of PHP

```bash
export PHP_AUTOCONF=/usr/bin/autoconf-2.13
export PHP_AUTOHEADER=/usr/bin/autoheader-2.13

```
1. TCPDF ERROR: [Image] Unable to get image: http://io85.com/images/logo/luteck_logo.jpg 

Apparently the "fopen"-wrappers are not used by TCPDF.

If you supply the URL of an image, TCPDF tries to download it with cURL into the "cache"-directory where your TCPDF-installation is stored (you have to check what the K_PATH_CACHE-constant contains to be sure).

So I guess you have to have write permissions in this directory that the magic works. Also you need cURL installed and compiled with php.

```bash
yum install curl curl-devel

```
Recompile PHP with

```bash
--with-curl

```
1. Premature end of script headers: php 

- Revert to php.ini-recommended
- Ensure files and directories are owned by apache and set to at least chmod 754 
- Recompile PHP if problem persists try older revision.
- Ensure you are installing the php-cgi executable and not the bash executable

```bash
install /usr/local/php5/php-cgi /www/cgi-bin/php/php5-cgi

```

1. Common Errors 

1. If you do not have gcc installed 

```bash
configure: error: no acceptable cc found in $PATH

```
1. If you do not have gcc-c++ installed 

```bash
configure: error: installation or configuration problem: C++ compiler cannot create executables.

```
1. If you do not have flex installed 

```bash
configure: error: cannot find output from lex; giving up

```
1. If you do not have libxml2 libxml2-devel installed 

```bash
configure: error: xml2-config not found. Please check your libxml2 installation.

```
1. If you do not have bzip2 bzip2-devel installed 

```bash
configure: error: Please reinstall the BZip2 distribution

```
1. If you do not have openssl, openssl-devel installed 

```bash
configure: error: Cannot find OpenSSL's <evp.h>

```
1. If you do not have libjpeg, libjpeg-devel installed 

```bash
configure: error: libjpeg.(a|so) not found.

```
1. If you do not have libpng, libpng-devel installed 

```bash
configure: error: libpng.(a|so) not found.

```
1. If you do not have freetype, freetype-devel installed 

```bash
configure: error: freetype2 not found!

```
1. If you do not have mysql-client, mysql-devel, mysql-server, mysql-shared-compat installed 

```bash
configure: error: Cannot find MySQL header files under /usr/local.

```
1. Cannot find autoconf. Please check your autoconf installation and the $PHP_AUTOCONF environment variable. Then, rerun this script. 

This problem is caused by missing couple variables at the shell level: PHP_AUTOCONF, PHP_AUTOHEADER. It is very easy to solve this problem:

**Note**: Autoconf 2.13 may be required to build older versions of PHP

```bash
export PHP_AUTOCONF=/usr/bin/autoconf-2.13
export PHP_AUTOHEADER=/usr/bin/autoheader-2.13

```
1. TCPDF ERROR: [Image] Unable to get image: http://io85.com/images/logo/luteck_logo.jpg 

Apparently the "fopen"-wrappers are not used by TCPDF.

If you supply the URL of an image, TCPDF tries to download it with cURL into the "cache"-directory where your TCPDF-installation is stored (you have to check what the K_PATH_CACHE-constant contains to be sure).

So I guess you have to have write permissions in this directory that the magic works. Also you need cURL installed and compiled with php.

```bash
yum install curl curl-devel

```
Recompile PHP with

```bash
--with-curl

```
1. Premature end of script headers: php 

- Revert to php.ini-recommended
- Ensure files and directories are owned by apache and set to at least chmod 754 
- Recompile PHP if problem persists try older revision.
- Ensure you are installing the php-cgi executable and not the bash executable

```bash
install /usr/local/php5/php-cgi /www/cgi-bin/php/php5-cgi

```
