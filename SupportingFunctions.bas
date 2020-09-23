Attribute VB_Name = "SupportingFunctions"
Option Explicit

' Support functions for the GA class
'    null conversions
'    ConvertCommaToSystemdecimalseparator
'    KeyStrokeControlNumerical
'    ...

Public Function StrNull(ByVal Value As Variant) As String
    '
    ' test if a variant is null
    ' when null it is set to ""
    ' else the value is returned as string
    '
    StrNull = CStr(Value & "")
End Function

Public Function IntNull(ByVal Value As Variant) As Integer
    '
    ' test if a variant is null
    ' when null it is set to 0
    ' else the value is returned as integer
    '
    If IsNull(Value) Or Len(Value) = 0 Then
        IntNull = 0
    Else
        If IsNumeric(Value) Then
            IntNull = CInt(Value)
        Else
            IntNull = CInt("0" & VarToNum(Value))
        End If
    End If
End Function

Public Function LngNull(Value As Variant) As Long
    '
    ' test if a variant is null
    ' when null it is set to 0
    ' else the value is returned as long
    '
    If IsNull(Value) Or Len(Value) = 0 Then
        LngNull = 0
    Else
        If IsNumeric(Value) Then
            LngNull = CLng(Value)
        Else
            LngNull = CLng("0" & VarToNum(Value))
        End If
    End If

End Function

Public Function DblNull(ByVal Value As Variant) As Double
    '
    ' test if a variant is null
    ' when null it is set to 0
    ' else the value is returned as double
    '
    If IsNull(Value) Or Len(Value) = 0 Then
        DblNull = 0
    Else
        If IsNumeric(Value) Then
            DblNull = CDbl(Value)
        Else
            DblNull = CDbl("0" & VarToNum(Value))
        End If
    End If
End Function

Public Function VarToNum(ByVal Argument As Variant) As String
    Dim str_work        As String
    Dim str_character   As String
    Dim int_i           As Integer
    Dim int_length      As Integer
    Dim bln_Negative    As Boolean
    
    int_length = Len(CStr(Argument))
    bln_Negative = False
    
    For int_i = 1 To int_length
        str_character = Mid(Argument, int_i, 1)
        
        Select Case str_character
            
            Case "0" To "9", ".", ","
                str_work = str_work & str_character
                
            Case "-"
                bln_Negative = True
            
            Case Else
        
        End Select
    Next int_i
    
    If bln_Negative = True Then
        str_work = str_work & "-"
    End If
    
    VarToNum = str_work
    
End Function

Public Function KeyStrokeControlNumerical(ByVal KeyAscii As Integer, Optional MinusSignAllowed As Boolean = True, Optional CommaAllowed As Boolean = True) As Integer
    '
    ' Make sure the pressed key is numerical...
    ' allows backspace and arrow keys.
    ' Optionally allow comma/point and minus-sign
    '
    KeyStrokeControlNumerical = KeyAscii
    
    Select Case KeyAscii
        Case 8      ' Backspace
        
        Case 44, 46     ' Comma and point
            If CommaAllowed = False Then
                KeyStrokeControlNumerical = 0
            Else
                KeyStrokeControlNumerical = Asc(strCurrentsystemDecimalSeparator)
            End If
                
        Case 45     ' Minus sign
            If MinusSignAllowed = False Then
                KeyStrokeControlNumerical = 0
            End If
            
        Case 48 To 57
            
        Case Else
            KeyStrokeControlNumerical = 0
    End Select
    
End Function

Public Function ConvertCommaToSystemdecimalseparator(ByVal strStart As String) As String
    '
    ' This function is to provide correct localization..
    ' In my country (Belgium) a comma is ','
    ' VB needs the point-symbol for double numbers, and in many countries
    ' the ',' is used as thousand-separator. The ',' symbol used in
    ' the saved files (GA-files) is read 'wrongly' in such cases.
    ' this function makes sure the correct symbol is used regardless of the windows-set commasymbol
    ' Especially usefull when loading values from textfiles...
    '
    If InStr(strStart, strCurrentsystemDecimalSeparator) <> 0 Then
        ' nothing to change
        ConvertCommaToSystemdecimalseparator = strStart
    Else
        If strCurrentsystemDecimalSeparator = "," Then
            ConvertCommaToSystemdecimalseparator = Replace(strStart, ".", strCurrentsystemDecimalSeparator)
        Else
            ConvertCommaToSystemdecimalseparator = Replace(strStart, ",", strCurrentsystemDecimalSeparator)
        End If
    End If

End Function

Public Function IsLoaded(ByVal FormName As String) As Boolean
    '
    ' check to see if a given form is loaded
    '
    Dim intI            As Integer
    
    IsLoaded = False
    FormName = UCase$(FormName)
    For intI = 0 To Forms.Count - 1
        If UCase$(Forms(intI).Name) = FormName Then
            IsLoaded = True
            Exit For
        End If
    Next intI
    
End Function

Public Sub SetTextboxAsSelected(ByRef Ctrl_Veld As Control)
    '
    ' set the given textbox as selected (it's content will be entirely selected)
    '
    With Ctrl_Veld
        .SelStart = 0
        .SelLength = Len(.Text)
    End With
    
End Sub

