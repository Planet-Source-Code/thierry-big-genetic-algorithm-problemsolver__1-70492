VERSION 5.00
Begin VB.Form frmGenAlgGrid 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Fill the Grid"
   ClientHeight    =   5100
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8805
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5100
   ScaleWidth      =   8805
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkSameNumber 
      Caption         =   "Allow same number to appear multiple times"
      Height          =   495
      Left            =   6120
      TabIndex        =   1
      Top             =   1680
      Width           =   2535
   End
   Begin VB.CommandButton cmdTextfile 
      Caption         =   "Show explanation text"
      Height          =   375
      Left            =   6120
      TabIndex        =   0
      Top             =   720
      Width           =   2415
   End
   Begin VB.TextBox txtSum 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   7920
      TabIndex        =   2
      Text            =   "250"
      Top             =   3480
      Width           =   615
   End
   Begin VB.CommandButton cmdFillGrid 
      Caption         =   "Start"
      Height          =   375
      Left            =   3600
      TabIndex        =   4
      Top             =   4080
      Width           =   1935
   End
   Begin VB.CommandButton cmdGAControlPanel 
      Caption         =   "GA control panel..."
      Height          =   375
      Left            =   3600
      TabIndex        =   5
      Top             =   4560
      Width           =   1935
   End
   Begin VB.TextBox txtGenerations 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   2520
      TabIndex        =   3
      Text            =   "75000"
      Top             =   4080
      Width           =   735
   End
   Begin VB.CommandButton cmdStop 
      Caption         =   "Stop"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5760
      TabIndex        =   7
      Top             =   4560
      Width           =   1935
   End
   Begin VB.CommandButton cmdShowChromo 
      Caption         =   "Pause and show stats"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5760
      TabIndex        =   6
      Top             =   4080
      Width           =   1935
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      Height          =   375
      Left            =   7920
      TabIndex        =   8
      Top             =   4560
      Width           =   735
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      Caption         =   "Value for sum (minimum 15, maximum 500) ="
      Height          =   255
      Left            =   4680
      TabIndex        =   35
      Top             =   3480
      Width           =   3135
   End
   Begin VB.Label Label3 
      Caption         =   "In a 3 x 3 grid, find 9 integers between 0 and 500 so that the sums of each row and columns equal a given number"
      Height          =   495
      Left            =   1320
      TabIndex        =   34
      Top             =   120
      Width           =   7455
   End
   Begin VB.Label Label2 
      Caption         =   "Problem :"
      Height          =   255
      Left            =   120
      TabIndex        =   33
      Top             =   120
      Width           =   735
   End
   Begin VB.Label lblSum 
      Alignment       =   2  'Center
      Caption         =   "sum"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   5
      Left            =   3360
      TabIndex        =   32
      Top             =   3120
      Width           =   855
   End
   Begin VB.Label lblSum 
      Alignment       =   2  'Center
      Caption         =   "sum"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   4
      Left            =   2400
      TabIndex        =   31
      Top             =   3120
      Width           =   855
   End
   Begin VB.Label lblSum 
      Alignment       =   2  'Center
      Caption         =   "sum"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   3
      Left            =   1440
      TabIndex        =   30
      Top             =   3120
      Width           =   855
   End
   Begin VB.Label lblSum 
      Caption         =   "sum"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   2
      Left            =   4920
      TabIndex        =   29
      Top             =   2280
      Width           =   855
   End
   Begin VB.Label lblSum 
      Caption         =   "sum"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   1
      Left            =   4920
      TabIndex        =   28
      Top             =   1680
      Width           =   855
   End
   Begin VB.Label lblSum 
      Caption         =   "sum"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   0
      Left            =   4920
      TabIndex        =   27
      Top             =   1080
      Width           =   855
   End
   Begin VB.Label lblGenerations 
      Height          =   255
      Left            =   1800
      TabIndex        =   26
      Top             =   4680
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "Generations :"
      Height          =   255
      Index           =   6
      Left            =   240
      TabIndex        =   25
      Top             =   4680
      Width           =   1095
   End
   Begin VB.Line Line9 
      X1              =   8640
      X2              =   120
      Y1              =   3960
      Y2              =   3960
   End
   Begin VB.Label Label4 
      Caption         =   "Howmany generations"
      Height          =   255
      Left            =   240
      TabIndex        =   24
      Top             =   4080
      Width           =   2055
   End
   Begin VB.Label Label1 
      Caption         =   "="
      Height          =   255
      Index           =   5
      Left            =   3720
      TabIndex        =   23
      Top             =   2880
      Width           =   255
   End
   Begin VB.Label Label1 
      Caption         =   "="
      Height          =   255
      Index           =   4
      Left            =   2760
      TabIndex        =   22
      Top             =   2880
      Width           =   255
   End
   Begin VB.Label Label1 
      Caption         =   "="
      Height          =   255
      Index           =   3
      Left            =   1800
      TabIndex        =   21
      Top             =   2880
      Width           =   255
   End
   Begin VB.Label Label1 
      Caption         =   "="
      Height          =   255
      Index           =   2
      Left            =   4560
      TabIndex        =   20
      Top             =   2400
      Width           =   255
   End
   Begin VB.Label Label1 
      Caption         =   "="
      Height          =   255
      Index           =   1
      Left            =   4560
      TabIndex        =   19
      Top             =   1800
      Width           =   255
   End
   Begin VB.Label Label1 
      Caption         =   "="
      Height          =   255
      Index           =   0
      Left            =   4560
      TabIndex        =   18
      Top             =   1200
      Width           =   255
   End
   Begin VB.Line Line8 
      X1              =   1440
      X2              =   4320
      Y1              =   2760
      Y2              =   2760
   End
   Begin VB.Line Line7 
      X1              =   1440
      X2              =   4320
      Y1              =   960
      Y2              =   960
   End
   Begin VB.Line Line6 
      X1              =   4320
      X2              =   4320
      Y1              =   960
      Y2              =   2760
   End
   Begin VB.Line Line5 
      X1              =   1440
      X2              =   1440
      Y1              =   960
      Y2              =   2760
   End
   Begin VB.Line Line4 
      X1              =   3360
      X2              =   3360
      Y1              =   960
      Y2              =   2760
   End
   Begin VB.Line Line3 
      X1              =   2400
      X2              =   2400
      Y1              =   960
      Y2              =   2760
   End
   Begin VB.Line Line2 
      X1              =   1440
      X2              =   4320
      Y1              =   2160
      Y2              =   2160
   End
   Begin VB.Line Line1 
      X1              =   1440
      X2              =   4320
      Y1              =   1560
      Y2              =   1560
   End
   Begin VB.Label lblGrid 
      Alignment       =   2  'Center
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   8
      Left            =   3480
      TabIndex        =   17
      Top             =   2280
      Width           =   735
   End
   Begin VB.Label lblGrid 
      Alignment       =   2  'Center
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   7
      Left            =   2520
      TabIndex        =   16
      Top             =   2280
      Width           =   735
   End
   Begin VB.Label lblGrid 
      Alignment       =   2  'Center
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   6
      Left            =   1560
      TabIndex        =   15
      Top             =   2280
      Width           =   735
   End
   Begin VB.Label lblGrid 
      Alignment       =   2  'Center
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   5
      Left            =   3480
      TabIndex        =   14
      Top             =   1680
      Width           =   735
   End
   Begin VB.Label lblGrid 
      Alignment       =   2  'Center
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   4
      Left            =   2520
      TabIndex        =   13
      Top             =   1680
      Width           =   735
   End
   Begin VB.Label lblGrid 
      Alignment       =   2  'Center
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   3
      Left            =   1560
      TabIndex        =   12
      Top             =   1680
      Width           =   735
   End
   Begin VB.Label lblGrid 
      Alignment       =   2  'Center
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   2
      Left            =   3480
      TabIndex        =   11
      Top             =   1080
      Width           =   735
   End
   Begin VB.Label lblGrid 
      Alignment       =   2  'Center
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   1
      Left            =   2520
      TabIndex        =   10
      Top             =   1080
      Width           =   735
   End
   Begin VB.Label lblGrid 
      Alignment       =   2  'Center
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Index           =   0
      Left            =   1560
      TabIndex        =   9
      Top             =   1080
      Width           =   735
   End
