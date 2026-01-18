# True Type Fonts


= Overview =

The primary font technology used on Microsoft Windows and the Mac OS is based on the TrueType specification. TrueType fonts are scalable which means the glyphs can be displayed at any resolution and any point size (though the glyphs may not look good in extreme cases). A TrueType font is a binary file containing a number of tables. There is a directory of tables at the start of the file. The file may contain only one table of each type, and the type is indicated by a case-sensitive four letter tag. Each table and the whole font file have checksums.

The TrueType specification was developed by Apple and adopted by Microsoft. Later Microsoft and Adobe expanded the specification to support smart rendering and PostScript glyphs. The new specification, which added more tables, was called OpenType. Apple also added tables to TrueType to support a different smart rendering system producing the Apple Advanced Typography (AAT) font specification. SIL’s Graphite smart rendering system works by adding tables, too.

= Data Tables =

A TrueType font file consists of a sequence of concatenated tables. A table is a sequence of words. Each table must be long aligned and padded with zeros if necessary.

The first of the tables is the font directory, a special table that facilitates access to the other tables in the font. The directory is followed by a sequence of tables containing the font data. These tables can appear in any order. Certain tables are required for all fonts. Others are optional depending upon the functionality expected of a particular font.

The tables have names known as tags. Tags have the type uint32. Currently defined tag names consist of four characters. Tag names with less than four characters have trailing spaces. When tag names are shown in text they are enclosed in straight quotes.

Tables that are required must appear in any valid TrueType font file. The required tables and their tag names are shown in the table below.

{| class="wikitable" style="text-align:left;"
|-
! Tag !! Table
|-
| 'cmap' || character to glyph mapping
|-
| 'glyf' || glyph data
|-
| 'head' || font header
|-
| 'hhea' || horizontal header
|-
| 'hmtx' || horizontal metrics
|-
| 'loca' || index to location
|-
| 'maxp' || maximum profile
|-
| 'name' || naming
|-
| 'post' || PostScript
|}

## Character To Glyph Index Mapping Table - 'cmap'

This table defines the mapping of character codes to the glyph index values used in the font. It may contain more than one subtable, in order to support more than one character encoding scheme. Character codes that do not correspond to any glyph in the font should be mapped to glyph index 0. The glyph at this location must be a special glyph representing a missing character.
The table header indicates the character encodings for which subtables are present. Each subtable is in one of four possible formats and begins with a format code indicating the format used.
The platform ID and platform-specific encoding ID are used to specify the subtable; this means that each platform ID/platform-specific encoding ID pair may only appear once in the cmap table. Each subtable can specify a different character encoding. (See the ‘name’ table section). The entries must be sorted first by platform ID and then by platform-specific encoding ID.

- When building a Unicode font for Windows, the platform ID should be 3 and the encoding ID should be 1.
- When building a symbol font for Windows, the platform ID should be 3 and the encoding ID should be 0.
- When building a font that will be used on the Macintosh, the platform ID should be 1 and the encoding ID should be 0.

The supported platform identifier (platformID) codes are given in the following table. PlatformID codes have been assigned for Unicode, Macintosh, and Microsoft. PlatformID codes 240 through 255 have been reserved for user-defined platforms and are not available for registration.

{| class="wikitable" style="text-align:left"
|-
! Platform ID !! Platform !! Specific Encoding
|-
| 0 || Unicode || Indicates Unicode version.
|-
|1 || Macintosh || Script Manager code.
|-
| 2 || (reserved; do not use)
|-
| 3 || Microsoft || Microsoft encoding.
|}

The platform ID 2 was originally to use with ISO/IEC 10646, but that use is now deprecated, as ISO/IEC 10646 and Unicode have identical character code assignments.

For historical reasons some applications, which install or use fonts, perform version control
using values in the Macintosh platform. Because of this, it is recommended that Macintosh
platform exists in all fonts and that the syntax of the Version string follows the guidelines
given below. When building a font containing Roman characters that will be used on the
Macintosh, additional naming entries for the English language for the Macintosh Roman
platform are required.

## Name - 'name'

This table stores text strings which an application can use to provide information about the font. Each string in the **name** table has a platform and encoding id corresponding to the platform and encoding ids in the **cmap** table. Each string also has a language id which can be used to support strings in different languages. For Windows (platform id 3) the language id is the same as a Windows LCID. For the Mac OS (platform id 1), script manager codes are used instead.

