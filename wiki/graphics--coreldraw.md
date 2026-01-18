# CorelDraw


## Open .EPS Files with CorelDraw11

For some reason there is a bug in CorelDraw11 which prohibits it from opening .EPS files. Instead in inserts a gray box representing the bounding box of the image with the file information. I have found a workaround for this issue and it is explained below.



- Open CorelDraw11 and create a blank document.
- From the **Tools** sub-menu of the menu bar select **Customization**.
- You should now see the Options window appear. On the left side of this window there is a tree at the bottom of the tree is the **Global** element, Click on it and expand it.
- Click on **Filters** and on the right of the options window should appear the Filters file association options.
- What we want to do is tell Corel to use a different filter than the traditional EPS filter to open EPS files. So on the far right you should see a list box with all of the currently configured filters and their associated files. Locate **EPS - Encapsulated PostScript** and click on it once to highlight it. Now it gets a tad complex because we still want to be able to export .EPS files but we don't want to use the .EPS filter to import them. So what we need to do is give it less of a priority than the PostScript filter. We  can do this by using the **Move Down** button to move it below the **PS, PRN, EPS - PostScript** filter.
- Once this is completed EPS files will fall back onto the PostScript filter. This is OK because an EPS is still PostScript at the core and we will only have to ensure some simple options for the filter at time of open. Click **OK** to save your changes and close the Options window.
- Close the existing blank document and locate a valid .EPS we can use to test.
- There are some more bugs / anomalies with CorelDraw11 when it comes to file names. So the only way I am able to have it keep my file name is by dragging the desired file(s) into the CorelDraw workspace. (Please ensure no documents are open as it will then insert the files into the open document rather than creating a temp document with the file name for each file)
- Once a file is dropped onto the workspace you will be prompted with the **Import PostScript** dialog box. Simply configure the following settings:

- VM Size: 8.0 MB
- Import text as Curves
- Report PostScript errors

- Click **OK** to dismiss the box and open the .EPS file. You should now see curves and be able to manipulate the vector graphic.

I should mention that I have seen instances where files open blank, but I had not found any file which did not open to be a properly formated EPS file. I usually use an application like Adobe Illustrator to confirm that the file is not corrupted. I.E. no bitmap images, mesh objects, redundant paths. Once I verify this I re-export it as an .EPS and then in order for CorelDraw11 to open the file it needs to be converted by [Goverts GoBatchGS](graphics--goverts-gobatchgs.md). This has been successful everytime. Hope this is of help to someone.

## FAQ

### Why won't my curves weld properly after I converted them from outlines?

CorelDraw 11 has a bug in the **Convert Outline to Object** tool where it is unable to convert outlines which are not a whole number in width. This bug was encountered in a file exported from Freehand 10. It is not always reproducible but an easy fix is reduce the outline to a whole number.

= Macros =

## Installing

To install a macro in Corel Applications please follow these steps:

- Copy your desired macro files so we are able to paste them into the correct location.
**Note:** All Corel macro files should have an extension of .gms
- Browse to the GMS folder:
- Under windows the path should be as follows:
```bash
C:\Program Files\Corel\<Corel App Folder>\Draw\GMS\
```
- Paste the files you copied in the first step into the GMS folder and close all windows\Applications.
- Launch the Corel application and create a new blank document.
- From the **Tools** menu choose **Customization**
- From the left menu tree choose **Commands** and then from the drop down box on the right choose **Macros**.
- Select the desired macros from the list and do one or more of the following:
- Click and drag the macro onto any toolbar.
- Click on the **Shortcut Keys** and assign a memorable key command.
- Click **OK** to apply the changes and enjoy your macroing!

## Examples

### Create Measurement Shapes

```
Sub Measure()
    ActivePage.CreateLayer "Measure"
    ' Create Negative Space Ruler
    Dim n_space As Shape
    ActiveDocument.Unit = cdrMillimeter
    Set n_space = ActiveLayer.CreateEllipse(0, 1, 1, 0)
    n_space.Outline.Type = cdrNoOutline
    n_space.Fill.UniformColor.CMYKAssign 0, 100, 100, 0
    ' Create Positive Space Ruler
    Dim p_space As Shape
    ActiveDocument.Unit = cdrMillimeter
    Set p_space = ActiveLayer.CreateEllipse(1, 1.5, 2.5, 0)
    p_space.Outline.Type = cdrNoOutline
    p_space.Fill.UniformColor.CMYKAssign 100, 0, 0, 0
End Sub
```

```
Sub KillMeasure()
    ActivePage.Layers("Measure").Delete
End Sub
```

### Convert Outlines to Objects

Locates all shapes with outlines and converts them to objects. Then deletes the leftover null shapes.

