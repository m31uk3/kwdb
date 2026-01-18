# Bash


## Shells

What is a shell? The short answer is that it is a command interpreter. It is what allows you to interact with the system from the console. That is, it is what locates and starts programs for you. It also has builtin commands and is, infact, a complete programming language. Most of the init scripts on a Linux system are written in bash, peruse the files in /etc/rc.d/init.d in order to see examples of bash scripts.

Bash is not the only shell available, there are many others: sh, ash, tcsh, csh, pdksh, ksh, sash, zsh, etc... Bash happens to be the default shell in most Linux distributions. BTW, the name, 'Bash', stands for 'Bourne Again SHell' -- a pun on the original UNIX shell, sh, written by Steve Bourne. Bash is an improved reimplementation of sh, largely POSIX compliant.

## Paths and File Names

A path is composed of two types of parts, separators and elements. The separator on Unix(-like) systems is the forward slash, /, which suggests that the elements to the right are under those to the left. The elements are text strings that are the names of directories or files. File and directory names can be up to 256 characters long and contain just about any character, including control characters, spaces, and other special characters. While you can have special characters in your filename, I would dissuade you from doing so: if you need to separate name parts for readability, use an underscore instead... spaces and other special characters ( ?, *, or !, for instance ) will confuse bash commands and need to be escaped or quoted -- infact, stick to just letters, numbers, and the following three characters: '.', '_', & '-'. Also, there is no limit to the number of periods that you can put in a name -- you could name a file ..., for instance -- such can make file exchange with legacy operating systems difficult ( then again, they keep giving you files with spaces in the name, so it probably comes out even in the end... ).

If you want to check what file name and path length limits are on a system, look at the man page for getconf. This command can report what the limits are that are compiled into the OS.

File endings are not mandated by the OS. Unix-like operating systems figure out what a file is by looking at its content. Most files contain identifiers in their first few bytes. If that does not help, the shell looks further for clues like newlines and control characters. This is not to say that you don't see file endings on Unix, they can be a convenience to the user and some applications use them.

### Dots

You should know the meanings of these two things: '.' and '..'. The single dot by itself means 'this directory, here', e.g., and find . -type f -print would print all the regular files starting in the current directory. The double dot, '..', means 'this directory's parent directory', e.g., if you are in /home/rjh/, ls -l .. would list /home's contents.

### Tilde expansion

The tilde ( the final 'e' is NOT long! ), '~', with no username immediately after it expands to the current user's home directory ( what echo $USER returns ), e.g., if rjh types ls ~, rjh's home directory will be listed, no matter where rjh is in the file system. Also, constructions such as ls ~/subdirectory/ are possible. On a related note, remember that typing cd with no argument will return you to your home directory ( like typing cd ~ ).

If you give a path with a tilde followed by a username, the shell will try to expand that by substituting the path to that user's home directory. So, ls ~bob expands to ls /home/bob, assuming that bob is a valid user on the machine.

## Start Up

Short and to the point: when you start up bash as a login session ( from login or as bash -l from within another shell ), bash reads a series of startup files in order to configure its environment. The config files tell it how to colorize its output, where to look for executables, who its owner is, what its own name is, and other behaviors/data. These data are kept in the shell's environment variables.

The files read, in order, are:

1. /etc/profile,
1. ~/.bash_profile,
1. /etc/bashrc, and
1. ~/.bashrc.

The profile files are intended to store environment variables and the like. The bashrc files are intended to store aliases and bash functions.

Upon exit, ~/.bash_logout is executed in order to clean up after the shell.


### Profile

```bash
export HISTFILESIZE=50000
export HISTSIZE=50000
export HISTCONTROL=ignoredups

```
## Bash Scripting

Programs are written in programming languages that may be one of two fundamental types: compiled or interpreted. Compiled languages must be run through a compiler such as gcc or Borland. The compiler translates the source code, which is generated in a text editor, into machine code -- inscrutable strings of numbers -- which is the only thing that the computer understands. Interpreted languages are also written in a text editor, but nothing else needs to be done before they are runnable. A program called the interpreter reads the file when you run the script and translates the source code into machine code on the fly.

