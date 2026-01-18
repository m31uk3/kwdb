# Awk Command


## Usage

```bash
   Unix:  awk '/pattern/ {print "$1"}'    # standard Unix shells
DOS/Win:  awk '/pattern/ {print "$1"}'    # okay for DJGPP compiled
          awk "/pattern/ {print \"$1\"}"  # required for Mingw32

```
Most of my experience comes from version of GNU awk (gawk) compiled for
Win32. Note in particular that DJGPP compilations permit the awk script
to follow Unix quoting syntax '/like/ {"this"}'. However, the user must
know that single quotes under DOS/Windows do not protect the redirection
arrows (<, >) nor do they protect pipes (|). Both are special symbols
for the DOS/CMD command shell and their special meaning is ignored only
if they are placed within "double quotes." Likewise, DOS/Win users must
remember that the percent sign (%) is used to mark DOS/Win environment
variables, so it must be doubled (%%) to yield a single percent sign
visible to awk.

If I am sure that a script will NOT need to be quoted in Unix, DOS, or
CMD, then I normally omit the quote marks. If an example is peculiar to
GNU awk, the command 'gawk' will be used. Please notify me if you find
errors or new commands to add to this list (total length under 65
characters). I usually try to put the shortest script first.

## File Spacing

```bash
# double space a file
awk '1;{print ""}'
awk 'BEGIN{ORS="\n\n"};1'

# double space a file which already has blank lines in it. Output file
# should contain no more than one blank line between lines of text.
# NOTE: On Unix systems, DOS lines which have only CRLF (\r\n) are
# often treated as non-blank, and thus 'NF' alone will return TRUE.
awk 'NF{print $0 "\n"}'

# triple space a file
awk '1;{print "\n"}'

```
## Numbering and Calculations

```bash
# precede each line by its line number FOR THAT FILE (left alignment).
# Using a tab (\t) instead of space will preserve margins.
awk '{print FNR "\t" $0}' files*

# precede each line by its line number FOR ALL FILES TOGETHER, with tab.
awk '{print NR "\t" $0}' files*

# number each line of a file (number on left, right-aligned)
# Double the percent signs if typing from the DOS command prompt.
awk '{printf("%5d : %s\n", NR,$0)}'

# number each line of file, but only print numbers if line is not blank
# Remember caveats about Unix treatment of \r (mentioned above)
awk 'NF{$0=++a " :" $0};{print}'
awk '{print (NF? ++a " :" :"") $0}'

# count lines (emulates "wc -l")
awk 'END{print NR}'

# print the sums of the fields of every line
awk '{s=0; for (i=1; i<=NF; i++) s=s+$i; print s}'

# add all fields in all lines and print the sum
awk '{for (i=1; i<=NF; i++) s=s+$i}; END{print s}'

# print every line after replacing each field with its absolute value
awk '{for (i=1; i<=NF; i++) if ($i < 0) $i = -$i; print }'
awk '{for (i=1; i<=NF; i++) $i = ($i < 0) ? -$i : $i; print }'

# print the total number of fields ("words") in all lines
awk '{ total = total + NF }; END {print total}' file

# print the total number of lines that contain "Beth"
awk '/Beth/{n++}; END {print n+0}' file

# print the largest first field and the line that contains it
# Intended for finding the longest string in field #1
awk '$1 > max {max=$1; maxline=$0}; END{ print max, maxline}'

# print the number of fields in each line, followed by the line
awk '{ print NF ":" $0 } '

# print the last field of each line
awk '{ print $NF }'

# print the last field of the last line
awk '{ field = $NF }; END{ print field }'

# print every line with more than 4 fields
awk 'NF > 4'

# print every line where the value of the last field is > 4
awk '$NF > 4'

```
## Text Conversion and Substitution

