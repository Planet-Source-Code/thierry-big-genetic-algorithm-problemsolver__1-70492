VERSION 5.00
Begin VB.Form frmGenAlgCircles 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Circles"
   ClientHeight    =   8550
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9630
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8550
   ScaleWidth      =   9630
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdTextfile 
      Caption         =   "Show explanation text"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   6960
      Width           =   2415
   End
   Begin VB.CommandButton cmdShowChromo 
      Caption         =   "Pause and show stats"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5760
      TabIndex        =   7
      Top             =   7560
      Width           =   1935
   End
   Begin VB.CommandButton cmdStop 
      Caption         =   "Stop"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5760
      TabIndex        =   8
      Top             =   8040
      Width           =   1935
   End
   Begin VB.TextBox txtGenerations 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   2520
      TabIndex        =   4
      Text            =   "50000"
      Top             =   7560
      Width           =   735
   End
   Begin VB.CommandButton cmdGAControlPanel 
      Caption         =   "GA control panel..."
      Height          =   375
      Left            =   3600
      TabIndex        =   6
      Top             =   8040
      Width           =   1935
   End
   Begin VB.CommandButton cmdFindDisc 
      Caption         =   "Start"
      Enabled         =   0   'False
      Height          =   375
      Left            =   3600
      TabIndex        =   5
      Top             =   7560
      Width           =   1935
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      Height          =   375
      Left            =   8760
      TabIndex        =   9
      Top             =   8040
      Width           =   735
   End
   Begin VB.CommandButton cmdDrawCIrcles 
      Caption         =   "Clear and draw random circles"
      Height          =   375
      Left            =   6600
      TabIndex        =   3
      Top             =   6960
      Width           =   2895
   End
   Begin VB.TextBox txtNumberOfCircles 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   5880
      TabIndex        =   2
      Text            =   "10"
      Top             =   6960
      Width           =   495
   End
   Begin VB.PictureBox PictBox 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      ForeColor       =   &H80000008&
      Height          =   6255
      Left            =   120
      ScaleHeight     =   6225
      ScaleWidth      =   9345
      TabIndex        =   0
      Top             =   480
      Width           =   9375
   End
   Begin VB.Label Label2 
      Caption         =   "Problem :"
      Height          =   255
      Left            =   120
      TabIndex        =   15
      Top             =   0
      Width           =   735
   End
   Begin VB.Label Label3 
      Caption         =   $"frmGenAlgCircles.frx":0000
      Height          =   495
      Left            =   960
      TabIndex        =   14
      Top             =   0
      Width           =   8535
   End
   Begin VB.Label Label4 
      Caption         =   "Howmany generations"
      Height          =   255
      Left            =   240
      TabIndex        =   13
      Top             =   7560
      Width           =   2055
   End
   Begin VB.Line Line1 
      X1              =   9480
      X2              =   120
      Y1              =   7440
      Y2              =   7440
   End
   Begin VB.Label Label1 
      Caption         =   "Generations :"
      Height          =   255
      Index           =   1
      Left            =   240
      TabIndex        =   12
      Top             =   8160
      Width           =   1095
   End
   Begin VB.Label lblGenerations 
      Height          =   255
      Left            =   1800
      TabIndex        =   11
      Top             =   8160
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "Howmany random circles :"
      Height          =   255
      Index           =   0
      Left            =   3720
      TabIndex        =   10
      Top             =   6960
      Width           =   2055
   End
End
Attribute VB_Name = "frmGenAlgCircles"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim WithEvents GenAlg           As clsGeneticAlgorithm
Attribute GenAlg.VB_VarHelpID = -1

Dim lngCirclesX()               As Long ' The array of random circles that
Dim lngCirclesY()               As Long ' fill the space initially
Dim lngCirclesR()               As Long '

Dim lngBestMiddleX              As Long '
Dim lngBestMiddleY              As Long ' The best circle found so far
Dim lngBestRadius               As Long '

Dim lngLargestPossibleRadius    As Long

Dim blnDoLoop                   As Boolean

Private Sub cmdDrawCIrcles_Click()
    '
    ' Draw random circles
    '
    ' Save the circles info in the array.
    
    Call GenerateCircles
    
    Call DrawCircles
    
    cmdFindDisc.Enabled = True

End Sub

Private Sub cmdexit_Click()
    
    GenAlg.Clear
    
    Set GenAlg = Nothing
    
    Unload Me

End Sub

