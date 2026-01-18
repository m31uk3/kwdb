# Windows XP Firewall


## Summary

XP Service pack 2 enables the firewall by default. 
I personally suggest you do not disable the firewall as it was put there for a reason but...

## Via Command Prompt

To turn the firewall Off

```bash
netsh firewall set opmode disable

```
To turn the firewall On

```bash
netsh firewall set opmode enable

```
