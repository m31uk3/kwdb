# Visual Basic Script


## Onyx Registration Script

```
Dim oWSHShell
Dim oWSHEnvironment
Dim Processes
Dim Process
Dim isAlive
Dim retCode
Dim RegItm1
Dim RegItm2
Dim CurApp

Set oWSHShell = WScript.CreateObject("WScript.Shell")
Set objWMIService = GetObject("winmgmts:")
Set Processes = objWMIService.InstancesOf("Win32_Process")
'Set oWSHEnvironment = oWSHShell.Environment("windir")
RegItm1 = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ProductKey"
RegItm2 = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\ProductKey"

For each Process in Processes  
	'WScript.Echo Process.Name
	'WScript.Echo Process.ProcessId
	Select Case LCase(Process.Name)  
		Case "postershop.exe" 'Onyx ProductionHouse
        		'retCode = oWSHShell.Popup(Process.Name & " will Close in 30 seconds.", 30, "Onyx Registration Script", 4 + 16)		
			'Select Case retCode
        			'case 6, -1
                			'Process.Terminate(0) 'Yes or timeout was chosen
        			'case 7
                			'WScript.quit(1) 'No was chosen
			'End Select
			Process.Terminate(0)
	End Select    
Next

Set isAlive = objWMIService.ExecQuery("SELECT * FROM Win32_Process WHERE Name = 'Postershop.exe'")

If isAlive.Count = 0 Then
	If keyExists(RegItm1) = True Then oWSHShell.RegDelete RegItm1
	If keyExists(RegItm2) = True Then oWSHShell.RegDelete RegItm2
	WScript.Sleep 20000 'Wait 20 seconds.

	oWSHShell.Run """E:\Onyx Graphics\ProductionHouse\server\Postershop.exe""", 5, False
	WScript.Sleep 30000 'Wait 30 seconds.

	oWSHShell.AppActivate "Enter"
	WScript.Sleep 5000 'Wait 5 seconds.
	oWSHShell.SendKeys "{TAB}{ENTER}" 'Close the registration screen.

	'oWSHShell.Run "C:\DD\Scripts\close.register.onyx.vbs", 8, False
Else
	MsgBox "Onyx is still running. Please close the application and attempt registration again.", vbCritical, "Onyx Registration Script"
	Set oWSHShell = Nothing
	WScript.Quit
End If

Set oWSHShell = Nothing
WScript.Quit

'Start Functions

function KeyExists(byval sKeyPath)
    keyExists= false
    sKeyPath= trim(sKeyPath): if (sKeyPath="") then exit function
    if not (right(sKeyPath, 1)="\") then sKeyPath= sKeyPath & "\"

    on error resume next
        createobject("wscript.shell").regRead sKeyPath

        select case err
           case 0: keyExists= true

           case &h80070002: dim sErrMsg
               sErrMsg= replace(err.description, sKeyPath, "")
               err.clear

               createobject("wscript.shell").regRead "HKEY_ERROR\"
               keyExists= not (sErrMsg=replace(err.description, _
                  "HKEY_ERROR\", ""))
        end select
    on error goto 0
end function
```


## DD Track Batch Script