Private Sub cmdFindDisc_Click()
    
    Dim lngGeneration           As Long
    
    cmdExit.Enabled = False
    cmdFindDisc.Enabled = False
    txtNumberOfCircles.Enabled = False
    cmdDrawCIrcles.Enabled = False
    txtGenerations.Enabled = False
    cmdGAControlPanel.Enabled = False
    cmdShowChromo.Enabled = True
    cmdStop.Enabled = True
    
    lblGenerations.Caption = ""
    
    lngBestMiddleX = 0
    lngBestMiddleY = 0
    lngBestRadius = 0
    
    '
    ' STEP 1 : INITIALIZATION
    '

    '
    ' Set the chromosome and gene properties for the given problem
    '
    ' Here not every property can be taken blindly from the circles.GA file.
    ' The maximumvalue for the gene is directly taken from the picturebox.
    '
    If PictBox.ScaleWidth > PictBox.ScaleHeight Then
        GenAlg.LongGeneMaxValue = PictBox.ScaleWidth
        lngLargestPossibleRadius = PictBox.ScaleWidth
    Else
        GenAlg.LongGeneMaxValue = PictBox.ScaleHeight
        lngLargestPossibleRadius = PictBox.ScaleHeight
    End If
    
    ' Start
    ' create the initial population
    ' Let's make 10 chromosomes
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
    
    ' redraw the circles
    Call RedrawCircles
    
    cmdExit.Enabled = True
    cmdFindDisc.Enabled = True
    txtNumberOfCircles.Enabled = True
    cmdDrawCIrcles.Enabled = True
    txtGenerations.Enabled = True
    cmdGAControlPanel.Enabled = True
    cmdShowChromo.Enabled = False
    cmdStop.Enabled = False
    
End Sub


Private Sub cmdGAControlPanel_Click()

    Load frmGenAlgControlPanel
    frmGenAlgControlPanel.ReadSettings = GenAlg
    
    frmGenAlgControlPanel.Show vbModal
    
    If cmdFindDisc.Enabled = True Then
        ' redraw the circles
        Call RedrawCircles
    End If
    
End Sub

Private Sub cmdShowChromo_Click()
    '
    ' Pause and show the GA-statistics
    '
    Load frmGenAlgShowChromo
    Call frmGenAlgShowChromo.RefreshList(GenAlg)
            
    frmGenAlgShowChromo.Show vbModal

    ' redraw the circles
    Call RedrawCircles
    
End Sub

Private Sub cmdStop_Click()

    blnDoLoop = False
    
End Sub

Private Sub cmdTextfile_Click()
    
    Call Shell("Notepad.exe " & App.Path & "\Documentation\Circles.txt", vbNormalFocus)
    
End Sub

Private Sub Form_Load()

    Set GenAlg = New clsGeneticAlgorithm

    blnDoLoop = False

    Call GenAlg.ReadGASettings(App.Path & "\GA\circles.GA")
    
End Sub

Private Sub GenAlg_EvaluateFitness(ByVal lngIndex As Long, dblFitness As Double)

    Dim lngMiddleX              As Long
    Dim lngMiddleY              As Long
    Dim lngRadius               As Long

    Dim blnDiscOK               As Boolean
            
    ' first decode the chromosome. Return the circle parameters contained inside
    Call DecodeGeneFunction(lngIndex, lngMiddleX, lngMiddleY, lngRadius)
                
    blnDiscOK = True
    ' are his values within the picturebox ?
    If (lngMiddleX - lngRadius) < 0 Or (lngMiddleX + lngRadius) > PictBox.ScaleWidth Then
        blnDiscOK = False
    End If
    If (lngMiddleY - lngRadius) < 0 Or (lngMiddleY + lngRadius) > PictBox.ScaleHeight Then
        blnDiscOK = False
    End If
    If lngRadius = 0 Then
        ' trap here a radius of zero
        lngRadius = lngLargestPossibleRadius + 1
    End If
    If lngRadius > lngLargestPossibleRadius Then
        blnDiscOK = False
    End If
            
            
    If blnDiscOK = False Then
        ' it's not a good one
        ' make the fitness a very large number (bad)
        dblFitness = 1E+16
    Else
        ' if this disc intersects, it's not a good one...
        If CirclesDoNotIntersect(lngMiddleX, lngMiddleY, lngRadius) = False Then
            ' it's not a good one
            ' make the fitness a very large number (bad)
            dblFitness = 1E+16
        
        Else
            ' is it better than the best so far ?
            If lngRadius > lngBestRadius Then
                lngBestRadius = lngRadius
                lngBestMiddleX = lngMiddleX
                lngBestMiddleY = lngMiddleY
            
                ' redraw the circles
                Call RedrawCircles
            End If
            
            ' Now, the radius must be maximal, so the maximum
            ' fitness is the largest possible radius
            ' so the fitness can be calculated as
            ' 1/radius
            dblFitness = DblNull(1 / lngRadius)

        End If
    End If

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

