# Sed Command


## Summary

```
NAME
     sed -- stream editor

SYNOPSIS
     sed [-Ean] command [file ...]
     sed [-Ean] [-e command] [-f command_file] [-i extension] [file ...]

DESCRIPTION
     The sed utility reads the specified files, or the standard input if no
     files are specified, modifying the input as specified by a list of com-
     mands.  The input is then written to the standard output.

     A single command may be specified as the first argument to sed.  Multiple
     commands may be specified by using the -e or -f options.  All commands
     are applied to the input in the order they are specified regardless of
     their origin.

     The following options are available:

     -E      Interpret regular expressions as extended (modern) regular
             expressions rather than basic regular expressions (BRE's).  The
             re_format(7) manual page fully describes both formats.

     -a      The files listed as parameters for the ``w'' functions are cre-
             ated (or truncated) before any processing begins, by default.
             The -a option causes sed to delay opening each file until a com-
             mand containing the related ``w'' function is applied to a line
             of input.

     -e command
             Append the editing commands specified by the command argument to
             the list of commands.

     -f command_file
             Append the editing commands found in the file command_file to the
             list of commands.  The editing commands should each be listed on
             a separate line.

     -i extension
             Edit files in-place, saving backups with the specified extension.
             If a zero-length extension is given, no backup will be saved.  It
             is not recommended to give a zero-length extension when in-place
             editing files, as you risk corruption or partial content in situ-
             ations where disk space is exhausted, etc.

     -n      By default, each line of input is echoed to the standard output
             after all of the commands have been applied to it.  The -n option
             suppresses this behavior.

     The form of a sed command is as follows:

           [address[,address]]function[arguments]

     Whitespace may be inserted before the first address and the function portions of the command.

     Normally, sed cyclically copies a line of input, not including its termi-
     nating newline character, into a pattern space, (unless there is some-
     thing left after a ``D'' function), applies all of the commands with
     addresses that select that pattern space, copies the pattern space to the
     standard output, appending a newline, and deletes the pattern space.

     Some of the functions use a hold space to save all or part of the pattern
     space for subsequent retrieval.

Sed Addresses
     An address is not required, but if specified must be a number (that
     counts input lines cumulatively across input files), a dollar (``$'')
     character that addresses the last line of input, or a context address
     (which consists of a regular expression preceded and followed by a delim-
     iter).

     A command line with no addresses selects every pattern space.

     A command line with one address selects all of the pattern spaces that
     match the address.

     A command line with two addresses selects an inclusive range.  This range
     starts with the first pattern space that matches the first address.  The
     end of the range is the next following pattern space that matches the
     second address.  If the second address is a number less than or equal to
     the line number first selected, only that line is selected.  In the case
     when the second address is a context address, sed does not re-match the
     second address against the pattern space that matched the first address.
     Starting at the first line following the selected range, sed starts look-
     ing again for the first address.

     Editing commands can be applied to non-selected pattern spaces by use of
     the exclamation character (``!'') function.

Sed Regular Expressions
     The regular expressions used in sed, by default, are basic regular
     expressions (BREs, see re_format(7) for more information), but extended
     (modern) regular expressions can be used instead if the -E flag is given.
     In addition, sed has the following two additions to regular expressions:

     1.   In a context address, any character other than a backslash (``\'')
          or newline character may be used to delimit the regular expression.
          Also, putting a backslash character before the delimiting character
          causes the character to be treated literally.  For example, in the
          context address \xabc\xdefx, the RE delimiter is an ``x'' and the
          second ``x'' stands for itself, so that the regular expression is
          ``abcxdef''.

     2.   The escape sequence \n matches a newline character embedded in the
          pattern space.  You can't, however, use a literal newline character
          in an address or in the substitute command.

     One special feature of sed regular expressions is that they can default
     to the last regular expression used.  If a regular expression is empty,
     i.e., just the delimiter characters are specified, the last regular
     expression encountered is used instead.  The last regular expression is
     defined as the last regular expression used as part of an address or sub-
     stitute command, and at run-time, not compile-time.  For example, the
     command ``/abc/s//XXX/'' will substitute ``XXX'' for the pattern ``abc''.

Sed Functions
     In the following list of commands, the maximum number of permissible
     addresses for each command is indicated by [0addr], [1addr], or [2addr],
     representing zero, one, or two addresses.

     The argument text consists of one or more lines.  To embed a newline in
     the text, precede it with a backslash.  Other backslashes in text are
     deleted and the following character taken literally.

     The ``r'' and ``w'' functions take an optional file parameter, which
     should be separated from the function letter by white space.  Each file
     given as an argument to sed is created (or its contents truncated) before
     any input processing begins.

     The ``b'', ``r'', ``s'', ``t'', ``w'', ``y'', ``!'', and ``:'' functions
     all accept additional arguments.  The following synopses indicate which
     arguments have to be separated from the function letters by white space
     characters.

     Two of the functions take a function-list.  This is a list of sed func-
     tions separated by newlines, as follows:

           { function
             function
             ...
             function
           }

     The ``{'' can be preceded by white space and can be followed by white
     space.  The function can be preceded by white space.  The terminating
     ``}'' must be preceded by a newline or optional white space.

     [2addr] function-list
             Execute function-list only when the pattern space is selected.

     [1addr]a\
     text    Write text to standard output immediately before each attempt to
             read a line of input, whether by executing the ``N'' function or
             by beginning a new cycle.

     [2addr]b[label]
             Branch to the ``:'' function with the specified label.  If the
             label is not specified, branch to the end of the script.

     [2addr]c\
     text    Delete the pattern space.  With 0 or 1 address or at the end of a
             2-address range, text is written to the standard output.

     [2addr]d
             Delete the pattern space and start the next cycle.

     [2addr]D
             Delete the initial segment of the pattern space through the first
             newline character and start the next cycle.

     [2addr]g
             Replace the contents of the pattern space with the contents of
             the hold space.

     [2addr]G
             Append a newline character followed by the contents of the hold
             space to the pattern space.

     [2addr]h
             Replace the contents of the hold space with the contents of the
             pattern space.

     [2addr]H
             Append a newline character followed by the contents of the pat-
             tern space to the hold space.

     [1addr]i\
     text    Write text to the standard output.

     [2addr]l
             (The letter ell.)  Write the pattern space to the standard output
             in a visually unambiguous form.  This form is as follows:

                   backslash          \\
                   alert              \a
                   form-feed          \f
                   carriage-return    \r
                   tab                \t
                   vertical tab       \v

             Nonprintable characters are written as three-digit octal numbers
             (with a preceding backslash) for each byte in the character (most
             significant byte first).  Long lines are folded, with the point
             of folding indicated by displaying a backslash followed by a new-
             line.  The end of each line is marked with a ``$''.

     [2addr]n
             Write the pattern space to the standard output if the default
             output has not been suppressed, and replace the pattern space
             with the next line of input.

     [2addr]N
             Append the next line of input to the pattern space, using an
             embedded newline character to separate the appended material from
             the original contents.  Note that the current line number
             changes.

     [2addr]p
             Write the pattern space to standard output.

     [2addr]P
             Write the pattern space, up to the first newline character to the
             standard output.

     [1addr]q
             Branch to the end of the script and quit without starting a new
             cycle.

     [1addr]r file
             Copy the contents of file to the standard output immediately
             before the next attempt to read a line of input.  If file cannot
             be read for any reason, it is silently ignored and no error con-
             dition is set.

     [2addr]s/regular expression/replacement/flags
             Substitute the replacement string for the first instance of the
             regular expression in the pattern space.  Any character other
             than backslash or newline can be used instead of a slash to
             delimit the RE and the replacement.  Within the RE and the
             replacement, the RE delimiter itself can be used as a literal
             character if it is preceded by a backslash.

             An ampersand (``&'') appearing in the replacement is replaced by
             the string matching the RE.  The special meaning of ``&'' in this
             context can be suppressed by preceding it by a backslash.  The
             string ``\#'', where ``#'' is a digit, is replaced by the text
             matched by the corresponding backreference expression (see
             re_format(7)).

             A line can be split by substituting a newline character into it.
             To specify a newline character in the replacement string, precede
             it with a backslash.

             The value of flags in the substitute function is zero or more of
             the following:

                   N       Make the substitution only for the N'th occurrence
                           of the regular expression in the pattern space.

                   g       Make the substitution for all non-overlapping
                           matches of the regular expression, not just the
                           first one.

                   p       Write the pattern space to standard output if a
                           replacement was made.  If the replacement string is
                           identical to that which it replaces, it is still
                           considered to have been a replacement.

                   w file  Append the pattern space to file if a replacement
                           was made.  If the replacement string is identical
                           to that which it replaces, it is still considered
                           to have been a replacement.

     [2addr]t [label]
             Branch to the ``:'' function bearing the label if any substitu-
             tions have been made since the most recent reading of an input
             line or execution of a ``t'' function.  If no label is specified,
             branch to the end of the script.

     [2addr]w file
             Append the pattern space to the file.

     [2addr]x
             Swap the contents of the pattern and hold spaces.

     [2addr]y/string1/string2/
             Replace all occurrences of characters in string1 in the pattern
             space with the corresponding characters from string2.  Any char-
             acter other than a backslash or newline can be used instead of a
             slash to delimit the strings.  Within string1 and string2, a
             backslash followed by any character other than a newline is that
             literal character, and a backslash followed by an ``n'' is
             replaced by a newline character.

     [2addr]!function
     [2addr]!function-list
             Apply the function or function-list only to the lines that are
             not selected by the address(es).

     [0addr]:label
             This function does nothing; it bears a label to which the ``b''
             and ``t'' commands may branch.

     [1addr]=
             Write the line number to the standard output followed by a new-
             line character.

     [0addr]
             Empty lines are ignored.

     [0addr]#
             The ``#'' and the remainder of the line are ignored (treated as a
             comment), with the single exception that if the first two charac-
             ters in the file are ``#n'', the default output is suppressed.
             This is the same as specifying the -n option on the command line.

ENVIRONMENT
     The COLUMNS, LANG, LC_ALL, LC_CTYPE and LC_COLLATE environment variables
     affect the execution of sed as described in environ(7).

DIAGNOSTICS
     The sed utility exits 0 on success, and >0 if an error occurs.

SEE ALSO
     awk(1), ed(1), grep(1), regex(3), re_format(7)

STANDARDS
     The sed utility is expected to be a superset of the IEEE Std 1003.2
     (``POSIX.2'') specification.

     The -E, -a and -i options are non-standard FreeBSD extensions and may not
     be available on other operating systems.

HISTORY
     A sed command, written by L. E. McMahon, appeared in Version 7 AT&T UNIX.

AUTHORS
     Diomidis D. Spinellis <dds@FreeBSD.org>
```

