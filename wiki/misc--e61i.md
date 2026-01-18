# E61i


### Import CA Certificate

There has been some discussion in various forums about how to install a SSL certificate to S60 3.0 device. I asked around and I'm planning on creating a short document around the subject. But first the quick way of sharing information - a blog! I hope this will provide some clarity to the subject.

An SSL certificate can be used for different purposes:

- Authenticating client to server (e.g. SSL/TLS client authentication)
- Authenticating server during SSL/TLS handshake

Using client certificates to authenticate a user
S60 only allows importing personal certificates and associated keys from .p12 files. The certificate must be a general X.509 certificate which is DER encoded. Private key and certificate file are to be packaged into a PKCS 12 package (.p12 format). The file can then be imported to the device, for example by using file transfer.

Using the certificate to authenticate a web server
The certificate must be a general X.509 certificate which is DER encoded. In order to be able to import certificate, it must be recognized as a CA certificate to make it work.

If certificate is not recognized as a CA certificate (meaning that key usage is not CertSigning and BasicConstrains doesn’t indicate that it is not a CA certificate), then you need to follow these steps

Using a web server:
1. Copy the certificate file to Web server
2. Set the MIME type for the directory where the certificate is as application/x-x509-ca-cert

In **/etc/mime.types** add the following line:

```bash
application/x-x509-ca-cert	der

```
(apachectl stop and start didn't work for me. I had to restart the server.)

```bash
apachectl restart


```
3. Use the web browser in the S60 device to browse the certificate
4. Import the certificate
5. **Power Cycle S60 Device**

### Sources
- http://symcaimport.redelijkheid.com/
- http://blogs.forum.nokia.com/index.php?op=ViewArticle&blogId=104645&articleId=412
- http://wiki.zimbra.com/index.php?title=Nokia_E61/E62_With_Self-Signed_SSL_Certificate
