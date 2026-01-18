# Excel


= Windows XP =

### Replace Non-Standard Space Characters

The ASCII code for non-breaking space is 160 and along with other chars like 202 which look like space but have different ASCII values cause very frustrating problems for formulas using functions like SUBSTITUTE(). Additionally functions like CLEAN() do not detect these CHARs as they are technical valid within the extended ASCII code set. Fortunately we can replace them with space or other delimiters using the SUBSTITUTE() function in combination with the CHAR() function.

```bash
=SUBSTITUTE(SUBSTITUTE(B2, CHAR(202), CHAR(32)), CHAR(160), CHAR(32))

```
In most cases it will likely be easier to clean the data in bash using tr, sed, and awk. The example below replaces carriage returns with newline and removes all non essential ASCII characters using their respective ASCII codes. Characters can be deleted or replaced by utilizing the -d command parameter. Dive Deeper: https://alvinalexander.com/blog/post/linux-unix/how-remove-non-printable-ascii-characters-file-unix 

```
pbpaste | tr '\r\n' '\n' | tr -c '\11\12\15\40-\176' '\t' | grep ^[digit:::digit:](misc--.md) | pbcopy
```

```bash
pbpaste | tr -cd '\11\12\15\40-\176'

```
You can also attempt to count the total LEN and function off of that result

```bash
=IF(LEN(C20)=4,VALUE(LEFT(C20,1)),VALUE(LEFT(C20,2)))

```
### String Manipulation

Split on First Occurrence of Char and return all chars **before** split point

```bash
=MID(D2,1,(FIND(CHAR(1),SUBSTITUTE(D2,":",CHAR(1),1),1)-1))

```
Split on First Occurrence of Char and return all chars **after** split point

```bash
=MID(D2,(FIND(CHAR(1),SUBSTITUTE(D2,":",CHAR(1),1),1)+1),(LEN(D2)-FIND(CHAR(1),SUBSTITUTE(D2,":",CHAR(1),1),1)))

```
Split on Last Occurrence of Char and return last 13 characters

```bash
=MID(B2,(FIND(CHAR(1),SUBSTITUTE(B2, "PKG-", CHAR(1),((LEN(B2)-LEN(SUBSTITUTE(UPPER(B2),"PKG-","")))/LEN("PKG-"))),1)+LEN("PKG-")),13)

```
Split on Last Occurrence of Char and return to end of string

```bash
=TRIM(RIGHT(SUBSTITUTE(H2," ",REPT(" ",LEN(H2))),LEN(H2)))

```
Sub-string by occurrence of two characters (extract text between characters)
```bash
=MID(A2,SEARCH("(",A2)+1,SEARCH("@",A2)-SEARCH("(",A2)-1)
=MID(TRIM(RIGHT(SUBSTITUTE(A2,"(",REPT(" ",LEN(A2))),LEN(A2))),1,(FIND("@",TRIM(RIGHT(SUBSTITUTE(A2,"(",REPT(" ",LEN(A2))),LEN(A2))), 1)-1))

```
### Date and Time

Excel stores dates as sequential serial numbers so that they can be used in calculations. January 1, 1900 is serial number 1, and January 1, 2008 is serial number 39448 because it is 39,447 days after January 1, 1900. You will need to change the number format (Format Cells) in order to display a proper date.

Remember that Excel stores times as a fraction of a day, so to convert any given time to minutes you simply multiply a time value by the number of minutes in a day (24 * 60 = 1440). You can then divide by the desired time interval, in this case 15.

Days since January 1, 1900 (View Timestamp as Number) = 42602.7936342593

```bash
=(("8/21/2016  7:02:50 PM" * 1)

```
Days since January 1, 1900 (No Change) = 42602.7936342593

```bash
=(("8/21/2016  7:02:50 PM" * (24*60))/15)/((24*60)/15)

```
Multiples of Fifteen = 4089868.18888889 

```bash
=(("8/21/2016  7:02:50 PM" * (24*60))/15)

```
Run a FLOOR function Before Converting back into Days = 42602.7916666667

```bash
=FLOOR(("8/21/2016  7:02:50 PM" * (24*60)/15),1)/((24*60)/15)

```
The final result returns the 15 minute grouping (00,15,30,45) rounded down.

```bash
=(FLOOR((N4*(24/4)),1)/((24/4)))*24

```
This also works with any integer, in this case we group days into 4 hour groups.

### Index Match on multiple criteria

Return value in respective Index cell