## Examples

### Sed Edit In Place

Simple Number Format
 
```bash
cat test | sed -E -e "s/^([0-9]{6,})-([0-9]{6,})/`echo -e \'','\'`\2'/g"

```
Remove empty / blank lines

```bash
sed '/^$/d' /tmp/data.txt

find -name “*.php” | xargs sed -i ‘s/\<Namespace::/WikiNamespace::/g'^C

for i in `find . -regex '.*[0-9]\{3\}\.php'`; do sed -i '' -e 's/..\/config/..\/plug_ins\/tcpdf\/config/' $i; sed -i '' -e 's/..\/tcpdf.php/..\/plug_ins\/tcpdf\/tcpdf.php/' $i;  done

for i in `find . -regex '.*[^\.(mp3|php)]$'`; do rm -f $i; done

for i in `find . -regex '.*[0-9]\{3\}\.php'`; do sed -i '' -e 's/..\/images/..\/plug_ins\/tcpdf\/images/g' $i; done

for i in `find . -regex '.*[0-9]\{3\}\.php'`; do sed -i '' -e 's/..\/cache/..\/plug_ins\/tcpdf\/cache/g' $i; done

for i in `find . -regex '.*[0-9]\{3\}\.php'`; do sed -i '' -e 's/..\/htmlcolors.php/..\/plug_ins\/tcpdf\/htmlcolors.php/g' $i; done

