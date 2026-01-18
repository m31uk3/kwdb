# CMsort


Do you (still) need to sort plain text files with DOS, WINDOWS, UNIX, MAC (or even mixed!) end-of-line marks? Or files with fixed-length records? Then you should take a look at CMSort, a freeware command line sort utility for Windows 95/98/NT/2000/XP.

## Usage

```
CMsort version 1.6 - Sort a DOS, WINDOWS, UNIX, MAC, or mixed text file
(c) 2002 Christian Maas (chmaas@handshake.de  www.chmaas.handshake.de)
Currently available physical memory: 998,760,448 bytes
Usage:   CMsort [sort field] ... [option] ... <input file> <output file>
Sort fields: /S=F,L string  from position F with length L (case sensitive)
             /C=F,L string  from position F with length L (case insensitive)
             /N=F,L numeric from position F with length L
             Notes: 1. The complete line is used as sort field when running
                       CMsort without indicating sort fields.
                    2. Use L=0 for the last non-numeric sort field to define
                       a (part-) key until end of line.
Options: /F=n read/write files with fixed-length records (n byte without CR/LF)
         /B ignore blank or empty records
         /D ignore records with duplicate keys (according to sort fields)
         /D=<file> ignore records with duplicate keys, write them to <file>
         /Q quiet mode (no progress output)
         /H=n don't sort n header lines (default: n=0)
         /W=n n-way-merge of temporary files (2<=n<=5, default: n=5)
         /T=<path> for temporary files (/T=TMP for Windows temporary file path)
         /M=n[p] use n KB [or n% of physical available] memory;
            default:   use 10%, at least 100 KB, but max. 1024 KB
            otherwise: use as indicated, but at least 100 KB
Use CMsort /E to show examples.
```

## Merging CSV Files

The following line will merge all .csv files into the output.csv file.

```bash
type *.csv > output.csv

```
## Sorting CSV Files

The following line will preform a ascending numerical sort on the input file.

```bash
CMsort.exe /N=5,13- /B input.csv output.csv

```
### Removing Duplicates

The following line will preform an ascending numerical sort on the input file and remove any duplicates.

```bash
CMsort.exe /N=5,13- /B /D input.csv output.csv

```
## Sources

- http://www.chmaas.handshake.de/delphi/freeware/cmsort/cmsort.htm

