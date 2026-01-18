# Chmod


The **chmod** command (abbreviated from **ch**ange **mod**e) is a UNIX shell command in Unix and Unix-like environments.

When executed, the command can change file system modes of Computer file|files and directory (file systems)|directories. The modes include permissions and special modes.

## History
A <tt>chmod</tt> command first appeared in AT&T Unix version 1, and is still used today on Unix-like machines.

## Usage
The <tt>chmod</tt> command options are specified like this:

```bash
$ chmod [''options''] ''mode'' ''file1'' ...

```
To view what the permissions currently are, type:
 
```bash
$ ls -l

```
## Options
The <tt>chmod</tt> command has a number of command line options that affect its behavior.   The most common options are:
*<tt>-R</tt>: Changes the modes of directories and files recursion|recursively
<!-- <tt>-h</tt>: if the file specified is a soft link, change the mode of the link itself rather than the file that the link points to. -- this option is not supported by GNU chmod -->
*<tt>-v</tt>: Verbose mode; lists all files as they are being processed

## String modes
:*See also: File system permissions#Symbolic notation|Symbolic notation of file system permissions*

To the <tt>chmod</tt> utility, all permissions and special modes are represented by its mode parameter.  One way to adjust the mode of files or directories is to specify a symbolic mode.  The symbolic mode is composed of three components, which are combined to form a single string of text:

```bash
$ chmod [''references''][''operator''][''modes''] ''file1'' ...

```
The references (or classes) are used to distinguish the users to whom the permissions apply. If no references are specified it defaults to "all". They are represented by one or more of the following letters:
{|class="wikitable"
|-
! Reference !! Class  !! Description 
|-
|<tt>u</tt> || user   || the owner of the file
|-
|<tt>g</tt> || group  || users who are members of the file's group
|-
|<tt>o</tt> || others || users who are not the owner of the file or members of the group
|-
|<tt>a</tt> || all    || all three of the above, is the same as *ugo*
|}

The <tt>chmod</tt> program uses an operator to specify how the modes of a file should be adjusted.  The following operators are accepted: 
{|class="wikitable"
|-
! Operator !! Description
|-
|<tt>+</tt> ||adds the specified modes to the specified classes
|-
|<tt>-</tt> ||removes the specified modes from the specified classes
|-
|<tt>=</tt> ||the modes specified are to be made the exact modes for the specified classes
|}

The modes indicate which permissions are to be granted or taken away from the specified classes.  There are three basic modes which correspond to the basic permissions: 
{|class="wikitable"
|-
! Mode !! Name !! Description
|-
|<tt>r</tt> || read  ||**r**ead a file or list a directory's contents
|-
|<tt>w</tt> || write ||**w**rite to a file or directory
|-
|<tt>x</tt> || execute ||e**x**ecute a file or recurse a directory tree
|-
|<TT>X</TT> || special execute || which is not a permission in itself but rather can be used instead of x. It applies execute permissions to directories regardless of their current permissions and applies execute permissions to a file which already has at least 1 execute permission bit already set (either user, group or other). It is only really useful when used with '+' and usually in combination with the -R option for giving group or other access to a big directory tree without setting execute permission on normal files (such as text files), which would normally happen if you just used "chmod -R a+rx .", whereas with 'X' you can do "chmod -R a+rX ." instead
|-
|<tt>s</tt> || setuid/gid || details in #Special modes|Special modes section
|-
|<tt>t</tt> || sticky || details in #Special modes|Special modes section
|}

The combination of these three components produces a string that is understood by the <tt>chmod</tt> command.  Multiple changes can be specified by separating multiple symbolic modes with commas.

### String mode examples
For example, the following command would be used to add the read and write permissions to the user and group classes of a file or directory named <tt>sample</tt>:
 
```bash
$ '''chmod ug+rw sample'''
$ ls -ld sample
drw-rw----   2 unixguy  unixguy       96 Dec  8 12:53 sample

```
This command removes all permissions, and allows no one to read, write, or execute the file named <tt>sample</tt>.
 
```bash
$ '''chmod a-rwx sample'''
$ ls -l sample
----------   2 unixguy  unixguy       96 Dec  8 12:53 sample

```
The following command changes the permissions for the user and the group to read and execute only (no write permission) on <tt>sample</tt>  .

```bash
Sample file permissions before command
$ ls -ld sample
drw-rw----   2 unixguy  unixguy       96 Dec  8 12:53 sample
$ '''chmod ug=rx sample'''
$ ls -ld sample
dr-xr-x---   2 unixguy  unixguy       96 Dec  8 12:53 sample

```
## Octal numbers

The <tt>chmod</tt> command also accepts three- and four-digit octal numbers representing modes. See the article mentioned above for more. Using a four-digit octal number to set the modes of a file or directory named <tt>sample</tt> would look something like this:

```bash
chmod 0664 sample

```
Assuming that the <tt>setuid</tt>, <tt>setgid</tt> and <tt>sticky</tt> bits are not set, this is equivalent to:

```bash
chmod 664 sample

```
or

```bash
chmod +r,-x,ug+w sample

```
## Special modes

The <tt>chmod</tt> command is also capable of changing the additional permissions or special modes of a file or directory.  The symbolic modes use <tt>s</tt> to represent the *setuid* and *setgid* modes, and <tt>t</tt> to represent the *Sticky bit|sticky* mode.  The modes are only applied to the appropriate classes, regardless of whether or not other classes are specified.

Most operating systems support the specification of special modes using octal modes, but some do not.  On these systems, only the symbolic modes can be used.

## Examples

Read is added for all

```bash
chmod +r <file>

```
Execute permission is removed for all

```bash
chmod -x <file>

```
Read and write is set for the owner, all permissions are cleared for the group and others

```bash
chmod u=rw,go= <file>

```
Change the permissions of the file *file* to read and write for all.

```bash
chmod +rw <file>

```
Change the permissions of the directory *docs* and all its contents to add write access for the user, and deny write access for everybody else.

```bash
chmod -R u+w,go-w docs/

```
ADDS! read and write access for the owner, the group, and all others.

```bash
chmod 666 <file>

```
equivalent to u=rwx (4+2+1),go=rx (4+1 & 4+1). The 0 specifies *no special modes*.

```bash
chmod 0755 <file>

```
The 4 specifies *Setuid (set user ID)*.

```bash
chmod 4755 <file>

```
Sets a-x for all directories in tree starting from path/ (use '-type f' to match files only).

```bash
find path/ -type d  -exec chmod a-x {} \;

```
Allows directory browsing ls for example if you've reset permissions for Samba write access.

```bash
find path/ -type d  -exec chmod 777 {} \;

```
set a directory tree to rwx for owner directories, rw for owner files, --- for group and all.

```bash
chmod -R u+rwX,g-rwx,o-rwx <directory>

```
= Sources =

- http://en.wikipedia.org/wiki/Chmod

