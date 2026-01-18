# Rsync


## Summary

rsync  is  a  program that behaves in much the same way that rcp does, but has many more options and uses the rsync remote-update protocol to greatly speed up file transfers when the destination file is being updated.

The rsync remote-update protocol allows rsync to transfer just the differences between two sets of files across the network connection, using an efficient checksum-search algorithm described in the technical report that accompanies this package.

Some of the additional features of rsync are:
- support for copying links, devices, owners, groups, and permissions
- exclude and exclude-from options similar to GNU tar
- a CVS exclude mode for ignoring the same files that CVS would ignore
- can use any transparent remote shell, including ssh or rsh
- does not require root privileges
- pipelining of file transfers to minimize latency costs
- support for anonymous or authenticated rsync servers (ideal for mirroring)

## Usage

The basic syntax for rsync is simple enough -- just run rsync [options] source destination to copy the file or files provided as the source argument to the destination.

So, for example, if you want to copy some files under your home directory to a USB storage device, you might use rsync -a /home/user/dir/ /media/disk/dir/. By the way, "/home/user/dir/" and "/home/usr/dir" are not the same thing to rsync. Without the final slash, rsync will copy the directory in its entirety. With the trailing slash, it will copy the contents of the directory but won't recreate the directory. If you're trying to replicate a directory structure with rsync, you should omit the trailing slash -- for instance, if you're mirroring /var/www on another machine or something like that.

In this example, I included the archive option (-a), which actually combines several rsync options. It combines the recursive and copy symlinks options, preserves group and owner, and generally makes rsync suitable for making archive copies. Note that it doesn't preserve hardlinks; if you want to preserve them, you will need to add the hardlinks option (-H).

Another option you'll probably want to use most of the time is verbose (-v), which tells rsync to report lots of information about what it's doing. You can double and triple up on this option -- so using -v will give you some information, using -vv will give more, and using -vvv will tell you everything that rsync is doing.

```bash
rsync [OPTION]... SRC [SRC]... [USER@]HOST:DEST

rsync [OPTION]... [USER@]HOST:SRC DEST

rsync [OPTION]... SRC [SRC]... DEST

rsync [OPTION]... [USER@]HOST::SRC [DEST]

rsync [OPTION]... SRC [SRC]... [USER@]HOST::DEST

rsync [OPTION]... rsync://[USER@]HOST[:PORT]/SRC [DEST]

rsync [OPTION]... SRC [SRC]... rsync://[USER@]HOST[:PORT]/DEST

```
## Options

Here  is  a  short summary of the options available in rsync. Please refer to the detailed description below for a complete description.

