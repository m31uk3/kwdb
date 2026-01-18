# DiskPart


## Overview

DiskPart.exe is a text-mode command interpreter that enables you to manage objects (disks, partitions, or volumes) by using scripts or direct input from a command prompt. Before you can use DiskPart.exe commands, you must first list, and then select the object to give it focus. When an object has focus, any DiskPart.exe commands that you type will act on that object.

You can list the available objects and determine an object's number or drive letter by using the list disk, list volume, and list partition commands. The list disk and list volume commands display all disks and volumes on the computer. However, the list partition command only displays partitions on the disk that has focus. When you use the list commands, an asterisk (*) appears next to the object with focus. You select an object by its number or drive letter, such as disk 0, partition 1, volume 3, or volume C.

When you select an object, the focus remains on that object until you select a different object. For example, if the focus is set on disk 0 and you select volume 8 on disk 2, the focus shifts from disk 0 to disk 2, volume 8. Some commands automatically change the focus. For example, when you create a new partition, the focus automatically switches to the new partition.

You can only give focus to a partition on the selected disk. When a partition has focus, the related volume (if any) also has focus. When a volume has focus, the related disk and partition also have focus if the volume maps to a single specific partition. If this is not the case, focus on the disk and partition is lost.

## DiskPart commands

### active

On basic disks, marks the partition with focus as active. This informs the basic input/output system (BIOS) or Extensible Firmware Interface (EFI) that the partition or volume is a valid system partition or system volume.

Only partitions can be marked as active.

**Important**

DiskPart verifies only that the partition is capable of containing the operating system startup files. DiskPart does not check the contents of the partition. If you mistakenly mark a partition as active and it does not contain the operating system startup files, your computer might not start.

**Syntax**
```bash
active

```
### add disk

Mirrors the simple volume with focus to the specified disk.

**Syntax**
```bash
add disk=N [noerr]

```
**Parameters**
```bash
N
```
Specifies a disk, other than the one containing the existing simple volume, to contain the mirror. You can mirror only simple volumes. The specified disk must have unallocated space at least as large as the size of the simple volume you want to mirror.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### assign

Assigns a drive letter or mount point to the volume with focus. If no drive letter or mount point is specified, the next available drive letter is assigned. If the drive letter or mount point is already in use, an error is generated.

By using the assign command, you can change the drive letter associated with a removable drive.

You cannot assign drive letters to system volumes, boot volumes, or volumes that contain the paging file. In addition, you cannot assign a drive letter to an Original Equipment Manufacturer (OEM) partition or any GUID Partition Table (GPT) partition other than a basic data partition.

**Syntax**
```bash
assign [{letter=D | mount=Path}] [noerr]

```
**Parameters**
```bash
letter=D
```
The drive letter you want to assign to the volume.
```bash
mount=Path
```
The mount point path you want to assign to the volume.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### attributes

Displays, sets, or clears volume attributes on the selected volume.

**Syntax**
```bash
attributesvolume [{set | clear}] [{hidden | readonly | nodefaultdriveletter | shadowcopy}] [noerr]

```
**Parameters**
```bash
attributes volume
```
Displays the attributes of the selected volume.
```bash
set
```
Sets the specified attribute (hidden, read-only, no default drive letter, or shadow copy volume) on the selected volume.
```bash
clear
```
Clears the specified attribute (hidden, read-only, no default drive letter, or shadow copy volume) from the selected volume.
```bash
hidden
```
Specifies that the volume is hidden.
```bash
readonly
```
Specifies that the volume is read-only.
```bash
nodefaultdriveletter
```
Specifies that the volume does not receive a drive letter by default.
```bash
shadowcopy
```
Specifies that the volume is a shadow copy volume.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### automount

When enabled (the default), Windows automatically mounts the file system for a new basic volume when it is added to the system and then assigns a drive letter to the volume. In system area network configurations, disabling automount prevents Windows from automatically mounting or assigning drive letters to any new basic volumes that are added to the system.

**Syntax**
```bash
automount [enable] [disable] [scrub] [noerr]

```
**Parameters**
```bash
enable
```
Enables Windows to automatically mount new basic volumes that are added to the system and to assign them drive letters.
```bash
disable
```
Prevents Windows from automatically mounting any new basic volumes that are added to the system.
```bash
scrub
```
Removes volume mount point directories and registry settings for volumes that are no longer in the system. This prevents volumes that were previously in the system from being automatically mounted and given their former volume mount point(s) when they are added back to the system.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### break disk

