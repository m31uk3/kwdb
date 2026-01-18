# Finder


### Show Hidden Files

**How to make OS X show hidden files using Terminal**

If you’re feeling particularly adventurous, you can use the Terminal command line interface to view hidden files and folders. Here’s how to do it:

Open Terminal from the Utilities folder in Applications, or by searching for it using Spotlight. You can also use the Go menu in the Finder to go directly to the Utilities folder.
Type, or copy and paste, this command: 

```bash
defaults write com.apple.Finder AppleShowAllFiles true

```
Press Return
Type: killall Finder

**How to hide any file or folder using Terminal**
Now that you know how to view hidden files and folders on your Mac, you may be wondering how you can hide other files or folders, to keep them away from prying eyes. There are a number of third-party applications and utilities that offer to do this for you, but you can do it yourself in Terminal, like this:

Launch Terminal.
Type: chflags hidden
Press the spacebar.
Drag the file or folder you want to hide from the Finder onto the Terminal window.
You’ll see the path to the file or folder displayed in Terminal after the command you typed.
Hit Return to execute the command.
The file or folder you dragged onto the Terminal window will now be hidden. To see it again, use one of the methods described above to see hidden files.

To make the file visible permanently again, use the steps above, but in step 2 type: chflags nohidden


**Tell if a folder/file is hidden in Mac OS X**

```

10
down vote
accepted
According to the ls man page, you should be able -O option combined with the -l option to view flags with ls. For example:

ls -Ol foo.txt
-rw-r--r-- 1 harry staff - 0 18 Aug 19:11 foo.txt
chflags hidden foo.txt
ls -Ol foo.txt
-rw-r--r-- 1 harry staff hidden 0 18 Aug 19:11 foo.txt
chflags nohidden foo.txt
ls -Ol foo.txt
-rw-r--r-- 1 harry staff - 0 18 Aug 19:11 foo.txt
Edit: Just to give a more specific solution to what the OP wanted (see comments below): To see if a folder is hidden or not, we can pass the -a option to ls to view the folder itself. We can then pipe the output into sed -n 2p (thanks Stack Overflow) to get the required line of that output. An example:

mkdir foo
chflags hidden foo
ls -aOl foo | sed -n 2p
drwxr-xr-x@ 2 harry staff hidden 68 18 Aug 19:11 .
Edit 2: For a command that should work regardless of whether it's a file or a folder, we need to do something slightly more hacky.

The needed line of output from ls -al varies depending on whether the thing is a file or folder, as folders show a total count, whereas files do not. To get around this, we can grep for the character r. This should be in ~all of all files/folders (nearly all should have at least one read permission), but not in the totals line.

As the line we want to get then becomes the first line, we can use head -n 1 to get the first line (alternative, if you prefer sed, sed -n 1p could be used).

So, for example with a directory:

mkdir foo
chflags hidden foo
ls -aOl foo | grep r | head -n 1
drwxr-xr-x@ 2 harry staff hidden 68 18 Aug 19:11 .
and with a file:

touch foo.txt
chflags hidden foo.txt
ls -aOl foo.txt | grep r | head -n 1
-rw-r--r-- 1 harry staff hidden 0 18 Aug 19:11 foo.txt
Edit 3: See Tyilo's answer below for a nicer way than grepping for r :)
```

### Sources

- https://unix.stackexchange.com/questions/18973/tell-if-a-folder-file-is-hidden-in-mac-os-x
- https://macpaw.com/how-to/show-hidden-files-on-mac
