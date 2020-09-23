VERSION 5.00
Begin VB.Form frmGenAlgTSP 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "The Traveling Salesman"
   ClientHeight    =   8550
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9615
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8550
   ScaleWidth      =   9615
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdTextfile 
      Caption         =   "Show explanation text"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   6960
      Width           =   2415
   End
   Begin VB.PictureBox PictBox 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      ForeColor       =   &H80000008&
      Height          =   6255
      Left            =   120
      ScaleHeight     =   6225
      ScaleWidth      =   9345
      TabIndex        =   13
      Top             =   600
      Width           =   9375
   End
   Begin VB.TextBox txtNumberOfCities 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   5880
      TabIndex        =   1
      Text            =   "30"
      Top             =   6960
      Width           =   495
   End
   Begin VB.CommandButton cmdDrawCities 
      Caption         =   "Clear and draw random cities"
      Height          =   375
      Left            =   6600
      TabIndex        =   2
      Top             =   6960
      Width           =   2895
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      Height          =   375
      Left            =   8760
      TabIndex        =   9
      Top             =   8040
      Width           =   735
   End
   Begin VB.CommandButton cmdStartTSP 
      Caption         =   "Start"
      Enabled         =   0   'False
      Height          =   375
      Left            =   3600
      TabIndex        =   4
      Top             =   7560
      Width           =   1935
   End
   Begin VB.CommandButton cmdGAControlPanel 
      Caption         =   "GA control panel..."
      Height          =   375
      Left            =   3600
      TabIndex        =   5
      Top             =   8040
      Width           =   1935
   End
   Begin VB.TextBox txtGenerations 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   2520
      TabIndex        =   3
      Text            =   "50000"
      Top             =   7560
      Width           =   735
   End
   Begin VB.CommandButton cmdStop 
      Caption         =   "Stop"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5760
      TabIndex        =   7
      Top             =   8040
      Width           =   1935
   End
   Begin VB.CommandButton cmdShowChromo 
      Caption         =   "Pause and show stats"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5760
      TabIndex        =   6
      Top             =   7560
      Width           =   1935
   End
   Begin VB.Label Label3 
      Caption         =   $"frmGenAlgTSP.frx":0000
      Height          =   495
      Left            =   840
      TabIndex        =   15
      Top             =   120
      Width           =   8415
   End
   Begin VB.Label Label2 
      Caption         =   "Problem :"
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   120
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Howmany cities"
      Height          =   255
      Index           =   0
      Left            =   3720
      TabIndex        =   12
      Top             =   6960
      Width           =   2055
   End
   Begin VB.Label lblGenerations 
      Height          =   255
      Left            =   1800
      TabIndex        =   11
      Top             =   8160
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "Generations :"
      Height          =   255
      Index           =   1
      Left            =   240
      TabIndex        =   10
      Top             =   8160
      Width           =   1095
   End
   Begin VB.Line Line1 
      X1              =   9480
      X2              =   120
      Y1              =   7440
      Y2              =   7440
   End
   Begin VB.Label Label4 
      Caption         =   "Howmany generations"
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   7560
      Width           =   2055
   End
End
Attribute VB_Name = "frmGenAlgTSP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim WithEvents GenAlg           As clsGeneticAlgorithm
Attribute GenAlg.VB_VarHelpID = -1

Dim lngCityX()                  As Long ' Holds the position in the picturebox
Dim lngCityY()                  As Long ' for every city

Dim lngShortestRoute()          As Long ' holds the best chromosome found so far

Dim dblShortestRoute            As Double ' the shortest route so far

Dim lngValidChromosome()        As Long

Dim blnDoLoop                   As Boolean

Private Sub cmdDrawCities_Click()
    '
    ' Generate random cities
    '
    ' Save the cities-info in an array
    
    Call GenerateCities
    
    Call DrawCities

    cmdStartTSP.Enabled = True
    
End Sub

Private Sub GenerateCities()
    '
    ' Generate random cities
    '
    Dim intX                    As Integer
    Dim intY                    As Integer
    
    Dim lngCX                   As Long
    Dim lngCY                   As Long
    
    Dim blnCityOK               As Boolean
    
    ReDim lngCityX(IntNull(txtNumberOfCities.Text))
    ReDim lngCityY(IntNull(txtNumberOfCities.Text))
    
    Randomize Timer * 24
    
    For intX = 0 To (IntNull(txtNumberOfCities.Text) - 1)

        Do
            lngCX = LngNull(Rnd * Int(Pictbox.ScaleWidth))
            lngCY = LngNull(Rnd * Int(Pictbox.ScaleHeight))
            blnCityOK = True
        
            ' check that this city is not too close to another
            ' Not really necessary, but it is to make the visual
            ' representation more 'open' and not too cluttered
            For intY = 0 To (IntNull(txtNumberOfCities.Text) - 1)
                If lngCityX(intY) = 0 And lngCityY(intY) = 0 Then
                    Exit For
                End If
                If DistanceBetweenCities(lngCityX(intY), lngCityY(intY), lngCX, lngCY) < 300 Then
                    blnCityOK = False
                    Exit For
                End If
            Next intY
        Loop Until blnCityOK = True

        lngCityX(intX) = lngCX
        lngCityY(intX) = lngCY

    Next intX
    
