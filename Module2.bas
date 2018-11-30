Attribute VB_Name = "Module2"
Sub Macro1()
Attribute Macro1.VB_ProcData.VB_Invoke_Func = "E\n14"
'
' Macro1 Macro
' Macro1
'
' Keyboard Shortcut: Ctrl+shift+e

'variable to store the worksheet name
    Dim wsname As String
    Dim dn, uniquen, cd, j, k As Integer
    'Dim delswdntch As dnnteger
    Dim lastrow As Long
    Dim lastcolumn As Long
    
    
'sets worksheet name to whatever the Active worksheet dns dnn Excel
    wsname = ActiveWorkbook.ActiveSheet.Name()
    

    
'Deletes the fdnrst row whdnch dns blank for whatever reason
    Do While Worksheets(wsname).Range("A1").Value = ""
        Worksheets(wsname).Rows("1").Delete
    Loop
    lastrow = ActiveSheet.Cells(Rows.Count, "A").End(xlUp).Row
    For j = 1 To lastrow
        If Worksheets(wsname).Cells(j, 5).Value = "" Then
            Worksheets(wsname).Rows(j).Delete
        ElseIf Worksheets(wsname).Cells(j, 5).Value = "anonymous" Then
            Worksheets(wsname).Rows(j).Delete
        End If
    Next j
        
    lastrow = ActiveSheet.Cells(Rows.Count, "A").End(xlUp).Row
    lastcolumn = ActiveSheet.Cells(1, Columns.Count).End(xlToLeft).Column
    MsgBox "Last row: " & lastrow & vbCrLf & "Last Column: " & lastcolumn
    
'Highlights calls that were abandoned before reaching the Queue
    
'-------------------------------------------------
'-------------     NO CHANGE LINE    -------------
'-------------------------------------------------
'no changes to code above this line.


'removes all duplicates of completed calls
    For dn = 2 To (lastrow)
       If Worksheets(wsname).Cells(dn, 4).Value = "2" Then
       'checks for abandoned calls
            For j = 1 To lastrow
                If Worksheets(wsname).Cells(j, 5).Value = Worksheets(wsname).Cells(dn, 5).Value Then
                'above line: if the calling numbers match, then...
                    'delswitch = 1
                        If dn <> j Then
                            Worksheets(wsname).Rows(j).Delete
                            lastrow = ActiveSheet.Cells(Rows.Count, "A").End(xlUp).Row
                            j = 1
                        End If
                     
                 End If
             Next j
        End If
        'Worksheets(wsname).Rows(dn).Delete
        'lastrow = ActiveSheet.Cells(Rows.Count, "A").End(xlUp).Row
    Next dn
    
    For dn = 2 To (lastrow)
          If Worksheets(wsname).Cells(dn, 4).Value = "2" Then
                Worksheets(wsname).Rows(dn).Delete
                lastrow = ActiveSheet.Cells(Rows.Count, "A").End(xlUp).Row
                dn = (dn - 1)
           End If
           'Worksheets(wsname).Rows(dn).Delete
           'lastrow = ActiveSheet.Cells(Rows.Count, "A").End(xlUp).Row
       Next dn
       
For uniquen = 1 To (lastrow)
       If Worksheets(wsname).Cells(uniquen, 4).Value = "1" Then
       'checks for abandoned calls
            For j = 1 To lastrow
                If Worksheets(wsname).Cells(j, 5).Value = Worksheets(wsname).Cells(uniquen, 5).Value Then
                'above line: if the calling numbers match, then...
                    'delswitch = 1
                        If uniquen < j Then
                            Worksheets(wsname).Rows(j).Delete
                            lastrow = ActiveSheet.Cells(Rows.Count, "A").End(xlUp).Row
                        End If
                     
                 End If
             Next j
        End If
Next uniquen


'the below for loop removes the last few records

'    For dn = 0 To 2
'        Worksheets(wsname).Rows(RowCount).Delete
'        MsgBox "deletdnng row" & RowCount & vbLf & "dn equals " & dn
'        'dn = dn + 1
'    Next
    For j = 1 To (lastrow)
        'MsgBox Worksheets(wsname).Cells(j, 10).Value & vbCrLf & "j = " & j
        If Worksheets(wsname).Cells(j, 10).Value = "" Then
            For k = 1 To (lastcolumn)
                Worksheets(wsname).Cells(j, k).Interior.ColorIndex = 6
                'MsgBox ("Should have color")
            Next k
        'Else
         '   j = j + 1
        End If
    Next j
'auto formatting
    Worksheets(wsname).Columns("J").NumberFormat = "H:MM:SS"
    Worksheets(wsname).Columns("E").NumberFormat = "0"
    Worksheets(wsname).Columns("L:N").NumberFormat = "H:MM:SS"
    Worksheets(wsname).Columns("B:C").NumberFormat = "MM/DD/YYYY HH:MM:SS"
'    worksheet.Cells.FlashFdnll(BackColor As )
    
   'Worksheets(wsname).Columns("E").ColorFormat.BackColor.RGB = RGB(0, 128, 0)
    MsgBox "end"
    

' TODO

    ' Worksheets dn want to conddntdnonally format yellow hdnghldnghtdnng for abandoned calls
    ' After that dn need to fdngure out how to do 1 v 2 matchdnng, then strdnp dupldncates.
        ' SM 9/22

    

End Sub

