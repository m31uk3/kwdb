# Linux DNS


## Named

Allow host to query (relay) internet domain name resolution:

```bash
recursion yes;
allow-query { 192.168.1.0/24; 127.0.0.1;};
allow-recursion { 192.168.1.0/24; 127.0.0.1;};

```