{| class="wikitable" style="text-align:left"
|-
! ID !! Description
|-
| 0 || Copyright notice
|-
| 1 || Font Family name.
|-
| 2 || Font Subfamily name. Font style (italic, oblique) and weight (light, bold, black, etc.). A font with no particular differences in weight or style (e.g. medium weight, not italic) should have the string "Regular" stored in this position.
|-
| 3 || Unique font identifier. Usually similar to 4 but with enough additional information to be globally unique. Often includes information from Id 8 and Id 0.
|-
| 4 || Full font name. This should be a combination of strings 1 and 2. Exception: if the font is “Regular” as indicated in string 2, then use only the family name contained in string 1. This is the font name that Windows will expose to users.
|-
| 5 || Version string. Must begin with the syntax ‘Version n.nn ‘ (upper case, lower case, or mixed, with a space following the number).
|-
| 6 || Postscript name for the font.
|-
| 7 || Trademark. Used to save any trademark notice/information for this font. Such information should be based on legal advice. This is distinctly separate from the copyright.
|-
| 8 || Manufacturer Name.
|-
| 9 || Designer. Name of the designer of the typeface.
|-
| 10 || Description. Description of the typeface. Can contain revision information, usage recommendations, history, features, etc.
|-
| 11 || URL Vendor. URL of font vendor (with protocol, e.g., http://, ftp://). If a unique serial number is embedded in the URL, it can be used to register the font.
|-
| 12 || URL Designer. URL of typeface designer (with protocol, e.g., http://, ftp://).
|-
| 13 || License description. Description of how the font may be legally used, or different example scenarios for licensed use. This field should be written in plain language, not legalese.
|-
| 14 || License information URL. Where additional licensing information can be found.
|-
| 15 || Reserved; Set to zero.
|-
| 16 || Preferred Family (Windows only). In Windows, the Family name is displayed in the font menu. The Subfamily name is presented as the Style name. For historical reasons, font families have contained a maximum of four styles, but font designers may group more than four fonts to a single family. The Preferred Family and Preferred Subfamily IDs allow font designers to include the preferred family/subfamily groupings. These IDs are only present if they are different from IDs 1 and 2.
|-
| 17 || Preferred Subfamily (Windows only). See above.
|-
| 18 || Compatible Full (Mac OS only). On the Mac OS, the menu name is constructed using the FOND resource. This usually matches the Full Name. If you want the name of the font to appear differently than the Full Name, you can insert the Compatible Full Name here.
|-
| 19 || Sample text. This can be the font name, or any other text that the designer thinks is the best sample text to show what the font looks like.
|-
| 20 || PostScript CID findfont name.
|-
| 21-255 || Reserved for future expansion.
|-
| 256-32767 || Font-specific names.
|}

### Required Values

The following name ID’s are defined, and they apply to all platforms. Extensions to this table will be registered with Apple DTS.

{| class="wikitable" style="text-align:left"
|-
! Code !! Meaning
|-
| 0 || Copyright notice.
|-
| 1 || Font Family name
|-
| 2 || Font Subfamily name; for purposes of definition, this is assumed to address style (italic, oblique) and weight (light, bold, black, etc.) only. A font with no particular differences in weight or style (e.g. medium weight, not italic and fsSelection bit 6 set) should have the string “Regular” stored in this position.
|-
| 3 || Unique font identifier
|-
| 4 || Full font name; this should simply be a combination of strings 1 and 2. Exception: if string 2 is “Regular,” then use only string 1. This is the font name that Windows will expose to users.
|-
| 5 || Version string. In n.nn format.
|-
| 6 || Postscript name for the font.
|-
| 7 || Trademark; this is used to save any trademark notice/information for this font. Such information should be based on legal advice. This is distinctly separate from the copyright.
|}

**Note**: While both Apple and Microsoft support the same set of name strings, the interpretations may be somewhat different. But since name strings are stored by platform, encoding and language (placing separate strings in for both Apple and MS platforms), this should not present a problem.

### Examples

The key information for this table for MS fonts relates to the use of strings 1, 2 and 4.

The Subfamily string in the 'name' table should be used for variants of weight (ultra light to extra black) and style (oblique/italic or not).  So, for example, the full font name of “Helvetica Narrow Italic” should be defined as Family name “Helvetica Narrow” and Subfamily “Italic.” This is so that Windows can group the standard four weights of a font in a reasonable fashion for non-typographically aware applications which only support combinations of “bold” and “italic.”

Helvetica Narrow Oblique

Font Family name = Helvetica Narrow

Font Subfamily name = Oblique

Full font name = Helvetica Narrow Oblique


Helvetica Narrow

Font Family name = Helvetica Narrow

Font Subfamily name = Regular

Full font name = Helvetica Narrow


Helvetica Narrow Light Italic

Font Family name = Helvetica Narrow

Font Subfamily name = Light Italic

Full font name = Helvetica Narrow Light Italic

### Example (.SVG File)

Below is a text generated .svg file. You can match the element **font-family** of the text container to key id 1 **Font Family Name** in the [Name](misc--.md#name) table above.

```
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xml:space="preserve">
<g>
<text x="0" y="149.62448979592" font-size="161.33333333333" font-family="Hole-HeartedRegular" text-anchor="" fill="#D31818">Adrian</text>
<text x="0" y="352.07346938776" font-size="161.33333333333" font-family="Hole-HeartedRegular" text-anchor="" fill="#D31818">was here!</text>
</g>
<font-face font-family="Hole-HeartedRegular">
<font-face-src><font-face-uri xlink:href="/local/www/us/img/fonts/ttf/hole-heartedregular.ttf" />
</font-face-src>
</font-face>
</svg>
```

= Tools =

Collection of applications which process True Type Fonts.

## Editing

### TTF EDIT

The ttf_edit TrueType font table editor available for free during a limited time to persons willing to serve as beta testers. NOTE: The ttf_edit tool provides you a programming language to edit, import, and export encodings, names, and metrics in TrueType fonts. It is a language-based (not graphical) tool, and is not concerned with the glyph shapes themselves.

- http://www.truetex.com/

### TTX

TTX is a tool to convert OpenType and TrueType fonts to and from XML. FontTools is a library for manipulating fonts, written in Python. It supports TrueType, OpenType, AFM and to an extent Type 1 and some Mac-specific formats.

- http://sourceforge.net/projects/fonttools/

### FontCreator

This professional font editor allows you to create and edit TrueType and OpenType fonts. It has the powerful drawing tools that typographers and graphic designers require, and an intuitive interface that allows beginners to become productive immediately.

- http://www.high-logic.com/fontcreator.html

= Linux =

## Overview

An easy way to install Microsoft's TrueType core fonts on linux

The original unaltered .exe files as downloaded from microsoft.com when they were available here

## Install

If you don't have a rpm based distribution, you can compile the tool to extract the .ttf files from the .exe files, cabextract from source, found here
How to install

Installing Microsoft's TrueType core fonts for the web on any rpm based linux box with TrueType support is now easy. The instructions below have been tested on various Red Hat and Fedora Core systems, but they are fairly generic so they should apply to any redhat-like linux distribution, such as mandrake or yellowdog. If you are running debian, please have a look here. If you are running suse, please have a look here

1.

Make sure you have the following rpm-packages installed from from your favourite distribution. Any version should do.
- rpm-build
- wget
- A package that provides the ttmkfdir utility. For example
```bash
o For Fedora Core and Red Hat Enterprise Linux 4, ttmkfdir
o For old redhat releases, XFree86-font-utils
o For mandrake-8.2, freetype-tools
```
2.

Install the cabextract utility. For users of Fedora Core it is available from extras. Others may want to compile it themselves from source, or download the source rpm from fedora extras and rebuild.

3.

Download the latest msttcorefonts spec file from here

4.

If you haven't done so already, set up an rpm build environment in your home directory. You can to this by adding the line %_topdir %(echo $HOME)/rpmbuild to your $HOME/.rpmmacros and create the directories $HOME/rpmbuild/BUILD and $HOME/rpmbuild/RPMS/noarch

5.

Build the binary rpm with this command:

```bash
$ rpmbuild -bb msttcorefonts-2.0-1.spec

```
This will download the fonts from a Sourcforge mirror (about 8 megs) and repackage them so that they can be easily installed.

6.

Install the newly built rpm using the following command (you will need to be root):

```bash
# rpm -ivh $HOME/rpmbuild/RPMS/noarch/msttcorefonts-2.0-1.noarch.rpm

```
7.

You might need to reload the X font server. Normally this is done as a part of the installation process (this is done by chkfontpath). However in some situations it seems like you need to reload or restart the font server manually. I am told that the last argument needs to be restart and not reload on Mandrake 9.0

```bash
# /sbin/service xfs reload

```
A bug in RedHat 8.0 makes the X server lose the connection to the font server if the font server is restarted instead of reloaded. That will cause assorted strange behaviour (changed fonts in newly opened applications, applications hanging). Logging out and logging in again will solve the problems, or just use 'reload' instead of 'restart'.
8. Enjoy your new high quality fonts. To verify that the installation succeeded, please use the command 'xlsfonts | grep ^-microsoft'. You should see a whole lot of microsoft font names there. Please note that you need to restart all programs that you want to make aware of the new fonts. Note also that not all fonts have 'microsoft' in their name, some of them will be from 'monotype' instead.

## Features

- Does not distribute Microsoft's fonts in a prohibited way (to the best of my knowledge that is)
- Doesn't bypass the rpm database like other font install scripts


= Sources =

- http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=IWS-Chapter08
- http://developer.apple.com/textfonts/TTRefMan/RM06/Chap6.html
- http://www.microsoft.com/typography/SpecificationsOverview.mspx
- http://www.groupsrv.com/computers/post-84094.html
- http://www.microsoft.com/typography/OTSpec/name.htm