```
Sub CvertOutlines()
    Dim sh As Shape, shRange As ShapeRange
    ActivePage.Shapes.All.CreateSelection
    Set shRange = ActiveSelectionRange
    'Find Outlines and Cvert to Objects
    For Each sh In shRange
        If sh.Outline.Type = cdrOutline Then
            'sh.Selected = False
            sh.Outline.ConvertToObject
        End If
    Next sh
    ActivePage.Shapes.All.CreateSelection
    'Find Null Shapes and Delete
    For Each sh In shRange
        If sh.Outline.Type = cdrNoOutline And sh.Fill.Type = cdrNoFill Then
            sh.Delete
        End If
    Next sh
End Sub
```

### Center Shapes and Crop Document

```
Sub AutoSizePage()
    On Error Resume Next
    ActiveDocument.BeginCommandGroup "AutoSizePage"
    Dim CurRange As ShapeRange, Width As Double, Height As Double, mSpace As Double
        'Margin size.
    mSpace = 0.05
        'Get shape(s) range.
    Set CurRange = ActivePage.Shapes.All

    If CurRange.count > 0 Then
        ActiveDocument.Unit = cdrInch
            'Get range size + margin.
        CurRange.GetSize Width, Height
            'Adjust current page size.
        ActivePage.SetSize Width + mSpace, Height + mSpace
            'Check application version
        If Application.VersionMajor > 11 Then
                'Align range to center of page.
            CurRange.AlignRangeToPage cdrAlignHCenter + cdrAlignVCenter
        Else
                'Bug fix set default page size for export
            ActiveDocument.Pages(0).SetSize Width + mSpace, Height + mSpace
                'Set range postion to center since no AlignRangeToPage in 11
            CurRange.SetPosition (mSpace / 2), Height + (mSpace / 2)
        End If
    Else
        MsgBox "Please select 1 or more object(s).", vbExclamation, "AutoSizePage"
    End If
    
    ActiveDocument.ClearSelection
    ActiveDocument.EndCommandGroup
End Sub
```

### Convert to Curves, Ungroup All, Mirror, Set Outline Width & Color, Remove Fill

```
Sub CutnClean()
'By Luke Jackson 16.10.2007
'##########################
    On Error Resume Next
    ActiveDocument.BeginCommandGroup "CutnClean"
    'Unlock and Ungroup all objects
    ActivePage.Shapes.All.Unlock
    ActivePage.Shapes.All.UngroupAll
    'Copy fill color to outline
    Dim oColor As Color, sCount As Long, sShape As Shape
    sCount = ActivePage.Shapes.count
    Set sShape = ActivePage.Shapes.Item(2)
    If sCount > 2 And sShape.Fill.Type <> cdrNoFill Then
        Set oColor = sShape.Fill.UniformColor
        ActivePage.Shapes.All.SetOutlineProperties Color:=oColor
    End If
    'Convert text to curves
    ActivePage.Shapes.All.ConvertToCurves
    'Group to prevent overlap
    ActivePage.Shapes.All.Group
    'Mirror for cutting
    ActivePage.Shapes.All.Flip cdrFlipHorizontal
    'Set width to hairline, remove fill
    ActivePage.Shapes.All.SetOutlineProperties width:=0.003
    ActivePage.Shapes.All.ApplyNoFill
    'Clear group and selection
    ActivePage.Shapes.All.UngroupAll
    ActiveDocument.ClearSelection
    ActiveDocument.EndCommandGroup
End Sub
```

### Create Text

```
Sub IPageNumber()
    On Error Resume Next
    ActiveDocument.BeginCommandGroup "IPageNumber"
    Nesting.IPageNumberEx
    ActiveDocument.EndCommandGroup
End Sub

Private Sub IPageNumberEx(Optional t_pages As Integer = 0)
    Dim p_name, o_name As String, p_text As String, s_text As String, c_text As String
    o_name = ActivePage.Name
        'Get page number from page name.
    p_name = Split(o_name, " ", -1, vbTextCompare)
        'Set prefix and suffix
    p_text = "PG-"
    s_text = "-of-"
    
    If o_name = "Page 1" Then
        If t_pages > 0 Then
                'Assemble as single string.
            c_text = p_text & p_name(1) & s_text & t_pages
            Nesting.cTextShape c_text, "Arial", 50, cdrInch
        Else
            frmIPageNumber.Show
        End If
    Else
            'Assemble as single string.
        c_text = p_text & p_name(1)
        Nesting.cTextShape c_text, "Arial", 50, cdrInch
    End If
End Sub

Private Sub btOK_Click()
    If IsNumeric(txtPages.Value) And txtPages.Value > 0 And txtPages.Value < 32768 Then
        IPageNumberEx txtPages.Value
    Else
        MsgBox "Please enter a number greater than 0 and less than 32768.", , "IPageNumber"
    End If
    Unload Me
End Sub

Private Sub btCancel_Click()
    Unload Me
End Sub

Private Sub cTextShape(s_text As String, s_font As String, s_size As Byte, d_unit As cdrUnit)
        'Create text shape with s_text.
    Dim sh As Shape
    ActiveDocument.Unit = d_unit
    c_text = Trim(s_text)
    'MsgBox c_text
    Set sh = ActiveLayer.CreateArtisticText(1, 1, c_text, cdrEnglishUS, cdrCharSetDefault, s_font, s_size)
    'Nesting.GetClick
End Sub
```