End
Attribute VB_Name = "frmGenAlgGrid"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim WithEvents GenAlg           As clsGeneticAlgorithm
Attribute GenAlg.VB_VarHelpID = -1

Dim blnDoLoop                   As Boolean

Dim lngBestGrid                 As Long

Private Sub cmdexit_Click()

    GenAlg.Clear
    
    Set GenAlg = Nothing
    
    Unload Me

End Sub

Private Sub cmdFillGrid_Click()
    '
    ' start filling the grid
    '
    Dim lngGeneration           As Long
    
    
    ' reset the grid
    Call ResetGrid
    
    
    cmdExit.Enabled = False
    cmdFillGrid.Enabled = False
    txtGenerations.Enabled = False
    cmdGAControlPanel.Enabled = False
    cmdShowChromo.Enabled = True
    cmdStop.Enabled = True
    
    lblGenerations.Caption = ""
    
    '
    ' STEP 1 : INITIALIZATION
    '

    '
    ' Set the chromosome and gene properties for the given problem
    '
    ' Done by loading the FillGrid.GA-file
    
    ' Start
    ' create the initial population
    Call GenAlg.CREATEPOPULATION(GenAlg.PopulationSize)

    lngGeneration = 1
    
    blnDoLoop = True
    
    Do
        lblGenerations.Caption = lngGeneration
        lblGenerations.Refresh
        
        Call GenAlg.EVALUATE

        DoEvents

        Call GenAlg.SELECTION

        Call GenAlg.REPRODUCTION

        lngGeneration = lngGeneration + 1
    Loop Until lngGeneration > LngNull(txtGenerations.Text) Or blnDoLoop = False
    
    MsgBox "Stopped"
    
    cmdExit.Enabled = True
    cmdFillGrid.Enabled = True
    txtGenerations.Enabled = True
    cmdGAControlPanel.Enabled = True
    cmdShowChromo.Enabled = False
    cmdStop.Enabled = False
    