```
ParseBatch()

Public Function ParseBatch()

Dim oWSHShell
Dim Fso
Dim Files
Dim sFilter
Dim sFolder
Dim File
Dim oFiles
Dim oFile
Dim oFolders
Dim oFolder
Dim sPath
Dim FileInfo
Dim Folders
Dim Folder
Dim Info
Dim bFolders
Dim b_type
Dim b_date
Dim ddFolders
Dim ddFolder
Dim objNetwork
Dim CompName
Dim UserName
Dim Printer
Dim fURL
Dim bURL
Dim key
Dim wLog
Dim lDate
Dim sIni
ReDim c(10)
Dim q: q = 0

Set oWSHShell = CreateObject("WScript.Shell")
Set Fso = CreateObject("Scripting.FileSystemObject")

'Computer Info
sIni = "D:\Scripts\sprd.dd.track.batch.ini"

Set objNetwork = CreateObject("WScript.Network")
CompName = objNetwork.ComputerName
UserName = objNetwork.UserName
'UserName = LCase(GetLocalUser())
Set wLog = Fso.CreateTextFile("D:\Scripts\batch.log.txt", True)
'Returns "Wednesday, Jan 27 1993 17:04:03"
lDate = "dddd, MMM dd yyyy hh:mm:ss"
'Write Log Header
wLog.WriteLine "################################# Spreadshirt DD Track Log - " & UserName & "@" & CompName & " - " & vbsFormat(Now, lDate) & " #################################"

'Tracking Configuration
key = ""
Action = "batched"
Printer = "000"
fURL = "http://io85.com/track/clean.php"
bURL = "http://io85.com/track/batch.php"
URI = "?key=" & key & "&compname=" & CompName & "&username=" & UserName & "&printer=" & Printer & "&action=" & Action

Folders = ListDir("L:\Production_Printouts\nested\f3", "*")

For Each Folder In Folders
    If VarType(GetFolderInfo(Folder)) <> vbInteger Then
        Info = GetFolderInfo(Folder)
        If ReadIni(sIni, "Batch_Status", "Current_ID") < Mid(Info(2), 2) Then
            bFolders = ListDir(Folder, "*")
            b_type = GetBatchType(bFolders)
            b_date = GetFolderDate(Folder)
            If VarType(b_type) <> vbInteger Then
                '################# Log Batch ########################
                If q > UBound(c) Then ReDim Preserve c(q * 2)
                c(q) = Mid(Info(2), 2) & "," & FolderName(Folder) & "," & b_date & "," & b_type
                wLog.WriteLine c(q)
                q = q + 1
                If b_type = "Mixed" Or b_type = "DD_Only" Then
                    ddFolders = ListDir(Folder & "\" & "pixel", "*")
                    For Each ddFolder In ddFolders
                        If DDFolderType(ddFolder) = "dark" Or DDFolderType(ddFolder) = "light" Then
                            oFolders = ListDir(ddFolder, "*")
                            If UBound(oFolders) >= 0 Then
                                For Each oFolder In oFolders
                                    If FolderName(oFolder) = "oversize" Then
                                        oFiles = ListFiles(oFolder, "*")
                                        If UBound(oFiles) > 0 Then
                                            For Each oFile In oFiles
                                                If VarType(GetFileInfo(oFile)) <> vbInteger Then
                                                    '################# Log Oversize File ########################
                                                    wLog.WriteLine TrackInfo(fURL & URI & "&batchid=" & Mid(Info(2), 2) & "&b_folder=" & FolderName(Folder) & "&b_type=" & b_type & "&dd_type=" & DDFolderType(ddFolder) & "&ofolder=" & FolderName(oFolder) & "&f_name=" & oFile & GetFileInfo(oFile) & GetImgInfo(oFolder, oFile))
                                                Else
                                                    wLog.WriteLine "Not a printout! - " & oFile
                                                End If
                                            Next
                                            If q > UBound(c) Then ReDim Preserve c(q * 2)
                                            c(q) = Mid(Info(2), 2) & "," & FolderName(Folder) & "," & b_date & "," & b_type & "," & DDFolderType(ddFolder) & "," & FolderName(oFolder) & "," & UBound(oFiles) + 1
                                            wLog.WriteLine c(q)
                                            q = q + 1
                                        End If
                                    End If
                                Next
                            End If
                            Files = ListFiles(ddFolder, "*")
                            If UBound(Files) > 0 Then
                                For Each File In Files
                                    If VarType(GetFileInfo(File)) <> vbInteger Then
                                        '################# Log File ########################
                                        wLog.WriteLine TrackInfo(fURL & URI & "&batchid=" & Mid(Info(2), 2) & "&b_folder=" & FolderName(Folder) & "&b_type=" & b_type & "&dd_type=" & DDFolderType(ddFolder) & "&ofolder=" & "&f_name=" & File & GetFileInfo(File) & GetImgInfo(ddFolder, File))
                                    Else
                                        wLog.WriteLine "Not a printout! - " & File
                                    End If
                                Next
                                If q > UBound(c) Then ReDim Preserve c(q * 2)
                                c(q) = Mid(Info(2), 2) & "," & FolderName(Folder) & "," & b_date & "," & b_type & "," & DDFolderType(ddFolder) & "," & "," & UBound(Files) + 1
                                wLog.WriteLine c(q)
                                q = q + 1
                            End If
                        End If
                    Next
                End If
            Else
                wLog.WriteLine "Not a batch! - " & Folder
            End If
            WriteIni sIni, "Batch_Status", "Current_ID", Mid(Info(2), 2) 'Index Batch ID
        End If
    Else
        wLog.WriteLine "Not a Batch! - " & Folder
    End If
    '################# Post Batch Info ########################
    If Not IsEmpty(c(LBound(c))) Then
        ReDim Preserve c(q - 1)
            'Echo Counts
        'wLog.WriteLine bURL & URI & BatchInfoURI(c)
        wLog.WriteLine TrackInfo(bURL & URI & BatchInfoURI(c))
        ReDim c(10)
        q = 0
    End If
Next

'Write Log Footer
wLog.WriteLine "################################# Spreadshirt DD Track Log - " & UserName & "@" & CompName & " - " & vbsFormat(Now, lDate) & " #################################"
wLog.Close
Set oWSHShell = Nothing

End Function

Public Function TrackInfo(ByVal URL)

Dim http

TrackInfo = -1

    'Create HTTP Connection
    Set http = CreateObject("MSXML2.XMLHTTP")
    http.Open "GET", URL, False
    http.send
    WScript.Sleep (500) 'Wait 0.5 Seconds
    If http.Status = 200 Then ' And http.StatusText = "OK" Then
        TrackInfo = http.Status
    End If
End Function

Public Function BatchInfoURI(ByVal BatchArr)

'2312,20101130_22_x2312_f3_E,1291136552,Mixed
'2312,20101130_22_x2312_f3_E,1291136552,Mixed,dark,oversize,7
'2312,20101130_22_x2312_f3_E,1291136552,Mixed,dark,,99
'2312,20101130_22_x2312_f3_E,1291136552,Mixed,light,oversize,3
'2312,20101130_22_x2312_f3_E,1291136552,Mixed,light,,23

Dim batch_num
Dim b_timestamp
Dim b_folder
Dim b_type
Dim dd_d_qty: dd_d_qty = 0 
Dim dd_od_qty: dd_od_qty = 0
Dim dd_td_qty: dd_td_qty = 0
Dim dd_l_qty: dd_l_qty = 0
Dim dd_ol_qty: dd_ol_qty = 0
Dim dd_tl_qty: dd_tl_qty = 0
Dim dd_t_qty: dd_t_qty = 0
Dim i
Dim s
Dim URI

BatchInfoURI = -1

For i = 0 To UBound(BatchArr) Step 1
    If Not IsEmpty(BatchArr(i)) Then
        s = Split(BatchArr(i), ",")
        Select Case UBound(s)
            Case 3
                batch_num = s(0)
                b_folder = s(1)
                b_timestamp = s(2)
                b_type = s(3)
            Case 6
                If s(4) = "dark" And Len(s(5)) = 0 And s(6) > 0 Then dd_d_qty = Abs(s(6))
                If s(4) = "dark" And Len(s(5)) > 0 And s(6) > 0 Then dd_od_qty = Abs(s(6))
                If s(4) = "light" And Len(s(5)) = 0 And s(6) > 0 Then dd_l_qty = Abs(s(6))
                If s(4) = "light" And Len(s(5)) > 0 And s(6) > 0 Then dd_ol_qty = Abs(s(6))
        End Select
    End If
Next

'Sum Totals
dd_td_qty = dd_d_qty + dd_od_qty
dd_tl_qty = dd_l_qty + dd_ol_qty
dd_t_qty = dd_td_qty + dd_tl_qty

'Build URI
URI = "&batch_num=" & batch_num _
& "&b_folder=" & b_folder _
& "&b_timestamp=" & b_timestamp _
& "&b_type=" & b_type _
& "&dd_d_qty=" & dd_d_qty _
& "&dd_od_qty=" & dd_od_qty _
& "&dd_td_qty=" & dd_td_qty _
& "&dd_l_qty=" & dd_l_qty _
& "&dd_ol_qty=" & dd_ol_qty _
& "&dd_tl_qty=" & dd_tl_qty _
& "&dd_t_qty=" & dd_t_qty

If batch_num > 0 And b_timestamp > 0 Then BatchInfoURI = URI

End Function

Public Function GetFolderInfo(ByVal File)
Dim Files
Dim sPath
Dim FileInfo
Dim Info
Dim Hexs
Dim URI

GetFolderInfo = -1

sPath = Split(File, "\") 'Split on Path
Select Case UBound(sPath)
    Case 4
    	'L:\Production_Printouts\nested\f3\20101108_05_x2214_f3_K"
        If Not IsEmpty(sPath(UBound(sPath))) Then
            FileInfo = Split(sPath(UBound(sPath)), "_")
            Select Case UBound(FileInfo)
                Case 4
                    '20101203_05_x2324_f3_Q
                    '00000000_11_22222_33_4
                    GetFolderInfo = FileInfo
                    Exit Function
                Case 5
                    '20101203_05_x2324_f3_Q_PF-11568
                    '00000000_11_22222_33_4_55555555
                    GetFolderInfo = FileInfo
                    Exit Function
                Case Else
                    Exit Function
               End Select
        Else
            Exit Function
        End If
    Case Else
        Exit Function
    End Select

End Function

Public Function GetFileInfo(ByVal File)
Dim Files
Dim sFile
Dim FileInfo
Dim Info
Dim Hexs
Dim URI

GetFileInfo = -1

If Not IsEmpty(File) Then
    sFile = Split(File, ".") 'Split on Filename
    FileInfo = Split(sFile(0), "_") 'Split on Underscore
    Select Case UBound(FileInfo)
        Case 5
            '2624941_846337_109_L_FFFFFF_white_1_Preview.bmp
            '1111111_222222_333_4_555555_66666_7_88888888888
            URI = "&config=" & FileInfo(0) _
            & "&trans=" & FileInfo(1) _
            & "&product=" & FileInfo(2) _
            & "&size=" & FileInfo(3) _
            & "&hex=" & FileInfo(4) _
            & "&color=" & FileInfo(5)
            GetFileInfo = URI
            Exit Function
        Case 6
            'Distingish between dual color products or two word color names
            Hexs = 0
            For Each Info In FileInfo
                If IsHex(Info, 6) Then Hexs = Hexs + 1
            Next
            Select Case Hexs
                Case 2
                    '23824549_845933_111_S_32409A_royal_blue_1_Preview.bmp
                    '00000000_111111_222_3_444444_55555_6666_7_88888888888
                    URI = "&config=" & FileInfo(0) _
                    & "&trans=" & FileInfo(1) _
                    & "&product=" & FileInfo(2) _
                    & "&size=" & FileInfo(3) _
                    & "&hex=" & FileInfo(4) _
                    & "&color=" & FileInfo(5) & "%20" & FileInfo(6)
                Case 3
                    '2007771_845904_121_L_FFFFFF_000000_white-black_1_Preview.bmp
                    '0000000_111111_222_3_444444_555555_66666666666_7_88888888888
                    URI = "&config=" & FileInfo(0) _
                    & "&trans=" & FileInfo(1) _
                    & "&product=" & FileInfo(2) _
                    & "&size=" & FileInfo(3) _
                    & "&hex=" & FileInfo(4) _
                    & "&hex2=" & FileInfo(5) _
                    & "&color=" & FileInfo(6)
                Case Else
                    URI = "&config=" & FileInfo(0) _
                    & "&trans=" & FileInfo(1) _
                    & "&product=" & FileInfo(2) _
                    & "&size=" & FileInfo(3) _
                    & "&hex=Unknown" _
                    & "&color=Unknown"
                End Select
                GetFileInfo = URI
                Exit Function
        Case 7
            '23830562_846334_402_M_B8C3DB_melange_sky_blue_1_Preview.bmp
            '00000000_111111_222_3_444444_5555555_666_7777_8_99999999999
            URI = "&config=" & FileInfo(0) _
            & "&trans=" & FileInfo(1) _
            & "&product=" & FileInfo(2) _
            & "&size=" & FileInfo(3) _
            & "&hex=" & FileInfo(4) _
            & "&color=" & FileInfo(5) & "%20" & FileInfo(6) & "%20" & FileInfo(7)
            GetFileInfo = URI
            Exit Function
        Case 8
            '22007807_856080_48_L_(14-16_yrs)_32409A_royal_blue.png
            '00000000_111111_22_3_444444_5555_666666_77777_8888
            URI = "&config=" & FileInfo(0) _
            & "&trans=" & FileInfo(1) _
            & "&product=" & FileInfo(2) _
            & "&size=" & FileInfo(3) & "%20" & FileInfo(4) & "%20" & FileInfo(5) _
            & "&hex=" & FileInfo(6) _
            & "&color=" & FileInfo(7) & "%20" & FileInfo(8)
            GetFileInfo = URI
            Exit Function
        Case 9
            '20018688_846664_48_L__14-16_yrs__FFFFFF_white_1_Preview.bmp
            '00000000_111111_22_3_4_5555_666_7_88888_99999_10_1111111111
            URI = "&config=" & FileInfo(0) _
            & "&trans=" & FileInfo(1) _
            & "&product=" & FileInfo(2) _
            & "&size=" & FileInfo(3) & "%20" & FileInfo(5) & "%20" & FileInfo(6) _
            & "&hex=" & FileInfo(8) _
            & "&color=" & FileInfo(9)
            GetFileInfo = URI
            Exit Function
        Case 10
            '20307736_843436_48_L__14-16_yrs__1E9658_kelly_green_1_Preview.bmp
            '00000000_111111_22_3_4_5555_666_7_88888_99999_10101_11_1212121212
            URI = "&config=" & FileInfo(0) _
            & "&trans=" & FileInfo(1) _
            & "&product=" & FileInfo(2) _
            & "&size=" & FileInfo(3) & "%20" & FileInfo(5) & "%20" & FileInfo(6) _
            & "&hex=" & FileInfo(8) _
            & "&color=" & FileInfo(9) & "%20" & FileInfo(10)
            GetFileInfo = URI
            Exit Function
        Case Else
            Exit Function
        End Select
Else
    Exit Function
End If

End Function

Public Function IsHex(ByVal strInput, ByVal sLimit)

Dim i
Dim j
Dim m
Dim sHexValue
Dim sHexValues
Dim aHexValues
strInput = UCase(strInput)
sHexValues = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F"
aHexValues = Split(sHexValues, ",")

IsHex = False

If LenB(strInput) = 0 Then Exit Function

i = 1
j = Len(strInput)
m = 0

Do Until i > j
    'If (Mid(strInput, i, 1) Like "[0-9A-Fa-f]") Then m = m + 1
    For Each sHexValue In aHexValues
        Dim d: d = UCase(Mid(strInput, i, 1))
        If UCase(Mid(strInput, i, 1)) = sHexValue Then
            m = m + 1
            Exit For
        End If
    Next
    i = i + 1
Loop

If m = j And m = sLimit Then IsHex = True

End Function

Public Function IsBatch(ByVal Folders)

Dim i
Dim s

IsBatch = False

If UBound(Folders) >= 0 Then
    For i = 0 To UBound(Folders) Step 1
        s = FolderName(Folders(i))
        If s = "nested" Or s = "pixel" Then
            IsBatch = True
            Exit Function
        End If
    Next
End If

End Function

Public Function GetBatchType(ByVal Folders)

Dim i
Dim s
Dim SubFolders
Dim h: h = 0
Dim t
Dim dd: dd = False
Dim ns: ns = False

GetBatchType = -1

If UBound(Folders) >= 0 Then
    For i = 0 To UBound(Folders) Step 1
        s = FolderName(Folders(i))
        If s = "pixel" Then 'Check for Pixel
            SubFolders = ListDir(Folders(i) & "\" & "pixel", "*") 'Check for DD
            If UBound(SubFolders) >= 0 Then
                Do While h <= UBound(SubFolders)
                    t = FolderName(SubFolders(h))
                    If t = "digitaldirect_dark" Or t = "digitaldirect_light" Then
                        dd = True
                        Exit Do
                    End If
                    h = h + 1
                Loop
            End If
        ElseIf s = "nested" Then 'Check for Nested
            ns = True
        End If
    Next
End If

If ns And dd Then
    GetBatchType = "Mixed"
    Exit Function
ElseIf ns Then
    GetBatchType = "Flex_Only"
    Exit Function
ElseIf dd Then
    GetBatchType = "DD_Only"
    Exit Function
End If

End Function

Function InbfArray(ByVal Item, a)
Dim i
Dim s

InbfArray = False

For i = 0 To UBound(a) Step 1
   s = Split(a(i), "\")
    If s(UBound(s)) = Item Then
        InbfArray = True
        Exit Function
    End If
Next
End Function

Public Function ListDir(ByVal Path, ByVal sFilter)
' Returns an array with the file names that match Path.
' The Path string may contain the wildcard characters "*"
' and "?" in the file name component. The same rules apply
' as with the MSDOS DIR command.
' If Path is a directory, the contents of this directory is listed.
' If Path is empty, the current directory is listed.
' Author: Christian d'Heureuse (www.source-code.biz)
   Dim Fso: Set Fso = CreateObject("Scripting.FileSystemObject")
   If Path = "" Then Path = "*.*"
   Dim Parent
   If Fso.FolderExists(Path) Then      ' Path is a directory
      Parent = Path
      If sFilter = "" Then sFilter = "*"
     Else
      Parent = Fso.GetParentFolderName(Path)
      If Parent = "" Then If Right(Path, 1) = ":" Then Parent = Path Else Parent = "."
      sFilter = Fso.GetFileName(Path)
      If sFilter = "" Then sFilter = "*"
      End If
   ReDim a(10)
   Dim n: n = 0
   Dim Folder: Set Folder = Fso.GetFolder(Parent)
   Dim Files: Set Files = Folder.SubFolders
   Dim File
   For Each File In Files
      'If Len(File.Name) > 4 Then
         If n > UBound(a) Then ReDim Preserve a(n * 2)
         a(n) = File.Path
         n = n + 1
       'End If
      Next
   ReDim Preserve a(n - 1)
   ListDir = a
End Function

Public Function ListFiles(ByVal Path, ByVal sFilter)
' Returns an array with the file names that match Path.
' The Path string may contain the wildcard characters "*"
' and "?" in the file name component. The same rules apply
' as with the MSDOS DIR command.
' If Path is a directory, the contents of this directory is listed.
' If Path is empty, the current directory is listed.
' Author: Christian d'Heureuse (www.source-code.biz)
   Dim Fso: Set Fso = CreateObject("Scripting.FileSystemObject")
   If Path = "" Then Path = "*.*"
   Dim Parent
   If Fso.FolderExists(Path) Then      ' Path is a directory
      Parent = Path
      If sFilter = "" Then sFilter = "*"
     Else
      Parent = Fso.GetParentFolderName(Path)
      If Parent = "" Then If Right(Path, 1) = ":" Then Parent = Path Else Parent = "."
      sFilter = Fso.GetFileName(Path)
      If sFilter = "" Then sFilter = "*"
      End If
   ReDim a(10)
   Dim n: n = 0
   Dim Folder: Set Folder = Fso.GetFolder(Parent)
   Dim Files: Set Files = Folder.Files
   Dim File
   For Each File In Files
      'If Len(File.Name) > 4 Then
         If n > UBound(a) Then ReDim Preserve a(n * 2)
         a(n) = File.Name
         n = n + 1
       'End If
      Next
   If n > 0 Then ReDim Preserve a(n - 1)
   If n = 0 Then ReDim Preserve a(n)
   ListFiles = a
End Function

Function ReadIni(myFilePath, mySection, myKey)
    ' This function returns a value read from an INI file
    '
    ' Arguments:
    ' myFilePath  [string]  the (path and) file name of the INI file
    ' mySection   [string]  the section in the INI file to be searched
    ' myKey       [string]  the key whose value is to be returned
    '
    ' Returns:
    ' the [string] value for the specified key in the specified section
    '
    ' CAVEAT:     Will return a space if key exists but value is blank
    '
    ' Written by Keith Lacelle
    ' Modified by Denis St-Pierre and Rob van der Woude

    Const ForReading = 1
    Const ForWriting = 2
    Const ForAppending = 8

    Dim intEqualPos
    Dim objFSO, objIniFile
    Dim strFilePath, strKey, strLeftString, strLine, strSection

    Set objFSO = CreateObject("Scripting.FileSystemObject")

    ReadIni = ""
    strFilePath = Trim(myFilePath)
    strSection = Trim(mySection)
    strKey = Trim(myKey)

    If objFSO.FileExists(strFilePath) Then
        Set objIniFile = objFSO.OpenTextFile(strFilePath, ForReading, False)
        Do While objIniFile.AtEndOfStream = False
            strLine = Trim(objIniFile.ReadLine)

            ' Check if section is found in the current line
            If LCase(strLine) = "[" & LCase(strSection) & "]" Then
                strLine = Trim(objIniFile.ReadLine)

                ' Parse lines until the next section is reached
                Do While Left(strLine, 1) <> "["
                    ' Find position of equal sign in the line
                    intEqualPos = InStr(1, strLine, "=", 1)
                    If intEqualPos > 0 Then
                        strLeftString = Trim(Left(strLine, intEqualPos - 1))
                        ' Check if item is found in the current line
                        If LCase(strLeftString) = LCase(strKey) Then
                            ReadIni = Trim(Mid(strLine, intEqualPos + 1))
                            ' In case the item exists but value is blank
                            If ReadIni = "" Then
                                ReadIni = " "
                            End If
                            ' Abort loop when item is found
                            Exit Do
                        End If
                    End If

                    ' Abort if the end of the INI file is reached
                    If objIniFile.AtEndOfStream Then Exit Do

                    ' Continue with next line
                    strLine = Trim(objIniFile.ReadLine)
                Loop
            Exit Do
            End If
        Loop
        objIniFile.Close
    Else
        WScript.Echo strFilePath & " doesn't exists. Exiting..."
        WScript.Quit 1
    End If
End Function

Sub WriteIni(myFilePath, mySection, myKey, myValue)
    ' This subroutine writes a value to an INI file
    '
    ' Arguments:
    ' myFilePath  [string]  the (path and) file name of the INI file
    ' mySection   [string]  the section in the INI file to be searched
    ' myKey       [string]  the key whose value is to be written
    ' myValue     [string]  the value to be written (myKey will be
    '                       deleted if myValue is <DELETE_THIS_VALUE>)
    '
    ' Returns:
    ' N/A
    '
    ' CAVEAT:     WriteIni function needs ReadIni function to run
    '
    ' Written by Keith Lacelle
    ' Modified by Denis St-Pierre, Johan Pol and Rob van der Woude

    Const ForReading = 1
    Const ForWriting = 2
    Const ForAppending = 8

    Dim blnInSection, blnKeyExists, blnSectionExists, blnWritten
    Dim intEqualPos
    Dim objFSO, objNewIni, objOrgIni, wshShell
    Dim strFilePath, strFolderPath, strKey, strLeftString
    Dim strLine, strSection, strTempDir, strTempFile, strValue

    strFilePath = Trim(myFilePath)
    strSection = Trim(mySection)
    strKey = Trim(myKey)
    strValue = Trim(myValue)

    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set wshShell = CreateObject("WScript.Shell")

    strTempDir = wshShell.ExpandEnvironmentStrings("%TEMP%")
    strTempFile = objFSO.BuildPath(strTempDir, objFSO.GetTempName)

    Set objOrgIni = objFSO.OpenTextFile(strFilePath, ForReading, True)
    Set objNewIni = objFSO.CreateTextFile(strTempFile, False, False)

    blnInSection = False
    blnSectionExists = False
    ' Check if the specified key already exists
    blnKeyExists = (ReadIni(strFilePath, strSection, strKey) <> "")
    blnWritten = False

    ' Check if path to INI file exists, quit if not
    strFolderPath = Mid(strFilePath, 1, InStrRev(strFilePath, "\"))
    If Not objFSO.FolderExists(strFolderPath) Then
        WScript.Echo "Error: WriteIni failed, folder path (" _
                   & strFolderPath & ") to ini file " _
                   & strFilePath & " not found!"
        Set objOrgIni = Nothing
        Set objNewIni = Nothing
        Set objFSO = Nothing
        WScript.Quit 1
    End If

    While objOrgIni.AtEndOfStream = False
        strLine = Trim(objOrgIni.ReadLine)
        If blnWritten = False Then
            If LCase(strLine) = "[" & LCase(strSection) & "]" Then
                blnSectionExists = True
                blnInSection = True
            ElseIf InStr(strLine, "[") = 1 Then
                blnInSection = False
            End If
        End If

        If blnInSection Then
            If blnKeyExists Then
                intEqualPos = InStr(1, strLine, "=", vbTextCompare)
                If intEqualPos > 0 Then
                    strLeftString = Trim(Left(strLine, intEqualPos - 1))
                    If LCase(strLeftString) = LCase(strKey) Then
                        ' Only write the key if the value isn't empty
                        ' Modification by Johan Pol
                        If strValue <> "<DELETE_THIS_VALUE>" Then
                            objNewIni.WriteLine strKey & "=" & strValue
                        End If
                        blnWritten = True
                        blnInSection = False
                    End If
                End If
                If Not blnWritten Then
                    objNewIni.WriteLine strLine
                End If
            Else
                objNewIni.WriteLine strLine
                    ' Only write the key if the value isn't empty
                    ' Modification by Johan Pol
                    If strValue <> "<DELETE_THIS_VALUE>" Then
                        objNewIni.WriteLine strKey & "=" & strValue
                    End If
                blnWritten = True
                blnInSection = False
            End If
        Else
            objNewIni.WriteLine strLine
        End If
    Wend

    If blnSectionExists = False Then ' section doesn't exist
        objNewIni.WriteLine
        objNewIni.WriteLine "[" & strSection & "]"
            ' Only write the key if the value isn't empty
            ' Modification by Johan Pol
            If strValue <> "<DELETE_THIS_VALUE>" Then
                objNewIni.WriteLine strKey & "=" & strValue
            End If
    End If

    objOrgIni.Close
    objNewIni.Close

    ' Delete old INI file
    objFSO.DeleteFile strFilePath, True
    ' Rename new INI file
    objFSO.MoveFile strTempFile, strFilePath

    Set objOrgIni = Nothing
    Set objNewIni = Nothing
    Set objFSO = Nothing
    Set wshShell = Nothing
End Sub

Public Function vbsFormat(Expression, Format)
    vbsFormat = CoreFormat("{0:" & Format & "}", Expression)
End Function

' Allows more of the .NET formatting functionality to be used directly if required
Public Function CoreFormat(Format, Expression)
    CoreFormat = Expression
    On Error Resume Next
    With CreateObject("System.Text.StringBuilder")
        .AppendFormat Format, Expression
        If Err = 0 Then CoreFormat = .ToString
    End With
End Function

Function UDate(ThisDate)
    'Offset EST
    UDate = CLng(DateDiff("s", "01/01/1970 00:00:00", ThisDate))
End Function

Public Function GetFolderDate(ByVal Folder)
Dim objScript
Dim sFolder
Dim mDate
Dim URI
GetFolderDate = -1
        Set objScript = CreateObject("Scripting.FileSystemObject")
        Set sFolder = objScript.GetFolder(Folder)
        mDate = UDate(sFolder.DateLastModified)
        If Len(mDate) > 0 Then
            'URI = "&f_timestamp=" & mDate
            GetFolderDate = mDate
        End If
End Function

Public Function GetImgInfo(ByVal Folder, ByVal File)

Dim FileDetails(34)
Dim objShell
Dim objFolder
Dim objFolderItem
Dim i
Dim w
Dim h
Dim f_timestamp
Dim f_name
Dim URI

GetImgInfo = -1

If Not IsEmpty(File) Then
    Set objShell = CreateObject("Shell.Application")
    Set objFolder = objShell.Namespace(Folder)
    Set objFolderItem = objFolder.ParseName(File)

    FileDetails(3) = objFolder.GetDetailsOf(objFolderItem, 3)
    FileDetails(27) = objFolder.GetDetailsOf(objFolderItem, 27)
    FileDetails(28) = objFolder.GetDetailsOf(objFolderItem, 28)
    
    If Len(FileDetails(3)) > 0 Then f_timestamp = UDate(FileDetails(3))
    If UBound(Split(FileDetails(27))) = 1 Then w = Split(FileDetails(27))
    If UBound(Split(FileDetails(28))) = 1 Then h = Split(FileDetails(28))
    
    If Len(w(0)) > 0 And Len(h(0)) > 0 Then
        URI = "&f_timestamp=" & f_timestamp & "&width=" & w(0) & "&height=" & h(0)
        GetImgInfo = URI
        Exit Function
    End If
End If

End Function

Public Function FolderName(ByVal Path)

Dim s

FolderName = Path 'Return Path on Error
s = Split(Path, "\")

If UBound(s) > 0 Then FolderName = s(UBound(s))

End Function

Public Function DDFolderType(ByVal Path)

Dim s

DDFolderType = Path 'Return Path on Error
s = Split(Path, "_")

If UBound(s) > 0 Then DDFolderType = s(UBound(s))

End Function
```