```bash
# IN UNIX ENVIRONMENT: convert DOS newlines (CR/LF) to Unix format
awk '{sub(/\r$/,"");print}'   # assumes EACH line ends with Ctrl-M

# IN UNIX ENVIRONMENT: convert Unix newlines (LF) to DOS format
awk '{sub(/$/,"\r");print}

# IN DOS ENVIRONMENT: convert Unix newlines (LF) to DOS format
awk 1

# IN DOS ENVIRONMENT: convert DOS newlines (CR/LF) to Unix format
# Cannot be done with DOS versions of awk, other than gawk:
gawk -v BINMODE="w" '1' infile >outfile

```
### Remove newline char at end of line

```bash
awk '{printf("%s ",$0)}'

# Use "tr" instead.
tr -d \r <infile >outfile            # GNU tr version 1.22 or higher

# delete leading whitespace (spaces, tabs) from front of each line
# aligns all text flush left
awk '{sub(/^[ \t]+/, ""); print}'

# delete trailing whitespace (spaces, tabs) from end of each line
awk '{sub(/[ \t]+$/, "");print}'

# delete BOTH leading and trailing whitespace from each line
awk '{gsub(/^[ \t]+|[ \t]+$/,"");print}'
awk '{$1=$1;print}'           # also removes extra space between fields

# insert 5 blank spaces at beginning of each line (make page offset)
awk '{sub(/^/, "     ");print}'

# align all text flush right on a 79-column width
awk '{printf "%79s\n", $0}' file*

# center all text on a 79-character width
awk '{l=length();s=int((79-l)/2); printf "%"(s+l)"s\n",$0}' file*

# substitute (find and replace) "foo" with "bar" on each line
awk '{sub(/foo/,"bar");print}'           # replaces only 1st instance
gawk '{$0=gensub(/foo/,"bar",4);print}'  # replaces only 4th instance
awk '{gsub(/foo/,"bar");print}'          # replaces ALL instances in a line

# substitute "foo" with "bar" ONLY for lines which contain "baz"
awk '/baz/{gsub(/foo/, "bar")};{print}'

# substitute "foo" with "bar" EXCEPT for lines which contain "baz"
awk '!/baz/{gsub(/foo/, "bar")};{print}'

# change "scarlet" or "ruby" or "puce" to "red"
awk '{gsub(/scarlet|ruby|puce/, "red"); print}'

# reverse order of lines (emulates "tac")
awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' file*

# if a line ends with a backslash, append the next line to it
# (fails if there are multiple lines ending with backslash...)
awk '/\\$/ {sub(/\\$/,""); getline t; print $0 t; next}; 1' file*

# print and sort the login names of all users
awk -F ":" '{ print $1 | "sort" }' /etc/passwd

# print the first 2 fields, in opposite order, of every line
awk '{print $2, $1}' file

# switch the first 2 fields of every line
awk '{temp = $1; $1 = $2; $2 = temp}' file

# print every line, deleting the second field of that line
awk '{ $2 = ""; print }'

# print in reverse order the fields of every line
awk '{for (i=NF; i>0; i--) printf("%s ",i);printf ("\n")}' file

# remove duplicate, consecutive lines (emulates "uniq")
awk 'a !~ $0; {a=$0}'

# remove duplicate, nonconsecutive lines
awk '! a[$0]++'                     # most concise script
awk '!($0 in a) {a[$0];print}'      # most efficient script

# concatenate every 5 lines of input, using a comma separator
# between fields
awk 'ORS=%NR%5?",":"\n"' file

```
## Selective Printing of Certain Lines

