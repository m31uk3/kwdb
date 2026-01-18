# DTG Graphic Process


= Introduction =

This page provides a basic knowledge base and details the steps required to process graphics for printing on the Kornit direct to garment printers.

## Requirements

- Adobe Photoshop CS2+
- Basic Usage Knowledge
- Onyx ProductionHouse 7+
- Kornit 1bit Printer Driver

## Knowledgebase

In order to optimize graphics for printing on the Kronit, it is important to understand the following points:

- Layers
- Channels
- Spot Colors
- Solidity
- Opacity
- Color Profiles
- .tif Graphic File Format

### Layers


Layers allow you to work on one element of an image without disturbing the others. Think of layers as sheets of acetate stacked one on top of the other. You can see through transparent areas of a layer to the layers below. You can change the composition of an image by changing the order and attributes of layers. In addition, special features such as adjustment layers, fill layers, and layer styles let you create sophisticated effects.

A new image in Photoshop has a single layer. The number of additional layers, layer effects, and layer sets you can add to an image is limited only by your computer’s memory. 
Layer groups help you organize and manage layers. You can use groups to arrange your layers in a logical order and to reduce clutter in the Layers palette. You can nest groups within other groups. You can also use groups to apply attributes and masks to multiple layers simultaneously.

**Note:** For our process it is important to convert the background to a regular layer. This is because you cannot change the stacking order of a background, its blending mode, or its opacity.

### Channels

Channels are grayscale images that store different types of information:

- **Color information channels** are created automatically when you open a new image. The image’s color mode determines the number of color channels created. For example, an RGB image has a channel for each color (red, green, and blue) plus a composite channel used for editing the image.
- **Alpha channels** store selections as grayscale images. You can add alpha channels to create and store masks, which let you manipulate or protect parts of an image.
- **Spot color channels** specify additional plates for printing with spot color inks.
An image can have up to 56 channels. The file size required for a channel depends on the pixel information in the channel. Certain file formats, including TIFF and Photoshop formats, compress channel information and can save space. The size of an uncompressed file, including alpha channels and layers, appears as the rightmost value in the status bar at the bottom of the window when you choose Document Sizes from the pop-up menu.

**Note:** As long as you save a file in a format supporting the image’s color mode, the color channels are preserved. Alpha channels are preserved only when you save a file in Photoshop, PDF, PICT, Pixar, TIFF, or raw formats. DCS 2.0 format preserves only spot channels. Saving in other formats may cause channel information to be discarded.

### Spot Colors

Spot colors are special premixed inks used instead of, or in addition to, the process color (CMYK) inks. Each spot color requires its own plate on the press. (Because a varnish requires a separate plate, it is considered a spot color, too.)

If you are planning to print an image with spot colors, you need to create spot channels to store the colors. To export spot channels, save the file in DCS 2.0 format or PDF.

Note the following when working with spot colors:

- For spot color graphics that have crisp edges and knock out the underlying image, consider creating the additional artwork in a page‑layout or illustration application.
- To apply spot color as a tint throughout an image, convert the image to Duotone mode and apply the spot color to one of the duotone plates. You can use up to four spot colors, one per plate.
- The names of the spot colors are printed on the separations.
- Spot colors are overprinted on top of the fully composited image. Each spot color is printed in the order it appears in the Channels palette, with the topmost channel printing as the topmost spot color.
- You cannot move spot colors above a default channel in the Channels palette except in Multichannel mode.
- Spot colors cannot be applied to individual layers.
- Printing an image with a spot color channel to a composite color printer will print the spot color at an opacity indicated by the Solidity setting.
- You can merge spot channels with color channels, splitting the spot color into its color channel components.

### Solidity


Solidity, is a value between 0% and 100%. 
This option lets you simulate on-screen the density of the printed spot color. A value of 100% simulates an ink that completely covers the inks beneath (such as a metallic ink); 0% simulates a transparent ink that completely reveals the inks beneath (such as a clear varnish). You can also use this option to see where an otherwise transparent spot color (such as a varnish) will appear.

**Note:** The Solidity and color choice options affect only the on-screen preview and the composite print. They have no effect on the printed separations.

### Opacity

**Layer Opacity**

A layer’s opacity determines to what degree it obscures or reveals the layer beneath it. A layer with 1% opacity appears nearly transparent, whereas one with 100% opacity appears completely opaque.

**Note:** You cannot change the opacity of a background layer or a locked layer. You can, however, convert a background layer to a regular layer, which does support transparency. See To convert a background into a layer.