End Sub

Private Sub cmdGAControlPanel_Click()

    Load frmGenAlgControlPanel
    frmGenAlgControlPanel.ReadSettings = GenAlg
    
    frmGenAlgControlPanel.Show vbModal

End Sub

Private Sub cmdShowChromo_Click()
    '
    ' Pause and show the GA-statistics
    '
    Load frmGenAlgShowChromo
    Call frmGenAlgShowChromo.RefreshList(GenAlg)
            
    frmGenAlgShowChromo.Show vbModal

End Sub

Private Sub cmdStop_Click()

    blnDoLoop = False

End Sub

Private Sub cmdTextfile_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\fillgrid.txt", vbNormalFocus)

End Sub

Private Sub Form_Load()

    Call ResetGrid
    
    Set GenAlg = New clsGeneticAlgorithm

    blnDoLoop = False

    Call GenAlg.ReadGASettings(App.Path & "\GA\FillGrid.GA")
    
End Sub

Private Sub GenAlg_EvaluateFitness(ByVal lngIndex As Long, dblFitness As Double)
    '
    ' Decode the chromosome,
    ' see what are the sums for each row and column
    ' calculate fitness
    '
    Dim lngsum(6)               As Long
                ' 1  row1
                ' 2  row2
                ' 3  row3
                ' 4  column1
                ' 5  column2
                ' 6  column3
    Dim lngHelp                 As Long
    Dim lngSumToSeek            As Long
    
    Dim intX                    As Integer
    Dim intY                    As Integer
    
    Dim blnSameNumberMoreThanOnce As Boolean
    
    lngSumToSeek = LngNull(txtSum.Text)
    blnSameNumberMoreThanOnce = False
    
    ' decode
    ' rows
    lngsum(1) = GenAlg.ShowGenelong(lngIndex, 0) + GenAlg.ShowGenelong(lngIndex, 1) + GenAlg.ShowGenelong(lngIndex, 2)
    lngsum(2) = GenAlg.ShowGenelong(lngIndex, 3) + GenAlg.ShowGenelong(lngIndex, 4) + GenAlg.ShowGenelong(lngIndex, 5)
    lngsum(3) = GenAlg.ShowGenelong(lngIndex, 6) + GenAlg.ShowGenelong(lngIndex, 7) + GenAlg.ShowGenelong(lngIndex, 8)
    ' columns
    lngsum(4) = GenAlg.ShowGenelong(lngIndex, 0) + GenAlg.ShowGenelong(lngIndex, 3) + GenAlg.ShowGenelong(lngIndex, 6)
    lngsum(5) = GenAlg.ShowGenelong(lngIndex, 1) + GenAlg.ShowGenelong(lngIndex, 4) + GenAlg.ShowGenelong(lngIndex, 7)
    lngsum(6) = GenAlg.ShowGenelong(lngIndex, 2) + GenAlg.ShowGenelong(lngIndex, 5) + GenAlg.ShowGenelong(lngIndex, 8)
 
    ' take the absolute difference between the sum we seek and
    ' the sums we have for every row / column
    lngHelp = Abs(lngsum(1) - lngSumToSeek) + Abs(lngsum(2) - lngSumToSeek) + Abs(lngsum(3) - lngSumToSeek) + Abs(lngsum(4) - lngSumToSeek) + Abs(lngsum(5) - lngSumToSeek) + Abs(lngsum(6) - lngSumToSeek)
 
    ' allow same number to appear multiple times ?
    If chkSameNumber.Value = vbUnchecked Then
        GoSub SameNumber
        If blnSameNumberMoreThanOnce = True Then
            ' same number appears, make the fitness bigger
            lngHelp = lngHelp + 100
        End If
    End If
    
    ' Have we a better solution than the previous one ?
    If lngHelp < lngBestGrid Then
        lngBestGrid = lngHelp
        GoSub DrawGrid
    End If
    
    ' Have we found a solution ?
    If lngHelp = 0 Then
        blnDoLoop = False
        dblFitness = 0
        MsgBox "Solution found !"
    Else
        dblFitness = DblNull(lngHelp)
    End If
    
