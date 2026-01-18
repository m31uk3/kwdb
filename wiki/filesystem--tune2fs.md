# Tune2fs


## Where did my free space go on my ext3 partition?

After freshly formating a 750GB (688GB) hard disk I noticed the following output:

```
Filesystem            Size  Used Avail Use% Mounted on
/dev/sde1             688G  198M  653G   1% /ol-storage
[root@server.com ~]# 
```

So where did roughly 40GB of my hard disk disappear to?

### Reserved Blocks Percentage

-m reserved-blocks-percentage

Set the percentage of the  filesystem  which  may  only  be  allocated  by  privileged processes. Reserving some  number  of  filesystem  blocks  for  use by privileged processes is done to avoid filesystem fragmentation, and to allow system daemons, such as syslogd(8), to continue to function correctly after non-privileged processes are prevented from writing to the filesystem. **Normally, the default percentage of reserved blocks is 5%.**

### Change Reserved Blocks Percentage

Using the -m option of the tune2fs command below will allow you to specify the percentage of blocks you wish to reserve. For external disks and any other disk which won't be running any processes it's save to set this lower than the default of 5%.

```bash
tune2fs -m 1 /dev/sde1

```
[root@server.com ~]# tune2fs -m 1 /dev/sde1
tune2fs 1.40.2 (12-Jul-2007)
Setting reserved blocks percentage to 1% (1831430 blocks)
```

```
And based upon the output below you can see that the missing space is now available.

```
Filesystem            Size  Used Avail Use% Mounted on
/dev/sde1             688G  198M  681G   1% /ol-storage
[root@server.com ~]# 
```
