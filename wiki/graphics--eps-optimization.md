# EPS Optimization


= Sorting EPS Types = 

## Bash

### Embedded Fonts Check (CorelDraw)

```bash
grep -al "%%BeginResource: font" *

```
### Embedded Fonts Check (Adobe Illustrator)

When Adobe Illustrator saves in EPS format if the the **Embed Fonts (for other applications)** is checked it will embed the font file for the associated object(s) that have not been converted to outlines. (Only fonts with the appropriate permission bits will be embedded)

Adobe then embeds the follow Document Structuring Convention element **%ADOBeginSubsetFont:** along with the appropriate font information. This process is repeated for each font type existing in the file.

To return the list of files in the current directory that have embedded fonts execute:

```bash
grep -al %ADOBeginSubsetFont: *

```
If you want to return the name of the embedded font execute:

```bash
grep -ah %ADOBeginSubsetFont: * | cut -d : -f 2 | awk '{gsub(/^[ \t]+|[ \t]+$/,"");print}' | grep ^[a-zA-Z0-9]

```
### Embedded Fonts Check (Generic)

```bash
grep -ah %%DocumentFonts: * | cut -d : -f 2 | awk '{gsub(/^[ \t]+|[ \t]+$/,"");print}' | grep ^[a-zA-Z0-9]

```
### Binary Image Check

```bash
grep -al %%BeginBinary *

```
= Convert & CleanUp EPS =

## GhostScript GoBatchGS Frontend Windows XP

GhostScript is a great tool to convert PostScript and PDF to various other formats like EPS, JPEG, TIFF, PDF.

Normally GhostScript is executed from the command line. With numerous options it is 100% flexible but not so easy to use. The popular GSView GUI didn't offer what I needed: a simple way to process a bunch of PostScript or PDF files. So Govert created his own GUI, named GoBatchGS. The most important output formats are implemented. As well as the most important options like resolution and JPEG quality and even the option to merge PDF output.

Wolfgang Reszel has translated the captions in GoBatchGS to German so it is also available in Deutsch.

You will also need to install [Ghostscript](http://www.cs.wisc.edu/~ghost/) and install it prior to running the GUI.

Download [GoBatchGS](http://www.noliturbare.com/)

## GhostScript Windows Command Prompt

An open source command line based solution for cleaning up eps files.

Copy the GhostScript directory to your C:\ root.

Save the text below to a text file and name that file **fixit.cmd**. Simply drag desired eps file onto the fixit.cmd icon and a **cleanded.eps** will be generated for you.

### Example
```
"C:\gs\gs8.56\bin\GSWin32c" -sDEVICE=epswrite -r72 -dLanguageLevel=2 -sOutputFile="%HOMEDRIVE%%HOMEPATH%\Desktop\cleaned.eps" -dNOPAUSE -dEPSCrop %1 -c quit
pause
```

### EPSwrite Device

The epswrite device outputs encapsulated postscript.

Options:

```bash
-dLanguageLevel=1 | 1.5 | 2 | 3 (default is 2)

```
Set the language level of the generated file. Language level 1.5 is language level 1 with color extensions.
Currently language level 3 generates the same PostScript as 2.

### EPS parameters

```bash
-dEPSCrop

```
Crop an EPS file to the bounding box. This is useful when converting an EPS file to a bitmap. 

```bash
-dEPSFitPage

```
Resize an EPS file to fit the page. This is useful for enlarging an EPS file to fit the paper size when printing. 

```bash
-dNOEPS

```
Prevent special processing of EPS files. This is useful when EPS files have incorrect Document Structuring Convention comments.

### Examples

**Show Bounding Box (White is ignored by default)**:

```bash
"C:\gs\gs8.56\bin\GSWin32c" -dBATCH -dNOPAUSE -sDEVICE=bbox 744173_3449329_spshirt1_orig.ai

```
**Show Bounding Box (White Included)**:

```bash
"C:\gs\gs8.56\bin\GSWin32c" -dBATCH -dNOPAUSE -sDEVICE=bbox -c "<< /WhiteIsOpaque true >> setpagedevice" -f 744173_3449329_spshirt1_orig.ai

```
**Convert Adobe Illustrator .ai file to open with CorelDraw using Ghostscript**:

```bash
C:\gs\gs8.56\bin\GSWin32c -sDEVICE=epswrite -r72 -sOutputFile="<Dest File>.EPS"" -dNOPAUSE -dEPSCrop "<Source File>" -c quit

```
I noticed a bug in CorelDraw\Ghostscript when the artwork extends outside of Illustrators ArtBoard. Ghostscript seems to treat it as an actual shape...

When I reopened the converted file with Illustrator it contains an additional clipping mask exactly the same size as the original .ai documents ArtBoard. CorelDraw must mistakenly assume this is the actual bounding box and crops/cuts off any area of the graphic which exists outside.

= Sources =

- http://www.cs.wisc.edu/~ghost/ Ghostscript
- http://www.noliturbare.com GoBatchGS
- http://www.pstoedit.net/ pstoedit
- http://www.cs.wisc.edu/~ghost/gsview/epstool.htm epstool
- http://www.ics.uci.edu/~edashofy/epscleaner.html Extended EPS Information
- http://hepunx.rl.ac.uk/~adye/psdocs/DSC3.html Document Structuring Conventions
- http://en.wikipedia.org/wiki/Encapsulated_PostScript Wikipedia Article
- http://potrace.sourceforge.net/

= See Also =

- [Goverts GoBatchGS](graphics--goverts-gobatchgs.md)

= Tags =

Cleanup EPS File, Large EPS File, Compress EPS File

