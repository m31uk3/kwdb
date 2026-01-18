# Firewall ipfw


**ipfw** -- IP firewall and traffic shaper control program

## Introduction

You may not know that your Mac OS X is equipped with a very powerful firewall that is capable of filtering,shaping, and logging traffic. The purpose of this tutorial will be to explain the different ways in which it can be used. All managment of the firewall will be done via Terminal. It is possible to apply simple rule-sets in System Settings but this will not be possible if you configure advanced rule-sets via the Terminal.

The following information is only specific parts of the ipfw man page. If you would like to view it in it's entirety type this command in terminal:

```
man ifpw
```

## Background

The ipfw utility is the user interface for controlling the ipfw firewall and the dummynet traffic shaper in FreeBSD.

An ipfw configuration, or ruleset, is made of a list of rules numbered
from 1 to 65535.  Packets are passed to ipfw from a number of different places in the protocol stack (depending on the source and destination of the packet, it is possible that ipfw is invoked multiple times on the same packet). The packet passed to the firewall is compared against each of the rules in the firewall ruleset.  When a match is found, the action corresponding to the matching rule is performed.

Depending on the action and certain system settings, packets can be reinjected into the firewall at some rule after the matching one for further processing.

An ipfw ruleset always includes a default rule (numbered 65535) which cannot be modified or deleted, and matches all packets.  The action associated with the default rule can be either deny or allow depending on how the kernel is configured.

All rules (including dynamic ones) have a few associated counters: a packet count, a byte count, a log count and a timestamp indicating the time of the last match.  Counters can be displayed or reset with ipfw commands.

Rules can be added with the add command; deleted individually or in groups with the delete command, and globally (except those in set 31) with the flush command; displayed, optionally with the content of the counters, using the show and list commands.  Finally, counters can be reset with the zero and resetlog commands.

## Synopsis

- ipfw [-cq] add rule
- ipfw [-acdefnNStT] {list | show} [rule | first-last ...]
- ipfw [-f | -q] flush
- ipfw [-q] {delete | zero | resetlog} [set] [number ...]
- ipfw enable {firewall | one_pass | debug | verbose | dyn_keepalive}
- ipfw disable {firewall | one_pass | debug | verbose | dyn_keepalive}

- ipfw set [disable number ...] [enable number ...]
- ipfw set move [rule] number to number
- ipfw set swap number number
- ipfw set show

- ipfw {pipe | queue} number config config-options
- ipfw [-s [field]] {pipe | queue} {delete | list | show} [number ...]

- ipfw [-cnNqS] [-p preproc [preproc-flags]] pathname

The following options are available:

- **-a** While listing, show counter values.  The show command just implies this option.

- **-c** When entering or showing rules, print them in compact form, i.e. without the optional "ip from any to any" string when this does not carry any additional information.

- **-d** While listing, show dynamic rules in addition to static ones.

- **-e** While listing, if the -d option was specified, also show expired dynamic rules.

- **-f** Don't ask for confirmation for commands that can cause problems if misused, i.e. flush.  If there is no tty associated with the process, this is implied.

- **-n** Only check syntax of the command strings, without actually passing them to the kernel.

- **-N** Try to resolve addresses and service names in output.