```
        -v, --verbose               increase verbosity
        -q, --quiet                 decrease verbosity
        -c, --checksum              always checksum
        -a, --archive               archive mode, equivalent to -rlptgoD
        -r, --recursive             recurse into directories
        -R, --relative              use relative path names
            --no-relative           turn off --relative
            --no-implied-dirs       don’t send implied dirs with -R
        -b, --backup                make backups (see --suffix & --backup-dir)
            --backup-dir            make backups into this directory
            --suffix=SUFFIX         backup suffix (default ~ w/o --backup-dir)
        -u, --update                update only (don’t overwrite newer files)
            --inplace               update the destination files inplace
        -K, --keep-dirlinks         treat symlinked dir on receiver as dir
        -l, --links                 copy symlinks as symlinks
        -L, --copy-links            copy the referent of all symlinks
            --copy-unsafe-links     copy the referent of "unsafe" symlinks
            --safe-links            ignore "unsafe" symlinks
        -H, --hard-links            preserve hard links
        -p, --perms                 preserve permissions
        -o, --owner                 preserve owner (root only)
        -g, --group                 preserve group
        -D, --devices               preserve devices (root only)
        -t, --times                 preserve times
        -S, --sparse                handle sparse files efficiently
        -n, --dry-run               show what would have been transferred
        -W, --whole-file            copy whole files, no incremental checks
            --no-whole-file         turn off --whole-file
        -x, --one-file-system       don’t cross filesystem boundaries
        -B, --block-size=SIZE       force a fixed checksum block-size
        -e, --rsh=COMMAND           specify the remote shell
            --rsync-path=PATH       specify path to rsync on the remote machine
            --existing              only update files that already exist
            --ignore-existing       ignore files that already exist on receiver
            --delete                delete files that don’t exist on sender
            --delete-excluded       also delete excluded files on receiver
            --delete-after          receiver deletes after transfer, not before
            --ignore-errors         delete even if there are I/O errors
            --max-delete=NUM        don’t delete more than NUM files
            --partial               keep partially transferred files
            --partial-dir=DIR       put a partially transferred file into DIR
            --force                 force deletion of dirs even if not empty
            --numeric-ids           don’t map uid/gid values by user/group name
            --timeout=TIME          set I/O timeout in seconds
        -I, --ignore-times          turn off mod time & file size quick check
            --size-only             ignore mod time for quick check (use size)
            --modify-window=NUM     compare mod times with reduced accuracy
        -T  --temp-dir=DIR          create temporary files in directory DIR
            --compare-dest=DIR      also compare received files relative to DIR
            --link-dest=DIR         create hardlinks to DIR for unchanged files
        -P                          equivalent to --partial --progress
        -z, --compress              compress file data
        -C, --cvs-exclude           auto ignore files in the same way CVS does
            --exclude=PATTERN       exclude files matching PATTERN
            --exclude-from=FILE     exclude patterns listed in FILE
            --include=PATTERN       don’t exclude files matching PATTERN
            --include-from=FILE     don’t exclude patterns listed in FILE
            --files-from=FILE       read FILE for list of source-file names
        -0  --from0                 all file lists are delimited by nulls
            --version               print version number
            --daemon                run as an rsync daemon
            --no-detach             do not detach from the parent
            --address=ADDRESS       bind to the specified address
            --config=FILE           specify alternate rsyncd.conf file
            --port=PORT             specify alternate rsyncd port number
            --blocking-io           use blocking I/O for the remote shell
            --no-blocking-io        turn off --blocking-io
            --stats                 give some file transfer stats
            --progress              show progress during transfer
            --log-format=FORMAT     log file transfers using specified format
            --password-file=FILE    get password from FILE
            --bwlimit=KBPS          limit I/O bandwidth, KBytes per second
            --write-batch=FILE      write a batch to FILE
            --read-batch=FILE       read a batch from FILE
            --checksum-seed=NUM     set block/file checksum seed
        -4  --ipv4                  prefer IPv4
        -6  --ipv6                  prefer IPv6
        -h, --help                  show this help screen
```

### Hidden Files

rsync will move hidden files (files whose names begin with a .) by default. If you want to exclude (ignore) hidden files, you can use this option:

```bash
--exclude=".*/"

```
You can also use the --exclude option to prevent copying things like Vim's swap files (.swp) and automatic backups (.bak) created by some programs.

## Examples

Echo all files from source location to target.

- Recursively sync files.
- Preserve Permissions.
- Preserve Owner.
- Preserve Group.
- Copy Whole File don't check for file updates.
- Delete all files that no longer exist on source.
- Ignore Existing files on target.
- Exclude specified folders.
- Exclude hidden files

```bash
rsync -vrpogW --ignore-existing --delete --exclude ".*" --exclude "System Volume Information" --exclude "RECYCLER" /SOURCE_MP3/ /TARGET_MP3

```
Making local copies

Suppose you have an external USB or FireWire drive, and you want to copy data from your home directory to your external drive. A good way to do this would be to keep all your important data under a single top-level directory and then copy it to a backup directory on the external drive using a command like:

```bash
rsync -avh /home/usr/dir/ /media/disk/backup/

```
If you want to make sure that local files you've deleted since the last time you ran rsync are deleted from the external system as well, you'll want to add the --deleted option, like so:

