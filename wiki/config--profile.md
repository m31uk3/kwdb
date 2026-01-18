# .profile


```
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin
PIT=72.22.16.230
GBG=71.240.126.32

# Command Aliases
alias ll='ls -lGh'
alias updatedb='/usr/libexec/locate.updatedb'
alias ssh-pitt='ssh root@$PIT -p 2222'
alias ssh-gbg='ssh root@$GBG -p 2222'
alias word='sed `perl -e "print int rand(99999)"`"q;d" /usr/share/dict/words'
```

