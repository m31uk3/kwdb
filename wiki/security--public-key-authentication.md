# Public Key Authentication



OpenSSH is a FREE version of the SSH connectivity tools that technical users of the Internet rely on. For more information on OpenSSH check out their website [OpenSSH](http://www.openssh.com/)

## Introduction

Users of telnet, rlogin, and ftp may not realize that their password is transmitted across the Internet unencrypted, but it is. OpenSSH encrypts all traffic (including passwords) to effectively eliminate eavesdropping, connection hijacking, and other attacks. Additionally, OpenSSH provides secure tunneling capabilities and several authentication methods, and supports all SSH protocol versions.

Another great feature about OpenSSH is the Public Key Authentication mechanism. With this feature enabled you are able to securely authenticate to servers with out typing in a password.

## Requirements

This tutorial will assume that you meet the requirements listed below. I will use [Fedora Core 3](misc--fedora-core-3.md) in this tutorial so if you are using something different your file paths may differ.

### Linux

[Terminal](misc--terminal-linux.md)

### Mac OS X

[Terminal](misc--terminal-macos.md)

### Windows XP

[PuTTY](windows--terminal.md)

## Generate Key Pair (Linux/Mac OS X)

This can be accomplished on either a server or a client. If you do not have access to the server you will have to send your public key file to someone that does and have them import it for you.

Open a Terminal and ensure you are in your home directory.

To confirm this your prompt should look something like this **[user@computer.ext ~]#**.

If the **~/.ssh** directory does not exist create it using the commands below:

```bash
mkdir .ssh
cd .ssh

```
Locate the command ssh-keygen:

```
Usage: ssh-keygen [options]
Options:
  -b bits     Number of bits in the key to create.
  -c          Change comment in private and public key files.
  -e          Convert OpenSSH to IETF SECSH key file.
  -f filename Filename of the key file.
  -g          Use generic DNS resource record format.
  -i          Convert IETF SECSH to OpenSSH key file.
  -l          Show fingerprint of key file.
  -p          Change passphrase of private key file.
  -q          Quiet.
  -y          Read private key file and print public key.
  -t type     Specify type of key to create.
  -B          Show bubblebabble digest of key file.
  -C comment  Provide new comment.
  -N phrase   Provide new passphrase.
  -P phrase   Provide old passphrase.
  -r hostname Print DNS resource record.
  -G file     Generate candidates for DH-GEX moduli
  -T file     Screen candidates for DH-GEX moduli
```

In this tutorial I will use a key type of DSA you are welcome to explore the different types but for my needs DSA is more than capable.

Create your key pair by executing the following command:

**Old Encryption - Not Supported by Some Servers Anymore**

```bash
ssh-keygen -t dsa -b 1024 -f <filename>

```
**Preferred Encryption - Supported by Almost all Servers**

```bash
ssh-keygen -t rsa -b 2048 -f <filename>

```
You will be prompted to enter a passphrase **THIS IS IMPORTANT!!!**
If you forget your passphrase the key pair is lost forever please choose a passphrase you will not forget!

```
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in test.
Your public key has been saved in test.pub.
The key fingerprint is:
14:48:d2:cf:fd:b0:39:ff:39:64:78:f1:07:25:b0:d2 ljackson@Lukes-MBP.fritz.box
The key's randomart image is:
+--[ RSA 2048]----+
|    .o...   ..   |
|     .o  . . .. .|
|       o... E  o |
|       .o o.  o  |
|        S  = . + |
|          + o + o|
|           o +  .|
|            . .. |
|             .o. |
+-----------------+
```

You should now have 2 files in your **~/.ssh** directory:

- <filename> - Private Key
- <filename>.pub - Public Key

If you are on a client you can move the public key file into your user directory and when it is to be transfered to the server you will know where to find it.

Do so with the command below:

```bash
mv <filename>.pub ../

```
## Generate Key Pair (Windows)

It is also possible to do this on a Windows compatible OS using [PuTTYgen](http://www.putty.nl/download.html).

## Configure SSH Daemon (Linux/Mac OS X)

Open the file **/etc/ssh/sshd_config** and browse to the section displayed below:

```
# Authentication:

#LoginGraceTime 2m
#PermitRootLogin yes
#StrictModes yes
#MaxAuthTries 6

RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile      .ssh/authorized_keys
```

Ensure that the last 3 parameters are set like above and then save your changes.

You will have to restart the SSH daemon for your changes to take effect. You can do so with the command below:

```bash
/etc/init.d/sshd restart

```
If it completes successfully you should see something similar to the output below:

```bash
[root@server.ext ~]# /etc/init.d/sshd restart
Stopping sshd:                                             [  OK  ]
Starting sshd:                                             [  OK  ]

```
## Configure User (Linux/Mac OS X)

Since **root** is the most powerful user it will be used in this tutorial. if you wish to enable authentication for another user follow these steps and replace **root** with the desired **username**.

Return back to your home directory and check to see if you have a file named **authorized_keys** in sub-directory called **.ssh**.

If you don't no problem just create them like so:

```bash
mkdir .ssh
cd .ssh
touch authorized_keys

```
Now add the public key to the **authorized_keys** file. This may seem easy but it is the most common place for error. If you miss copy one character it will not authenticate you.

To prevent any errros cat the contents of your public key (**<filename>.pub**) to the **authorized_keys** file.

```bash
cat ../<filename>.pub > authorized_keys

```
Should you be in a situation where you have to copy and paste the key from one server to another insure that the key file looks identical to the original. This will save you many hours of troubleshooting as there is no log entry telling you the public key was copied incorrectly.

Ensure the ownership is set to root and the permissions are 644 with the commands below:

```bash
chown -R root:root ~/.ssh
chmod -R 644 ~/.ssh

```
## Configure Client (Linux/Mac OS X)

Open a Terminal and ensure you are in your home directory.

If the **~/.ssh** directory does not exist create it using the command below:

```bash
mkdir .ssh

```
If you created the key-pair on the server you can copy the private key to the client using the commands below:

```bash
cd ~/.ssh
scp root@server.ext:.ssh/<filename> identity

```
Otherwise you only have to copy your file to identity with the commands below:

```bash
cd ~/.ssh
cp <filename> identity

```
Ensure the ownership is set to root and the permissions are 644 with the commands below:

```bash
chown -R root:root ~/.ssh
chmod -R 644 ~/.ssh


```
Find the command **ssh-agent**:

```
Usage: ssh-agent [options] [command [args ...]]
Options:
  -c          Generate C-shell commands on stdout.
  -s          Generate Bourne shell commands on stdout.
  -k          Kill the current agent.
  -d          Debug mode.
  -a socket   Bind agent socket to given name.
  -t life     Default identity lifetime (seconds).
```

You will need to bind the ssh-agent to your current Terminal with the command below:

```bash
ssh-agent $SHELL

```
Next locate the command **ssh-add**:

```
Usage: ssh-add [options]
Options:
  -l          List fingerprints of all identities.
  -L          List public key parameters of all identities.
  -d          Delete identity.
  -D          Delete all identities.
  -x          Lock agent.
  -X          Unlock agent.
  -t life     Set lifetime (in seconds) when adding identities.
  -c          Require confirmation to sign using identities
```

By default ssh-add will look in the **identity** file for you private keys.

Add you private key to the agent with the command below:

```bash
ssh-add

```
You should be prompted for your passphrase similar to the output below:

```bash
[root@client.ext .ssh]# ssh-add 
Enter passphrase for /root/.ssh/identity: 
Identity added: /root/.ssh/identity (/root/.ssh/identity)

```
Now you are ready to connect to the remote server with your private key.

```bash
[root@client.ext .ssh]# ssh root@server.ext
Last login: Sun Oct  8 07:45:16 2006 from 127.0.0.1
[root@server.ext ~]#

```
## Configure Client (Mac OS X) (GUI)

Open a Terminal and ensure you are in your home directory.

If the **~/.ssh** directory does not exist create it using the command below:

```bash
mkdir .ssh

```
If you created the key-pair on the server you can copy the private key to the client using the commands below:

```bash
cd ~/.ssh
scp root@server.ext:.ssh/<filename> identity

```
Otherwise you only have to copy your file to identity with the commands below:

```bash
cd ~/.ssh
cp <filename> identity

```
Ensure the ownership is set to root and the permissions are 644 with the commands below:

```bash
chown -R root:root ~/.ssh
chmod -R 644 ~/.ssh

```

### Requirements

1. Mac OS X 10.4.X+
1. Built-in Terminal Application
1. SSH-Agent Client - [http://www.phil.uu.nl/~xges/ssh/ Download]

### Install SSH-Agent

Install the SSH-Agent you downloaded from the requirements section.

You will have to launch the application and configure some settings before it is ready for use. Click on **View** from the menu and select **Show SSH Identities**. Find your identity file and ensure **Default** is checked. Next select **SSH Agent** from the menu and choose **Preferences**. Ensure that **Activate Default Identities** is enabled when launched. Close SSH-Agent.

It may be useful to have on the dock, this way you can easily activate keys by simply clicking once and entering your passphrase. Launch SSH-Agent one last time and it should prompt you for your passphrase and activate your ID. 

Once this is completed you can close the identities window and test your connection with the open terminal window.

```bash
[root@client.ext .ssh]# ssh root@server.ext
Last login: Sun Oct  8 07:45:16 2006 from 127.0.0.1
[root@server.ext ~]#

```
## Configure Client (Windows) (GUI)

It is also possible to do this on a Windows compatible OS using [PuTTY and Pagent](http://www.putty.nl/download.html).

## See Also

- [Secure Copy (SCP)](security--scp.md) - An alternative to FTP and SFTP.

## External Links

- [http://www.putty.nl/download.html www.putty.nl] - Client (Windows) (GUI) & Generate Key Pair (Windows)
- [http://www.phil.uu.nl/~xges/ssh/ www.phil.uu.nl] - Client (Mac OS X) (GUI)