### AutoAnSPage

```
Sub AutoAnSPage()
    On Error Resume Next
    ActiveDocument.BeginCommandGroup "AutoAnSPage"
    Dim doc As Document
    Dim ss As ShapeRange
    Dim leftMargin As Integer
    Dim topMargin As Integer
    
    Set doc = ActiveDocument
    doc.Unit = cdrMillimeter
    
    'Set Margin
    leftMargin = 5
    topMargin = 15
    
    Set ss = doc.ActivePage.Shapes.All

    If ss.count > 0 Then
        
        If ss.SizeWidth > ss.SizeHeight Then
        
            'Force Portrit
            ss.Rotate 270
        
        End If
        
        'Align Foil to Workspace
        ss.AlignRangeToPoint cdrAlignTop + cdrAlignLeft, (ActivePage.LeftX + leftMargin), (ActivePage.TopY - topMargin)
        
    Else
        MsgBox "Please select 1 or more object(s).", vbExclamation, "AutoAnSPage"
    End If
    ActiveDocument.ClearSelection
    ActiveDocument.EndCommandGroup
End Sub
```

### AutoAnSPageNoRotate

```
Sub AutoAnSPageNoRotate()
    On Error Resume Next
    ActiveDocument.BeginCommandGroup "AutoAnSPageNoRotate"
    Dim doc As Document
    Dim ss As ShapeRange
    Dim wb As ShapeRange
    Dim leftMargin As Integer
    Dim topMargin As Integer
    
    Set doc = ActiveDocument
    doc.Unit = cdrMillimeter
    
    'Set Margin
    leftMargin = 5
    topMargin = 5
    
    Set ss = doc.ActivePage.Shapes.All
    Set wb = doc.ActivePage.FindShapes(Name:="WeedBorder")
    wb.Delete
    
    If ss.count > 0 Then
        
        'If ss.SizeWidth > ss.SizeHeight Then
        
            'Force Portrit
            ss.Rotate 270
        
        'End If
        
        'Align Foil to Workspace
        ss.AlignRangeToPoint cdrAlignTop + cdrAlignLeft, (ActivePage.LeftX + leftMargin), (ActivePage.TopY - topMargin)
        
        Nesting.WeedingBoardHeader
        
    Else
        MsgBox "Please select 1 or more object(s).", vbExclamation, "AutoAnSPageNoRotate"
    End If
    ActiveDocument.ClearSelection
    ActiveDocument.EndCommandGroup
End Sub
```

### WeedingBoardHeader

```
Sub WeedingBoardHeader()
    On Error Resume Next
    ActiveDocument.BeginCommandGroup "WeedingBoardHeader"
    Dim doc As Document
    Dim ss As ShapeRange
    Dim wb As ShapeRange
    Dim leftMargin As Integer
    Dim topMargin As Integer
    
    Set doc = ActiveDocument
    doc.Unit = cdrMillimeter
    
    'Set Margin
    leftMargin = 10
    topMargin = 0
    
    Set ss = doc.ActivePage.Shapes.All
    Set wb = doc.ActivePage.FindShapes(Name:="WeedBorder")
    
    If wb.count = 0 Then
    
        Dim s1 As Shape
        Set s1 = ActiveLayer.CreateLineSegment(5, 0, 450, 0)
        s1.Name = "WeedBorder"
        s1.Fill.ApplyNoFill
        s1.Outline.SetProperties 0.003, OutlineStyles(0), CreateCMYKColor(0, 0, 0, 100), ArrowHeads(0), ArrowHeads(0), cdrFalse, cdrFalse, cdrOutlineButtLineCaps, cdrOutlineMiterLineJoin, 0#, 100, MiterLimit:=45#
        wb.Add s1
        wb.AlignRangeToPoint cdrAlignTop + cdrAlignLeft, (ActivePage.LeftX + leftMargin), (ActivePage.TopY - topMargin)
        
        'This is where we flip the designs to make space for pull board
        ss.Add s1
        ss.Rotate 180
        
    Else
        MsgBox "Weeding Border Already Exists.", vbExclamation, "AutoAnSPage"
    End If
    ActiveDocument.ClearSelection
    ActiveDocument.EndCommandGroup
End Sub
```

### AutoAnSPageNoRotate

