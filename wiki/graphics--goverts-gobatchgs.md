# Goverts GoBatchGS


## Summary

GhostScript is a great tool to convert PostScript and PDF to various other formats like EPS, JPEG, TIFF, PDF.

Normally GhostScript is executed from the command line. With numerous options it is 100% flexible but not so easy to use. The popular GSView GUI didn't offer what I needed: a simple way to process a bunch of PostScript or PDF files. So Govert created his own GUI, named GoBatchGS. The most important output formats are implemented. As well as the most important options like resolution and JPEG quality and even the option to merge PDF output.

Wolfgang Reszel has translated the captions in GoBatchGS to German so it is also available in Deutsch.

You will also need to install [Ghostscript](http://www.cs.wisc.edu/~ghost/) and install it prior to running the GUI.

Download [GoBatchGS](http://www.noliturbare.com/)

## Install GhostScript



I find that it is most useful to install GhostScript to the C:\ as it will reduce problems with ENV Vars and spaces in paths.

Once you have downloaded and run the GhostScript Install executable you should see something similar to the image on the right. If you would also like to use C:\ as your install path you will have to change it from the default of C:\Program Files\gs.

Once you are ready to install click the **Install** button and GhostScript will extract and correctly link all of the necessary files. 

After setup completes it should open the GhostScript folder confirming that everything has installed correctly.

It is safe to close this folder and continue on with GoBatchGS installation.

## Install GoBatchGS

Simply extract the GOBATCHGS.exe from the GoBatchGS.zip file you downloaded from Govert's website and place in the your GhostScript bin directory.

If you installed using the example above it should be as follows (Where N(s) are replaced your version number):

```bash
C:\gs\gsN.NN\bin\

```
Once you have extracted the file to location above create a shortcut so it is easier to access. For example I have a shortcut on my Desktop and you can do this by right clicking and select Send To > Desktop

Now go ahead and continue with configure and you'll be up and running in no time.

## Configure GoBatchGS

First you will have to configure your GS Bin directory. This is simply the path where **gswin32c.exe** is found on your system.

- Click on the Configure Menu from the menu bar.
- Click on GS bin dir

Now browse to the correct folder as described above and highlight it. Once completed press OK.

Lastly you will have to configure an output directory by clicking on the **Path** button. I find it useful to create a **_ready** folder and use this as my output directory.

Thats it you should be ready to go.

## GoBatchGS FAQ

### Why are the converted EPS files cut off or cropped?

Please ensure that you have checked...

```bash
If pagesize info misses in inputfile:
* Take Bounding Box as pagesize

```
### Why does the program crash when I try to use the Watch folder option?

I think there is a bug with Windows XP and GoBatchGS hopefully this will be resolved in a future release.

## See Also

- [EPS Optimization](graphics--eps-optimization.md)