Applies to dynamic disks only. Breaks the mirrored volume with focus into two simple volumes. One simple volume retains the drive letter and any mount points of the mirrored volume. The other simple volume receives the focus so you can assign it a drive letter.

By default, the contents of both halves of the mirror are retained. Each half becomes a simple volume. By using the nokeep parameter, you retain only one half of the mirror as a simple volume, and the other half is deleted and converted to free space. Neither volume receives the focus.

**Syntax**
```bash
break disk=N [nokeep] [noerr]

```
**Parameters**
```bash
N
```
Specifies the disk that contains the mirrored volume. This disk is given focus and does not retain the drive letter or any mount points. If the specified disk is the current system or boot disk, the command fails.
```bash
nokeep
```
Specifies that only one of the mirrored volumes is retained; the simple volume, N, is deleted and converted to free space. Neither the volume nor the free space receives the focus.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### clean

Removes any and all partition or volume formatting from the disk with focus. On master boot record (MBR) disks, only the MBR partitioning information and hidden sector information are overwritten. On GUID Partition Table (GPT) disks, the GPT partitioning information, including the Protective MBR, is overwritten. There is no hidden sector information.

**Syntax**
```bash
clean [all]

```
**Parameters**
```bash
all
```
Specifies that each and every sector on the disk is set to zero, which completely deletes all data contained on the disk.

### convert basic

Converts an empty dynamic disk to a basic disk.

**Important**

The disk must be empty to convert it to a dynamic disk. Back up your data, and then delete all partitions or volumes before converting the disk.

**Syntax**
```bash
convert basic [noerr]

```
**Parameters**
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### convert dynamic

Converts a basic disk into a dynamic disk. Any existing partitions on the disk become simple volumes.

**Syntax**
```bash
convert dynamic [noerr]

```
**Parameters**
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### convert gpt

Converts an empty basic disk with the master boot record (MBR) partition style into a basic disk with the GUID partition table (GPT) partition style.

**Important**

The disk must be empty to convert it to a GPT disk. Back up your data, and then delete all partitions or volumes before converting the disk.

**Syntax**
```bash
convert gpt [noerr]

```
**Parameters**
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### convert mbr

Converts an empty basic disk with the GUID Partition Table (GPT) partition style to a basic disk with the master boot record (MBR) partition style.

**Important**


The disk must be empty to convert it to an MBR disk. Back up your data, and then delete all partitions or volumes before converting the disk.

**Syntax**
```bash
convert mbr [noerr]

```
**Parameters**
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### create partition efi

On Itanium-based computers, creates an Extensible Firmware Interface (EFI) system partition on a GUID Partition Table (GPT) disk. After the partition has been created, the focus is given to the new partition.

**Syntax**
```bash
create partition efi [size=N] [offset=N] [noerr]

```
**Parameters**
```bash
size=N
```
The size of the partition in megabytes (MB). If no size is given, the partition continues until there is no more free space in the current region.
```bash
offset= N
```
The byte offset at which the partition is created. If no offset is given, the partition is placed in the first disk extent that is large enough to hold it.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### create partition extended

Creates an extended partition on the current drive. After the partition has been created, the focus automatically shifts to the new partition. Only one extended partition can be created per disk. This command fails if you attempt to create an extended partition within another extended partition. You must create an extended partition before you can create logical drives.

**Syntax**
```bash
create partition extended [size=N] [offset=N] [noerr]

```
**Parameters**
```bash
size=N
```
The size of the extended partition in megabytes (MB). If no size is given, the partition continues until there is no more free space in the region. The size is cylinder snapped. The size is rounded to the closest cylinder boundary. For example, if you specify a size of 500 MB, the partition would be rounded up to 504 MB.
```bash
offset=N
```
Applies to master boot record (MBR) disks only. The byte offset at which the extended partition is created. If no offset is given, the partition will start at the beginning of the first free space on the disk. The offset is cylinder snapped. The offset is rounded to the closest cylinder boundary. For example, if you specify an offset that is 27 MB and the cylinder size is 8 MB, the offset is rounded to the 24 MB boundary.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### create partition logical