Private Sub txtNumberOfCircles_GotFocus()
    Call SetTextboxAsSelected(txtNumberOfCircles)
End Sub

Private Sub txtNumberOfCircles_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub GenerateCircles()
    '
    ' Generate random non-interseding circles
    ' Save the circles center and radius in the array
    ' Check that a given circle does not intersect or exists inside another circle
    '
    Dim intX                    As Integer
    Dim intY                    As Integer
    
    Dim lngRadius               As Long
    Dim lngMiddleX              As Long
    Dim lngMiddleY              As Long
    Dim lngDistX                As Long
    Dim lngDistY                As Long
    
    Dim blnCircleOK             As Boolean
    
    ReDim lngCirclesX(IntNull(txtNumberOfCircles.Text))
    ReDim lngCirclesY(IntNull(txtNumberOfCircles.Text))
    ReDim lngCirclesR(IntNull(txtNumberOfCircles.Text))
    
    Randomize Timer * 24
    
    For intX = 1 To IntNull(txtNumberOfCircles.Text)

        Do
            ' radius is minimum 100, maximum 1000
            lngRadius = LngNull(Int(Rnd * 900) + 100)

            lngMiddleX = LngNull((Rnd * Int(PictBox.ScaleWidth - (lngRadius * 2))) + lngRadius)
            lngMiddleY = LngNull((Rnd * Int(PictBox.ScaleHeight - (lngRadius * 2))) + lngRadius)

            ' check if this circle intersects with an existing one
            blnCircleOK = True
            If CirclesDoNotIntersect(lngMiddleX, lngMiddleY, lngRadius) = False Then
                blnCircleOK = False
            End If
        Loop Until blnCircleOK = True

        lngCirclesX(intX) = lngMiddleX
        lngCirclesY(intX) = lngMiddleY
        lngCirclesR(intX) = lngRadius

    Next intX
    
End Sub

Private Function CirclesDoNotIntersect(ByVal lngCircX1 As Long, ByVal lngCircY1 As Long, ByVal lngCircR1 As Long) As Boolean
    '
    ' Calculate if two circles intersect
    ' Returns true (no intersection) or false (circles intersect)
    '
    ' formula :
    '   distance between two centerpoints must be bigger or equal to the sum of
    '   their radius
    '
    Dim lngDistance             As Long
    
    Dim intY                    As Integer
    
    CirclesDoNotIntersect = True
    
    For intY = 1 To UBound(lngCirclesX())
        If Not (lngCirclesX(intY) = 0 And lngCirclesY(intY) = 0 And lngCirclesR(intY) = 0) Then
    
            ' distance
            lngDistance = Sqr(((lngCircX1 - lngCirclesX(intY)) ^ 2) + ((lngCircY1 - lngCirclesY(intY)) ^ 2))
    
            ' sum radius
            If lngDistance >= (lngCircR1 + lngCirclesR(intY)) Then
                ' no intersection
            Else
                CirclesDoNotIntersect = False
                Exit For
            End If
        End If
    Next intY
    
End Function

Private Sub DrawCircles()
    
    Dim intX                    As Integer
    
    ' clear the display
    '
    PictBox.Cls
    
    ' draw the circles
    For intX = 1 To IntNull(txtNumberOfCircles.Text)
        PictBox.Circle (lngCirclesX(intX), lngCirclesY(intX)), lngCirclesR(intX)
    Next intX

    DoEvents
    
End Sub

Private Sub RedrawCircles()
    ' redraw the circles
    Call DrawCircles

    ' show the best one so far
    PictBox.Circle (lngBestMiddleX, lngBestMiddleY), lngBestRadius, RGB(255, 0, 0)
    DoEvents

End Sub

Private Sub DecodeGeneFunction(ByVal lngIndex As Long, ByRef lngMiddleX As Long, ByRef lngMiddleY As Long, ByRef lngRadius As Long)
    '
    ' decode the genes of a given chromosome and make the calculation
    ' each gene is between 1 and GenAlg.NumberGeneMax
    ' Three genes per chromosome
    ' first two genes are the center X-Y coordinates of a disc
    ' the third is the radius
    '
    
    lngMiddleX = GenAlg.ShowGenelong(lngIndex, 0)

    lngMiddleY = GenAlg.ShowGenelong(lngIndex, 1)

    lngRadius = GenAlg.ShowGenelong(lngIndex, 2)

End Sub