```bash
=INDEX(Setup.Benchmark!$F$1:$F$781,MATCH(1,(G2=Setup.Benchmark!$G$1:$G$781)*(I2=Setup.Benchmark!$J$1:$J$781)*(J2=Setup.Benchmark!$K$1:$K$781),0))

```
Return 1 or 0 based on match

```bash
=IF(ISNUMBER(MATCH(1,(G2=Setup.Benchmark!$G$1:$G$781)*(I2=Setup.Benchmark!$J$1:$J$781)*(J2=Setup.Benchmark!$K$1:$K$781),0)),1,0)
 

```
### Non Printable Characters, VLOOKUP or INDEX MATCH #N/A Error Fix, Solution

```bash
=VLOOKUP(TRIM(SUBSTITUTE(D2,CHAR(160),CHAR(32))),'io85'!A:D,4,FALSE)

```
#### Excel Help

**Important**  The TRIM function was designed to trim the 7-bit ASCII space character (value 32) from text. In the Unicode character set, there is an additional space character called the nonbreaking space character that has a decimal value of 160. This character is commonly used in Web pages as the HTML entity, &nbsp;. By itself, the TRIM function does not remove this nonbreaking space character. For an example of how to trim both space characters from text, see Remove spaces and nonprinting characters from text.

```
Sometimes text values contain leading, trailing, or multiple embedded space characters (Unicode character set (Unicode: A character encoding standard developed by the Unicode Consortium. By using more than one byte to represent each character, Unicode enables almost all of the written languages in the world to be represented by using a single character set.) values 32 and 160), or non-printing characters (Unicode character set values 0 to 31, 127, 129, 141, 143, 144, and 157). These characters can sometimes cause unexpected results when you sort, filter, or search. For example, users may make typographical errors by inadvertently adding extra space characters, or imported text data from external sources may contain nonprinting characters embedded in the text. Because these characters are not easily noticed, the unexpected results may be difficult to understand. To remove these unwanted characters, you can use a combination of the TRIM, CLEAN, and SUBSTITUTE functions. 

The TRIM function removes spaces from text except for single spaces between words. The CLEAN function removes all nonprintable characters from text. Both functions were designed to work with 7-bit ASCII, which is a subset of the ANSI character set (ANSI character set: An 8-bit character set used by Microsoft Windows that allows you to represent up to 256 characters (0 through 255) by using your keyboard. The ASCII character set is a subset of the ANSI set.). It's important to understand that the first 128 values (0 to 127) in 7-bit ASCII represent the same characters as the first 128 values in the Unicode character set.

The TRIM function was designed to trim the 7-bit ASCII space character (value 32) from text. In the Unicode character set, there is an additional space character called the nonbreaking space character that has a decimal value of 160. This character is commonly used in Web pages as the HTML entity, &nbsp;. By itself, the TRIM function does not remove this nonbreaking space character. 

The CLEAN function was designed to remove the first 32 non-printing characters in the 7 bit ASCII code (values 0 through 31) from text. In the Unicode character set, there are additional nonprinting characters (values 127, 129, 141, 143, 144, and 157). By itself, the CLEAN function does not remove these additional nonprinting characters. 

To do this task, use the SUBSTITUTE function to replace the higher value Unicode characters with the 7-bit ASCII characters for which the TRIM and CLEAN functions were designed.
```

### Clean / Trim Non Printing Chars from Excel Data

Removes the trailing space from the string "BD 122 " (BD 112) 

```bash
=TRIM(A2)
```
Removes the nonprinting BEL character (ASCII value of 7) from the string value created by the expression ="XY"&CHAR(7)&"453" (XY453) 

```bash
=CLEAN(A3) 

Replaces each nonbreaking space character (Unicode value of 160) with a space character (ASCII value of 32) by using the SUBSTITUTE function, and then removes the leading and multiple embedded spaces from the string " BD   122" (BD 112) 

=TRIM(SUBSTITUTE(A4,CHAR(160),CHAR(32)))

```
Replaces the nonprinting DEL character (ASCII value of 127) with a BEL character (ASCII value of 7) by using the SUBSTITUTE function, and then removes the BEL character from the string "MN987" (MN987) 

```bash
=CLEAN(SUBSTITUTE(A5,CHAR(127),CHAR(7)))

```
### Excel 2007

Data -> From Other Sources ->

### Dynamic Chart Titles From Pivot Table (Date Range)