Creates a logical drive in the extended partition. After the partition has been created, the focus automatically shifts to the new logical drive.

**Syntax**
```bash
create partition logical [size=N] [offset=N] [noerr]

```
**Parameters**
```bash
size=N
```
The size of the logical drive in megabytes (MB). If no size is given, the partition continues until there is no more free space in the current region. The size is cylinder snapped. The size is rounded to the closest cylinder boundary. For example, if you specify a size of 500 MB, the partition would be rounded up to 504 MB.
```bash
offset=N
```
Applies to master boot record (MBR) disks only. The byte offset at which the logical drive is created. The offset is cylinder snapped (that is, the offset is rounded up to completely fill whatever cylinder size is being used). If no offset is given, then the partition is placed in the first disk extent that is large enough to hold it. The partition is at least as long in bytes as the number specified by size=N. If you specify a size for the logical drive, it must be smaller than the extended partition.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### create partition msr

Creates a Microsoft Reserved (MSR) partition on a GUID Partition Table (GPT) disk.

**Caution**

Be very careful when using the create partition msr command. Because GPT disks require a specific partition layout, creating Microsoft reserved partitions could cause the disk to become unreadable. On GPT disks that are used to start Windows XP 64-bit Edition (Itanium), the EFI System partition is the first partition on the disk, followed by the Microsoft Reserved partition. GPT disks used only for data storage do not have an EFI System partition; the Microsoft Reserved partition is the first partition.

Windows XP 64-bit Edition (Itanium) does not mount Microsoft reserved partitions. You cannot store data on them and you cannot delete them.

**Syntax**
```bash
create partition msr [size=N] [offset=N] [noerr]

```
**Parameters**
```bash
size=N
```
The size of the partition in megabytes (MB). The partition is at least as long in bytes as the number specified by size=N. If no size is given, the partition continues until there is no more free space in the current region.
```bash
offset=N
```
The byte offset at which to create the partition. The partition starts at the byte offset specified by offset=N. It is sector snapped; that is, the offset is rounded up to completely fill whatever sector size is being used. If no offset is given, the partition is placed in the first disk extent that is large enough to hold it.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### create partition primary

Creates a primary partition on the current basic disk. After you create the partition, the focus automatically shifts to the new partition. The partition does not receive a drive letter. You must use the assign command to assign a drive letter to the partition.

**Syntax**
```bash
create partition primary [size=N] [offset=N] [ID={Byte | GUID}] [align=N] [noerr]

```
**Parameters**
```bash
size=N

```
The size of the partition in megabytes (MB). If no size is given, the partition continues until there is no more unallocated space in the current region. The size is cylinder snapped. The size is rounded to the closest cylinder boundary. For example, if you specify a size of 500 MB, the partition is rounded up to 504 MB.
```bash
offset=N
```
The byte offset at which to create the partition. If no offset is given, the partition will start at the beginning of the first free space on the disk. For master boot record (MBR) disks, the offset is cylinder snapped. The offset is rounded to the closest cylinder boundary. For example, if you specify an offset that is 27 MB and the cylinder size is 8 MB, the offset is rounded to the 24 MB boundary.
```bash
ID={ Byte| GUID}
```
Intended for Original Equipment Manufacturer (OEM) use only. CautionCreating partitions with this parameter might cause your computer to fail or be unable to start up. Unless you are an OEM or an IT professional experienced with GPT disks, do not create partitions on GPT disks using the ID={Byte | GUID} parameter. Instead, always use the create partition efi command to create EFI System partitions, the create partition msr command to create Microsoft Reserved partitions, and the create partition primary command (without the ID={Byte | GUID} parameter) to create primary partitions on GPT disks.For MBR disks, you can specify a partition type byte, in hexadecimal form, for the partition. If no partition type byte is specified on an MBR disk, the create partition primary command creates a partition of type 0x6. Any partition type byte can be specified with the ID={Byte | GUID} parameter. DiskPart does not check the partition type byte for validity, nor does it perform any other checking of the ID parameter.For GPT disks you can specify a partition type GUID for the partition you want to create:EFI System partition: c12a7328-f81f-11d2-ba4b-00a0c93ec93bMicrosoft reserved partition: e3c9e316-0b5c-4db8-817d-f92df00215aeBasic data partition: ebd0a0a2-b9e5-4433-87c0-68b6b72699c7LDM Metadata partition on a dynamic disk: 5808c8aa-7e8f-42e0-85d2-e1e90434cfb3LDM Data partition on a dynamic disk: af9b60a0-1431-4f62-bc68-3311714a69adIf no partition type GUID is specified, the create partition primary command creates a basic data partition. Any partition type can be specified with the ID={Byte | GUID} parameter. DiskPart does not check the partition GUID for validity, nor does it perform any other checking of the ID parameter.
```bash
align=N
```
Typically used with hardware RAID Logical Unit Number (LUN) arrays to improve performance when the logical units (LUs) are not cylinder aligned. Aligns a primary partition that is not cylinder aligned at the beginning of a disk and rounds the offset to the closest alignment boundary, where N is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary. The align=N command fails if the primary partition is not at the beginning of the disk. If used with offset=N, the offset is within the first usable cylinder on the disk.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### create volume raid