```
Trim Edges

```bash
sed -E 's/^.{4}(.*).{3}$/\1/g'

```
And Prefix/Suffix to Line

```bash
cat batch.log.txt | sed -e 's/^/(/;s/.$/),/'
cat batch.log.txt | sed -e 's/^/(/' -e 's/.$/),/'
cat ljasedmad.txt | sed -E -e "s/([a-zA-Z]+),([0-9]+),([a-zA-Z0-9_\-]+),(.+),([^,\)]+)/'','\1',\2,'\3',\4,'\5'/g" -e 's/([0-9]{10})/\1 + 18000/'

```
SQL Fields

```bash
cat lkljl | sed -E -e 's/[^`]*`([_a-zA-Z]*)`[^`]*/\1/g'

```
Randomize List

```bash
for i in `cat newtest`; do echo $RANDOM \'$i\'; done | sort | cut -d' ' -f 2 | tr -s "\r\n" ","

```
Condense Batch

```bash
ls -1 | grep -E ^[0-9] | sed -E -e 's/^([0-9]*)_.*.png/& \1/g' | uniq -f 1 | cut -d' ' -f 1 | xargs -IX mv X _ready/X

```
Parse Size Info

```bash
cat batch.log.txt | grep FFFFFF | sed -E -e 's/.*width=([0-9]{2,4})&height=([0-9]{2,4}).*/\1,\2/g' > white.dd.sizes.csv