- Select a layer or group in the Layers palette.
- Do one of the following:
- In the Layers palette, enter a value in the Opacity text box or drag the Opacity pop‑up slider. 
- Choose Layer > Layer Style > Blending Options. Enter a value in the Opacity text box or drag the Opacity pop‑up slider.
- Select the Move tool and type a number indicating the percentage of opacity.

**Fill Opacity**

In addition to setting opacity, which affects any layer styles and blending modes applied to the layer, you can specify a fill opacity for layers. Fill opacity affects pixels painted in a layer or shapes drawn on a layer without affecting the opacity of any layer effects that have been applied to the layer.

Do one of the following:
- In the Layers palette, enter a value in the Fill Opacity text box or drag the Fill Opacity pop‑up slider.
- Double-click a layer thumbnail, choose Layer > Layer Style > Blending Options.

**Note:** To view blending options for a text layer, choose Layer > Layer Style > Blending Options, or choose Blending Options from the Add A Layer Style button at the bottom of the Layers palette. Enter a value in the Fill Opacity text box.

### Color Profiles


Precise, consistent color management requires accurate ICC-compliant profiles of all of your color devices. For example, without an accurate scanner profile, a perfectly scanned image may appear incorrect in another program, simply due to any difference between the scanner and the program displaying the image. This misleading representation may cause you to make unnecessary, time-wasting, and potentially damaging “corrections” to an already satisfactory image. With an accurate profile, a program importing the image can correct for any device differences and display a scan’s actual colors.

A color management system uses the following kinds of profiles:

**Monitor profiles** Describe how the monitor is currently reproducing color. This is the first profile you should create because it is absolutely essential for managing color. If what you see on your monitor is not representative of the actual colors in your document, you will not be able to maintain color consistency. (See To calibrate and profile your monitor.)

**Input device profiles** Describe what colors an input device is capable of capturing or scanning. If your digital camera offers a choice of profiles, Adobe recommends that you select Adobe RGB. Otherwise, use sRGB (which is the default for most cameras). Advanced users may also consider using different profiles for different light sources. For scanner profiles, some photographers create separate profiles for each type or brand of film scanned on a scanner.

**Output device profiles** Describe the color space of output devices like desktop printers and a printing press. The color management system uses output device profiles to properly map the colors in an document to the colors within the gamut of an output device’s color space. The output profile should also take into consideration specific printing conditions, such as the type of paper and ink. For example, glossy paper is capable of displaying a different range of colors than a matte paper.

Most printer drivers come with built-in color profiles. It’s a good idea to try these profiles before you invest in custom profiles. For information on how to print using the built-in profiles, see Letting the printer determine colors when printing. For information on how to obtain custom profiles, see Obtaining custom profiles for desktop printers.

**Document profiles** Define the specific RGB or CMYK color space of a document. By assigning, or tagging, a document with a profile, the application provides a definition of actual color appearances in the document. For example, R=127, G=12, B=107 is just a set of numbers that different devices will display differently. But when tagged with the AdobeRGB color space, these numbers specify an actual color or wavelength of light; in this case, a specific color of purple. 

When color management is on, Adobe applications automatically assign new documents a profile based on Working Space options in the Color Settings dialog box. Documents without associated profiles are known as **untagged** and contain only raw color numbers. When working with untagged documents, Adobe applications use the current working space profile to display and edit colors. (See About color working spaces.)

**Tip:** To view the current document profile, select Document Color Profile in the status bar.

**Managing color with profiles**

**A.** Profiles describe the color spaces of the input device and the document.   **B.** Using the profiles’ descriptions, the color management system identifies the document’s actual colors.   **C.** The monitor’s profile tells the color management system how to translate the numeric values to the monitor’s color space.  **D.** Using the output device’s profile, the color management system translates the document’s numeric values to the color values of the output device so the actual colors are printed.

### .tif Graphic File Format

Tagged-Image File Format (TIFF, TIF) is used to exchange files between applications and computer platforms. TIFF is a flexible bitmap image format supported by virtually all paint, image-editing, and page-layout applications. Also, virtually all desktop scanners can produce TIFF images. TIFF documents have a maximum file size of 4 GB. Photoshop CS supports large documents saved in TIFF format. However, most other applications and older versions of Photoshop do not support documents with file sizes greater than 2 GB.

