# WinTV


## Linux
Install Drivers
- [ivtv](misc--ivtv.md)
Simple Multicast Streaming
- [emcast](misc--emcast.md)

While not ivtv specific, this little hack is useful for streaming video over the network without the overhead of a system like mythtv. This is especially useful for testing if you have a tv card in a headless box and want to take mythtv out of the equation.

Once you have [ivtv](misc--ivtv.md) installed and got it working, you need to install [netcat](http://netcat.sourceforge.net/) on both machines.

On the client, run:

```bash
nc -l -p 5000 | mplayer -

```
And on the server, run:

```bash
cat /dev/video0 | nc 192.168.4.5 5000

```
What this does is simply using the netcat program to take whatever comes out of /dev/video0 and send it to 192.168.4.5 on port 5000. The receiving machine listen on port 5000 and take whatever comes in, and sends it to mplayer to show it.

You can use any IP and any port number, as long as it's free and you have the rights to use it. Xine (or any other app for that matter) can also be used instead of mplayer.

Note: Execute the client command first, or the serverside netcat doesnt have anything to connect to.

### Multicast stream

*I think that emcast is death...*

If you want to stream over multicast IP, I suggest to download this little tool: [emcast](http://www.junglemonkey.net/emcast/) instead netcat.

so, on server, run:

```bash
cat /dev/video0 | emcast 224.1.2.3:1234

```
on client, run:

```bash
emcast 224.1.2.3:1234 | mplayer -

```
where 224.1.2.3 is a multicast IP and 1234 the port where send/listen for stream.

## Sources

- http://ivtvdriver.org/index.php/Howto:Netcat_streaming