```bash
# print first 10 lines of file (emulates behavior of "head")
awk 'NR < 11'

# print first line of file (emulates "head -1")
awk 'NR>1{exit};1'

 # print the last 2 lines of a file (emulates "tail -2")
awk '{y=x "\n" $0; x=$0};END{print y}'

# print the last line of a file (emulates "tail -1")
awk 'END{print}'

# print only lines which match regular expression (emulates "grep")
awk '/regex/'

# print only lines which do NOT match regex (emulates "grep -v")
awk '!/regex/'

# print the line immediately before a regex, but not the line
# containing the regex
awk '/regex/{print x};{x=$0}'
awk '/regex/{print (x=="" ? "match on line 1" : x)};{x=$0}'

# print the line immediately after a regex, but not the line
# containing the regex
awk '/regex/{getline;print}'

# grep for AAA and BBB and CCC (in any order)
awk '/AAA/; /BBB/; /CCC/'

# grep for AAA and BBB and CCC (in that order)
awk '/AAA.*BBB.*CCC/'

# print only lines of 65 characters or longer
awk 'length > 64'

# print only lines of less than 65 characters
awk 'length < 64'

# print section of file from regular expression to end of file
awk '/regex/,0'
awk '/regex/,EOF'

# print section of file based on line numbers (lines 8-12, inclusive)
awk 'NR==8,NR==12'

# print line number 52
awk 'NR==52'
awk 'NR==52 {print;exit}'          # more efficient on large files

# print section of file between two regular expressions (inclusive)
awk '/Iowa/,/Montana/'             # case sensitive

```
## Selective Deletion of Certain Lines

```bash
# delete ALL blank lines from a file (same as "grep '.' ")
awk NF
awk '/./'

```
## Examples

### Parse Hyperlink Text between href tags

```bash
cat untitled.txt | awk -F'[<|>]' '{print $3}' | sed 's/^ *//;s/ *$//' | tr -s "\r\n" ","

```
### Fetch Printer Report and E-Mail

```bash
wget -O- http://192.168.1.12/start/StatPtr1.htm | grep 'sLabel\[' | head -n 6 | awk -F'"' '{ print $2": "$4 }' | mail -s 'Kyrocera MS-4000DN Printer Report' email@email.com

```
### Clean Up Jpeg Files Based on Date

Convert unix timestamp from filename to folder path based on date:

```bash
ls -1 *.jpg | awk -F _ '{print $2}' | sed 's/[^[:digit:]]//g' | utimecam

```
### Batch rename files

Rename file including only the second field:

```bash
ls -1 | awk -F - '{print("mv \"" $0"\""" \""$2"\"")}' | /bin/sh

```
Rename file excluding only the first field:

```bash
ls -1 | awk -F _ '{str=$2;for(i=3;i<=NF;++i) str=str FS $i; print("mv " $0 " "str)}' | /bin/sh

```
Bulk Rename files separated by - character, including spaces in file names with bash

```bash
ls -1 | awk -F - '{str=$2;for(i=3;i<=NF;++i) str=str FS $i; print("mv " "\""$0"\"" " \""str"\"")}' | /bin/sh

```
### Fetch local ip and return 3rd octet (Mac OS X)

```bash
ifconfig en0 | grep 'broadcast' | awk '{print $2}' | awk -F . '{print $3}'

ifconfig | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | awk -F . '$1 != 127 && $1 !=255 && $4 < 255 {print $3}'

```
### Total list of numbers

```bash
awk 'BEGIN{total=0} {total += $1} END{print total}'

```
### Bulk Rename SQL Tables

```bash
awk -F'_' '{t=$0; for(i=n;i<=NF;i++)$(i-(n-1))=$i;NF=NF-(n-1);print "RENAME TABLE `database`.`"t"` TO `database`.`user_"$0"`;" }' OFS='_' n=4 FILE_EXT

awk -F'_' '{t=$0; for(i=n;i<=NF;i++)$(i-(n-1))=$i;NF=NF-(n-1);print "ALTER TABLE `database`.`user_"$0"`  DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;" }' OFS='_' n=4 FILE_EXT

awk -F'_' '{t=$0; for(i=n;i<=NF;i++)$(i-(n-1))=$i;NF=NF-(n-1);print "ALTER TABLE `database`.`user_"$0"` ENGINE = InnoDB;" }' OFS='_' n=4 FILE_EXT

```
### Sum Column of Numbers