Interpreted languages run slower because of this. They have several advantages, however. The primary advantage is that there is no compile step. With large projects, that can save substantial amounts of time: just write your code and run it -- no waiting around for a possibly long compilation to complete. Further, most interpreted languages lend themselves to testing small fragments of code: write a few lines, run them, if they work, put them into the project... As such, they make ideal rapid prototyping languages, where the developer uses a slow-running, quick to write language to work out an idea, then translates it into a compilable language for performance.

Examples of compiled languages are C and C++. C is the language in which most of Unix and Linux are written. There are many scripting languages available with your distribution: perl, python, haskell, ruby, etc. Bash, pdksh, tcsh, and such are command interpreters. They are also programming languages. You can think of shell scripting as similar to DOS batch files, except written in an actual programming language...

Bash is the default shell on Linux. It is compatable with older Bourne shell scripts ( /bin/sh ). It is used widely for system administration. Usually, all the startup scripts are written in bash. With a text editor such as vim examine these files: /etc/rc.d/rc.sysinit and /etc/rc.d/rc. Also, take some time to root through the files in /etc/rc.d/init.d, reading anything you find interesting.

It is fruitless to try to teach a group of non-programmers how to write bash scripts in the course of one evening, so we will skip that. None the less, you need to be familiar with some basics of how scripting works because it is so essential to UNIX system administration.

### How to run a script

Bash scripts are plain text files. There are several ways to run a script:

1. chmod the script, adding execute to the permissions. You need to make sure that the first line of the file is a 'shebang' line. That is a line which tells the operating system which interpreter to give the script to in order to run it. Its format is either:
```bash
#!/usr/bin/bash
```
or
```bash
#!/usr/bin/env bash
```
2. Pass the script as a argument to the interpreter, e.g., at the command line type: bash scriptname
- A few things about the language itself:
- Comments are preceded by a hash, # . Everything to the right of the hash is disregarded by the interpreter. Comments are there in order to let the programmer know what he was thinking whenever he wrote the script.
- Variables are usually spelled with all capital letters, e.g., VAR . If you are assigning a value to one, you use just the variable name, e.g., VAR = somevalue ; if you are using the VAR's value, you precede it with a $ , e.g., echo $VAR .
- Any command on a line by itself does not need a terminator -- a character to tell the interpreter where the end of the line is. You can string several commands together on one line if you separate them with a semicolon ( which is the terminator ). It is usually poor form, however, to put more than one command on a line.
- How to find out more about bash:
there is a lot of information in the info page about bash. Type: info bash, in order to read the info page. The trouble about the info page, though, is that it was written by programmers for programmers... One book that I have is called 'Learning the Bash Shell', by Newham and Rosenblatt, published by O'Reilly ( http://www.oreilly.com ). This book is good for beginners, building up from a presumed minimal knowledge set to some fairly advanced programming.

## Execution

The shell locates and executes programs whose names you enter on the command line. It finds the programs by searching through a subset of the filesystem specified by the PATH environment variable. In order to see the contents of you PATH, type echo $PATH. Note that as root, you should never have a PATH that includes '.' -- there is the story of a bofh who was duped by some junior admins who needed access to some part of the machine (which he wouldn't grant them; they put a rootkit of some sort in a directory, named it 'ls' and then complained to the bofh that they were having problems with the directory; he changed to the directory, typed 'ls' in order to see what was there, and was promptly rooted...

## Aliases

Aliases are short text strings that the shell substitutes for patterns that it sees on the command line. There are a number of system aliases on most versions of Linux such as aliasing cp against cp -i ( the -i switch means 'interactive', i.e., ask before overwriting ( or removing, in the case of rm -i )). The builtin alias will list all aliases that apply to your current shell. In order to specify an new alias, type alias ll="ls -l" ( this is a common alias already on your machine ). ll is the alias, "ls -l" is the command it's aliased against. Note that it is double quote enclosed -- that is due to there being a space in the text string -- if there are no spaces, then the quotes are not needed. In order to make the alias permanent, place it in your ~/.bashrc script.

## History

Bash provides an execllent history mechanism to allow you to re-execute previous commands with minimal typing. Each command that you type is kept in ~/.bash_history in order ( take a look at it with less ). You can also view your history by typing history -- the history builtin numbers the commands for you. Typing history 10 will list the last ten entries in your history file. You can select a command and rerun it by typing !999, where '999' is the number of the command. That is called 'bang execution'. You can also type the bang and the first few letters of the command -- bash will search backward through your history file to find the firs match and will run that. The simplest thing is to just use the up/down arrow keys in order to scroll through your previous commands -- when you get to one that you like, hit either TAB in order to edit it or RETURN in order to rerun it. You can also use the builtin fc, 'fix command', in order to select a range ( or single ) command for re-execution. fc puts the commands into a text editor session ( vi by default ) so that you can edit ( fix ) them before running them. The commands are run when you exit the editor -- in order to not run them, delete them... The format for fc is fc 900 950 where '900' is the first command to run and '950' is the last.

## IO Streams & Redirection

The power of UNIX comes from its root philosophy, that of the toolbox approach. Software bloat comes from trying to write monolithic applications that aspire to be and do everything, emacs, for instance ;) The defining ideas of unix are that everything is a text stream and that programs should be small and do one thing well. Such small programs are called filters. Where the power comes in is in the ability to redirect the output of one filter to the input of another.

