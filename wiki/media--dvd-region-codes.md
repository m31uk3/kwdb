# DVD Region Codes




= Summary =

DVD-Video discs may be encoded with a region code intended to restrict the area of the world in which they can be played. Discs can be produced without region coding; they are sometimes referred to as region 0 discs.

The commercial DVD player specification requires that a player to be sold in a given place must not play discs encoded for a different region (region 0 discs are not restricted). The purpose of this system is to allow motion picture studios to control the various aspects of a release (including content, date and, in particular, price) according to the region. In practice many DVD players are or can be modified to be region-free, allowing playback of all discs. Entirely independent of CSS encryption, region coding pertains to regional lockout, which originated in the video game industry.

- Read more on Wikipedia about [http://en.wikipedia.org/wiki/DVD_region_code DVD Region Codes]

## My Opinion

My opinion is best summarized by two points. DVD Region Codes are the Motion Picture Association of America's attempt to:

1. Divide the global market into smaller more manageable markets. This is done to ensure that they can "culturalize" their propaganda for each market and "tweak" pricing.
1. Prevent cheaper priced foreign DVD's from playing on the consumers DVD player. (Typically DVDs are much cheaper in the Asian markets)

= Mac OS X =

There are two types of Region Code restriction on Apple personal computers.

1. Software
1. Firmware

If you have an older computer it is likely you will only have the software restriction. However if your DVD drive has been manufactured in the last two years it is likely that you will have both software and firmware restrictions.

## Evil DVD Drives

Open Terminal and run the following command to determine the make and model of your drive.

```bash
system_profiler SPParallelATADataType | grep DVD

```
### MATSHITACD-RW CW-8124

## Good DVD Drives

### MATSHITADVD-R UJ-845E

## Evil Applications



### DVD Player

The DVD Player Application that is included with the Mac OS X operating system enforces DVD Region Codes.

DVD players--including Apple's DVD Player--are generally limited to playing discs of only one region, usually the region where the DVD player was purchased. For example, DVD players purchased in Canada usually only play Region 1 DVD-Video discs.

The Apple DVD Player is capable of playing discs from any region. Once you play a disc, the DVD drive stores the disc's region in its memory (called firmware) and limits you to playing discs from that region. In Mac OS 9, the region is automatically assigned by the Region Manager software when the first region-encoded disc is loaded into the drive.

In Mac OS X, this dialog box appears the first time a DVD disc is inserted:

```
"Since this is the first use of a DVD disc, the drive region code must be initialized before playing.

"New Drive Setting: Region Code 1

"You can only change the drive region code 5 more times."
```

The region on the drive is set after clicking Set Drive Region. A similar dialog appears for any subsequent discs that have a different region code.

Apple's DVD Region Manager software allows you to change the region the DVD drive is set to use up to five times. On the fifth time, the drive is permanently set to use that region, and you cannot make any more changes. For example, you have both a Region 1 and Region 2 DVD-Video disc. You insert the Region 1 disc and DVD Player is now set to play only Region 1 discs. You insert the Region 2 disc, and DVD Player is now set to play only Region 2 discs. If you continue to switch between the discs, on the fifth time the DVD drive is permanently set to use the region of that disc.

In Mac OS X 10.3 Panther and later, users with administrative privileges aren't prompted to change the region the very first time a DVD-Video disc of a single region is inserted. Instead, the region of the DVD drive is automatically set to the region of the DVD disc that was inserted. Accounts that don't have administrative privileges must authenticate with an administrator account name and password, because changing the drive's region code requires administrative privileges.

## Good Ideas

### Disable DVD Player Launch on DVD Insertion




Because DVD Player is an "Evil Application" we think it is best to change your default system settings from automatically launching it when you insert you favorite DVD.

1. Open System Preferences
1. Find CDs & DVDs and click on the icon. (Show in the picture on the left.)
1. Find **"When you insert a video DVD:"** and change the value to **"Ignore"**. You can also configure your own scripts or even specify another application to launch instead but for simplicity this tutorial will us **"Ignore"**. (Shown in picture on right)
1. Finally close the window and try it out by inserting you favorite DVD.

**Note:** If you did it right you should no longer be prompted to change your drives region code.

**Tip:** DVD Player will still manually check for region codes when you launch it. So we recommend an application from the **Good Applications** section.

## Good Applications

### VLC Player

- Download: http://www.videolan.org/vlc/download-macosx.html

1. Select File->Open Disc
1. Click on the Disc tab, click on DVD, select the device, and click OK (usually this is selected by default). The DVD will now play, and your region code will remain intact.

**Note:** This will only work if your DVD drive does not have the Region Code enforced in it's firmware. Please see the [#Evil DVD Drives](misc--.md#evil-dvd-drives) section for more information.

- [Vlc](media--vlc.md)

= Windows XP =

## Evil Applications

### Windows Media Player

= Linux =

= Sources =

- Wikipedia -> http://en.wikipedia.org/wiki/DVD_region_code
- Apple -> http://docs.info.apple.com/article.html?artnum=60183
- Apple Forum -> http://discussions.apple.com/thread.jspa?messageID=2160034