Creates a RAID-5 volume using three or more specified dynamic disks. After you create the volume, the focus automatically shifts to the new volume.

**Syntax**
```bash
create volume raid [size=N] disk=N,N,N[,N,...] [noerr]

```
**Parameters**
```bash
size=N
```
The amount of disk space, in megabytes (MB), that the volume will occupy on each disk. If no size is given, the largest possible RAID-5 volume will be created. The disk with the smallest available contiguous free space determines the size for the RAID-5 volume and the same amount of space is allocated from each disk. The actual amount of usable disk space in the RAID-5 volume is less than the combined amount of disk space because some of the disk space is required for parity.
```bash
disk=N,N,N[ ,N,...]
```
The dynamic disks on which to create the RAID-5 volume. You need at least three dynamic disks in order to create a RAID-5 volume. An amount of space equal to size=N is allocated on each disk.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### create volume simple

Creates a simple volume. After you create the volume, the focus automatically shifts to the new volume.

**Syntax**
```bash
create volume simple [size=N] [disk=N] [noerr]

```
**Parameters**
```bash
size=N
```
The size of the volume in megabytes (MB). If no size is given, the new volume takes up the remaining free space on the disk.
```bash
disk=N
```
The dynamic disk on which the volume is created. If no disk is given, the current disk is used.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### create volume stripe

Creates a striped volume using two or more specified dynamic disks. After you create the volume, the focus automatically shifts to the new volume.

**Syntax**
```bash
create volume stripe [size=N] disk=N,N[,N,...] [noerr]

```
**Parameters**
```bash
size=N
```
The amount of disk space, in megabytes (MB), that the volume will occupy on each disk. If no size is given, the new volume takes up the remaining free space on the smallest disk and an equal amount of space on each subsequent disk.
```bash
disk=N,N[ ,N,...]
```
The dynamic disks on which the striped volume is created. You need at least two dynamic disks to create a striped volume. An amount of space equal to size=N is allocated on each disk.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### delete disk

Deletes a missing dynamic disk from the disk list.

**Syntax**
```bash
delete disk [noerr] [override]

```
**Parameters**
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.
```bash
override
```
Enables DiskPart to delete all simple volumes on the disk. If the disk contains half of a mirrored volume, the half of the mirror on the disk is deleted. The delete disk override command fails if the disk is a member of a RAID-5 volume.

### delete partition

On a basic disk, deletes the partition with focus. You cannot delete the system partition, boot partition, or any partition that contains the active paging file or crash dump (memory dump).

**Caution**

Deleting a partition on a dynamic disk can delete all dynamic volumes on the disk, thus destroying any data and leaving the disk in a corrupt state. To delete a dynamic volume, always use the delete volume command instead.

Partitions can be deleted from dynamic disks, but they should not be created. For example, it is possible to delete an unrecognized GUID Partition Table (GPT) partition on a dynamic GPT disk. Deleting such a partition does not cause the resulting free space to become available. This command is intended to allow reclamation of the space on a corrupted offline dynamic disk in an emergency situation where the clean command cannot be used.

**Syntax**
```bash
delete partition [noerr] [override]

```
**Parameters**
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.
```bash
override
```
Enables DiskPart to delete any partition regardless of type. Typically, DiskPart only permits you to delete known data partitions.