```bash
=IF(DAY(MIN(Summary!$B$6:$B$20))=DAY(MAX(Summary!$B$6:$B$20)),CONCATENATE("CW ",WEEKNUM(MIN(Summary!$B$6:$B$20),1)," - ",TEXT(MIN(Summary!$B$6:$B$20),"mmmm"), ", ",DAY(MIN(Summary!$B$6:$B$20))&IF(OR(DAY(MIN(Summary!$B$6:$B$20))={1,2,3,21,22,23,31}),CHOOSE(1*RIGHT(DAY(MIN(Summary!$B$6:$B$20)),1),"st","nd ","rd"),"th")),CONCATENATE("CW ",WEEKNUM(MIN(Summary!$B$6:$B$20),1)," - ",TEXT(MIN(Summary!$B$6:$B$20),"mmmm"), ", ",DAY(MIN(Summary!$B$6:$B$20))&IF(OR(DAY(MIN(Summary!$B$6:$B$20))={1,2,3,21,22,23,31}),CHOOSE(1*RIGHT(DAY(MIN(Summary!$B$6:$B$20)),1),"st","nd ","rd"),"th")," - ",CONCATENATE("CW ",WEEKNUM(MAX(Summary!$B$6:$B$20),1)," - ",TEXT(MAX(Summary!$B$6:$B$20),"mmmm"), ", ",DAY(MAX(Summary!$B$6:$B$20))&IF(OR(DAY(MAX(Summary!$B$6:$B$20))={1,2,3,21,22,23,31}),CHOOSE(1*RIGHT(DAY(MAX(Summary!$B$6:$B$20)),1),"st","nd ","rd"),"th"))))

```
### Week Number

```bash
=CONCATENATE("Cal Week: ", (1+INT((#REF!-(DATE(YEAR(#REF!),1,2)-WEEKDAY(DATE(YEAR(#REF!),1,0))))/7)))

=WEEKNUM(TEXT(E2, "mmmm dd, yyyy"), 2)

```
## Count Cells when not blank

```bash
=COUNTIF(D2:G2,"<>"&"")

```
## Concatenate Vlookup Values When Source is not blank

```bash
=CONCATENATE(IF(D17 <> "",(VLOOKUP(D17,Printtypes!$A$1:$B$19, 2,FALSE)),""),IF(E17 <> "",(", " & VLOOKUP(E17,Printtypes!$A$1:$B$19, 2,FALSE)),""),IF(F17 <> "",(", " & VLOOKUP(F17,Printtypes!$A$1:$B$19, 2,FALSE)),""),IF(G17 <> "",(", " & VLOOKUP(G17,Printtypes!$A$1:$B$19, 2,FALSE)),""))

```
## CountIf with Subtotal (Respects Hidden/Filtered Cells

```bash
=SUMPRODUCT(SUBTOTAL(3,OFFSET(B1:B51,ROW(B1:B51)-ROW(B1),0,1)),--(B1:B51="Inactive"))

```
## Count Unique Names / Numbers

The entire formula is as follows (replace C3:C25 with the range of data you want the formula to check)

```bash
=SUM(IF(FREQUENCY(IF(LEN(C3:C25)>0,MATCH(C3:C25,C3:C25,0),""), IF(LEN(C3:C25)>0,MATCH(C3:C25,C3:C25,0),""))>0,1))

```
If you just want to count unique numbers, and not text, use the following formula instead:

```bash
=SUM(IF(FREQUENCY(C3:C25, C3:C25)>0,1))

```
## Split string by occurrence of character

Return the portion of string from the second occurrence of character:

```bash
=RIGHT($E2;LEN($E2) - FIND("-";$E2;FIND("-";$E2)+1))

```
Return the portion of string until the first occurrence of character:

```bash
=LEFT($E2;FIND("-";$E2)-1)


```
## Replace Double Quotes and Comma Within String

```bash
=SUBSTITUTE(N1, CONCATENATE(CHAR(34),",",CHAR(34)),  "")

```
## Conditional Formating "At Change In Value"

