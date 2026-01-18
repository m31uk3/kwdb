# OpenSSL


## Generate Self-Signed Certificate

Create a RSA private key for your CA (will be Triple-DES encrypted and PEM formatted)

```bash
openssl genrsa -des3 -out server.key 2048

```
You can see the details of this RSA private key via the command:

```bash
openssl rsa -noout -text -in ca.key

```
Create a Certificate Signing Request (CSR) with the server RSA private key (output will be PEM formatted):

```bash
openssl req -new -key server.key -out server.csr

```
You can see the details of this CSR via the command

```bash
openssl req -noout -text -in server.csr 

```
You can create a decrypted PEM version (not recommended) of this private key via:

```bash
openssl rsa -in ca.key -out ca.key.unsecure

```
If you want to run apache without a password rename it correctly:

```bash
mv server.unsecure server.key

```
Generate apache mod_ssl certificate:

```bash
openssl x509 -req -days 730 -in server.csr -signkey server.key -out server.crt

```
Verify contents of certificate:

```bash
openssl x509 -noout -text -in server.crt

```
## Example

```bash
mv ssl.key/server.key ssl.key/server.key.bk
openssl genrsa -des3 -out ssl.key/server.key 2048
openssl rsa -noout -text -in ssl.key/server.key
openssl rsa -in ssl.key/server.key -out ssl.key/server.key.unsecure
mv ssl.key/server.key ssl.key/server.key.bk
mv ssl.key/server.key.unsecure ssl.key/server.key
openssl req -new -key ssl.key/server.key -out ssl.csr/server.csr
openssl req -noout -text -in ssl.csr/server.csr
openssl x509 -req -days 730 -in ssl.csr/server.csr -signkey ssl.key/server.key -out ssl.crt/server.crt
openssl x509 -noout -text -in ssl.crt/server.crt

```
## Sources

- http://www.redhat.com/docs/manuals/linux/RHL-9-Manual/custom-guide/s1-secureserver-generatingkey.html
- http://www.fedoraforum.org/forum/archive/index.php/t-107046.html
- http://www.modssl.org/docs/2.8/ssl_faq.html#cert-ownca
- https://www.digicert.com/help/
- https://www.digicert.com/kb/csr-ssl-installation/apache-openssl.htm


