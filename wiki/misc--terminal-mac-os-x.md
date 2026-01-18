# Terminal Mac OS X


The Terminal Application is found under **Finder** => **Applications** => **Utilities** => **Terminal**.

## Reset (Weird) Line Draw Characters

File > Send Reset or Apple Key + R

```bash
tput reset

```
What often happens to me is the escape sequence for setting a graphics (line draw) font is echoed to the terminal (because it just happened to be in the file I was cat'ing). That particular sequence is "Esc(0" which can be reset with "Esc(B".

Try typing this in a terminal:

```bash
echo "\033("0
echo "\033("B

```
## Clear Active Command Line

```bash
Ctrl + U

```
This will clear the entire line until the prompt. Quite useful when you have a long command buffered into history and need to type something simple like ls.

### Links

http://forums12.itrc.hp.com/service/forums/questionanswer.do?admit=109447627+1222627497292+28353475&threadId=111901

