# Find Command


**find** -- Linux/Unix/Mac OS X find command

## Introduction

You can use **find** to find things. It is very helpful when are you are trying to find things like files on your computer.

## Syntax

```
Usage: find [path...] [expression]

default path is the current directory; default expression is -print
expression may consist of: operators, options, tests, and actions:

operators (decreasing precedence; -and is implicit where no others are given):
      ( EXPR )   ! EXPR   -not EXPR   EXPR1 -a EXPR2   EXPR1 -and EXPR2
      EXPR1 -o EXPR2   EXPR1 -or EXPR2   EXPR1 , EXPR2

positional options (always true): -daystart -follow -regextype

normal options (always true, specified before other expressions):
      -depth --help -maxdepth LEVELS -mindepth LEVELS -mount -noleaf
      --version -xdev -ignore_readdir_race -noignore_readdir_race

tests (N can be +N or -N or N): -amin N -anewer FILE -atime N -cmin N
      -cnewer FILE -ctime N -empty -false -fstype TYPE -gid N -group NAME
      -ilname PATTERN -iname PATTERN -inum N -iwholename PATTERN -iregex PATTERN
      -links N -lname PATTERN -mmin N -mtime N -name PATTERN -newer FILE
      -nouser -nogroup -path PATTERN -perm [+-]MODE -regex PATTERN
      -wholename PATTERN -size N[bcwkMG] -true -type [bcdpflsD] -uid N
      -used N -user NAME -xtype [bcdpfls]

actions: -delete -print0 -printf FORMAT -fprintf FILE FORMAT -print 
      -fprint0 FILE -fprint FILE -ls -fls FILE -prune -quit
      -exec COMMAND ; -exec COMMAND {} + -ok COMMAND ;
      -execdir COMMAND ; -execdir COMMAND {} + -okdir COMMAND ;
```

## Usage

```bash
find <file or folder>

```
## Examples

### Modified Files

List all recently modified files in a directory.

```bash
find [folder] -mtime <days>
find . -type f -mtime -20

```
### Find by Name

Find all files in all sub-directories by Name, Regular Expression, Wild Card.

```bash
find . -name '*.svg'

```
### Tree Command Emulator

```
find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g' > file_structure.txt
```

### Regex

```bash
ll -1d */pixel/*trans* | xargs -IX find -E X -regex '.*(.png|.jpg)' | wc -l

find . -regex '.*[0-9]\{8\}\.svg' | grep black | xargs -IX grep -HE 'Transcription' X

find /local/folder/ -name '*.svg' -printf "%A@,%h,%f\n"

find /local/folder/*6163*/ -regex ".+\.\(png\|svg\)" -printf "%h,%f,%A@\n" | sed -E "s/[^,]+_x([0-9]+)_f[^,]+,([^,]+),([^,\.]+)\..+/\1,\2,\3/"

find /local/folder/20*/ -regex ".+\.\(png\|svg\)" -printf "%h,%f,%A@\n" | sed -E "s/[^,]+f10\/([^,\/]+)[^,]+,([^,]+),([^,\.]+)\..+/\1,\2,\3/"

find /local/folder/*6163*/ -regex ".+\.\(png\|svg\)" -printf "%f,%c\n" | sed -E "s/([^,]+),([^,\.]+)\.[^ ]+ ([0-9]{4})/\1,\2 \3/"

```
= Windows XP =

## Examples

### File Count

Return the count of files in the current directory, excluding directories.
Note: the /V "" removes any blank lines that could appear.

```bash
dir /b /a-d | find /c /v ""


```
