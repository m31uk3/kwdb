# ImageMagick


## Convert
### Examples

Crappy attempt at reflection:

```bash
convert 121-49.png \( OriginalImage.png -flip -blur 3x5 -crop 100%%x30%%+0+0 -negate -evaluate multiply 0.3 -negate  \( -size 585x128 gradient: \) +matte -compose copy_opacity -composite \) -append NewImage.png

```
## Montage

### Examples

```bash
montage -label '%f' [0-9]* -font Helvetica -pointsize 14 -resize 100% -geometry +30+30 -tile 3x -title 'Singeing Digital Direct Products' ../test.png

```
**Overlapping Polaroid Montage**

```bash
montage null: *.jpg null: -resize 25% -tile 1x -geometry +1-20 -bordercolor white -background gray20 +polaroid -background white -quality 100 poloroid.png
```
