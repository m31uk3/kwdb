# Proc


## Display Attached Hard Disks

```bash
# cat /proc/scsi/scsi

```
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD800JB-00JJ Rev: 05.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: _NEC     Model: DVD_RW ND-3500AG Rev: 2.16
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD3200KS-00P Rev: 21.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD1600JS-22M Rev: 02.0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
```

```
## Display CPU Information
 
```bash
# cat /proc/cpuinfo 

```
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2600+
stepping        : 0
cpu MHz         : 1913.164
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow up ts
bogomips        : 3828.18
clflush size    : 32
```
```
