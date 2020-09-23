VERSION 5.00
Begin VB.Form frmGenAlgExplanation 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Introduction : Explaining Genetic Algorithms"
   ClientHeight    =   8535
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6900
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8535
   ScaleWidth      =   6900
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdTextfile 
      Caption         =   "Show explanation text"
      Height          =   375
      Left            =   3360
      TabIndex        =   0
      Top             =   480
      Width           =   2415
   End
   Begin VB.CommandButton cmdReproduction 
      Caption         =   "STEP 4 : REPRODUCTION"
      Enabled         =   0   'False
      Height          =   375
      Left            =   240
      TabIndex        =   5
      Top             =   4440
      Width           =   5535
   End
   Begin VB.CommandButton cmdexit 
      Caption         =   "Exit"
      Height          =   375
      Left            =   5520
      TabIndex        =   7
      Top             =   7320
      Width           =   1215
   End
   Begin VB.CommandButton cmdInitialization 
      Caption         =   "STEP 1 : INITIALIZATION"
      Height          =   375
      Left            =   240
      TabIndex        =   1
      Top             =   1800
      Width           =   5535
   End
   Begin VB.Frame Frame1 
      Caption         =   "Population"
      Height          =   2775
      Left            =   120
      TabIndex        =   3
      Top             =   4920
      Width           =   5175
      Begin VB.ListBox lstPopulation 
         BeginProperty Font 
            Name            =   "Courier"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2010
         Left            =   120
         TabIndex        =   6
         Top             =   600
         Width           =   4695
      End
      Begin VB.Label Label4 
         Caption         =   "Chromosome"
         Height          =   255
         Left            =   240
         TabIndex        =   9
         Top             =   240
         Width           =   1815
      End
      Begin VB.Label Label5 
         Caption         =   "Fitness"
         Height          =   255
         Left            =   3480
         TabIndex        =   8
         Top             =   240
         Width           =   1095
      End
   End
   Begin VB.CommandButton cmdEvaluation 
      Caption         =   "STEP 2 : EVALUATION"
      Enabled         =   0   'False
      Height          =   375
      Left            =   240
      TabIndex        =   2
      Top             =   2400
      Width           =   5535
   End
   Begin VB.CommandButton cmdSelection 
      Caption         =   "STEP 3 : SELECTION"
      Enabled         =   0   'False
      Height          =   375
      Left            =   240
      TabIndex        =   4
      Top             =   3000
      Width           =   5535
   End
   Begin VB.Label lblSelectedParent2 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Height          =   255
      Left            =   2160
      TabIndex        =   18
      Top             =   3960
      Width           =   3255
   End
   Begin VB.Label lblSelectedParent1 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Height          =   255
      Left            =   2160
      TabIndex        =   17
      Top             =   3600
      Width           =   3255
   End
   Begin VB.Label Label8 
      Caption         =   "Parent 2"
      Height          =   255
      Index           =   1
      Left            =   720
      TabIndex        =   16
      Top             =   3960
      Width           =   975
   End
   Begin VB.Label Label8 
      Caption         =   "Parent 1"
      Height          =   255
      Index           =   0
      Left            =   720
      TabIndex        =   15
      Top             =   3600
      Width           =   975
   End
   Begin VB.Label Label7 
      Caption         =   $"FrmGenAlgExplanation.frx":0000
      ForeColor       =   &H000000C0&
      Height          =   735
      Left            =   120
      TabIndex        =   14
      Top             =   7800
      Width           =   6615
   End
   Begin VB.Line Line5 
      X1              =   5880
      X2              =   5760
      Y1              =   2760
      Y2              =   2640
   End
   Begin VB.Line Line4 
      X1              =   5760
      X2              =   5880
      Y1              =   2640
      Y2              =   2520
   End
   Begin VB.Line Line3 
      X1              =   5760
      X2              =   6120
      Y1              =   4680
      Y2              =   4680
   End
   Begin VB.Line Line2 
      X1              =   5760
      X2              =   6120
      Y1              =   2640
      Y2              =   2640
   End
   Begin VB.Line Line1 
      X1              =   6120
      X2              =   6120
      Y1              =   2640
      Y2              =   4680
   End
   Begin VB.Label Label1 
      Caption         =   "X + Y = 15"
      Height          =   255
      Left            =   1320
      TabIndex        =   13
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Problem :"
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   120
      Width           =   855
   End
   Begin VB.Label Label3 
      Caption         =   "What are possible values for X and Y ?"
      Height          =   255
      Left            =   2760
      TabIndex        =   11
      Top             =   120
      Width           =   3015
   End
   Begin VB.Label Label6 
      Caption         =   "Read the introduction to Genatic Algorithms and follow the explanation to get a grasp of what this is all about."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   120
      TabIndex        =   10
      Top             =   960
      Width           =   6135
   End
End
Attribute VB_Name = "frmGenAlgExplanation"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim WithEvents GenAlg                   As clsGeneticAlgorithm
Attribute GenAlg.VB_VarHelpID = -1