**Earned Points**

```bash
pbpaste | tr '\t' ' ' | grep -E '[0-9\.]{2,}$' | cut -d' ' -f 7 | awk '{s+=$1} END {print s}'

```
**Total Points**

```bash
pbpaste | tr '\t' ' ' | grep -E '^ [0-9\.][^\.%]{2,}' | cut -d' ' -f 2 | awk '{s+=$1} END {print s}'

```
**Sum Ledger**

```bash
pbpaste | cut -f 5 | sed 's/[^0-9\.]//g' | awk '{ sum+=$1} END {print sum}'

```
### Convert XML to MySQL

Revers Line Order For Alter Table

```bash
awk -F'[<>]' '{a[i++]=$2} END {for (j=i-1; j>=0;) print "ALTER TABLE `user_prd_ddd_setup_types` ADD `"tolower(a[j--])"` VARCHAR( 30 ) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `name`;"}' tmp.xml

```
Match INT(10)

```bash
awk -F'[<>]' '{print $2","$3}' tmp.xml | awk -F',' '$2 ~ /^[0-9]+$/ {print "ALTER TABLE `user_prd_ddd_setup_types` CHANGE `"tolower($1)"` `"tolower($1)"` INT( 10 ) UNSIGNED NOT NULL DEFAULT '0';"}'

```
Match FLOAT(6,3)

```bash
awk -F'[<>]' '{print $2","$3}' tmp.xml | awk -F',' '$2 ~ /^[0-9]+[\.]+[^\.[:alpha:]]*$/ {print "ALTER TABLE `user_prd_ddd_setup_types` CHANGE `"tolower($1)"` `"tolower($1)"` FLOAT( 6,3 ) UNSIGNED NOT NULL DEFAULT '0';"}'

```
Match TINYINT(1)

```bash
awk -F'[<>]' '{print $2","$3}' tmp.xml | awk -F',' '$2 ~ /^(true|false)$/ {print "ALTER TABLE `user_prd_ddd_setup_types` CHANGE `"tolower($1)"` `"tolower($1)"` TINYINT( 1 ) UNSIGNED NOT NULL DEFAULT '0';"}'

```
### Add Prefix AND/OR Suffix to String (Convert Windows Line Break)

```bash
cat A1000.kst | sed 's/^ *//;s/ *$//' | sed $'s/\r$//' | awk -v PRE='$file_body .= "' -v SUF='"."\\n";' '{ $0=PRE$0SUF; print ($0) }'

cat file.txt | tr -d "\r" | awk '{print "$file_body .= \""$0"\".\"\\n\";"}'

pbpaste | cut -f 2- | awk '{print "* "$0"\n"}' | pbcopy

```
### If Statements (if field length is...)

Export only src or href from course data

```
grep -H 'ENV = ' video-lectures-lesson-* | tr '"' '\n' | awk -F'[: ]' '{ if ($4 == "ENV" && $1 != prefix) prefix=$1; print prefix","$0}'| sed -n '/src/{n;p;}' | sed 's/\\//g;s/"//g'
```

Convert to wget string with awk and execute with bash

```
grep -H 'ENV = ' video-lectures-lesson-* | tr '"' '\n' | awk -F'[: ]' '{ if ($4 == "ENV" && $1 != prefix) prefix=$1; split(prefix,s,"[\-\.]"); print s[3]"-"s[4]","$0}'| sed -n '/src/{n;p;}' | sed 's/\\//g;s/"//g' | grep mp4 | awk -F',' '{ split($2,s,"[\/]");  print "wget "$2" -O "$1"-"s[5]}' | /bin/sh
```



Export only contacts from google

```bash
cat contacts.csv | cut -d',' -f 1-3 | awk -F ',' '{ if (length($3) > 1 && length($2) == 0) print $0}'


```
Replace values based on last value of specific field