End Sub

Private Sub DrawCities()
    
    Dim intX                    As Integer
    
    ' clear the display
    '
    Pictbox.Cls
    
    ' draw the cities
    For intX = 0 To (IntNull(txtNumberOfCities.Text) - 1)
        Pictbox.Circle (lngCityX(intX), lngCityY(intX)), 40, RGB(0, 0, 255)
    Next intX

    DoEvents
    
End Sub

Private Function DistanceBetweenCities(ByVal lngCity1X As Long, ByVal lngCity1Y As Long, ByVal lngCity2X As Long, ByVal lngCity2Y As Long) As Double
    '
    ' Calculate the distance between two cities
    '
    DistanceBetweenCities = DblNull(Sqr(((lngCity1X - lngCity2X) ^ 2) + ((lngCity1Y - lngCity2Y) ^ 2)))

End Function

Private Sub cmdexit_Click()

    GenAlg.Clear
    
    Set GenAlg = Nothing
    
    Unload Me

End Sub

Private Sub cmdGAControlPanel_Click()

    Load frmGenAlgControlPanel
    frmGenAlgControlPanel.ReadSettings = GenAlg
    
    frmGenAlgControlPanel.Show vbModal
    
    If cmdStartTSP.Enabled = True Then
        ' redraw the circles
        Call DrawCities
    End If

End Sub

Private Sub cmdShowChromo_Click()
    '
    ' Pause and show the GA-statistics
    '
    Load frmGenAlgShowChromo
    Call frmGenAlgShowChromo.RefreshList(GenAlg)
            
    frmGenAlgShowChromo.Show vbModal

    ' redraw the cities and connection
    Call DrawCities
    Call DrawConnections
    
End Sub

Private Sub cmdStartTSP_Click()

    Dim intX                    As Integer
    
    Dim lngGeneration           As Long
    
    cmdexit.Enabled = False
    cmdStartTSP.Enabled = False
    txtNumberOfCities.Enabled = False
    cmdDrawCities.Enabled = False
    txtGenerations.Enabled = False
    cmdGAControlPanel.Enabled = False
    cmdShowChromo.Enabled = True
    cmdStop.Enabled = True
    
    lblGenerations.Caption = ""
    

    cmdDrawCities.Enabled = False
    

    ' make the shortest route a very long one to start
    dblShortestRoute = Pictbox.ScaleHeight * DblNull(txtNumberOfCities.Text)
    
    '
    ' STEP 1 : INITIALIZATION
    '

    '
    ' Set the chromosome and gene properties for the given problem
    ' Loaded from GA-file
    
    ' just the maximumvalue and howmany genes has te be set here, since
    ' they can be modified by the user
    GenAlg.LongGeneMaxValue = LngNull(txtNumberOfCities.Text)
    GenAlg.GenesPerChromosome = LngNull(txtNumberOfCities.Text)
    
    '
    ' use only valid chromosomes
    '
    ' Fill in the startposition of our 'tojumble' valid chromosome-array
    ReDim lngValidChromosome(LngNull(txtNumberOfCities.Text) - 1)
    lngValidChromosome(0) = 0
    For intX = 1 To (LngNull(txtNumberOfCities.Text) - 1)
        lngValidChromosome(intX) = LngNull(intX)
    Next intX
    
    
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
    
    
    ' draw the connections
    Call DrawCities
    Call DrawConnections
    
    DoEvents

    cmdexit.Enabled = True
    cmdStartTSP.Enabled = True
    txtNumberOfCities.Enabled = True
    cmdDrawCities.Enabled = True
    txtGenerations.Enabled = True
    cmdGAControlPanel.Enabled = True
    cmdShowChromo.Enabled = False
    cmdStop.Enabled = False

End Sub

Private Sub cmdStop_Click()

    blnDoLoop = False

End Sub

Private Sub cmdTextfile_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\TSP.txt", vbNormalFocus)

End Sub

Private Sub Form_Load()

    Set GenAlg = New clsGeneticAlgorithm

    blnDoLoop = False

    GenAlg.ReadGASettings App.Path & "\GA\TSP.GA"

End Sub