TIFF format supports CMYK, RGB, Lab, Indexed Color, and Grayscale images with alpha channels and Bitmap mode images without alpha channels. Photoshop can save layers in a TIFF file; however, if you open the file in another application, only the flattened image is visible. Photoshop can also save annotations, transparency, and multiresolution pyramid data in TIFF format.

In Photoshop, TIFF image files have a bit depth of 8, 16, or 32 bits per channel. You can save high dynamic range images as 32‑bits-per-channel TIFF files.

= Download Batch (Graphic Archive) =

- Access the fulfillment -> printouts section of the * by hovering over the fulfillment tab in the upper right hand corner of the page and choosing printouts.
- Download the desired archive and extract the pixel folder to a working directory. (The desktop is a common choice)

Now launch Adobe Photoshop and continue with the next section.

= Pre-Processing (Photoshop) =

This is the first stage of graphical processing. It is mostly graphic pre-processing as the channel seperation will be done with Onyx PosterShop.

This section consists of the following steps:

- Graphic Preparation
- Reduce Shirt Color Range
- Create Spot Channels
- Fill Spot Channels
- Graphic Export

## Graphic Preparation

1. Open the original graphic.
1. Convert graphic to CMYK color.
1. From the menu-bar select **Image -> Mode -> CMYK**.
1. Set the graphic dimensions to **20 x 28 inches**.
1. From the menu-bar select **Image -> Canvas Size** (CTRL+ALT+C)
1. In the Canvas Size dialog enter 20 for width and 28 for height and click OK.
1. Flatten the graphic.
1. From the menu-bar select **Layer -> Flatten Image**.
1. Convert the Background Layer to a regular layer by right clicking on it in the Layers Pallet and choosing **Layer From Background...**
1. Default options on the New Layer window are correct. Simply press OK to convert the background layer.

## Reduce Garment Color Range

**Reducing a color range is not needed on white or "nearwhite" garments!!**

If you are working with a white or "nearwhite" garments please continue with [Graphic Export](misc--.md#graphic-export).

Because the design will be printed directly onto the garment, it is wasteful to print the garment color at 100%. Therefore we will reduce this based on the following classifications.

### Black Garments

Because we are using CMYK black garments are the easiest to reduce.

1. Remove the background with the **Magic Wand Tool** leaving the shadows and accents of the core graphic in tact.
1. Under the Channels pallet select the K channel.
1. Open the Levels dialog (CTRL+L)
1. Change the top-right most value to 100.
1. Change the middle value to 1.50.

### Color Garments

Color garments can be more complex depending on the intensity of the garment.

1. Remove garment color with the **Select Color Range...**
1. Double click on the **Foreground Color** and input the garment [http://en.wikipedia.org/wiki/Web_colors#Hex_triplet Hex triplet] from the filename into the field next to the pound sign.
1. From the menu-bar select **Select -> Select Color Range...**.
1. Ensure the following: Select: Sampled Colors, Fuzziness: 40, Radio: Selection and click OK
1. Press Delete on your keyboard to remove the garment color from the graphic.

## Create Spot Color Channels

**Spot Color Channels are only needed for dark digitals!!**

If you are working with a light digital please continue with [Graphic Export](misc--.md#graphic-export).

Spot Color Channels are explained in detail in [Spot Colors](misc--.md#spot-colors). In simple terms we will use these channels to provide the White and Highlight information.

1. Create Spot Color Channels
1. In the Channels Pallet at the bottom there is a small square next to a trash can icon. If you hover over this icon it should read **Create new channel**.
1. CTRL+CLICK on this icon to create a new Spot Color Channel.
1. In the New Spot Channel window set the following values for the white channel.
1. Name: White
1. Color: Blue
1. Solidity: 50%
1. Repeat for the highlight channel
1. Name: Highlight
1. Color: Red
1. Solidity: 50%

Once you have created both of you spot channels your channels pallet should reflect the channels listed below.

**Note:** Please keep in mind the order is very important and if you change it the inks will print reversed.

- Cyan
- Magenta
- Yellow
- Black
- White
- Highlight

## Fill Spot Channels

Filling the spot channels is a skill within itself. It becomes easier after each unique graphic you complete. Learning how to reproduce gradients with the highlight channel can be a very delicate process. Likewise knowing what aspects of the image require the white underlay can at time be confusing. With this document and the available video tutorials you should be able to develop an understanding of when, how and what to do. Below you will find examples of different spot channel classifications.

## Graphic Export

= Channel Separation (Onyx PosterShop) =

= Network Storage =

= Sources =

- Adobe Photoshop Help
- Wikipedia