Exit Sub

'
' Draw grid
'
DrawGrid:
    
    For intX = 0 To 8
        lblGrid(intX).Caption = GenAlg.ShowGenelong(lngIndex, intX)
    Next intX
    
    For intX = 0 To 5
        lblSum(intX).Caption = lngsum(intX + 1)
        If lngsum(intX + 1) = lngSumToSeek Then
            lblSum(intX).ForeColor = RGB(0, 0, 255)
        Else
            lblSum(intX).ForeColor = RGB(255, 0, 0)
        End If
    Next intX
    
Return
                    
'
' check if same number appears twice or more
'
SameNumber:

    blnSameNumberMoreThanOnce = False
    For intX = 0 To 7
        For intY = (intX + 1) To 8
            If GenAlg.ShowGenelong(lngIndex, intX) = GenAlg.ShowGenelong(lngIndex, intY) Then
                blnSameNumberMoreThanOnce = True
                Exit For
            End If
        Next intY
    Next intX
    
Return

End Sub

Private Sub GenAlg_GAError(ByVal ErrorCode As Long, ByVal ErrorDescription As String)

    MsgBox "ERROR !!" & vbNewLine & "Error " & ErrorCode & " " & ErrorDescription
    blnDoLoop = False

End Sub

Private Sub txtGenerations_GotFocus()
    Call SetTextboxAsSelected(txtGenerations)
End Sub

Private Sub txtGenerations_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub txtSum_GotFocus()
    Call SetTextboxAsSelected(txtSum)
End Sub

Private Sub txtSum_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub ResetGrid()
    '
    ' reset the grid
    '
    Dim intX                    As Integer
    
    For intX = 0 To 8
        lblGrid(intX).Caption = "?"
    Next intX
    
    For intX = 0 To 5
        lblSum(intX).Caption = LngNull(txtSum.Text)
        lblSum(intX).ForeColor = RGB(0, 0, 0)
    Next intX
    
    lngBestGrid = 500
    
End Sub