Private Sub GenAlg_EvaluateFitness(ByVal lngIndex As Long, dblFitness As Double)
    '
    ' The fitness calculation
    '
    ' decode the genes
    ' Calculate the length of the route and assign fitness
    ' In this case, the sum of the distance can be taken as fitnessscore
    '

    Dim intGenenumber           As Integer
    
    Dim lngCityNumber           As Long
    Dim lngNextCityNumber       As Long
    
    Dim dblDistance             As Double
    

    dblDistance = 0

    ' Calculate the distance
    For intGenenumber = 0 To (GenAlg.GenesPerChromosome - 1)
        lngCityNumber = GenAlg.ShowGenelong(lngIndex, intGenenumber)
        If intGenenumber = (GenAlg.GenesPerChromosome - 1) Then
            lngNextCityNumber = GenAlg.ShowGenelong(lngIndex, 0)
        Else
            lngNextCityNumber = GenAlg.ShowGenelong(lngIndex, intGenenumber + 1)
        End If

        dblDistance = dblDistance + DistanceBetweenCities(lngCityX(lngCityNumber), lngCityY(lngCityNumber), lngCityX(lngNextCityNumber), lngCityY(lngNextCityNumber))

    Next intGenenumber

    ' is this one better than the best one we have so far ?
    If dblDistance < dblShortestRoute Then
        dblShortestRoute = dblDistance

        ReDim lngShortestRoute(IntNull(txtNumberOfCities.Text) - 1)
        For intGenenumber = 0 To (GenAlg.GenesPerChromosome - 1)
            lngShortestRoute(intGenenumber) = GenAlg.ShowGenelong(lngIndex, intGenenumber)
        Next intGenenumber

        Pictbox.Refresh

        ' draw the connections
        Call DrawCities
        Call DrawConnections

        DoEvents
    End If

    ' As fitness, take the distance since the shorter the better...
    dblFitness = dblDistance

End Sub

Private Sub GenAlg_GAError(ByVal ErrorCode As Long, ByVal ErrorDescription As String)

    MsgBox "ERROR !!" & vbNewLine & "Error " & ErrorCode & " " & ErrorDescription
    blnDoLoop = False
    
End Sub

Private Sub GenAlg_NewChromosome(NewStringGenes() As String, NewLongGenes() As Long, NewDoubleGenes() As Double, ByVal intOrigin As GANewChromosomeOriginType)
    '
    ' Returns a random but valid chromosome, overriding the random chromosome
    ' created by the GAclass
    '
    Dim intX                    As Integer
    Dim intSwap1                As Integer
    Dim intSwap2                As Integer

    Dim lngHelp                 As Long

    ' jumble the array with valid citynumbers
    For intX = 0 To (GenAlg.GenesPerChromosome - 1)
        intSwap1 = Int(Rnd * LngNull(GenAlg.GenesPerChromosome))
        lngHelp = lngValidChromosome(intSwap1)
        intSwap2 = Int(Rnd * LngNull(GenAlg.GenesPerChromosome))
        lngValidChromosome(intSwap1) = lngValidChromosome(intSwap2)
        lngValidChromosome(intSwap2) = lngHelp
    Next intX

    ' copy the jumbled array to the correct gene-type array
    For intX = 0 To (GenAlg.GenesPerChromosome - 1)
        NewLongGenes(intX) = lngValidChromosome(intX)
    Next intX

    ' done
End Sub

Private Sub txtGenerations_GotFocus()
    Call SetTextboxAsSelected(txtGenerations)
End Sub

Private Sub txtGenerations_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub txtNumberOfCities_GotFocus()
    Call SetTextboxAsSelected(txtNumberOfCities)
End Sub

Private Sub txtNumberOfCities_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub DrawConnections()
    '
    '
    Dim intX                    As Integer
    Dim intCityNumber           As Integer
    Dim intNextCityNumber       As Integer
    
    On Local Error GoTo errorhandler
    
    ' draw the connections
    For intX = 0 To (IntNull(txtNumberOfCities.Text) - 1)
        For intCityNumber = 0 To (IntNull(txtNumberOfCities.Text) - 1)
            intNextCityNumber = intCityNumber + 1
            If intNextCityNumber >= IntNull(txtNumberOfCities.Text) Then
                intNextCityNumber = 0
            End If
            
            Pictbox.DrawWidth = 2
            Pictbox.Line (lngCityX(lngShortestRoute(intCityNumber)), lngCityY(lngShortestRoute(intCityNumber)))-(lngCityX(lngShortestRoute(intNextCityNumber)), lngCityY(lngShortestRoute(intNextCityNumber))), RGB(0, 255, 0)
        Next intCityNumber
    Next intX

    DoEvents
    
errorhandler:
    ' this is a very bad way to skip the 'out of range error' you get the very first time
    ' you come here
End Sub