```
Private Sub Worksheet_Change(ByVal Target As Range)

  Dim C As Variant
  Dim Clast As Variant
  Dim CI As Integer
  Dim ColS As Variant
  Dim ColE As Variant
  Dim FirstRow As Long
  Dim LastRow As Long
  Dim Rng As Range
  Dim Wks As Worksheet
  Dim Color As Boolean
  Dim Total As Long
  
  If Target.Row > 0 Then
  
        ColS = "A"
        ColE = "L"
        FirstRow = 2   'Assumes header row is row 1
        Set Wks = Worksheets("Scoreboard")
        'LastRow = Wks.Cells(Rows.Count, ColS).End(xlUp).Row
        LastRow = Target.Row
        
        LastRow = IIf(LastRow < FirstRow, FirstRow, LastRow)
    
      Set Rng = Wks.Range(Cells(FirstRow, ColS), Cells(LastRow, ColS))
        For Each C In Rng
          If IsDate(C) Then
            
            If Clast = "" Then
                CI = 50
                Clast = C
                'MsgBox "Start " & C & " - " & Clast
            ElseIf C <> Clast And Color = False Then
                CI = xlColorIndexNone
                Color = True
                'MsgBox "CF CNE " & C & "<>" & Clast
                Clast = C
            ElseIf C <> Clast And Color = True Then
                CI = 50
                Color = False
                'MsgBox "CT CNE " & C & "<>" & Clast
                Clast = C
            ElseIf C = Clast And Color = False Then
                CI = 50
                'MsgBox "CF CE " & C & "=" & Clast
                Clast = C
            ElseIf C = Clast And Color = True Then
                CI = xlColorIndexNone
                'MsgBox "CT CE " & C & "=" & Clast
                Clast = C
            Else
                CI = xlColorIndexNone
                MsgBox "Else " & C
            End If
            
            If CI > 0 Then
                With Range(Cells(C.Row, ColS), Cells(C.Row, ColE)).Interior
                    .Pattern = xlSolid
                    .PatternColorIndex = xlAutomatic
                    .ThemeColor = xlThemeColorAccent3
                    .TintAndShade = 0.599993896298105
                    .PatternTintAndShade = 0
                End With
            Else
                With Range(Cells(C.Row, ColS), Cells(C.Row, ColE)).Interior
                    .Pattern = xlNone
                    .TintAndShade = 0
                    .PatternTintAndShade = 0
                End With
            End If
            
          End If
          
          Total = Total + 1
          
        Next C
        
        'MsgBox Total
    End If
        
End Sub
```

## Function

```bash
=IF(INDIRECT(ADDRESS(ROW(),1,3))<>INDIRECT(ADDRESS((ROW()-1),1,3)),1,0)

```
## Date Filters Not Available for Pivot Table / Chart

Date Filters are not supported in Excel 2003 compatibility mode.

Re-save document in Excel 2007 format and the options will no longer be greyed out.

## Dynamic Graph/Chart Title

```bash
="Operator Summary - " & TEXT(MIN(Summary!$B$6:$B$20),"ddd, mmm dd, yyyy") & " to " & TEXT(MAX(Summary!$B$6:$B$20),"ddd, mmm dd, yyyy")

```
## Compound Interest

```bash
(100000 * (1 + (0,08/12))^(1)) - 100000

40000000 * (00042 / (1 - ((1 + 00042)^-(360)))) 

```
Monthly Mortgage payment + Opportunity cost of monthly interest earned on 20% down payment 

```bash
2147 + (100000 * (1 + (0,08/12))^(1)) - 100000

```
- http://www.thecalculatorsite.com/articles/finance/compound-interest-formula.php
- http://www.loansanddebts.com/mortgage_calculator.php

= Mac OS X =

## File Not Found

When starting Microsoft Excel 2004 for Mac OS X you may get the error "File Not Found". 

First place to check is the Excel Startup folder:

```
ljackson 14:46:50 ~/Library/Preferences> cd /Applications/Microsoft\ Office\ 2004/Office/Startup/
ljackson 14:47:33 /Applications/Microsoft Office 2004/Office/Startup> ll
drwxrwxr-x   4 ljackson  admin  136B May  3 14:39 Excel
drwxrwxr-x   2 ljackson  admin  68B Apr  8  2004 PowerPoint
drwxrwxr-x   2 ljackson  admin  68B Apr  8  2004 Word
ljackson 14:47:33 /Applications/Microsoft Office 2004/Office/Startup> cd Excel/
ljackson 14:47:37 /Applications/Microsoft Office 2004/Office/Startup/Excel> ll
total 96
-rw-r--r--   1 ljackson  admin    25K May  3 14:15 8DAE9700
-rw-r--r--   1 ljackson  admin    16K May  3 14:39 Personal Macro Workbook
```

In my case the alphanumerical file was generated when Excel crashed. So I will delete it:

```
ljackson 14:47:38 /Applications/Microsoft Office 2004/Office/Startup/Excel> rm -f 8DAE9700 
ljackson 14:47:53 /Applications/Microsoft Office 2004/Office/Startup/Excel> ll
total 40
-rw-r--r--   1 ljackson  admin    16K May  3 14:39 Personal Macro Workbook
```