```
Sub AutoAnSPageNoRotate()
    On Error Resume Next
    ActiveDocument.BeginCommandGroup "AutoAnSPageNoRotate"
    Dim doc As Document
    Dim ss As ShapeRange
    Dim wb As ShapeRange
    Dim leftMargin As Integer
    Dim topMargin As Integer
    
    Set doc = ActiveDocument
    doc.Unit = cdrMillimeter
    
    'Set Margin
    leftMargin = 5
    topMargin = 35
    
    Set ss = doc.ActivePage.Shapes.All
    Set wb = doc.ActivePage.FindShapes(Name:="WeedBorder")
    wb.Delete
    
    Nesting.WeedingBoardHeader
    
    If ss.count > 0 Then
        
        'If ss.SizeWidth > ss.SizeHeight Then
        
            'Force Portrit
            ss.Rotate 270
        
        'End If
        
        'Align Foil to Workspace
        ss.AlignRangeToPoint cdrAlignTop + cdrAlignLeft, (ActivePage.LeftX + leftMargin), (ActivePage.TopY - topMargin)
        
    Else
        MsgBox "Please select 1 or more object(s).", vbExclamation, "AutoAnSPageNoRotate"
    End If
    ActiveDocument.ClearSelection
    ActiveDocument.EndCommandGroup
End Sub
```

### Slightly adjust color of shapes

```
Private Sub ColorNudge()
Dim cFill As New Color
    cFill.CopyAssign s.Fill.UniformColor
    cFill.ConvertToCMYK
    cFill.CMYKBlack = cFill.CMYKBlack - 5
    s.Fill.UniformColor = cFill
End Sub
```

### QRotate

Assign to key commands for quick rotation of selection.

```
Sub QRotate90()
    ActiveSelection.Rotate (90)
End Sub

Sub QRotate45()
    ActiveSelection.Rotate (45)
End Sub
```

### Find Shapes Base

```
Sub FindShapesNoFillandOutline()
    Dim response As Long
    Dim sr As New ShapeRange
    'Check all the shape on the current Page
    FindShapesNoFillandOutlineSub ActivePage.Shapes, sr
    
    'Report back what was found from search
    If sr.Shapes.Count > 0 Then
        response = MsgBox("Number of shape to be deleted: " & sr.Count, vbYesNo, "Delete Shapes")
        If response = vbYes Then sr.Delete
    Else
        MsgBox "No Shapes Found."
    End If
End Sub

Sub FindShapesNoFillandOutlineSub(ss As Shapes, sr As ShapeRange)
    Dim s As Shape
    
    For Each s In ss
        If s.Type = cdrGroupShape Then
            'If a group is found loop all shapes in the group
            FindShapesNoFillandOutlineSub s.Shapes, sr
        Else
            'If shape has no fill and no outline add to shaperange
            If s.Fill.Type = cdrNoFill And s.Outline.Type = cdrNoOutline Then sr.add s
        End If
    Next s
End Sub
```

= Registry Settings =

## Default Page
```
[HKEY_CURRENT_USER\Software\Corel\CorelDraw\13.0\CorelDRAW\Application Preferences\Page Setup Settings]
"PaperSize"="4600000,5600000"
"PaperSizeType"="0"
"PaperOrientation"="0"
"PageLayout"="1"
"FacingPages"="0"
"LeftPageFirst"="0"
"PageBorderVisible"="1"
"PrintAndExportPageBackground"="1"
"Bleed"="0"
"BleedVisible"="0"

[HKEY_CURRENT_USER\Software\Corel\CorelDraw\13.0\CorelDRAW\Application Preferences\Ruler and Grid Settings]
"DrawingOrigin"="-2300000,-2800000"
"XGridFreq"="4.000000"
"YGridFreq"="4.000000"
"WorldPageUnits"="5"
"WorldScale"="1.000000"
"XRulerUnits"="5"
"YRulerUnits"="5"
"UseImperialTicksPerInch"="0"
"MinorTick"="0"
"HPixelResolution"="11811024"
"VPixelResolution"="11811024"
"ShowFraction"="1"
"GridShowAsLines"="1"
"GridUseFrequency"="1"
"SMHPixelResolution"="11811024"
"SMVPixelResolution"="11811024"
```

## Disable Welcome Screen

'''Doesn't Work!! Yet!!'''
```
[HKEY_CURRENT_USER\Software\Corel\CorelDraw\13.0\CorelDRAW\Application Preferences\Startup]
"ShowHintsOnStartup"="0"
```

= See Also =

- [EPS Optimization](graphics--eps-optimization.md)
- [Goverts GoBatchGS](graphics--goverts-gobatchgs.md)

= Tags =

Visual Basic Script, VBA, Visual Basic Macro, Corel Draw

= Sources =

- http://forum.oberonplace.com

