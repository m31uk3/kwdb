# Remote User Discovery


## Summary

This is a simple explaination on how to determin the current user of a remote Windows system.

## Windows XP SP1 <

```bash
nbtstat -a <computername>

```
## Windows XP SP2 >

```bash
tasklist /v /s <computername> /fi "IMAGENAME eq explorer.exe"

```
or

```bash
qwinsta console /server:<computername>

```
## Task List

```bash
tasklist /s gbg-qcd-orange /fi "IMAGENAME eq firefox.exe"

```