Now I don't get the anoying error "File Not Found" every time I launch Excel.

## VBA Macros

```
Sub RangeDateFix()
    Dim ndate As String
    'ActiveCell.CurrentRegion.Cells.Select
    For Each c In ActiveWindow.RangeSelection.Cells
        ndate = USdateEU(c.Value)
        c.Value = ndate
    Next
End Sub

Public Function USdateEU(ByVal tdate As String)
    Dim txt As String, ftxt As String, x As Variant, i As Long
    txt = tdate
    x = Split(txt, "/")
    'For i = 0 To UBound(x)
       'MsgBox x(i)
    'Next i
    ftxt = x(1) & "/" & x(0) & "/" & x(2)
    
    USdateEU = ftxt
    'MsgBox ftxt
End Function

Public Function Split(ByVal sInput As String, _
Optional ByVal sDelimiter As String, _
Optional ByVal nLimit As Long = -1, _
Optional ByVal bCompare As Integer = vbBinaryCompare _
) As Variant
  
Dim nCount As Long
Dim nPos As Long
Dim nDelimiterLength As Long
Dim nStart As Long
Dim sOutput() As String
  
If nLimit = 0 Then
    Split = Array()
Else
    nDelimiterLength = Len(sDelimiter)
    
    If nDelimiterLength = 0 Then
        Split = Array(sInput)
    Else
        nStart = 1
        nPos = InStr(nStart, sInput, sDelimiter, bCompare)
    
    Do While nPos
      
    ReDim Preserve sOutput(0 To nCount) As String
      
        If nCount + 1 = nLimit Then
            sOutput(nCount) = Mid(sInput, nStart)
            Exit Do
        Else
            sOutput(nCount) = Mid(sInput, nStart, nPos - nStart)
            nStart = nPos + nDelimiterLength
        End If
      
    nCount = nCount + 1
      
    nPos = InStr(nStart, sInput, sDelimiter, bCompare)
      
    Loop
      
    ReDim Preserve sOutput(0 To nCount) As String
      
    sOutput(nCount) = Mid(sInput, nStart)
      
    Split = sOutput
      
    End If
  
End If
  
End Function
```

## Clear Old Pivot Table Labels

```
Sub DeleteMissingItems2002All()
'prevents unused items in non-OLAP PivotTables
'pivot table tutorial by contextures.com
Dim pt As PivotTable
Dim ws As Worksheet
Dim pc As PivotCache

'change the settings
For Each ws In ActiveWorkbook.Worksheets
  For Each pt In ws.PivotTables
    pt.PivotCache.MissingItemsLimit = xlMissingItemsNone
  Next pt
Next ws

'refresh all the pivot caches
For Each pc In ActiveWorkbook.PivotCaches
  On Error Resume Next
  pc.Refresh
Next pc

End Sub  
   
```


## Append/Merge/Combine adjacent columns one after the other

**Mac OS X compatible**

```
Sub test()
Dim LR As Long, i As Long
For i = 2 To 4
    LR = Cells(Rows.Count, i).End(xlUp).Row
    Range(Cells(1, i), Cells(LR, i)).Copy Destination:=Cells(Rows.Count, 1).End(xlUp).Offset(1)
Next i
End Sub
```

**Manipulate Cells with SQL based Macro**

```
Sub doSQL()


    Dim strCon As String
    Dim oneSQL As String
    
    ' refer to 'microsoft activex data objects library'
    Dim cn As Object
    Dim rs As Object


    Set cn = CreateObject("ADODB.Connection")
    Set rs = CreateObject("ADODB.Recordset")
    
    strCon = "Provider=Microsoft.ACE.OLEDB.12.0;" & _
              "Data Source='" & ThisWorkbook.FullName & "';" & _
              "Extended Properties='Excel 12.0;HDR=No;IMEX=1';"    ' HDR=No  means no headers (field names)


    cn.Open strCon     ' open connection
    
'-------------------------------------------------------------------------------

    ' F1, F2, F3 are the default fieldnames when no headers are included with data    


    oneSQL = "SELECT F3 FROM [Sheet1$B:D] where F3 not like '' union all " & _
             "SELECT F1 FROM [Sheet1$B:D] where F1 not like '' union all " & _
             "SELECT F2 FROM [Sheet1$B:D] where F2 not like ''; "
    
    rs.Open oneSQL, cn      ' get recordset


    Sheets("Sheet1").Range("A:A").ClearContents

    Sheets("Sheet1").Range("A1").CopyFromRecordset rs     ' copy recordset to worksheet
    
'-------------------------------------------------------------------------------
    
    rs.Close
    cn.Close
    
    Set rs = Nothing
    Set cn = Nothing


End Sub
```