```bash
awk -F'[: ]' '{ if ($4 == "ENV" && $1 != prefix) prefix=$1; print prefix","$0}'


```
Export captions

```bash
cat 2505476419001_captions | grep '^[^0-9]' | awk '{ if (substr($0, length($0), 1)==",") print ""$0"#"; else print $0;}'
cat 2505476419001_captions | grep '^[^0-9]' | awk '/[^.]$/ { printf("%s ", $0); next } 1'

```
**Prefix the date from XML data to create comma separated values and grep on specific values**

```bash
pbpaste | grep -H '<' *.xml |  awk -F'[>:.<]' '{ if ($4 == "Date" && $5 != prefix) prefix=$5; print prefix","$1","$4","$5}' | grep 'Date\|RightTablePrints\|LeftTablePrints\|TotalTablesPrints\|WhiteBridgePrints\|ColorBridgePrints'


```
**Prefix the date from XML data to create comma separated values**

```bash
pbpaste | awk '{ if ($1 == "PDF") prefix="+"; else prefix=""; print $0prefix}' | tr '\n' ',' | tr '+' '\n'

```
### Safe String, remove all non alphanumerical chars and format for filenames

```bash
pbpaste | sed '/^$/d; s/^ *//; s/ *$//' | tr -dc '[:alnum:]\. \-\n\r' | awk '{gsub(/ /,"."); print tolower($0)}'

```
### Escape Single Quotes and build Python Dict from CSV list

```
pbpaste | tr '\r\n' '\n' | awk -F',' '{print "'\''"$1"'\'': {'\''desc'\'': '\''"$2"'\'', '\''price'\'':"$3", '\''type'\'': '\''"$4"'\'', '\''avail'\'': "$5"},"}'
```

### List of numbers padded with zeros separated by string

```
seq -f %02g 0 24 | awk 'BEGIN{ORS="'\'','\''"} {print ""$0""}'
```

### Mac OS X convert text from stdin bash command line into postscript pdf

```bash
pbpaste | enscript --word-wrap -p - | pstopdf -i -o ~/Downloads/tmp.pdf


```
Closed Captions filtered through REGEX with string chunks concatenated into sentences (Carriage Return Safe)

```bash
cat file.txt | sed "s/[”“]/\"/g;s/[’]/'/g" | sed 's/\r$//;s/[^0-9A-Za-z [:punct:]]//g;/^ $/d;s/^ *//;s/ *$//;' | grep -E '^[^0-9]{2,}' | awk '/[^.]$/ { printf("%s ", $0); next } 1' | enscript --word-wrap -p - | pstopdf -i -o ~/Downloads/Ch2_New_Belgium_Brewery.pdf

```
Youtube captions converted into PDF

```bash
curl-O https://www.youtube.com/api/timedtext?<query_string> | tr '>' '\n' | grep -E '^[alpha:::alpha:](misc--.md){1,}' | cut -d'<' -f 1

cat timedtext.xml | tr '>' '\n' | sed '/^ $/d;s/^ *//;s/ *$//;' | grep -E '^[[:alnum:]\.,]{1,}' | cut -d'<' -f 1 | awk '/[^.]$/ { printf("%s ", $0); next } 1' | pbcopy

```
**Revised 2021.01.18**

```bash
xmlstarlet sel -t -v "//text" timedtext.xml | xmlstarlet unesc | xmlstarlet unesc | awk '/[^.]$/ { printf("%s ", $0); next } 1' | enscript --word-wrap -p - | pstopdf -i -o ~/Downloads/trump.pdf

```
Odd artifacts with HTML and XML encoding that forcing the unescape command to need to be ran twice...still not sure about &quot;

**Revised 2021.01.19**