In order to do this, you should understand unix I/O. Input and Output are divided into three streams. A stream is a long series of characters, 8 bits per character on x86/Linux. Realize that the files on your computer are simply long, ordered sequences of characters terminated by NULL bytes ( abbreviated '\0' in C ). The three streams are:

- fd0 - standard input, abbreviated stdin,
- fd1 - standard output, stdout, and
- fd2 - standard error, stderr.

Standard input is normally attached to ( taken from ) the keyboard. It is designated 'file descriptor 0'. Standard output is normally attached to ( sends to ) the monitor ( terminal ). It is designated 'file descriptor 1'. Standard error is also usually attached to the terminal. It is designated 'file descriptor 2'.

When you type a command such as cat, if you pass it no file name, it takes stdin from the keyboard. Try this: type cat RET, then some text, followed by CTL-D. As you'll see, cat takes its input from the keyboard and spews it to the terminal. If you type cat some_file, you are redirecting cat's stdin from the file, some_file. You should recollect my showing you the < operator. It is a redirection operator. Think of it as pointing from the source to the destination and as being pronounced 'comes from'. The < is implied by the last command, i.e., you could have equally well typed cat < some_file. What happens if you type cat > some_file? Think of this operator as the 'goes into' sign. It redirects the stdout of cat into the file, some_file. If some_file does not exist, it gets created; if it does, it gets overwritten. In order to append to some_file, you must type cat >> some_file.

These three operators work for the terminal and for files. In order to redirect the stdout of a program ( think 'filter' ) to another program's stdin, you must use the pipe operator, |.

Try this: type ls. Then, ls | sort. You might be keen to guess what sort does, but look at its man page to see what all it does ( this applies to any command that you use ). Now try this: ls | sort -r | head -n 5. If that does not impress you, su - to root ( always use su -l ) and type: cat /var/log/messages | grep root. Can you account for all the root logins? ( actually, if you have been rooted, you probably will find nothing obvious like that... ). Finally, try some things such as: cat /var/log/messages | grep $USER > $USER.log. Or, track down sound problems with: cat /var/log/messages | grep sound | unique > sound.msg... Experiment.

A final note. You can use the file descriptors in order to redirect I/O. E.g., type find /var. That will give you a list of as many files as you can access ( do this as a regular user ). Suppose that you do not want to see the error messages. Type find /var 2> /dev/null > files_i_can_read. The descriptor '1' is presumed before the last goesinto. /dev/null is the bit bucket. Don't forget to empty it when you are done. Once you get the hang of redirection and learn some useful filters, you will be amazed at what you can do and will begin to wonder why anyone would want to use a graphical interface...

## Control Characters

There are a number of control characters that you should be familiar with: ^z, ^c, and ^d ( the carat ( ^ ) is a common symbol for the control key ). The ^z sequence sends a suspend signal to the terminal's controlling process. The ^c sequence sends an interrupt to the process, and ^d is the End of File ( EOF ) character that is used to terminate text strings and files ( which are really long text strings in UNIX, remember... ).

## Environment Variables

