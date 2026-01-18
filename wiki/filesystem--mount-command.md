# Mount Command


### Mounting a Linux LVM volume
You do not mount a partition of type "Linux LVM" the same way you mount a partition using a standard Linux file system (e.g. ext2, ext3).

```bash
fdisk -l /dev/hda

```
Disk /dev/hda: 160.0 GB, 160041885696 bytes
255 heads, 63 sectors/track, 19457 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1   *           1          13      104391   83  Linux
/dev/hda2              14       19457   156183930   8e  Linux LVM
```

mount /dev/hda2 /tmp/mnt
mount: /dev/hda2 already mounted or /tmp/mnt busy

```
First, let's determine the volume group containing the physical volume /dev/hda2.

```bash
pvs

```
  PV         VG         Fmt  Attr PSize   PFree
  /dev/hda2  VolGroup01 lvm2 a-   148.94G 32.00M
  /dev/hdb2  VolGroup00 lvm2 a-   114.94G 96.00M
```

```
Next, let's list the logical volumes in VolGroup01.

```bash
lvdisplay /dev/VolGroup01

```
  --- Logical volume ---
  LV Name                /dev/VolGroup01/LogVol00
  VG Name                VolGroup01
  LV UUID                zOQogm-G8I7-a4WC-T7KI-AhWe-Ex3Y-JVzFcR
  LV Write Access        read/write
  LV Status              available
  # open                 0
  LV Size                146.97 GB
  Current LE             4703
  Segments               1
  Allocation             inherit
  Read ahead sectors     0
  Block device           253:2
  
  --- Logical volume ---
  LV Name                /dev/VolGroup01/LogVol01
  VG Name                VolGroup01
  LV UUID                araUBI-4eer-uh5L-Dvnr-3bI6-4gYg-APgYy2
  LV Write Access        read/write
  LV Status              available
  # open                 0
  LV Size                1.94 GB
  Current LE             62
  Segments               1
  Allocation             inherit
  Read ahead sectors     0
  Block device           253:3
```

```
The logical volume I would like to "mount" (in purely the computing-related sense) is /dev/VolGroup01/LogVol00. The other logical volume is a swap partition.

```bash
mount /dev/VolGroup01/LogVol00 /tmp/mnt

```
## Sources

- http://www.brandonhutchinson.com/

