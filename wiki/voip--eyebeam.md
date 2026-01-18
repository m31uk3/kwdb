# Eyebeam


## Hidden Menus

The advanced settings menu has a few settings that you may want to look at.

Dial ***7469 (send)
and filter for system
find the lines:

- system:network:fw_force_ip
- system:network:fw_force_settings
- system:network:fw_force_fw_type


Changing force settings to 1 will allow you to specify an IP in the force_ip line.
(You change a setting by double clicking on the line)

Changing the FW type may help as well:

- 0 - Non symmetric
- 1 - Port restricted
- 2 - Symmetric
- 3 - Blocked
- 4 - Unknown 

## tcpdump results

It is clear to see that the asterisk server is receiving the packets from the phone but the server is then sending them to the internal ip address of the phone as apposed to the vpn address.

```
21:18:21.331703 IP 172.20.123.202.7804 > 172.20.1.6.5060: UDP, length 552
21:18:21.331821 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 469
21:18:21.331841 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 534
21:18:25.932692 IP 172.20.123.202.7804 > 172.20.1.6.5060: UDP, length 552
21:18:25.932903 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 469
21:18:25.932942 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 534
21:18:26.443657 IP 172.20.123.202.7804 > 172.20.1.6.5060: UDP, length 552
21:18:26.443816 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 469
21:18:26.443857 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 534
21:18:27.486369 IP 172.20.123.202.7804 > 172.20.1.6.5060: UDP, length 552
21:18:27.486505 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 469
21:18:27.486555 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 534
21:18:29.448540 IP 172.20.123.202.7804 > 172.20.1.6.5060: UDP, length 552
21:18:29.448698 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 469
21:18:29.448738 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 534
21:18:33.502700 IP 172.20.123.202.7804 > 172.20.1.6.5060: UDP, length 552
21:18:33.502857 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 469
21:18:33.502902 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 534
21:18:37.510222 IP 172.20.123.202.7804 > 172.20.1.6.5060: UDP, length 552
21:18:37.510363 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 469
21:18:37.510404 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 534
21:18:41.549545 IP 172.20.123.202.7804 > 172.20.1.6.5060: UDP, length 552
21:18:41.549701 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 469
21:18:41.549743 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 534
21:18:45.614937 IP 172.20.123.202.7804 > 172.20.1.6.5060: UDP, length 552
21:18:45.615095 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 469
21:18:45.615136 IP 172.20.1.6.5060 > 192.168.85.111.7804: UDP, length 534
```

## Research

Platform Mac OS X 10.4.10 PowerPC

Software Version: 1.5.16.6 RC2 release 1014g build 44939

Does not work via VPN

settings.cps
```
    <section name="network">
      <setting name="auto_detect_ip" value="0"/>
      <setting name="fw_force_fw_type" value="1"/>
      <setting name="fw_force_fw_type_hairpin" value="0"/>
      <setting name="fw_force_ip" value="172.20.123.202"/>
      <setting name="fw_force_settings" value="0"/>
      <setting name="local_ip" value="172.20.123.202"/>
    </section>
```

Does not work via VPN

```
    <section name="network">
      <setting name="fw_force_fw_type" value="1"/>
      <setting name="fw_force_fw_type_hairpin" value="0"/>
      <setting name="fw_force_ip" value="172.20.123.202"/>
      <setting name="fw_force_settings" value="1"/>
    </section>
```

Does not work via VPN

```
    <section name="network">
      <setting name="fw_force_fw_type" value="1"/>
      <setting name="fw_force_fw_type_hairpin" value="1"/>
      <setting name="fw_force_ip" value="172.20.123.202"/>
      <setting name="fw_force_settings" value="1"/>
    </section>
```

Platform Mac OS X 10.4.10 PowerPC

Software Version: AudioOnly 1.1 3014x stamp 26707

*Works* via VPN

nonguisettings.sok

```
system:network:auto_detect_ip="0"
system:network:local_ip="172.20.123.202"
```

## Worthless Support

### Auto-detect prevents VPN functionality?

Below is the extent of help I received on the CounterPath support forums.

**Derek Jacobs**

Post Posted: Sun Feb 03, 2008 4:29 am

No special settings are needed within the client to use over a properly setup VPN.

Please don't make changes to the ***7469 menu unless advised.

- http://support.counterpath.net/viewtopic.php?t=12064