The shell maintains a set of variables that it and programs running under it can use to get information. The information represents the program's environment. The variables determine things such as the owner's user id ( UID ), name ( USER ), group id ( GID ), home directory ( HOME ), most recent command ( _ ), present working directory ( PWD ), etc. etc. Some programs might need special environment variables set, for example, in order for them to know where they are installed in the filesystem. E.g., some systems need MOZILLA_HOME set. If you use Java, you probably had to set JAVA_HOME to point to the directory where Java was installed or CLASSPATH to tell it where to find Java executables.

Environment variables can be used to affect the behavior of a program be specifying a default set of arguments that you will not need to type at the command line. Bash uses them to determine things such as the number of columns to print on screen and what to display in the prompt. The most important variable, is the PATH. It is a colon-separated list of filesystem paths that the shell uses to determine where to look for execuatables given at the command line. If the command is not in the PATH, you need to specify the path absolutely. Try typing $ dhcpcd as a regular user. Bash will complain 'command not found'. Then type whereis dhcpcd. Notice that the path, /sbin is not in your PATH ( you can see the value of an environment variable by typing echo $VAR, where VAR is the variable you want to examine ).

You can set a variable at the command line by typing VAR=value, where VAR is the name of the variable ( conventionally capitalized ) and value is whatever you need it to be -- note that if there are spaces in the value you will need to double-quote it. Try this: type CD=/mnt/cdrom. Now, type mount $CD. Your cdrom should mount if there is anything in it, or else produce an error message about no medium being found. Notice the $ before the variable, it is necessary whenever you use the variable, e.g., echo $CD, but not when you set it... Now, type bash then try using $CD to mount or umount the drive. It should fail. When you typed bash, you started another instance of the shell under the original one. It inherited an environment exported from its parent shell. Any variables that were not exported were not inherited. Now, type exit ( or CTL-d ) then export CD, then again bash. Try using $CD to mount the disc now. It should work. export with no arguments will return a list of exported variables. env will show all variables. It can also be used to run a command in an altered environment ( see the man page... ).

## Job Control

Job control provides a way for a user to stop, resume, or modify the priority of execution of running programs or to run more than one program from the same console. A 'job' in this context is an instance of a program in memory and running.

A process can run in either the foreground or the background. A process that is running in the foreground is associated with the controlling terminal ( tty or pty ) and can receive keyboard events from the terminal. A background process is divorced from the terminal from which it was started and cannot receive terminal input.

