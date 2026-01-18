# History Command


**history** -- Linux/Unix/Mac OS X find command

## Introduction

You can use **history** to view a list of the commands executed during the current $SHEL session. It is very helpful when are you are typing a lot of complex commands.

## Syntax

lazy....

## Usage

```bash
usage: history [-c] [-d offset] [n] or history -awrn [filename] or history -ps arg [arg...]

```
## Examples

### List All Entries without line numbers
```bash
history -w /dev/stdout

```
### Extract all history commands at end-of-session (EOS)
```bash
history -w /dev/stdout > history_EOS_`date +%a_%b_%d_%F_%T`.txt

```
### List All Entries

```bash
history

```
### Execute Entry

```bash
!<offset>

```
### Delete Entry

```bash
history -d <offset>

```
### Delete last N lines from bash history
```bash
for i in {1..50}; do history -d 1030; done


```