```
Update Tracking

```bash
for i in `cat adjsad`; do grep $i /var/log/httpd/io85.com-access_log; done | sed -r -e 's/.*(\?key=.*) HTTP.*/\1/g' | xargs -iX links -source http://io85.com/track/clean.phpX

```
Format HTML & Extract Values Enclosed In Tags

```bash
sed -E -e "s/(<\/[^<>]+>)/\1\\`echo -e '\n\r'`/g" | sed -E -e '/^[^[:print:]]*$/d' -e 's/.*>(.*)<\/.*/\1/g' -e 's/^ *//;s/ *$//'

cat php.html | grep .gif | sed -E -e 's/.+src="(.+)" border="1".+>([0-9]{1,})-(.+)<\/.+/"\2","\3","\1"/g' | grep -E ^[\"0-9] > colors.csv

```
Parse HREF from HTML

```bash
sed -n 's/.*href="\([^"]*\).*/\1/p' * | grep files.*download | awk '{print "https://your.website"$0""}'
grep 'ENV = ' * | tr '"' '\n' | sed -n '/href/{n;p;}' | sed 's/\\//g;s/"//g' | awk -F '/' '{ if ($1==courses)  print "https://your.website"$0; else print $0;}'

```
Extract string between characters

```bash
grep 'CDATA' | sed -E -e 's/.*\[(.*)\]\].*/\1/g'


```
Remove all characters except digits. Replace all characters except digits with null.:

```bash
echo "m31uk3_1184329500.jpg" | sed 's/[^[:digit:]]//g'

```
Trim leading and trailing white space characters:

```bash
sed 's/^ *//;s/ *$//'

```
Trim leading and trailing non alpha numerical chars:

```bash
pbpaste | sed $'s/\t/,/g; s/[0-9],/&\\\n/g;' | sed 's/^[^[:alnum:]]*//g; s/[^[:alnum:]]*$//g; /^$/d;' | awk -F',' '{print $2","$1}' | sort

<nowiki>sed -e 's/^[space:::space:](misc--.md)*//;s/[space:::space:](misc--.md)*$//'</nowiki>

cat untitled.txt | awk -F'[<|>]' '{print $3}' | sed 's/^ *//;s/ *$//' | tr -s "\r\n" ","

```
Extract multiple substrings from string

```bash
links -source  http://www.spreadshirt.com/us/US/Service/Help-1328/categoryId/19/articleId/47 | grep -E \<[a-z0-9]{2}\>[\ [:alpha:]]*\<\/[a-z0-9]{2}\>\|.*[0-9A-F]{6}\.gif.* | sed -E "s/\<\/[a-z]{1,}\>/&\\`echo -e '\n\r'`/g" | sed -E -e 's/\<[a-z0-9]{2}\>([\ [:alpha:]]*)\<\/[a-z0-9]{2}\>/\1/g' -e 's/.*([0-9A-F]{6}).*"([0-9]{1,3}\-[\ [:alpha:]]{3,}).*/\1,\2/g' -e '/^$/d'

links -source http://www.spreadshirt.net/en/GB/Service/Help-1328/categoryId/9/articleId/47 | grep -E \<[a-z0-9]{2}\>[\ [:alpha:]]*\<\/[a-z0-9]{2}\>\|.*[0-9A-F]{6}\.gif.* | sed -E "s/\<\/[a-z]{1,}\>/&\\`echo -e '\n\r'`/g" | sed -E -e 's/\<[a-z0-9]{2}\>([\ [:alpha:]]*)\<\/[a-z0-9]{2}\>/\1/g' -e 's/.*([0-9A-F]{6}).*"([0-9]{1,3}\-[\ [:alpha:]]{3,}).*/\1,\2/g' -e '/^$/d'

```
Return quoted font values from SVG files:

Rough Draft Needs Revised!

```bash
find . | grep .svg$ | xargs -IX grep -H Helvetica X | sed 's/\(.\{1,\}\.svg\).*\(font-family=".\{1,\}"\).*/\1 \2/'

```
Rename Multiple Files

```bash
ls | sed "s/\(.*\).\.\(.\+\)/mv \0 \1.\2/" | sh

```
Replace Multiple Strings, Words, Regular Expressions from Terminal (Standard Input)

```bash
sed -e 's/12:04 am 01.20.09/12:04 pm 01.20.09/' -e 's/12:05 am 01.20.09/12:05 pm 01.20.09/' -e 's/12:08 am 01.20.09/12:08 pm 01.20.09/' -e 's/12:11 am 01.20.09/12:11 pm 01.20.09/' -e 's/12:16 am 01.20.09/12:16 pm 01.20.09/' -e 's/12:21 am 01.20.09/12:21 pm 01.20.09/' -e 's/12:22 am 01.20.09/12:22 pm 01.20.09/' -e 's/12:33 am 01.20.09/12:33 pm 01.20.09/' -e 's/12:35 am 01.20.09/12:35 pm 01.20.09/' -e 's/12:36 am 01.20.09/12:36 pm 01.20.09/' -e 's/12:46 am 01.20.09/12:46 pm 01.20.09/' > output.txt

```
Convert Kornit MediaDB.txt
```
cat MediaDB.txt | sed -E -e "s/MediaName[0-9]+=([print:::print:](misc--.md)+)/\[\1\]\\`echo -e '\n\r'`Dark media=1/g" -e "s/MediaHeight[0-9]+=([print:::print:](misc--.md)+)/Media height=\1\\`echo -e '\n\r'`Print height=0/g" -e "s/MediaSpeed[0-9]+=([print:::print:](misc--.md)+)/Spray speed=\1\\`echo -e '\n\r'`Linear lut file name=\\`echo -e '\n\r'`Author=lja/g"
```

Return Order/Trans Pair from Backlog Page

```
cat test | sed -E -e "s/.*>([digit:::digit:](misc--.md){6,}-[digit:::digit:](misc--.md){6,})<.*/\1/g" | grep -E [digit:::digit:](misc--.md)\{6,\}\-[digit:::digit:](misc--.md)\{6,\} | sed -E -e "s/([digit:::digit:](misc--.md){6,})-([digit:::digit:](misc--.md){6,})/\1_\2_deliverynote.pdf/g"
```

Return DD Product IDs

```bash
cat 969 | grep productTypeId | sed -r -e 's/.*productTypeId\/([digit:::digit:](misc--.md){1,})\/.*/\1/g' -e 's/^ *//;s/ *$//' | sort -n | uniq

```
String To Lowercase

```bash
$ echo 'HELLO' | awk '{print tolower($0)}'

```
## Replace NewLine Data with multiple character delimiter

```bash
pbpaste | tr -d '\r' | sed "s/.*/'&'/" | paste -sd, -  

```
**Links**

shell - How to replace one character with two characters using tr - Stack Overflow
https://stackoverflow.com/questions/18365482/how-to-replace-one-character-with-two-characters-using-tr

linux - Turning separate lines into a comma separated list with quoted entries - Unix & Linux Stack Exchange
https://unix.stackexchange.com/questions/338116/turning-separate-lines-into-a-comma-separated-list-with-quoted-entries

linux - Using paste command to join with multiple character delimiter - Super User
https://superuser.com/questions/537626/using-paste-command-to-join-with-multiple-character-delimiter



## Replace Multiple Spaces with Comma
```
cut -f 4- | sed 's/[ +]/,/g' | sed 's/[space:::space:](misc--.md)//g'
```

## Convert Line Breaks Windows / Unix

If you know how to enter carriage return into a script (control-V, control-M to enter control-M) where the '^M' is the control-M character. , then:

1. DOS to Unix

```bash
sed 's/^M$//'

```
1. Unix to DOS

```bash
sed 's/$/^M/'
 
```
You can also use the bash ANSI-C Quoting mechanism:

1. DOS to Unix

```bash
sed $'s/\r$//'

```
1. Unix to DOS

```bash
sed $'s/$/\r/'

```
### String to Lowercase, String Replace Space, String Trim Leading and Trailing Space, String Remove Empty Line

```bash
pbpaste | sed '/^$/d; s/^ *//; s/ *$//; y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/; s/ /./g';

```
pbpaste | sed '/^$/d; s/^ *//; s/ *$//; s/ /_/g;' | awk '{print tolower($0)}' | xargs -IX bash -c "echo \<h1\>Auto generated X file for IST-440\</h1\> > X.html
```

```
### Generate Data Dictionary from SQL Code

```bash
pbpaste | sed -E -e 's/[^ _A-Z,\)\(0-9]//g' -e 's/  */ /g' -e 's/^ //g' -e 's/^\(//g' -e 's/^ //g' -e 's/, *$//g' -e 's/ /;/' | awk -F';' '{print $1";"$1" column of table;" $2 ";ALL;NO;NO;NO"}' | tr ';' '\t'

```
### Get List of $_FIELDS Params

```bash
grep -h -E ^"'[A-Z]{2,}" * | sed 's/^ *//; s/ *$//' | sort | uniq

```
## Links

- http://wiki.linuxquestions.org/wiki/Sed