```bash
xmlstarlet sel -t -v "//text" timedtext.xml | xmlstarlet unesc | sed 's/&quot;/\"/g;' | xmlstarlet unesc | awk '{ printf("%s ", $0); next } 1' | sed 's/\([.!?]\)/\1\'$'\n/g' | sed '/^ $/d; s/^ *//; s/ *$//;'
xmlstarlet sel -t -v "//text" timedtext.xml | xmlstarlet unesc | sed 's/&quot;/\"/g;' | xmlstarlet unesc | awk '{ printf("%s ", $0); next } 1' | sed 's/\([.!?]\)/\1\'$'\n/g' | sed '/^ $/d; s/^ *//; s/ *$//;' | enscript --word-wrap -p - | pstopdf -i -o ~/Downloads/trump3.pdf

```
Solved documented xmlstarlet bug unescaping "&quot ;" using sed after first unescape, double unescape necessary due to html download of xml content, change in parsing results in less favorable line breaks. Adjusted awk to concatenate on all lines and then rely on sed to add newlines back in on line ending punctuation (!?.), sed cleanup to address awk inserted spaces


Direct Download M3U8 file playlist stream and convert into local MP4 video file

```bash
echo "Enter m3u8 link:";read link;echo "Enter output filename:";read filename;ffmpeg -i "$link" -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 23 $filename.mp4

```
-bsf:a aac_adtstoasc

    bsf = (bit stream filter)
    use aac_adtstoasc bsf for a audio streams, this is need if .m3u8 file consists with .ts files and output is .mp4
    reference https://ffmpeg.org/ffmpeg-bitstream-filters.html#aac_005fadtstoasc

-c copy -vcodec copy

    skip codec (encode and decode), just demux and mux
    I guess .ts and .mp4, for video stream, they are both H.264 codec, just guess.
    reference https://ffmpeg.org/ffmpeg.html#Stream-copy

-crf 50

    reference https://trac.ffmpeg.org/wiki/Encode/H.264#CRFExample
    the example shows -c:a copy did not re-encode, guess this option is not needed here.
    And 0 is lossless, 23 is the default, and 51 is worst quality possible 😢
```

```
https://gist.github.com/tzmartin/fb1f4a8e95ef5fb79596bd4719671b5d

### Convert Sorted 'du -k' into Human Readable (Megabytes)

```bash
du -d 1 -k | sort -nr | awk '$1 > 10240 {print $1 / 1024 $2}'

```
### Parse Backlog Tool

**Exclamation Mark Reverses Order** 

```bash
pbpaste | awk -F'%' '/[0-9]{6,}\-[0-9]{6,}|([0-9]{4}\-[0-9]{2}\-[0-9]{2} [0-9]{2}\:[0-9]{2}\:[0-9]{2})\([0-9]+ h\)/ {print $0}' | awk '!(NR%2){print p","$0}{p=$0}'

pbpaste | awk -F'%' '/[0-9]{6,}\-[0-9]{6,}|([0-9]{4}\-[0-9]{2}\-[0-9]{2} [0-9]{2}\:[0-9]{2}\:[0-9]{2})\([0-9]+ h\)/ {print $0}' | awk '(NR%2){print p","$0}{p=$0}'

pbpaste | awk '/[0-9]{6,}\-[0-9]{6,}/ {print x","$0};{x=$0}'


```
**If field two is equal to nothing, do nothing, else return line**

```bash
"C:\Program Files (x86)\GnuWin32\bin\awk.exe" -F"[,]" "{ if ($2 ==\"\") print \"~,\"$1; else print \",\"$2; }"

```
## Sources

- http://www.student.northpark.edu/pemente/awk/awk1line.txt

- http://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_06_03.html

- http://www.unix.com/shell-programming-scripting/34163-help-awk.html

Special thanks to Peter S. Tillier for helping me with the first release
of this FAQ file.

For additional syntax instructions, including the way to apply editing
commands from a disk file instead of the command line, consult:

"sed & awk, 2nd Edition," by Dale Dougherty and Arnold Robbins
```bash
 O'Reilly, 1997
```
"UNIX Text Processing," by Dale Dougherty and Tim O'Reilly
```bash
 Hayden Books, 1987
```
"Effective awk Programming, 3rd Edition." by Arnold Robbins
```bash
 O'Reilly, 2001

```
To fully exploit the power of awk, one must understand "regular
expressions." For detailed discussion of regular expressions, see
"Mastering Regular Expressions, 2d edition" by Jeffrey Friedl
```bash
  (O'Reilly, 2002).

```
The manual ("man") pages on Unix systems may be helpful (try "man awk",
"man nawk", "man regexp", or the section on regular expressions in "man
ed"), but man pages are notoriously difficult. They are not written to
teach awk use or regexps to first-time users, but as a reference text
for those already acquainted with these tools.

USE OF '\t' IN awk SCRIPTS: For clarity in documentation, we have used
the expression '\t' to indicate a tab character (0x09) in the scripts.
All versions of awk, even the UNIX System 7 version should recognize
the '\t' abbreviation.


### Convert Sorted 'du -k' into Human Readable (Megabytes)

```bash
du -d 1 -k | sort -nr | awk '$1 > 10240 {print $1 / 1024 $2}'

```
### Parse Backlog Tool

**Exclamation Mark Reverses Order** 

```bash
pbpaste | awk -F'%' '/[0-9]{6,}\-[0-9]{6,}|([0-9]{4}\-[0-9]{2}\-[0-9]{2} [0-9]{2}\:[0-9]{2}\:[0-9]{2})\([0-9]+ h\)/ {print $0}' | awk '!(NR%2){print p","$0}{p=$0}'

pbpaste | awk -F'%' '/[0-9]{6,}\-[0-9]{6,}|([0-9]{4}\-[0-9]{2}\-[0-9]{2} [0-9]{2}\:[0-9]{2}\:[0-9]{2})\([0-9]+ h\)/ {print $0}' | awk '(NR%2){print p","$0}{p=$0}'

pbpaste | awk '/[0-9]{6,}\-[0-9]{6,}/ {print x","$0};{x=$0}'


```
**If field two is equal to nothing, do nothing, else return line**

```bash
"C:\Program Files (x86)\GnuWin32\bin\awk.exe" -F"[,]" "{ if ($2 ==\"\") print \"~,\"$1; else print \",\"$2; }"

```
## Sources

- http://www.student.northpark.edu/pemente/awk/awk1line.txt

- http://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_06_03.html

- http://www.unix.com/shell-programming-scripting/34163-help-awk.html

Special thanks to Peter S. Tillier for helping me with the first release
of this FAQ file.

For additional syntax instructions, including the way to apply editing
commands from a disk file instead of the command line, consult:

"sed & awk, 2nd Edition," by Dale Dougherty and Arnold Robbins
```bash
 O'Reilly, 1997
```
"UNIX Text Processing," by Dale Dougherty and Tim O'Reilly
```bash
 Hayden Books, 1987
```
"Effective awk Programming, 3rd Edition." by Arnold Robbins
```bash
 O'Reilly, 2001

```
To fully exploit the power of awk, one must understand "regular
expressions." For detailed discussion of regular expressions, see
"Mastering Regular Expressions, 2d edition" by Jeffrey Friedl
```bash
  (O'Reilly, 2002).

```
The manual ("man") pages on Unix systems may be helpful (try "man awk",
"man nawk", "man regexp", or the section on regular expressions in "man
ed"), but man pages are notoriously difficult. They are not written to
teach awk use or regexps to first-time users, but as a reference text
for those already acquainted with these tools.

USE OF '\t' IN awk SCRIPTS: For clarity in documentation, we have used
the expression '\t' to indicate a tab character (0x09) in the scripts.
All versions of awk, even the UNIX System 7 version should recognize
the '\t' abbreviation.