```bash
rsync -avh --delete /home/user/dir/ /media/disk/backup

```
Be very careful with the delete option; with it, you can whack a bunch of files without meaning to. In fact, while you're getting used to rsync, it's probably a good idea to use the --dry-run option with your commands to run through the transfer first, without actually copying or synching files. If you do start an rsync transfer and realize that you've botched the command in some way that might result in the destruction of data, press Ctrl-c immediately to terminate the transfer. Some files may be gone, but you may be able to save the rest.
Making remote copies

What if you want to copy files offsite to a remote host? No problem -- all you need to do is add the host and user information. So, for instance, if you want to copy the same directory to a remote host, you'd use:

```bash
rsync -avhe ssh --delete /home/user/dir/ user@remote.host.com:dir/

```
If you want to know how fast the transfer is going, and how much remains to be copied, add the --progress option:

```bash
rsync --progress -avhe ssh --delete /home/user/dir/ user@remote.host.com:dir/

```
If you don't want to be prompted for a password each time rsync makes a connection -- and you don't -- make sure that you have rsync set up to log in using an SSH key rather than a password. To do this, create an SSH key on the local machine using ssh-keygen -t dsa, and press Enter when prompted for a passphrase. After the key is created, use ssh-copy-id -i .ssh/id_dsa.pub user@remote.host.com to copy the public key to the remote host.

What if you need to bring back some of the files you copied using rsync? Use the following syntax:

```bash
rsync -avze ssh remote.host.com:/home/user/dir/ /local/path/

```
The z option compresses data during the transfer. If the file you are copying exists on the local host, then rsync will just leave it alone -- the same as if you were copying files to a remote host.
Wrapping it up with a script

Once you've figured out what directory or directories you want to sync up, and you've gotten the commands you need to sync everything, it's easy to wrap it all up with a simple script. Here's a short sample:

```bash
rsync --progress -avze ssh --delete /home/user/bin/ user@remote.host.com:bin/
rsync --progress -avze ssh --delete /home/user/local/data/ user@remote.host.com:local/data/
rsync --progress -avze ssh --delete /home/user/.tomboy/ user@remote.host.com:/.tomboy/

```
Use the --progress option if you're going to be running rsync interactively. If not, there's no need for it.

If you look at the rsync man page, you can easily be confused. However, after a little practice with rsync, you'll find that it's not hard to set up rsync jobs that will help you prepare for the day that your disk drive craps out and you need access to your data right away

### Batch Download

```bash
rsync --bwlimit=1024 --progress -vrae 'ssh' user@server.net:/local/path/20110112_01_x2564_order_documents_f3_V.tar.gz .

rsync --bwlimit=1024 --existing --progress -vrae 'ssh' user@server.net:/local/path/20110112_01_x2564_order_documents_f3_V.tar.gz .

```
### Local File Copy with Status and Speed

```bash
rsync --bwlimit=1024 --partial --progress -vra ~/Downloads/QuickP\ 1.0.97.rar .

rsync -vra io.com/ io.com.svn/io_wos_base/

```
### SKUs Sync

```bash
rsync --bwlimit=1024 --partial --progress -vvrae 'ssh -p 2222' na_io85_dump_20150505.sql.gz root@SERVER:/www/io85.com/dd/htdocs/skus/


```
### Escaping Spaces with (~) Tilda Support and Brace Expansion

Below is an example of how to work with spaces in directory structure:

```bash
scp user@server.ext:'/home/samba/Service\ Deliver/System\ Admin/file\ name.sxw' .

scp user@host:"'filename with spaces'" destination

rsync --bwlimit=2048 --partial --progress -vvrae 'ssh' user@server:~/"'files/Name - With A lot Of spaces'" .

rsync --bwlimit=2048 --partial --progress -vvrae 'ssh' user@server:~/"'files/Name - With A lot Of spaces'"\{5..6\}"'.More name with spaces'"* .

rsync --bwlimit=2048 --partial --progress -vvrae 'ssh' user@server:~/"'files/File.S03E'"\{0..1\}{0..9\}* .


```
