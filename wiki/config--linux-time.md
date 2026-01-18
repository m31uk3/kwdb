# Linux Time


## Convert Unix Timstamp

Sometimes a program/tool prints its time information in unix timestamps. Unix timestamps are the seconds after 01/01/1970.
This is usually unreadable by humans.

To convert this timestamp into something readable, copy the following small script into a searchable path and make it executable.

```
#!/bin/awk -f   
{ print strftime("%c", $0); }
```

Call the tool with the following command:

```bash
echo "your timestamp" | scriptname

```
You'll get an response according to your local timezone.
Example:

```
$ date +%s   
1098181096   
$ echo "1098181096" | convertunixtime   
Tue Oct 19 12:18:16 2004
```

## Sources

- http://www.linuxhowtos.org/Tips%20and%20Tricks/converting_unixtimestamp.htm

