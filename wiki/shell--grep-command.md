# Grep Command


## Summary
grep is used to search text for patterns specified by the user. It is one of the most useful and powerful commands on Linux and other Unix-like operating systems.

grep's basic syntax is

```bash
grep [option(s)] pattern [file(s)]

```
The items in square brackets are optional. When used with no options and no arguments (i.e., input files), grep searches standard input (which by default is text typed in at the keyboard) for the specified pattern and returns each line that contains a match to standard output (which by default is the display screen).

A line of text is defined in this context not as what appears as a line of text on the display screen but rather as all text between two newline characters. Newline characters are invisible characters that are represented in Unix-like operating systems by a backslash followed by the letter n and which are created when a user presses the ENTER key when using a text editor (such as gedit). Thus, a line of text returned by grep can be as short as a single character or occupy many lines on the display screen.

grep can search any number of files simultaneously. Thus, for example, the following would search the three files file1, file2 and file3 for any line that contains the string (i.e., sequence of characters) Lin:

```bash
grep Lin file1 file2 file3

```
Each result is displayed beginning on a separate line, and it is preceded by the name of the file in which it was found in the case of multiple files. The inclusion of the file names in the output data can be suppressed by using the -h option.

grep is not limited to searching for just single strings. It can also search for sequences of strings, including phrases. This is accomplished by enclosing the sequence of strings that forms the pattern in quotation marks (either single or double). Thus, the above example could be modified to search for the phrase Linux is:

```bash
grep 'Linux is' file1 file2 file3

```
Text searches with grep can be considerably broadened by combining them with wildcards and/or performing recursive searches. A wildcard is a character that can represent some specific class of characters or sequence of characters. The following is a modification of the above example that uses the star wildcard (i.e., an asterisk), which represents any character or sequence of characters, to search all text files in the current directory (i.e., the directory in which the user is currently working):

```bash
grep 'Linux is' *

```
grep's search area can be broadened even further by using its -r option to search recursively through an entire directory tree (i.e., a directory and all levels of subdirectories within it) rather than just the files within a specified directory. For example, the following would search all files in the current directory and in all of its subdirectories (including their subdirectories, etc.) for every line containing the full name of the creator of Linux:

```bash
grep -r 'Linus Torvalds' *

```
One of the most commonly employed of grep's many options is -i, which instructs it to ignore case, that is, to ignore whether letters in the pattern and text searched are lower case (i.e., small letters) or upper case (i.e., capital letters). Thus, for instance, the previous example could very easily be converted to a case-insensitive search as follows:

```bash
grep -ir 'Linus Torvalds' *

```
This would produce the same results as

```bash
grep -ir 'linUS torvAlds' *

```
Another frequently used option is -c, which causes grep to only report the number of times that the pattern has been matched for each file and to not display the actual lines. Thus, for instance, the following would show the total number of times that the string inu appears in a file named file4:

```bash
grep -c inu file4

```
Another useful option is -n, which causes grep to precede each line of output with the number of the line in the text file from which it was obtained. The -v option inverts the match; that is, it matches only those lines that do not contain the given pattern. The -w option tells grep to select only those lines that contain an entire word or phrase that matches the specified pattern. The -x option tells grep to select only those lines that match exactly the specified pattern.

The -l option tells grep to not return the lines containing matches but to only return only the names of the files that contain matches. The -L option is the opposite of the -l option (and analogous to the -v option) in that it will cause grep to return only the names of files that do not contain the specified pattern.

grep does not search the names of files for a specified pattern, only the text contained within files. However, sometimes it is useful to search the names of files, as well as of directories and links, rather than the contents of files. Fortunately, this can easily be accomplished by first using the ls command to list the contents of a directory and then using a pipe (which is represented by the vertical bar character) to transfer its output to grep for searching. For example, the following would provide a list of all files, directories and links in the current directory that contain the string linu in their names:

```bash
ls | grep linu

```
The following example uses ls with its -l (i.e., long) option (which is unrelated to grep's -l option) to find all filesystem objects in the current directory whose permissions have been set so that any user can read, write and execute them:

```bash
ls -l | grep rwxrwxrwx

```
grep is very useful for obtain information from log and configuration files. For example, it can be used to obtain information about the USB (universal serial bus) devices on a system by filtering the output from the dmesg command (which provides the messages from the kernel as a system is booting up) as follows:

```bash
dmesg | grep -i usb

```
Among grep's other options are --help, which provides a very compact summary of some of its many capabilities, and -V, or --version, which provides information about the currently installed version.

grep's search functionality can be even further refined through the use of regular expressions. These are a pattern matching system that uses strings constructed according to pre-defined syntax rules to find desired patterns in text. Additional information about grep, including its use with regular expressions, can be obtained from its built-in manual page by using the man command, i.e.,

```bash
man grep

```
The name grep comes from a command in ed, which was the original text editor on the UNIX operating system. The command takes the form g/re/p, which means to search globally for matches to the regular expression (i.e., re), and print (which is UNIX terminology for write on the display screen) lines that are found.

## Examples

### Find Total Count of Occurrences of Strings, Words, Regular Expressions in Multiple Files

```bash
find . -name '*.svg' | xargs -IX grep -E '12:(04|05|08|11|16|21|22|33|35|36|46) am 01.20.09' X | sort | wc -l

find . -regex '.*[0-9]\{8\}\.svg' | grep black | xargs -IX grep -HE 'Transcription' X

```
### Find Count of Occurrences of Strings, Words, Regular Expressions in each of Multiple Files

```bash
find . -name '*.svg' | xargs -IX grep -HcE '12:(04|05|08|11|16|21|22|33|35|36|46) am 01.20.09' X | sort -t: +2

```
### Return IP Addresses

```bash
ifconfig | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'

```
### Filter IPv4 Address and Respective MAC Address

```bash
C:"\Program Files (x86)\GnuWin32\bin\grep.exe" "IPv4 Address\|Physical Address" *.mac | C:"\Program Files (x86)\GnuWin32\bin\grep.exe" -B 1 "(Preferred)"

```
### -bash:  grep: command not found (OSX)

```bash
cat test_dump.sql | grep

```
There appears to be a hidden asterisk.

This hidden character is triggered when the <alt>-key is not released before pressing the <space>-key. The german keyboard layout uses the <alt>-key to enter a pipe.

```bash
<space> != <alt><space>

```
If i delete that space between the pipe and grep and add one or two spaces, then the problem is gone

Maybe its a Problem with the Keyboard Layout.

### Filter any line containing a comma with a Regular Expression (REGEX)

```bash
pbpaste | tr '\r' '\n' | grep -E '^[^,]*$' | tr '\n' ','

```
### Match any files not ending with .php or starting with .

```bash
 ls -a1 | grep -P '^(?!(?:.*php$|^\.)).*$' | xargs -IX mv X archive/X

```
### Find all images on webpage

```bash
grep -H '.gif' * | tr ' ' '\n' | grep 'gif' | awk -F'"' '{print $2}' | sort | uniq

```