A process can be referred to in several ways. The Process ID number ( PID ) is one way. The job number is another. If you are referring to a process by job, you need to precede it by a % sign. In order to see what jobs are running on your terminal and the associated job numbers, type jobs. If you are logged into more than one terminal, type ps -ja ( the -j causes ps to use jobs' format ).

In order to move a running job to the background, you need to suspend it. You do that by typing CTL-z . The job is then suspended and bash reports its job number on the command line. Type bg in order to resume the current ( suspended ) job in the background. You can specify a job, if you have more than one going, by using bg %job_no. You can resume a job in the foreground by typing %job_no or fg %job_no ( fg by itself resumes the current job ).

We have covered kill elsewhere. Know that you can kill a process by its job number.

Although it is not a shell builtin and is not technically 'job control', we will cover nice here. When a job is running, the kernel assigns time slices to it and other running processes in a 'fair' manner based on scheduling priority ( the kernel's scheduler is what determines who gets to run in what order and for how long ). If you want to change the 'weighting' that your program gets when the kernel allots slices, you can start it by typing nice -n command. The default nice level is 0. The highest priority is -19 and the lowest, 20. The higher the number, the 'nicer' the program is to others. The -n x is an optional specifier for the adjustment to the priority, where x is some number -- the default is +10 if not specified. You can use renice in order to change the priority of an already running process by typing renice priority PID. Only root can increase the priority of a process ( less nice ) and you can only renice processes that you own.

## Globbing

Globbing is the name for the shell's filename expansion capabilities. When the shell parses a command line, it looks in each token ( word, if you like ) for the special characters:

- ? - One of any character
- * - Zero or more of any character
- [ - Introduces a character class

If it finds any of these, it replaces token with a list of all filenames that match the pattern that the token represents. The ? character is a wild card that stands for 'one of any character' -- except the dot ( . ). It must match one character: 'abc?' does not match 'abc', but does match 'abcd'. The * character matches zero or more of any character. The pattern 'abc*' matches 'abc' as well as 'abcd' and 'abcdefgh...'. The [ character introduces a character class, a list of single characters that can be matched. The pattern 'abc[de]' matches 'abcd' and 'abce' but not 'abc' nor 'abcg'. If no match is found, the meta characters can be taken as literally what the are. If you do not want a meta character expanded, you need to escape it with a backslash, e.g., a file named 'abc*' would have to be typed 'abc\*' to avoid expansion. The best way to avoid problems, though, is to avoid special characters -- don't use anything in a filename that you have to escape.

## Brace Expansion

On a similar subject, the shell also does brace expansion ( which is not globbing -- globbing is done to names from the filesystem ). If it sees a { character in a token, it checks to see if there is a pair of braces containing a properly formatted list of text strings ( at least one comma and no spaces ) then generates a list of tokens from the expansions. Note well that it does not do filename matching in order to determine whether to generate the token. Given the command
```bash
chown 701 public_html/chap{0{8,9},1{0,1,2}}
```
the last token will be expanded to the list: chap08, chap09, chap10, chap11, and chap12 ( the command will attempt to operate on the all the paths, possibly failing on any path that does not exist ). Note that you can nest braces.

### Create Files From Words

```bash
touch fns.crud.{delete,update,insert,read}.{show,do}.php


```
### More Examples

```bash
for i in {1..99}; do echo 00{0..9} 0{10..99}; printf '|\n'; done

for i in {1..99}; do printf "%.3d " {8..10} ; printf '|\n'; done

for i in {1..99}; do echo {a..z}; printf '|\n'; done

for i in {1..99}; do echo {a..z}; echo -e '|'; done

```
### String Operations

<TABLE
BORDER="1"
CLASS="CALSTABLE"
><TR
><TH
ALIGN="LEFT"
VALIGN="TOP"
>Expression</TH
><TH
ALIGN="LEFT"
VALIGN="TOP"
>Meaning</TH
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${#string}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Length of <TT
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
>&nbsp;</TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>&nbsp;</TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${string:position}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Extract substring from <TT
CLASS="PARAMETER"
><I
>$string</I
></TT
>
```bash
	at <TT
```
CLASS="PARAMETER"
><I
>$position</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${string:position:length}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Extract <TT
CLASS="PARAMETER"
><I
>$length</I
></TT
>
```bash
	characters substring from <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
>
```bash
	at <TT
```
CLASS="PARAMETER"
><I
>$position</I
></TT
> [zero-indexed,
```bash
	first character is at position 0]</TD
```
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
>&nbsp;</TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>&nbsp;</TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${string#substring}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Strip shortest match of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$substring</I
></TT
> from front of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${string##substring}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Strip longest match of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$substring</I
></TT
> from front of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${string%substring}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Strip shortest match of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$substring</I
></TT
> from back of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${string%%substring}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Strip longest match of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$substring</I
></TT
> from back of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
>&nbsp;</TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>&nbsp;</TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${string/substring/replacement}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Replace first match of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$substring</I
></TT
> with
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$replacement</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${string//substring/replacement}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Replace <EM
>all</EM
> matches of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$substring</I
></TT
> with
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$replacement</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${string/#substring/replacement}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>If <TT
CLASS="PARAMETER"
><I
>$substring</I
></TT
>
```bash
      matches <EM
```
>front</EM
> end of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
>, substitute
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$replacement</I
></TT
> for
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$substring</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>${string/%substring/replacement}</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>If <TT
CLASS="PARAMETER"
><I
>$substring</I
></TT
>
```bash
      matches <EM
```
>back</EM
> end of
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
>, substitute
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$replacement</I
></TT
> for
```bash
      <TT
```
CLASS="PARAMETER"
><I
>$substring</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
>&nbsp;</TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>&nbsp;</TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
>&nbsp;</TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>&nbsp;</TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>expr match "$string" '$substring'</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Length of matching <TT
CLASS="PARAMETER"
><I
>$substring</I
></TT
>*
```bash
        at beginning of <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>expr "$string" : '$substring'</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Length of matching <TT
CLASS="PARAMETER"
><I
>$substring</I
></TT
>*
```bash
        at beginning of <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>expr index "$string" $substring</TT
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Numerical position in <TT
CLASS="PARAMETER"
><I
>$string</I
></TT
>
```bash
	of first character in <TT
```
CLASS="PARAMETER"
><I
>$substring</I
></TT
>*
```bash
	that matches [0 if no match, first character counts as
	position 1]</TD
```
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>expr substr $string $position
```bash
        $length</TT
```
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Extract <TT
CLASS="PARAMETER"
><I
>$length</I
></TT
> characters
```bash
        from <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
> starting at
```bash
        <TT
```
CLASS="PARAMETER"
><I
>$position</I
></TT
> [0 if no match, first
```bash
	character counts as position 1]</TD
```
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>expr match "$string"
```bash
        '\($substring\)'</TT
```
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Extract <TT
CLASS="PARAMETER"
><I
>$substring</I
></TT
>*, searching
```bash
        from beginning of <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>expr "$string" :
```bash
        '\($substring\)'</TT
```
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Extract <TT
CLASS="PARAMETER"
><I
>$substring</I
></TT
>* , searching
```bash
        from beginning of <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>expr match "$string"
```bash
        '.*\($substring\)'</TT
```
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Extract <TT
CLASS="PARAMETER"
><I
>$substring</I
></TT
>*, searching
```bash
        from end of <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
><TR
><TD
ALIGN="LEFT"
VALIGN="TOP"
><TT
CLASS="OPTION"
>expr "$string" :
```bash
        '.*\($substring\)'</TT
```
></TD
><TD
ALIGN="LEFT"
VALIGN="TOP"
>Extract <TT
CLASS="PARAMETER"
><I
>$substring</I
></TT
>*, searching
```bash
        from end of <TT
```
CLASS="PARAMETER"
><I
>$string</I
></TT
></TD
></TR
></TABLE>

**Source:**

- http://tldp.org/LDP/abs/html/refcards.html#AEN22664
- http://wiki.bash-hackers.org/syntax/expansion/brace

= Exploits =

## Shellshock - Sep. 2014

### Scan for Apache Intrusions

```bash
grep -H "() {" /var/log/httpd/*_log

```
### Manual Patch - Fedora Core 15

Check for Vulnerability

**Safe**

```bash
env x='() { :;}; echo Server is vulnerable' bash -c "echo"

bash: warning: x: ignoring function definition attempt
bash: error importing function definition for `x'

```
**Vulnerable**

```bash
env x='() { :;}; echo Server is vulnerable' bash.old -c "echo"

Server is vulnerable

```
Check CPU Type

```bash
lscpu

```
Architecture:          i686
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                1
On-line CPU(s) list:   0
Thread(s) per core:    1
Core(s) per socket:    1
CPU socket(s):         1
Vendor ID:             AuthenticAMD
CPU family:            15
Model:                 44
Stepping:              2
CPU MHz:               1808.328
BogoMIPS:              3616.65
L1d cache:             64K
L1i cache:             64K
L2 cache:              128K
```

```
Check Kernel Type

```bash
uname -m
i686

```
Check LONG_BIT

```bash
getconf LONG_BIT
32

```
Locate Bash
 
```bash
which bash
/bin/bash

```
Backup Bash

```bash
cp /bin/bash /bin/bash.old

```
Determine Bash Version

```bash
bash --version
GNU bash, version 4.2.49(1)-release (i686-pc-linux-gnu)

```
Setup Patch Working Directory

```bash
mkdir /usr/local/src/bashfix
cd /usr/local/src/bashfix

```
Install Build Tools

```bash
sudo yum install patch ybacc bison autoconf

```
Download Bash

```bash
wget https://ftp.gnu.org/pub/gnu/bash/bash-4.2.tar.gz
tar zxvf bash-4.2.tar.gz
cd bash-4.0

```
Download and Apply Patches

**bash-multipatch.sh Script**

```
#!/bin/sh
 
# A quick script file for downloading an applying multiple patches when manually compiling GNU bash on Linux
# Written (mostly) by Steve Cook with (a little) help from Steve Jenkins
# This really seems like a lame way to have to do this, but it works. :) Use at your own risk.
 
# You can edit these variables
 
version="4.2"
nodotversion="42"
lastpatch="49"
 
# You probably don't want to edit anything below this line
 
for i in `seq 1 $lastpatch`;
do
number=$(printf %02d $i)
file="https://ftp.gnu.org/pub/gnu/bash/bash-${version}-patches/bash${nodotversion}-0$number"
echo $file
curl $file | patch -p0
done
```

Run Script

```bash
chmod 755 bash-multipatch.sh
./bash-multipatch.sh

```
Change Permissions

```bash
chown -R user:user bashfix/

```
Change to Normal User

```bash
su user

```
Run Configure

```bash
./configure

```
Run Make

```bash
make

```
Run Make Tests

```bash
make test

```
Check for New Bash Binary

```bash
ls -la bash
-rwxrwxr-x 1 user user 2362608 27. Sep 16:01 bash

```
Replace Bash Binary

```bash
sudo cp -f bash /bin/bash

```
Reset Bash

```bash
/bin/bash

```
Retest

```bash
env x='() { :;}; echo Server is vulnerable' bash -c "echo"

bash: warning: x: ignoring function definition attempt
bash: error importing function definition for `x'

```
Reboot Server

```bash
reboot

```
= See Also =

- [Bash Scripts](shell--bash.md#scripts) - Example Scripts

= Sources =

- Wayne M Albert
- http://stevejenkins.com/blog/2014/09/how-to-manually-update-bash-to-patch-shellshock-bug-on-older-fedora-based-systems/


---

## Scripts



```
alpha=( aa bb cc dd ee ff gg hh ii jj kk ll mm nn oo pp qq rr ss tt uu vv ww xx yy zz )

alpha_count=${#alpha[*]}

x=0

while [ "$x" -lt "$alpha_count" ]
do    # List all the elements in the array.
  wget -O ${alpha[$x]}.wav http://german.about.com/library/media/sound/${alpha[$x]}.wav
  sleep 1
  let "x = $x + 1"
done
```

1. Bash Infinite Loop 

```bash
while true; do echo Total Files: `ll | wc -l`; sleep 1; done

```
1. Conditional Device Check & Image Upload (Mac OS X) 

```
#!/bin/bash

CAMSTAT=`/usr/sbin/system_profiler SPUSBDataType | awk '{$1=$1;print}' | grep WebCam | cut -c 1-6`

if [ "$CAMSTAT" = "WebCam" ]; then

 # Create History Image
 echo Make History
 scp -P 2222 ~/m31uk3.jpg me@server.com:/www/server.com/htdocs/webcam/history/m31uk3_`date +%s`.jpg

 # Update Webcam
 echo Take a Picture
 scp -P 2222 ~/m31uk3.jpg me@server.com:/www/server.com/htdocs/webcam/

else
 echo No Cam Connected!
fi
```

1. Compress files into multiple archives limited by resulting archive file size 

```
#!/bin/bash

if [ $# != 3 ] ; then
    echo -e "$0 in out max\n"
    echo -e "\tin:  input directory"
    echo -e "\tout: output directory"
    echo -e "\tmax: split size threshold in bytes"
    exit
fi

IN=$1 OUT=$2 MAX=$3 SEQ=0 TOT=0
find $IN -type f |
while read i ; do du -s "$i" ; done |
sort -n |
while read SIZE NAME ; do
    if [ $TOT != 0 ] && [ $((TOT+SIZE)) -gt $MAX ] ; then
        SEQ=$((SEQ+1)) TOT=0
    fi
    TOT=$((TOT+SIZE))
    TAR=$OUT/$(printf '%08d' $SEQ).tar
    tar vrf $TAR "$NAME"
done

for i in *.tar; do gzip $i; done
```

1. Move Files Based On Date Name 

```
for ARG in $*
do
  PICPATH=`echo $ARG | cut -d_ -f 2 | cut -d. -f 1 | utimecam`
#  echo $PICPATH
  mv -v $ARG $PICPATH/$ARG
#  sleep 1
done
```

1. Replace Multiple Strings, Words, Regular Expressions in Multiple Files from Terminal 

```
find . -name '*.svg' | xargs -IX grep -E '12:(04|05|08|11|16|21|22|33|35|36|46) am 01.20.09' X | sort | wc -l
for i in `find . -name '*.svg' | xargs -IX grep -lE '12:(04|05|08|11|16|21|22|33|35|36|46) am 01.20.09' X` ; do
 amcount=${#i}
 extension="${i##*.}"
 newname="${i%?.*}"
 cat "$i" | sed -e 's/12:04 am 01.20.09/12:04 pm 01.20.09/' -e 's/12:05 am 01.20.09/12:05 pm 01.20.09/' -e 's/12:08 am 01.20.09/12:08 pm 01.20.09/' -e 's/12:11 am 01.20.09/12:11 pm 01.20.09/' -e 's/12:16 am 01.20.09/12:16 pm 01.20.09/' -e 's/12:21 am 01.20.09/12:21 pm 01.20.09/' -e 's/12:22 am 01.20.09/12:22 pm 01.20.09/' -e 's/12:33 am 01.20.09/12:33 pm 01.20.09/' -e 's/12:35 am 01.20.09/12:35 pm 01.20.09/' -e 's/12:36 am 01.20.09/12:36 pm 01.20.09/' -e 's/12:46 am 01.20.09/12:46 pm 01.20.09/' > "$i".fix.svg
 echo "$i" of "$amcount"
diff "$i" "$i".fix.svg
wc -l "$i"
wc -l "$i".fix.svg
mv "$i".fix.svg "$i"
done
```

1. Count Files in Subdirectories 

```bash
for i in `ls -1d */pixel/*trans*`; do echo -e $i = `find -E $i -regex '.*(.png|.jpg)' | wc -l`; done

```
1. Echo Random Word X Times 

```bash
for ((i=1;i<=555;i+=1)); do printf "`sed \`perl -e "print int rand(99999)"\`"q;d" /usr/share/dict/words` "; done

```
1. Sources 

- http://tldp.org/LDP/abs/html/refcards.html#AEN22664
- http://wiki.bash-hackers.org/syntax/expansion/brace


---

## Random Word



A simple script that returns a random word from the local dictionary file.

1. Supported Operating Systems 

- Mac OS X and Terminal
- Unix
- Linux

1. Requirements 

- Perl or $RANDOM
- /usr/share/dict/words file
- alias
- Bash

###How To

Simply edit your .profile file in your ~/ (home) directory and add the line below.

```
alias word='sed `perl -e "print int rand(99999)"`"q;d" /usr/share/dict/words'
```

Next reload your shell and thats it!

Now the next time you log in you can type word and a random word from the dictionary file will be displayed.

###Usage

Now you ask what would I ever use this for?

That is simple silly, I like to use it when creating hundreds of directories on friends computers and watching them delete them with the mouse! HA HA

Something like this....

```
x=0
y=93
r=0

while [ "$x" -lt "$y" ]
do    # Do what $y says.
  r=`perl -e "print int rand(99999)"`
#  echo $r
  mkdir -v fun/`sed $r"q;d" /usr/share/dict/words`
  let "x = $x + 1"
done
```

Also this could be quite handy when generating passwords for ssh accounts.

No more lame passwords for you...although it is a mass distributed dictionary file...hmmm ya lets just stick with pointless folder creation.


---

## Rename File Extensions



This is a simple function to quickly rename many files using Bash. It can be very useful for renaming pictures, mp3s, and movies.

1. Supported Operating Systems 

- Mac OS X and Terminal
- Unix
- Linux

1. Requirements 

- Bash

1. Syntax 

Below is a simple example for renaming uppercase jpg files to lowercase:

```bash
for i in *.JPG; do mv $i ${i%%.JPG}.jpg; done

for f in *.jpg; do mv "$f" "${f%.jpg}"; done

```
If you would like to use this function for other types of files here is a basic template:

```bash
for i in *.<EXISTING_EXT>; do mv $i ${i%%.<EXISTING_EXT>}.<RESULTING_EXT>; done

```
Another examples

```bash
for i in *.JPG; do j=`echo $i | cut -d . -f 1`; j=$j"_from_mark.jpg"; echo $j; mv $i $j; done;

for i in *.py; do cp "$i" "${i%-*}.py"; done

for i in *.py; do mv "$i" "${i%.py}-json.py"; done

```
String Operations

```bash
for i in *; do mv $i ${i#1440.jpg.*}.jpg; done

printf "%s\n" img{00{1..9},0{10..99},{100..999}}.png

```
Basic Example (Files without File Extensions)

```bash
for f in *; do mv "$f" "$f.jpg"; done


```

---

## Sort IP Addresses


```bash
grep ":25 HTTP/1.0" * | cut -d : -f 2 | cut -d" "  -f 1 | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 | uniq > test

```
