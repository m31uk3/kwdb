# Linux Modules


To find a module in the kernel's module dir:
```bash
find /lib/modules/ -iname '*.ko' -or -iname '*.o' | grep fuse

```
Handy bash alias
```bash
alias locatemodule="find /lib/modules/$(uname -r) -iname '*.ko' -or -iname '*.o' | grep "

```