### delete volume

Deletes the selected volume. You cannot delete the system volume, boot volume, or any volume that contains the active paging file or crash dump (memory dump).

**Syntax**
```bash
delete volume [noerr]

```
**Parameters**
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### detail disk

Displays the properties of the selected disk and the volumes on that disk.

**Syntax**
```bash
detail disk

```
### detail partition

Displays the properties of the selected partition.

**Syntax**
```bash
detail partition

```
### detail volume

Displays the disks on which the current volume resides.

**Syntax**
```bash
detail volume

```
### exit

Exits the DiskPart command interpreter.

**Syntax**
```bash
exit

```
### extend

Extends the volume with focus into next contiguous unallocated space. For basic volumes, the unallocated space must be on the same disk as the partition with focus. It must also follow (be of higher sector offset than) the partition with focus. A dynamic simple or spanned volume can be extended to any empty space on any dynamic disk. Using this command, you can extend an existing volume into newly created space.

If the partition was previously formatted with the NTFS file system, the file system is automatically extended to occupy the larger partition. No data loss occurs. If the partition was previously formatted with any file system format other than NTFS, the command fails with no change to the partition.

You cannot extend the current system or boot partitions.

**Syntax**
```bash
extend [size=N] [disk=N] [noerr]

```
extendfilesystem [noerr]

**Parameters**
```bash
size=N
```
The amount of space in megabytes (MB) to add to the current partition. If no size is given, the disk is extended to take up all of the next contiguous unallocated space.
```bash
disk=N
```
The dynamic disk on which the volume is extended. An amount of space equal to size=N is allocated on the disk. If no disk is specified, the volume is extended on the current disk.
```bash
filesystem
```
For use only on disks where the file system was not extended with the volume. Extends the file system of the volume with focus so that the file system occupies the entire volume.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### gpt attributes

On basic GPT disks, assigns the GPT attribute(s) to the partition with focus. GPT partition attributes give additional information about the use of the partition. Some attributes are specific to the partition type GUID.

**Important**

Changing the GPT attributes might cause your basic data volumes to be unmountable or fail to be assigned drive letters. Unless you are an original equipment manufacturer (OEM) or an IT professional experienced with GPT disks, do not change GPT attributes.

**Syntax**
```bash
gpt attributes=N

```
**Parameters**
```bash
N
```
The hexadecimal that pertains to the attribute that you want to apply to the partition with focus. The GPT attribute field is a 64-bit field that contains two subfields. The higher field is interpreted only in the context of the partition ID, while the lower field is common to all partition IDs. All partitions have the following attribute:0x0000000000000001 marks the partition as required. This indicates to all disk management utilities that the partition should not be deleted. The EFI System partition contains only those binaries necessary to start the operating system. This makes it easy for OEM- or operating system-specific binaries to be placed in other partitions.For basic data partitions, the following attribute is defined:0x8000000000000000 prevents the partition from having a drive letter automatically assigned. By default, each partition is assigned a new drive letter. Setting this attribute ensures that when a disk is moved to a new computer, a new drive letter will not be automatically generated. Instead, the user can manually assign drive letters.NoteOther attributes can be added at any time.

### help

Displays a list of the available commands.

**Syntax**
```bash
help

```
### import

Imports a foreign disk group into the local computer's disk group. The import command imports every disk that is in the same group as the disk that has focus.

**Syntax**
```bash
import [noerr]

```
**Parameters**
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### inactive

On basic master boot record (MBR) disks, marks the system partition or boot partition with focus as inactive. The computer starts from the next option specified in the BIOS such as the CD-ROM drive or a Pre-Boot eXecution Environment (PXE)-based boot environment (such as Remote Installation Services (RIS)) when you restart the computer.

**Caution**

Your computer might not start without an active partition. Do not mark a system or boot partition as inactive unless you are an experienced user with a thorough understanding of Windows Server 2003 operating systems.

