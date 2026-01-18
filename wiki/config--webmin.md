# Webmin


= Install =

## Satisfy Dependencies

```bash
perl(Net::SSLeay) is needed by webmin-1.310-1.fc5.rf.noarch
perl(Mon::Client) is needed by webmin-1.310-1.fc5.rf.noarch
perl(Authen::PAM) is needed by webmin-1.310-1.fc5.rf.noarch

```
## Installing Perl Modules

```bash
perl -MCPAN -e shell

```
If this is the first time running MCPAN it will ask you a ton of questions so be ready to chose the onces that make the most sense for your particular location and configuration.

The setting below is important for Dual Processor (Dual Core) Systems:

```
Parameters for the 'make' command?
Typical frequently used setting:

    -j3              dual processor system

Your choice:  [] -j3
Parameters for the 'make install' command?
Typical frequently used setting:

    UNINST=1         to always uninstall potentially conflicting files

Your choice:  [-j3] 
```

Now you are ready to install the modules listed above.

```bash
cpan> install Net::SSLeay
cpan> install Mon::Client
cpan> install Authen::PAM

```
Once the installs complete simple type exit to leave perl.

```bash
cpan> exit

```
## Install Webmin

I had to force it to ignore the dependencies because I used perl to install them rather than rpm.

```bash
rpm -Uvh --nodeps webmin-1.310-1.fc5.rf.noarch.rpm

```