Private Sub cmdEvaluation_Click()
    '
    ' STEP 2 : Evaluation
    '
    cmdEvaluation.Enabled = False
    
    ' call the fitnessloop to trugger the fitness events
    Call GenAlg.EVALUATE

    ' see the GenAlg_EvaluateFitness procedure for the fitness-calculation
    
    
    ' show the chromosomes in the listbox
    Call ShowChromosomes
    
    cmdSelection.Enabled = True

End Sub

Private Sub cmdexit_Click()

    GenAlg.Clear
    
    Set GenAlg = Nothing
    
    Unload Me
    
End Sub

Private Sub cmdInitialization_Click()

    '
    ' STEP 1 : INITIALIZATION
    '
    
    cmdInitialization.Enabled = False
    
    '
    ' Set some properties for the GA class
    '
    ' these are loaded from a GA-file
    GenAlg.ReadGASettings App.Path & "\GA\Explanation.ga"
    
    
    
    ' Start
    ' create the initial population
    Call GenAlg.CREATEPOPULATION(GenAlg.PopulationSize)
    
    ' show the chromosomes in the listbox
    Call ShowChromosomes

    cmdEvaluation.Enabled = True
    
End Sub

Private Sub cmdReproduction_Click()
    '
    ' STEP 4 : REPRODUCTION (+ ELITISM)
    '
    cmdReproduction.Enabled = False
    
    Call GenAlg.REPRODUCTION
    
    ' show the chromosomes in the listbox
    Call ShowChromosomes
    
    ' hide the selected parents
    lblSelectedParent1.Caption = ""
    lblSelectedParent2.Caption = ""
    
    
    cmdEvaluation.Enabled = True
    
End Sub

Private Sub cmdSelection_Click()
    '
    ' STEP 3 SELECTION
    '
    cmdSelection.Enabled = False
    
    
    Call GenAlg.SELECTION
    
    ' show the Selected chromosomes
    lblSelectedParent1.Caption = GenAlg.ShowChromosomestring(GenAlg.SelectedChromosomeIndex1)
    lblSelectedParent2.Caption = GenAlg.ShowChromosomestring(GenAlg.SelectedChromosomeIndex2)
    

    cmdReproduction.Enabled = True
    
End Sub

Private Sub ShowChromosomes()
    '
    ' Show the chromosomes in the listbox
    '
    Dim intX                    As Integer
    Dim intY                    As Integer
    
    Dim lngIndex                As Long
    
    Dim strLine                 As String
    
    
    lstPopulation.Clear
    
    For intX = 0 To (GenAlg.PopulationCount - 1)
        ' get the chromsomes in order of fitness
        ' best ones first
        strLine = ""
        For intY = 0 To (GenAlg.GenesPerChromosome - 1)
        
            strLine = strLine & GenAlg.ShowGenestring(intX, intY)
        Next intY
        
        strLine = strLine & Space$(20) & GenAlg.ShowFitness(intX)
        
        lstPopulation.AddItem strLine
    Next intX
    
End Sub

Private Sub cmdTextfile_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\ExplainingGAIntroduction.txt", vbNormalFocus)

End Sub

Private Sub Form_Load()

    Set GenAlg = New clsGeneticAlgorithm

End Sub

Private Sub GenAlg_EvaluateFitness(ByVal lngIndex As Long, dblFitness As Double)

    '
    ' Called from the GA-class EVALUATE procedure
    '
    Dim strChromo               As String
    Dim strGene                 As String
    Dim strChar                 As String
    
    Dim intValueX               As Integer
    Dim intValueY               As Integer
    Dim intGenenumber           As Integer
    Dim intY                    As Integer
    Dim intDecimal              As Integer
    

    ' get the individual genes
    For intGenenumber = 0 To (GenAlg.GenesPerChromosome - 1)
        strGene = GenAlg.ShowGenestring(lngIndex, intGenenumber)
        '
        ' Take the value out of the genes
        ' Gene 1 is X, gene 2 is Y
        Select Case intGenenumber
            Case 0
                GoSub BinaryToDecimal
                intValueX = intDecimal
            Case Else
                GoSub BinaryToDecimal
                intValueY = intDecimal
        End Select
    Next intGenenumber

    '
    ' Let's calculate the fitness
    '
    dblFitness = Abs(15 - (intValueX + intValueY))

    
    '
    ' A solution-check could be done at this point.
    ' A fitness value of 0 would mean a solution is found !!
    '
    If dblFitness = 0 Then
        ' normally you should end the cycle here, since a solution has been found
    End If


    Exit Sub

BinaryToDecimal:
    ' transform the binary number into a decimal
    intDecimal = 0
    For intY = Len(strGene) To 1 Step -1
        strChar = Mid$(strGene, intY, 1)
        If strChar = "1" Then
            intDecimal = intDecimal + (2 ^ (Len(strGene) - intY))
        End If
    Next intY

Return

End Sub

Private Sub GenAlg_GAError(ByVal ErrorCode As Long, ByVal ErrorDescription As String)

    MsgBox "ERROR !!" & vbNewLine & "Error " & ErrorCode & " " & ErrorDescription

End Sub