If you are unable to start your computer after marking the system or boot partition as inactive, insert the Setup CD in the CD-ROM drive, restart the computer, and then repair the partition using the Fixmbr and Fixboot commands in the Recovery Console. For more information about the Recovery Console, see Recovery Console overview [http://technet2.microsoft.com/WindowsServer/en/library/4700f5e7-da28-4d5d-b416-09d4cd1502a21033.mspx] and Recovery Console commands [http://technet2.microsoft.com/WindowsServer/en/library/077c1abc-c1d3-4d48-8ae8-1e9c38c6a90e1033.mspx].

**Syntax**
```bash
inactive

```
**Example**
```
DISKPART> select disk 1

Disk 1 is now the selected disk.

DISKPART> list partition

  Partition ###  Type              Size     Offset
  -------------  ----------------  -------  -------
  Partition 1    Primary            233 GB    32 KB

DISKPART> select partition 1

Partition 1 is now the selected partition.

DISKPART> inactive

DiskPart marked the current partition as inactive.
```

### list disk

Displays a list of disks and information about them, such as their size, amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the master boot record (MBR) or GUID partition table (GPT) partition style. The disk marked with an asterisk (*) has focus.

**Syntax**
```bash
list disk

```
### list partition

Displays the partitions listed in the partition table of the current disk. On dynamic disks, these partitions may not correspond to the dynamic volumes on the disk. This discrepancy occurs because dynamic disks contain entries in the partition table for the system volume or boot volume (if present on the disk). They also contain a partition that occupies the remainder of the disk in order to reserve the space for use by dynamic volumes.

**Syntax**
```bash
list partition

```
### list volume

Displays a list of basic and dynamic volumes on all disks.

**Syntax**
```bash
list volume

```
### online

Brings an offline disk or a volume with focus online. Resynchronizes the mirrored or RAID-5 volume with focus.

**Syntax**
```bash
online [noerr]

```
**Parameters**
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### rem

Provides a way to add comments to a script.

**Syntax**
```bash
rem

```
**Examples**

In this example script, rem is used to provide a comment about what the script does.

```
rem These commands set up 3 drives.

create partition primary size=2048

assign d:

create partition extend

create partition logical size=2048

assign e:

create partition logical

assign f:
```

### remove

Removes a drive letter or mount point from the volume with focus. If no drive letter or mount point is specified, DiskPart removes the first drive letter or mount point it encounters. If the all parameter is used, all current drive letters and mount points are removed. If the dismount parameter is used, DiskPart closes all open handles to the volume and then dismounts it.

The remove command can be used to change the drive letter associated with a removable drive. You cannot remove the drive letters on system, boot, or paging volumes. In addition, you cannot remove the drive letter for an OEM partition, any GPT partition with an unrecognized GUID, or any of the special, non-data, GPT partitions such as the EFI system partition.

**Syntax**
```bash
remove [{letter=D | mount=Path | all}] [dismount] [noerr]

```
**Parameters**
```bash
letter=D
```
The drive letter to be removed.
```bash
mount=Path
```
The mount point path to be removed.
```bash
all
```
Removes all current drive letters and mount points.
```bash
dismount
```
Dismounts the basic volume, when all drive letters and mount points have been removed from the volume, and takes the basic volume offline, making it unmountable. If other processes are using the volume, DiskPart closes any open handles before dismounting the volume. You can make the volume mountable by assigning it a driver letter or by creating a mount point path to the volume. Dismount will fail if used on a volume that has any remaining drive letters or mount points. For scripting, using remove all dismount is recommended.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### repair disk

Repairs the RAID-5 volume with focus by replacing the failed RAID-5 member with the specified dynamic disk. The specified dynamic disk must have free space greater than or equal to the total size of the failed RAID-5 member.

**Syntax**
```bash
repair disk=N [noerr]

```
**Parameters**
```bash
N
```
Specifies the dynamic disk that will replace the failed RAID-5 member. The specified disk must have free space equal to or larger than the total size of the failed RAID-5 member.
```bash
noerr
```
For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code.

### rescan

Locates new disks that may have been added to the computer.

**Syntax**
```bash
rescan

```
### retain

Prepares an existing dynamic simple volume to be used as a boot or system volume.

Creates a partition entry in the master boot record (MBR) on the dynamic simple volume with focus. To create an MBR partition, the dynamic simple volume must start at a cylinder-aligned offset and be an integral number of cylinders in size.

Creates a partition entry in the GUID partition table (GPT) on the dynamic simple volume with focus.

**Syntax**
```bash
retain

```
### select disk

Selects the specified disk and shifts the focus to it.

**Syntax**
```bash
select disk=[N]

```
**Parameters**
```bash
N
```
The disk number of the disk to receive focus. If no disk number is specified, the select command lists the disk that currently has the focus. You can view the numbers for all disks on the computer by using the list disk command.

### select partition

Selects the specified partition and gives it focus. If no partition is specified, the select command lists the current partition with focus. You can specify the partition by its number. You can view the numbers of all partitions on the current disk by using the list partition command. You must first select a disk using the DiskPart select disk command before you can select a partition.

**Syntax**
```bash
select partition=[N]

```
**Parameters**
```bash
N
```
The number of the partition to receive the focus.

### select volume

Selects the specified volume and gives it focus. If no volume is specified, the select command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point path. On a basic disk, selecting a volume also gives the corresponding partition focus. You can view the numbers of all volumes on the computer by using the list volume command.

**Syntax**
```bash
select volume=[{N | D}]

```
**Parameters**
```bash
N
```
The number of the volume to receive the focus.
```bash
D
```
The drive letter or mount point path of the volume to receive the focus.

## DiskPart scripting

Using DiskPart, you can create scripts to automate disk-related tasks, such as creating volumes or converting basic disks into dynamic disks. Scripting these tasks is useful if you are deploying Windows by using unattended Setup or Sysprep, which do not support creating volumes other than the boot volume. In addition, you can direct the output from a script to a text file. The script output, which consists of messages that describe whether the tasks performed by DiskPart were successful, can be useful when you are trying to debug a script.

**Important**

When using the DiskPart command as a part of a script, it is recommended that you complete all of the DiskPart operations together as part of a single DiskPart script. You can run consecutive DiskPart scripts, but you must allow at least 15 seconds between each script for a complete shutdown of the previous execution before running the DiskPart command again in successive scripts. Otherwise, the successive scripts might fail. You can add a pause between consecutive DiskPart scripts by adding the timeout /t 15 command to your batch file along with your DiskPart scripts.

### Creating and running a script

You can use Notepad to create a DiskPart script file by entering DiskPart commands, one per line. A DiskPart script file is a text file with a .txt extension. For example, you could create a simple two-line script called simple_volume.txt, which creates a simple volume on a dynamic disk and then assigns a drive letter to the volume:

Using this script, DiskPart would create a 3 GB simple volume on disk 2 (an existing dynamic disk) and assign that volume drive letter G.

To run a DiskPart script, at the command prompt, change to the directory where the script file is located and then type:

```bash
diskpart /sScriptName.txt

```
Where ScriptName.txt is the name of the text file that contains your script, for example, simple_volume.txt.

To redirect a DiskPart script’s output to a text file, type:

```bash
diskpart /sScriptName.txt > LogFile.txt

```
Where LogFile.txt is the name of the text file where DiskPart writes the output.

When DiskPart starts, the DiskPart version and computer name are displayed at the command prompt. By default, if DiskPart encounters an error while attempting to perform a scripted task, DiskPart stops processing the script and displays an error message (unless you specified the noerr parameter). DiskPart, however, always returns errors when it encounters syntax errors, regardless of whether you used the noerr parameter. The noerr parameter enables you to perform useful tasks. For example, you can use a single script to delete all partitions on all disks regardless of the total number of disks.

### DiskPart error codes

Error	Description

- 0 = No errors occurred. The entire script ran without failure.

- 1 = A fatal exception occurred. There may be a serious problem.

- 2 = The parameters specified for a DiskPart command were incorrect.

- 3 = DiskPart was unable to open the specified script or output file.

- 4 = One of the services DiskPart uses returned a failure.

- 5 = A command syntax error occurred. The script failed because an object was improperly selected or was invalid for use with that command.

### Formatting legend

- Italic = Information that the user must supply

- Bold = Elements that the user must type exactly as shown

- Ellipsis (...) = Parameter that can be repeated several times in a command line

- Between brackets ([]) = Optional items

- Between braces ({}); choices separated by pipe (|). Example: {even|odd} = Set of choices from which the user must choose only one

- Courier font = Code or program output

= Sources =

- http://technet2.microsoft.com/windowsserver/en/library/ca099518-dde5-4eac-a1f1-38eff6e3e5091033.mspx?mfr=true

= Tags =

Set partition active, Set partition inactive, diskpart, disk part, partition management