## DD Track Script

```
Option Explicit

TrackDD()

Public Function TrackDD()
'Spreadshirt DD Track v1

Dim oWSHShell
Dim http
Dim Fso
Dim Files
Dim sFilter
Dim sFolder
Dim File
Dim sPath
Dim FileInfo
Dim ImgInfo
Dim ImgDims
Dim Action
Dim objNetwork
Dim CompName
Dim UserName
Dim Printer
Dim URL
Dim URI
Dim key
Dim wLog
Dim lDate

Set oWSHShell = CreateObject("WScript.Shell")
Set Fso = CreateObject("Scripting.FileSystemObject")

'Computer Info
'sFolder = oWSHShell.ExpandEnvironmentStrings("%TEMP%")
'Set sFolder = Fso.GetSpecialFolder(TemporaryFolder)
sFolder = "C:\Temp"
sFilter = "*.bmp"

Set objNetwork = CreateObject("WScript.Network")
CompName = objNetwork.ComputerName
'UserName = objNetwork.UserName
UserName = LCase(GetLocalUser())
Set wLog = Fso.CreateTextFile("D:\Scripts\track.log.txt", True)
'Returns "Wednesday, Jan 27 1993 17:04:03"
lDate = vbsFormat(Now, "dddd, MMM dd yyyy h:mm:ss")
'Write Log Header
wLog.WriteLine "################################# Spreadshirt DD Track Log - " & UserName & "@" & CompName & " - " & lDate & " #################################"

'Tracking Configuration
key = ""
Printer = "001"
Action = "queued"
'URL = "http://track.io85.com/"
URL = "http://io85.com/track/clean.php"
URI = "?key=" & key & "&compname=" & CompName & "&username=" & UserName & "&printer=" & Printer & "&action=" & Action

'List BMPs in Temp Dir
Files = ListDir(sFolder, sFilter)
If UBound(Files) = -1 Then
  wLog.WriteLine "No files found!"
  Exit Function
End If
    
For Each File In Files
    If GetFileInfo(File) <> -1 Then
    	'Get File Info
        FileInfo = GetFileInfo(File)
        'Get Picture Info
        'If GetImgInfo(sFolder, File) <> -1 Then
            ImgInfo = GetImgInfo(sFolder, File)
            ImgDims = GetImgDimURI(ImgInfo)
        'End If
        'Create HTTP Connection
        Set http = CreateObject("MSXML2.XMLHTTP")
        http.Open "GET", URL & URI & FileInfo & ImgDims, False
        http.Send
        WScript.Sleep(2000) 'Wait 2 Seconds
        If http.Status = 200 Then ' And http.StatusText = "OK" Then
            Fso.DeleteFile (File)
            wLog.WriteLine File & "-" & ImgDims & "-" & http.Status' & "-" & http.responseText
        End If
    Else
        wLog.WriteLine "Not a printout! - " & File
    End If
Next

Set oWSHShell = Nothing

End Function

Public Function GetFileInfo(ByVal File)
Dim Files
Dim sPath
Dim FileInfo
Dim Info
Dim Hexs
Dim URI

GetFileInfo = -1

sPath = Split(File, "\") 'Split on Path
If Not IsEmpty(sPath(2)) Then
    FileInfo = Split(sPath(2), "_") 'Split on Underscore
    Select Case UBound(FileInfo)
        Case 7
            '2624941_846337_109_L_FFFFFF_white_1_Preview.bmp
            '1111111_222222_333_4_555555_66666_7_88888888888
            URI = "&config=" & FileInfo(0) _
            & "&trans=" & FileInfo(1) _
            & "&product=" & FileInfo(2) _
            & "&size=" & FileInfo(3) _
            & "&hex=" & FileInfo(4) _
            & "&color=" & FileInfo(5)
            GetFileInfo = URI
            Exit Function
        Case 8
            'Distingish between dual color products or two word color names
            Hexs = 0
            For Each Info In FileInfo
                If IsHex(Info, 6) Then Hexs = Hexs + 1
            Next
            Select Case Hexs
                Case 2
                    '23824549_845933_111_S_32409A_royal_blue_1_Preview.bmp
                    '00000000_111111_222_3_444444_55555_6666_7_88888888888
                    URI = "&config=" & FileInfo(0) _
                    & "&trans=" & FileInfo(1) _
                    & "&product=" & FileInfo(2) _
                    & "&size=" & FileInfo(3) _
                    & "&hex=" & FileInfo(4) _
                    & "&color=" & FileInfo(5) & "%20" & FileInfo(6)
                Case 3
                    '2007771_845904_121_L_FFFFFF_000000_white-black_1_Preview.bmp
                    '0000000_111111_222_3_444444_555555_66666666666_7_88888888888
                    URI = "&config=" & FileInfo(0) _
                    & "&trans=" & FileInfo(1) _
                    & "&product=" & FileInfo(2) _
                    & "&size=" & FileInfo(3) _
                    & "&hex=" & FileInfo(4) _
                    & "&hex2=" & FileInfo(5) _
                    & "&color=" & FileInfo(6)
                Case Else
                    URI = "&config=" & FileInfo(0) _
                    & "&trans=" & FileInfo(1) _
                    & "&product=" & FileInfo(2) _
                    & "&size=" & FileInfo(3) _
                    & "&hex=Unknown" _
                    & "&color=Unknown"
                End Select
                GetFileInfo = URI
                Exit Function
        Case 9
            '23830562_846334_402_M_B8C3DB_melange_sky_blue_1_Preview.bmp
            '00000000_111111_222_3_444444_5555555_666_7777_8_99999999999
            URI = "&config=" & FileInfo(0) _
            & "&trans=" & FileInfo(1) _
            & "&product=" & FileInfo(2) _
            & "&size=" & FileInfo(3) _
            & "&hex=" & FileInfo(4) _
            & "&color=" & FileInfo(5) & "%20" & FileInfo(6) & "%20" & FileInfo(7)
            GetFileInfo = URI
            Exit Function
        Case 11
            '20018688_846664_48_L__14-16_yrs__FFFFFF_white_1_Preview.bmp
            '00000000_111111_22_3_4_5555_666_7_88888_99999_10_1111111111
            URI = "&config=" & FileInfo(0) _
            & "&trans=" & FileInfo(1) _
            & "&product=" & FileInfo(2) _
            & "&size=" & FileInfo(3) & "%20" & FileInfo(5) & "%20" & FileInfo(6) _
            & "&hex=" & FileInfo(8) _
            & "&color=" & FileInfo(9)
            GetFileInfo = URI
            Exit Function
        Case 12
            '20307736_843436_48_L__14-16_yrs__1E9658_kelly_green_1_Preview.bmp
            '00000000_111111_22_3_4_5555_666_7_88888_99999_10101_11_1212121212
            URI = "&config=" & FileInfo(0) _
            & "&trans=" & FileInfo(1) _
            & "&product=" & FileInfo(2) _
            & "&size=" & FileInfo(3) & "%20" & FileInfo(5) & "%20" & FileInfo(6) _
            & "&hex=" & FileInfo(8) _
            & "&color=" & FileInfo(9) & "%20" & FileInfo(10)
            GetFileInfo = URI
            Exit Function
        Case Else
            Exit Function
        End Select
Else
    Exit Function
End If

End Function

Public Function IsHex(ByVal strInput, ByVal sLimit)

Dim I
Dim j
Dim m
Dim sHexValue
Dim sHexValues
Dim aHexValues
strInput = UCase(strInput)
sHexValues = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F"
aHexValues = Split(sHexValues, ",")

IsHex = False

If LenB(strInput) = 0 Then Exit Function

I = 1
j = Len(strInput)
m = 0

Do Until I > j
    'If (Mid(strInput, i, 1) Like "[0-9A-Fa-f]") Then m = m + 1
    For Each sHexValue In aHexValues
        Dim d: d = UCase(Mid(strInput, I, 1))
        If UCase(Mid(strInput, I, 1)) = sHexValue Then
            m = m + 1
            Exit For
        End If
    Next
    I = I + 1
Loop

If m = j And m = sLimit Then IsHex = True

End Function

Public Function ListDir(ByVal Path, ByVal sFilter)
' Returns an array with the file names that match Path.
' The Path string may contain the wildcard characters "*"
' and "?" in the file name component. The same rules apply
' as with the MSDOS DIR command.
' If Path is a directory, the contents of this directory is listed.
' If Path is empty, the current directory is listed.
' Author: Christian d'Heureuse (www.source-code.biz)
   Dim Fso: Set Fso = CreateObject("Scripting.FileSystemObject")
   If Path = "" Then Path = "*.*"
   Dim Parent
   If Fso.FolderExists(Path) Then      ' Path is a directory
      Parent = Path
      If sFilter = "" Then sFilter = "*"
     Else
      Parent = Fso.GetParentFolderName(Path)
      If Parent = "" Then If Right(Path, 1) = ":" Then Parent = Path Else Parent = "."
      sFilter = Fso.GetFileName(Path)
      If sFilter = "" Then sFilter = "*"
      End If
   ReDim a(10)
   Dim n: n = 0
   Dim Folder: Set Folder = Fso.GetFolder(Parent)
   Dim Files: Set Files = Folder.Files
   Dim File
   For Each File In Files
      If CompareFileName(File.Name, sFilter) Then
         If n > UBound(a) Then ReDim Preserve a(n * 2)
         a(n) = File.Path
         n = n + 1
         End If
      Next
   ReDim Preserve a(n - 1)
   ListDir = a
End Function

Private Function CompareFileName(ByVal Name, ByVal sFilter)  ' (recursive)
   CompareFileName = False
   Dim np, fp: np = 1: fp = 1
   Do
      If fp > Len(sFilter) Then CompareFileName = np > Len(Name): Exit Function
      If Mid(sFilter, fp) = ".*" Then   ' special case: ".*" at end of filter
         If np > Len(Name) Then CompareFileName = True: Exit Function
         End If
      If Mid(sFilter, fp) = "." Then    ' special case: "." at end of filter
         CompareFileName = np > Len(Name): Exit Function
         End If
      Dim fc: fc = Mid(sFilter, fp, 1): fp = fp + 1
      Select Case fc
         Case "*"
            CompareFileName = CompareFileName2(Name, np, sFilter, fp)
            Exit Function
         Case "?"
            If np <= Len(Name) And Mid(Name, np, 1) <> "." Then np = np + 1
         Case Else
            If np > Len(Name) Then Exit Function
            Dim nc: nc = Mid(Name, np, 1): np = np + 1
            If StrComp(fc, nc, vbTextCompare) <> 0 Then Exit Function
         End Select
      Loop
End Function

Private Function CompareFileName2(ByVal Name, ByVal np0, ByVal sFilter, ByVal fp0)
   Dim fp: fp = fp0
   Dim fc2
   Do                                  ' skip over "*" and "?" characters in filter
      If fp > Len(sFilter) Then CompareFileName2 = True: Exit Function
      fc2 = Mid(sFilter, fp, 1): fp = fp + 1
      If fc2 <> "*" And fc2 <> "?" Then Exit Do
      Loop
   If fc2 = "." Then
      If Mid(sFilter, fp) = "*" Then    ' special case: ".*" at end of filter
         CompareFileName2 = True: Exit Function
         End If
      If fp > Len(sFilter) Then         ' special case: "." at end of filter
         CompareFileName2 = InStr(np0, Name, ".") = 0: Exit Function
         End If
      End If
   Dim np
   For np = np0 To Len(Name)
      Dim nc: nc = Mid(Name, np, 1)
      If StrComp(fc2, nc, vbTextCompare) = 0 Then
         If CompareFileName(Mid(Name, np + 1), Mid(sFilter, fp)) Then
            CompareFileName2 = True: Exit Function
            End If
         End If
      Next
   CompareFileName2 = False
End Function

Public Function GetImgInfo(ByVal Folder, ByVal File)

Dim arrValues(34)
Dim objShell
Dim objFolder
Dim objFolderItem
Dim i
Dim sPath

GetImgInfo = -1

sPath = Split(File, "\") 'Split on Path
If Not IsEmpty(sPath(2)) Then
	Set objShell = CreateObject("Shell.Application")
	Set objFolder = objShell.Namespace(Folder)
	Set objFolderItem = objFolder.ParseName(sPath(2))
	
	For i = 0 To 33
	    arrValues(i) = objFolder.GetDetailsOf(objFolderItem, i)
	Next
	
	If UBound(arrValues) > 0 Then GetImgInfo = arrValues
End If

End Function

Public Function GetImgDimURI(ByVal FileDetails)

Dim w
Dim h
Dim f_timestamp
Dim f_name
Dim URI

GetImgDimURI = -1

If Len(FileDetails(0)) > 0 Then f_name = FileDetails(0)
If Len(FileDetails(3)) > 0 Then f_timestamp = UDate(FileDetails(3))
If UBound(Split(FileDetails(27))) = 1 Then w = Split(FileDetails(27))
If UBound(Split(FileDetails(28))) = 1 Then h = Split(FileDetails(28))

If Len(w(0)) > 0 And Len(h(0)) > 0 Then
	URI = "&f_timestamp=" & f_timestamp & "&f_name=" & f_name & "&width=" & w(0) & "&height=" & h(0)
	GetImgDimURI = URI
	Exit Function
End If

End Function

Public Function GetLocalUser()

Dim strComputer
Dim colProcesses
Dim objProcess
Dim Return
Dim strNameOfUser
Dim strUserDomain

GetLocalUser = "Unknown"
strComputer = "."
Set colProcesses = GetObject("winmgmts:" & _
   "{impersonationLevel=impersonate}!\\" & strComputer & _
   "\root\cimv2").ExecQuery("Select * from Win32_Process")

For Each objProcess in colProcesses

    Return = objProcess.GetOwner(strNameOfUser, strUserDomain)
	
	Select Case LCase(objProcess.Name)
		Case "kornit.exe"
			If Return <> 0 Then
			    'Wscript.Echo "Could not get owner info for process " & objProcess.Name & "Error = " & Return
			Else 
		        'WScript.Echo "Process " & objProcess.Name & " is owned by " & strUserDomain & "\" & strNameOfUser & "."
		    	GetLocalUser = strNameOfUser
		    	Exit Function
			End If
	    Case "explorer.exe"
			If Return <> 0 Then
			    'Wscript.Echo "Could not get owner info for process " & objProcess.Name & "Error = " & Return
			Else 
		        'WScript.Echo "Process " & objProcess.Name & " is owned by " & strUserDomain & "\" & strNameOfUser & "."
				GetLocalUser = strNameOfUser
				Exit Function
			End If
	End Select
Next

End Function

Public Function vbsFormat(Expression, Format)
    vbsFormat = CoreFormat("{0:" & Format & "}", Expression)
End Function

' Allows more of the .NET formatting functionality to be used directly if required
Public Function CoreFormat(Format, Expression)
    CoreFormat = Expression
    On Error Resume Next
    With CreateObject("System.Text.StringBuilder")
        .AppendFormat Format, Expression
        If Err=0 Then CoreFormat = .toString
    End With
End Function

Function UDate(ThisDate)
	UDate = CLng(DateDiff("s", "01/01/1970 00:00:00", ThisDate))
End Function
```
