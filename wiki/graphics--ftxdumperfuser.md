# Ftxdumperfuser


### Usage

```
 ftxdumperfuser

 [-t cmap|feat|hdmx|head|hhea|hmtx|loca|maxp|name|OS/2|post|prop|vhea|vmtx|Zapf|glyf|just|morx] 
 [-cFgGhIklLnNpuUxvV] 
 [-A d|f|k] 
 [-B size] 
 [-f font] 
 [-d datafile] 
 [-i ID delta] 
 [-o outputfile] 
 fontfile

General Options: 
-h Output this message 
-v Verbose operation, additional data is output to stderr 
-V Output the tool's version to stdout 
-o An optional output file for the results of a dump; 
   stdout is used if this parameter is not specified and -A d is not used 
Auto options on every face: 
-A Do an auto-dump, auto-fuse, or auto-kill on ALL faces in the file. 
You select between three options by using the parameter following the -A; 
i.e. 
 '-A d' means do an auto-dump, 
 '-A f' means do an auto-fuse, and 
 '-A k' means do an auto-kill. 
With these operations, the file name is automatically generated using the 
full name of the font followed by the table. Thus for example: 
 	

 ftxdumperfuser -A d -t cmap Foo.ttf 
would create a dump file, 'Foo.cmap.xml', and put the results of the dump in 
that file. 
 
Font selection options: 
-f The full name of the font within the font file on which to act 
-I Interpret the "fontfile" argument(s) as decimal fontIDs of installed fonts 
-N Interpret the "fontfile" argument(s) as names of installed fonts 
 
General table options: 
-l List the tables from the font; 
   the -t option is required if and only if the -l option is not used 
 
-t (required if -l is not used) 
   The four character tag for the table to dump or fuse 
   Single quotes around the tag are optional, except for tags with fewer 
   than four non-space characters (e.g., 'cvt ') 
-k Remove (i.e. 'kill') the table from the font
Dump options: 
-n Include name table entries in the dump 
-p Include PostScript glyph names in the dump 
-u Include Unicode character names in the dump 
-U Use UTF-16 for output, not UTF-8 
-x Output bad 'name' table entries as hex 
-g Force the use of the generic (hex) table dumper/fuser 
   instead of the table-specific one 
Fuse (Compile) options: 
-d The datafile to use for a fuse operation 
   NOTE: The tool allows dumps from multiple font files to a single text 
   file, but it does *not* allow fuses from a single text file to 
   multiple font files. The text input data file for a fuse operation 
   *must* consist of the XML source for a single table. 
-G Give glyph names precedence over glyph IDs in fuse operations 
-F Do a fuse operation using stdin as the data source 
-L Force the 'loca' table to be long-aligned when fusing in glyph data 
-c Use a compact format for data (e.g., with bitmaps or the 'glyf' table) 
Bitmap generation options: 
-B Auto-generate a set of bitmaps of the given size for the font 
-P Use the given pixel depth (must be 1, 2, 4, 8, 16, or 32) 
   when generating bitmaps; used with the -B option 
-s Use the given scaling factor (must be 1, 2, or 4) 
   when generating bitmaps; used with the -B option 
-i A delta to add to glyph ID's when dumping bitmaps
```

### Examples

Dump the name table of the font file to XML and then parse with xmlstarlet and XAPTH:

```
ftxdumperfuser -t name lte51250.ttf | xml sel -T -t -m "//nameTableEntry[@nameTypeName='Family' or @nameTypeName='Style' or @nameTypeName='Unique' or @nameTypeName='Full' or @nameTypeName='Version' or @nameTypeName='PostScript'] /localizedName" -s D:T:- "@platformName" -v "concat(../@nameTypeName,':')" -n -v "concat(@platformName,' -> ',.)" -n
```

Dump the postscript Glyph Name of each Character to XML and then parse with xmlstarlet and XAPTH:

```
ftxdumperfuser -t cmap -p trikotcollege.ttf | xml sel -T -t -m "//cmapSubtable[@platformName='Microsoft'] /map" -v "concat(@glyphName,'')" -n
```
