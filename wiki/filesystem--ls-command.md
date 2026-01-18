# Ls Command


### Count files in directory

```bash
ls -1 | wc -l

```
### List .png files and sort by second field

```bash
ls -1R | grep '.\.png' | sort +1 -t _

```
