# Negative Ping Time


== Windows XP Returns Negative Ping Times == 

After narrowing it down to the processor itself I started to put pressure on AMD for answers and was finally told to update the processor driver for all systems experiencing the problem. I did this at home last weekend and at work to almost a dozen servers and it has fixed the problem on ALL workstations and servers.

From my discussions with AMD I have pieced together the following likely issue with the dual core processors. It seems there is a timing issue between the two cores that slowly causes the timing to drift further and further apart between the two cores. This is why rebooting the machine temporarily fixes the syptoms; atleast for a couple of hours. The longer the system is up the worse the problem appears to get until simple tasks such as web browsing and copying files becomes untolerable.

Below is a link to AMD to get the latest processor driver which appears to correct the issue with the dual core processor.

**AMD Athlon™ 64 X2 Dual Core Processor Driver for Windows XP and Windows Server 2003**

[http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_871_13118,00.html](http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_871_13118,00.html)

For those that may feel this problem still resides on the network side I can only say in the past two months I have tried 5 different brand NICs (netgear, HP, linksys, d-link, and an older Compaq server NIC), 4 different switchs (Cisco 6513, Cisco 2950, Netgear, and D-Link), and tried a straight crossover cable between two computers and non had any affect on the problem. I have also experienced the problem on 3 different system boards (Compaq DL385, MSI K8N Neo4, and an Asus board. I have flashed the BIOS repeatedly on all these boards and the Neo4 ensured I was running the latest nForce4 drives. None of this troubleshooting has any affect on the problem.

In the past two or so months I have read about a lot of people having this problem but have not seen a fix for this posted anywhere so I am hoping this email can help at least one person save the months of meaningless troubleshooting I have to go through.

If you find this to be help full at solving your problem please take a minute to spread the word.

### BOOT.ini Solution

Microsoft Windows Server 2003 (any edition)  *(Could also apply to Windows XP AKA "Not Tested")*

- Edit the BOOT.ini file and add the parameter:

```bash
/usepmtimer

```
- Reboot the server.

Adding the "/usepmtimer" parameter to the BOOT.INI file configures the Windows operating system to use the PM_TIMER, rather than the Time Stamp Counter.

Note: When installing the AMD Opteron Processor with AMD PowerNow! Technology driver Version 1.3.2.16 (or later) from AMD, the BOOT.INI file will automatically be updated with the "/usepmtimer" parameter. While the driver itself does not resolve this issue, the installation process will make the necessary changes to the BOOT.INI file to prevent the issue from occurring.

== Sources == 

- http://h20000.www2.hp.com/bizsupport/TechSupport/Document.jsp?lang=en&cc=us&taskId=110&prodSeriesId=446006&prodTypeId=15351&objectID=c01075682
- Andrew ...

### Tags

AMD Dual Core CPU, Bug, Fix, Negative Pings, BOOT.ini