- **-q** While adding, zeroing, resetlogging or flushing, be quiet about actions (implies -f).  This is useful for adjusting rules by executing multiple ipfw commands in a script (e.g.,`sh /etc/rc.firewall'), or by processing a file of many ipfw rules across a remote login session.  If a flush is performed in normal (verbose) mode (with the default kernel configuration), it prints a message. Because all rules are flushed, the message might not be delivered to the login session, causing the remote login session to be closed and the remainder of the ruleset to not be processed. Access to the console would then be required to recover.

- **-S** While listing rules, show the set each rule belongs to. If this flag is not specified, disabled rules will not be listed.

- **-s** [field] While listing pipes, sort according to one of the four counters (total or current packets or bytes).

- **-t** While listing, show last match timestamp (converted with ctime()).

- **-T** While listing, show last match timestamp (as seconds from the epoch).  This form can be more convenient for postprocessing by scripts.

To ease configuration, rules can be put into a file which is processed using ipfw as shown in the last synopsis line.  An absolute pathname must be used.  The file will be read line by line and applied as arguments to the ipfw utility.

Optionally, a preprocessor can be specified using -p preproc where pathname is to be piped through.  Useful preprocessors include cpp(1) and m4(1). If preproc doesn't start with a slash (`/') as its first character, the usual PATH name search is performed.  Care should be taken with this in environments where not all file systems are mounted (yet) by the time ipfw is being run (e.g. when they are mounted over NFS).  Once -p has been specified, any additional arguments as passed on to the pre-processor for interpretation.  This allows for flexible configuration files (like conditionalizing them on the local hostname) and the use of macros to centralize frequently required arguments like IP addresses.

The ipfw pipe and queue commands are used to configure the traffic shaper, as shown in the [Traffic Shaping](misc--.md#traffic-shaping) section below.

If the world and the kernel get out of sync the ipfw ABI may break, preventing you from being able to add any rules.  This can adversely effect the booting process.  You can use ipfw disable firewall to temporarily disable the firewall to regain access to the network, allowing you to fix the problem.

## Syntax

In general, each keyword or argument must be provided as a separate command line argument, with no leading or trailing spaces. Keywords are case-sensitive, whereas arguments may or may not be case-sensitive depending on their nature (e.g. uid's are, hostnames are not).

In ipfw2 you can introduce spaces after commas ',' to make the line more readable. You can also put the entire command (including flags) into a single argument.  E.g. the following forms are equivalent:
		 
No Spaces:
```
ipfw -q add deny src-ip 10.0.0.0/24,127.0.0.1/8
```

Spaces:
```
ipfw -q add deny src-ip 10.0.0.0/24, 127.0.0.1/8
```

Spaces with quotes:
```
ipfw "-q add deny src-ip 10.0.0.0/24, 127.0.0.1/8"
```

### Traffic Shaper

ipfw is also the user interface for the dummynet(4) traffic shaper.

dummynet operates by first using the firewall to classify packets and divide them into flows, using any match pattern that can be used in ipfw rules.  Depending on local policies, a flow can contain packets for a single TCP connection, or from/to a given host, or entire subnet, or a protocol type, etc.

Packets belonging to the same flow are then passed to either of two different objects, which implement the traffic regulation:

- **pipe**

A pipe emulates a link with given bandwidth, propagation
delay, queue size and packet loss rate.  Packets are queued
in front of the pipe as they come out from the classifier,
and then transferred to the pipe according to the pipe's
parameters.

- **queue**

A queue is an abstraction used to implement the WF2Q+ (Worst-
case Fair Weighted Fair Queueing) policy, which is an effi-
cient variant of the WFQ policy.
The queue associates a weight and a reference pipe to each
flow, and then all backlogged (i.e., with packets queued)
flows linked to the same pipe share the pipe's bandwidth pro-
portionally to their weights.  Note that weights are not pri-
orities; a flow with a lower weight is still guaranteed to
get its fraction of the bandwidth even if a flow with a
higher weight is permanently backlogged.

In practice, pipes can be used to set hard limits to the bandwidth that a flow can use, whereas queues can be used to determine how different flow share the available bandwidth.

The pipe and queue configuration commands are the following:

```bash
pipe number config pipe-configuration

queue number config queue-configuration

```
The following parameters can be configured for a pipe:

- **bw** bandwidth | **device**

Bandwidth, measured in [K|M]{bit/s|Byte/s}.

A value of 0 (default) means unlimited bandwidth.  The unit must immediately follow the number, as in

```
ipfw pipe 1 config bw 300Kbit/s
```

If a device name is specified instead of a numeric value, as in

```
ipfw pipe 1 config bw tun0
```

then the transmit clock is supplied by the specified device.  At the moment only the tun(4) device supports this functionality, for use in conjunction with ppp(8).

- **delay** ms-delay

Propagation delay, measured in milliseconds.  The value is rounded to the next multiple of the clock tick (typically 10ms, but it is a good practice to run kernels with ``options HZ=1000'' to reduce the granularity to 1ms or less).  Default value is 0, meaning no delay.

The following parameters can be configured for a queue:

- **pipe** pipe_nr

Connects a queue to the specified pipe.  Multiple queues (with the same or different weights) can be connected to the same pipe, which specifies the aggregate rate for the set of queues.

- **weight** weight

Specifies the weight to be used for flows matching this queue. The weight must be in the range 1..100, and defaults to 1.

Finally, the following parameters can be configured for both pipes and queues:

- **buckets** hash-table-size

Specifies the size of the hash table used for storing the various queues.  Default value is 64 controlled by the sysctl(8) variable net.inet.ip.dummynet.hash_size, allowed range is 16 to 65536.

- **mask** mask-specifier

Packets sent to a given pipe or queue by an ipfw rule can be further classified into multiple flows, each of which is then sent to a different dynamic pipe or queue.  A flow identifier is constructed by masking the IP addresses, ports and protocol types as specified with the mask options in the configuration of the pipe or queue.  For each different flow identifier, a new pipe or queue is created with the same parameters as the original object, and matching packets are sent to it.

Thus, when dynamic pipes are used, each flow will get the same bandwidth as defined by the pipe, whereas when dynamic queues are used, each flow will share the parent's pipe bandwidth evenly with other flows generated by the same queue (note that other queues with different weights might be connected to the same pipe).

Available mask specifiers are a combination of one or more of the following:

```
dst-ip mask, src-ip mask, dst-port mask, src-port mask, proto mask or all,
```

where the latter means all bits in all fields are significant.

- **plr** packet-loss-rate

Packet loss rate.  Argument packet-loss-rate is a floating-point number between 0 and 1, with 0 meaning no loss, 1 meaning 100% loss. The loss rate is internally represented on 31 bits.

- **queue** {slots | sizeKbytes}

Queue size, in slots or KBytes.  Default value is 50 slots, which is the typical queue size for Ethernet devices.  Note that for slow speed links you should keep the queue size short or your traffic might be affected by a significant queueing delay.  E.g., 50 max sized ethernet packets (1500 bytes) mean 600Kbit or 20s of queue on a 30Kbit/s pipe.  Even worse effect can result if you get packets from an interface with a much larger MTU, e.g. the loopback interface with its 16KB packets.

## Examples

### Packet Filtering

This command adds an entry which denies all tcp packets from cracker.evil.org to the telnet port of wolf.tambov.su from being forwarded by the host:

```
ipfw add deny tcp from cracker.evil.org to wolf.tambov.su telnet
```

This one disallows any connection from the entire cracker's network to my host:

```
ipfw add deny ip from 123.45.67.0/24 to my.host.org
```

A first and efficient way to limit access (not using dynamic rules) is the use of the following rules:

```
ipfw add allow tcp from any to any established
ipfw add allow tcp from net1 portlist1 to net2 portlist2 setup
ipfw add allow tcp from net3 portlist3 to net3 portlist3 setup
<other rules>
ipfw add deny tcp from any to any
```

The first rule will be a quick match for normal TCP packets, but it will not match the initial SYN packet, which will be matched by the setup rules only for selected source/destination pairs.  All other SYN packets will be rejected by the final deny rule.

If you administer one or more subnets, you can take advantage of the ipfw2 syntax to specify address sets and or-blocks and write extremely compact rulesets which selectively enable services to blocks of clients, as below:

```
goodguys="{ 10.1.2.0/24{20,35,66,18} or 10.2.3.0/28{6,3,11} }"
badguys="10.1.2.0/24{8,38,60}"

ipfw add allow ip from ${goodguys} to any
ipfw add deny ip from ${badguys} to any
<other rules>
```

The ipfw1 syntax would require a separate rule for each IP in the above example.

The verrevpath option could be used to do automated anti-spoofing by adding the following to the top of a ruleset:

```
ipfw add deny ip from any to any not verrevpath in
```

This rule drops all incoming packets that appear to be coming to the sytem on the wrong interface. For example, a packet with a source address belonging to a host on a protected internal network would be dropped if it tried to enter the system from an external interface.

### Traffic Shaping

The following rules show some of the applications of ipfw and dummynet(4)
for simulations and the like.

#### Packet Loss

This rule drops random incoming packets with a probability of 5%:

```
ipfw add prob 0.05 deny ip from any to any in
```

A similar effect can be achieved making use of dummynet pipes:

```
ipfw add pipe 10 ip from any to any
ipfw pipe 10 config plr 0.05
```

#### Bandwidth

We can use pipes to artificially limit bandwidth, e.g. on a machine acting as a router, if we want to limit traffic from local clients on 192.168.2.0/24 we do:

```
ipfw add pipe 1 ip from 192.168.2.0/24 to any out
ipfw pipe 1 config bw 300Kbit/s queue 50KBytes
```

Note that we use the out modifier so that the rule is not used twice. Remember in fact that ipfw rules are checked both on incoming and outgoing packets.

#### Bidirectional

Should we want to simulate a bidirectional link with bandwidth limita-
tions, the correct way is the following:

```
ipfw add pipe 1 ip from any to any out
ipfw add pipe 2 ip from any to any in
ipfw pipe 1 config bw 64Kbit/s queue 10Kbytes
ipfw pipe 2 config bw 64Kbit/s queue 10Kbytes
```

The above can be very useful, e.g. if you want to see how your fancy Web
page will look for a residential user who is connected only through a
slow link.  You should not use only one pipe for both directions, unless
you want to simulate a half-duplex medium (e.g. AppleTalk, Ethernet,
IRDA).  It is not necessary that both pipes have the same configuration,
so we can also simulate asymmetric links.

#### Delay

Another typical application of the traffic shaper is to introduce some
delay in the communication.  This can significantly affect applications
which do a lot of Remote Procedure Calls, and where the round-trip-time
of the connection often becomes a limiting factor much more than band-
width:

```
ipfw add pipe 1 ip from any to any out
ipfw add pipe 2 ip from any to any in
ipfw pipe 1 config delay 250ms bw 1Mbit/s
ipfw pipe 2 config delay 250ms bw 1Mbit/s
```

#### Statistics

Per-flow queueing can be useful for a variety of purposes.  A very simple
one is counting traffic:

```
ipfw add pipe 1 tcp from any to any
ipfw add pipe 1 udp from any to any
ipfw add pipe 1 ip from any to any
ipfw pipe 1 config mask all
```

The above set of rules will create queues (and collect statistics) for
all traffic.  Because the pipes have no limitations, the only effect is
collecting statistics.  Note that we need 3 rules, not just the last one,
because when ipfw tries to match IP packets it will not consider ports,
so we would not see connections on separate ports as different ones.

#### Advanced

A more sophisticated example is limiting the outbound traffic on a net
with per-host limits, rather than per-network limits:

```
ipfw add pipe 1 ip from 192.168.2.0/24 to any out
ipfw add pipe 2 ip from any to 192.168.2.0/24 in
ipfw pipe 1 config mask src-ip 0x000000ff bw 200Kbit/s queue 20Kbytes
ipfw pipe 2 config mask dst-ip 0x000000ff bw 200Kbit/s queue 20Kbytes
```