## Color

```
Function HEXCOL2RGB(ByVal HexColor As String) As String

    'The input at this point could be HexColor = "#00FF1F"

Dim Red As String
Dim Green As String
Dim Blue As String
Dim Color As String

Color = Replace(HexColor, "#", "")
    'Here HexColor = "00FF1F"

Red = Val("&H" & Mid(Color, 1, 2))
    'The red value is now the long version of "00"

Green = Val("&H" & Mid(Color, 3, 2))
    'The red value is now the long version of "FF"

Blue = Val("&H" & Mid(Color, 5, 2))
    'The red value is now the long version of "1F"

'HEXCOL2RGB = RGB(Red, Green, Blue)
HEXCOL2RGB = Red & "," & Green & "," & Blue
    'The output is an RGB value

End Function

Sub CvrtHex()
    Dim Cell As Range
    If TypeName(Selection) <> "Range" Then Exit Sub
    For Each Cell In Selection
        If Cell.Value < 0 Then
            'Debug.Print ""
        Else
            Debug.Print HEXCOL2RGB(Cell.Value)
            Cell.Next.Value = HEXCOL2RGB(Cell.Value)
        End If
    Next Cell
End Sub

Sub CvrtHex2()
    Dim Cell As Range
    Dim clrs As Variant
    If TypeName(Selection) <> "Range" Then Exit Sub
    For Each Cell In Selection
        If Cell.Value < 0 Then
            'Debug.Print ""
        Else
            clrs = Split(Cell.Value, ",")
            Debug.Print clrs(0) & " " & clrs(1) & " " & clrs(2)
            Cell.Next.Interior.Color = RGB(clrs(0), clrs(1), clrs(2))
            Cell.Next.Value = "R" & clrs(0) & " G" & clrs(1) & " B" & clrs(2)
            If clrs(0) < 200 And clrs(1) < 200 And clrs(2) < 200 Then
                Cell.Next.Font.Color = RGB(255, 255, 255)
                Debug.Print "White"
            Else
                Cell.Next.Font.Color = RGB(0, 0, 0)
            End If
        End If
    Next Cell
End Sub
```


**Set Background Color of Cells to Adjacent Cell Value (RGB)**

```
Sub ColourCells()
Dim HowMany As Integer
On Error Resume Next
Application.DisplayAlerts = False
HowMany = Application.InputBox _
(Prompt:="Enter last row number.", Title:="To apply to how many rows?", Type:=1)
On Error GoTo 0
Application.DisplayAlerts = True
If HowMany = 0 Then
Exit Sub
Else
   Dim i As Integer
   For i = 2 To HowMany
      Cells(i, 6).Interior.Color = RGB(Cells(i, 2), Cells(i, 3), Cells(i, 4))
   Next i
End If
End Sub
```

## See Also

- [Excel_Mulit_File_Query](misc--excelmulitfilequery.md)

## Souces

- http://www.mrexcel.com/forum/excel-questions/673567-combining-multiple-columns-into-one-column-without-any-blank-cells-5.html
- http://www.ddmcomputing.com/excel/keys/xlsk05.htm
- http://thinketg.com/say-goodbye-to-vlookup-and-hello-to-index-match/
- http://www.eggheadcafe.com/forumarchives/macofficeExcel/Feb2006/post25897535.asp
- http://forums.macworld.com/message/334000
- http://msdn.microsoft.com/en-us/library/aa221353(office.11).aspx
- http://support.microsoft.com/kb/288117/en-us?spid=2513&sid=579
- http://www.contextures.com/xlPivot04.html


---

## Mulit File Query



Joining Excel documents can be quite useful for reporting. **All of the files you want to merge will have to have the same column names.**





















Using UNION ALL we can join as many files as we need.

```
SELECT * FROM `L:\Quality Control\Redo Sheets\redo_sheet_lri.xls`.`'Redo Sheet$'`
UNION ALL
SELECT * FROM `L:\Quality Control\Redo Sheets\redo_sheet_jra.xls`.`'Redo Sheet$'`
```





1. Tags 

Joining Excel Documents, Various Documents, Many Excel Files

