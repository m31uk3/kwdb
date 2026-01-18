# Vi Command


**vi** -- Linux/Unix/Mac OS X Basic Text Editor

## Introduction

You can use **vi** to edit files via SHELL. It is very helpful when are you are managing a system remotely.

## Usage

```
usage: vim [arguments] [file ..]       edit specified file(s)
   or: vim [arguments] -               read text from stdin
   or: vim [arguments] -t tag          edit file where tag is defined
   or: vim [arguments] -q [errorfile]  edit file with first error
```

### General Startup

To use vi: vi filename
To exit vi and save changes: ZZ   or  :wq
To exit vi without saving changes: :q!
To enter vi command mode: [esc]

### Counts

A number preceding any vi command tells vi to repeat that command that many times.

### Cursor Movement

h - move left (backspace)

j - move down

k - move up

l - move right (spacebar)

[return] - move to the beginning of the next line

$ - last column on the current line

0 - move cursor to the first column on the current line

^ - move cursor to first nonblank column on the current line

w - move to the beginning of the next word or punctuation mark

W - move past the next space

b - move to the beginning of the previous word or punctuation mark

B - move to the beginning of the previous word, ignores punctuation

e - end of next word or punctuation mark

E - end of next word, ignoring punctuation

H - move cursor to the top of the screen 

M - move cursor to the middle of the screen

L - move cursor to the bottom of the screen 

### Screen Movement

G -  move to the last line in the file

xG - move to line x

z+ - move current line to top of screen

z -  move current line to the middle of screen

z- - move current line to the bottom of screen

^F - move forward one screen

^B - move backward one line

^D - move forward one half screen

^U - move backward one half screen

^R - redraw screen ( does not work with VT100 type terminals )

^L - redraw screen ( does not work with Televideo terminals )

### Inserting

r -  replace character under cursor with next character typed

R -  keep replacing character until [esc] is hit

i -  insert before cursor

a -  append after cursor

A -  append at end of line

O -  open line above cursor and enter append mode

### Deleting

x - delete character under cursor

dd - delete line under cursor

dw - delete word under cursor

db - delete word before cursor

### Copying Code

yy - (yank)'copies' line which may then be put by the p(put) command. Precede with a count for multiple lines.

### Put Command

Brings back previous deletion or yank of lines, words, or characters

P - bring back before cursor

p - bring back after cursor

### Find Commands

? - finds a word going backwards

/ - finds a word going forwards

f - finds a character on the line under the cursor going forward

F - finds a character on the line under the cursor going backwards

t - find a character on the current line going forward and stop one character before it

T - find a character on the current line going backward and stop one character before it

<nowiki>; - repeat last f, F, t, T</nowiki>

### Miscellaneous Commands

.	- repeat last command

u	- undoes last command issued

U	- undoes all commands on one line

xp - deletes first character and inserts after second (swap)

J - join current line with the next line

^G - display current line number

% - if at one parenthesis, will jump to its mate

mx - mark current line with character x

'x - find line marked with character x

NOTE: Marks are internal and not written to the file.

### Line Editor Mode

Any commands form the line editor ex can be issued upon entering line mode.

To enter: type ':'

To exit: press[return] or [esc]

ex Commands
For a complete list consult the UNIX Programmer's Manual

### READING FILES

Copies (reads) filename after cursor in file currently editing

```bash
:r filename

```
### WRITE FILE

saves the current file without quitting

```bash
:w

```
### MOVING

move to line #

```bash
:#

```
move to last line of file

```bash
:$

```
### SHELL ESCAPE

Executes 'cmd' as a shell command.

```bash
:!'cmd'

```
## Arguments

```
--                   Only file names after this
-v                   Vi mode (like "vi")
-e                   Ex mode (like "ex")
-s                   Silent (batch) mode (only for "ex")
-d                   Diff mode (like "vimdiff")
-y                   Easy mode (like "evim", modeless)
-R                   Readonly mode (like "view")
-Z                   Restricted mode (like "rvim")
-m                   Modifications (writing files) not allowed
-M                   Modifications in text not allowed
-b                   Binary mode
-l                   Lisp mode
-C                   Compatible with Vi: 'compatible'
-N                   Not fully Vi compatible: 'nocompatible'
-V[N]                Verbose level
-D                   Debugging mode
-n                   No swap file, use memory only
-r                   List swap files and exit
-r (with file name)  Recover crashed session
-L                   Same as -r
-T <terminal>        Set terminal type to <terminal>
-u <vimrc>           Use <vimrc> instead of any .vimrc
--noplugin           Don't load plugin scripts
-o[N]                Open N windows (default: one for each file)
-O[N]                Like -o but split vertically
   +                    Start at end of file
   +<lnum>              Start at line <lnum>
--cmd <command>      Execute <command> before loading any vimrc file
-c <command>         Execute <command> after loading the first file
-S <session>         Source file <session> after loading the first file
-s <scriptin>        Read Normal mode commands from file <scriptin>
-w <scriptout>       Append all typed commands to file <scriptout>
-W <scriptout>       Write all typed commands to file <scriptout>
-x                   Edit encrypted files
-i <viminfo>         Use <viminfo> instead of .viminfo
-h  or  --help       Print Help (this message) and exit
--version            Print version information and exit
```

## Examples

### Show Line Numbers

While editing a document (and not inserting text), type the following to turn on line numbers:

```bash
:set number

```
If you tire of the line numbers, enter the following command to turn them off:

```bash
:set nonumber

```
## Sources

- http://www.cs.rit.edu/~cslab/vi.html
- http://www.lagmonster.org/docs/vi.html#motion

