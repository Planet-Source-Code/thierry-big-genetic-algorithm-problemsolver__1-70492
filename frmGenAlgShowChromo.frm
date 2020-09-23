VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmGenAlgShowChromo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Genetic Algorithm Chromosomes"
   ClientHeight    =   6795
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   12495
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6795
   ScaleWidth      =   12495
   StartUpPosition =   2  'CenterScreen
   Begin MSComDlg.CommonDialog CommonDialog 
      Left            =   120
      Top             =   6840
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   6015
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   12255
      _ExtentX        =   21616
      _ExtentY        =   10610
      _Version        =   393216
      TabHeight       =   520
      TabCaption(0)   =   "Chromosomes"
      TabPicture(0)   =   "frmGenAlgShowChromo.frx":0000
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Frame1"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).ControlCount=   1
      TabCaption(1)   =   "Statistics"
      TabPicture(1)   =   "frmGenAlgShowChromo.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Frame2"
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "Settings"
      TabPicture(2)   =   "frmGenAlgShowChromo.frx":0038
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Frame3"
      Tab(2).ControlCount=   1
      Begin VB.Frame Frame3 
         Height          =   5535
         Left            =   -74880
         TabIndex        =   27
         Top             =   360
         Width           =   12015
         Begin VB.PictureBox PictBox2 
            AutoRedraw      =   -1  'True
            Height          =   5175
            Left            =   6000
            ScaleHeight     =   5115
            ScaleWidth      =   5835
            TabIndex        =   29
            Top             =   240
            Width           =   5895
         End
         Begin VB.PictureBox Pictbox 
            AutoRedraw      =   -1  'True
            Height          =   5175
            Left            =   120
            ScaleHeight     =   5115
            ScaleWidth      =   5715
            TabIndex        =   28
            Top             =   240
            Width           =   5775
         End
      End
      Begin VB.Frame Frame2 
         Height          =   5535
         Left            =   -74880
         TabIndex        =   7
         Top             =   360
         Width           =   12015
         Begin VB.ListBox lstStats 
            BeginProperty Font 
               Name            =   "Courier"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   3180
            Left            =   120
            TabIndex        =   12
            Top             =   2160
            Width           =   11775
         End
         Begin VB.Label lblWarningStats 
            Alignment       =   2  'Center
            Caption         =   "No statistics availiable. Statistics recording is disabled."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   735
            Left            =   480
            TabIndex        =   36
            Top             =   3240
            Width           =   10935
         End
         Begin VB.Label Label4 
            Caption         =   "Disaster"
            Height          =   255
            Index           =   5
            Left            =   10320
            TabIndex        =   35
            Top             =   1800
            Width           =   855
         End
         Begin VB.Label Label4 
            Caption         =   "Soc.Div."
            Height          =   255
            Index           =   4
            Left            =   9480
            TabIndex        =   34
            Top             =   1800
            Width           =   855
         End
         Begin VB.Label Label4 
            Caption         =   "Std.Dev."
            Height          =   255
            Index           =   3
            Left            =   6720
            TabIndex        =   33
            Top             =   1800
            Width           =   855
         End
         Begin VB.Label Label4 
            Caption         =   "Worst"
            Height          =   255
            Index           =   2
            Left            =   3960
            TabIndex        =   32
            Top             =   1800
            Width           =   855
         End
         Begin VB.Label Label4 
            Caption         =   "Best"
            Height          =   255
            Index           =   1
            Left            =   1200
            TabIndex        =   31
            Top             =   1800
            Width           =   855
         End
         Begin VB.Label Label4 
            Caption         =   "Generation"
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   30
            Top             =   1800
            Width           =   855
         End
         Begin VB.Label lblCountDisasters 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Height          =   255
            Left            =   8280
            TabIndex        =   24
            Top             =   1320
            Width           =   2775
         End
         Begin VB.Label lblCountRandomOffsprings 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Height          =   255
            Left            =   8280
            TabIndex        =   23
            Top             =   960
            Width           =   2775
         End
         Begin VB.Label lblCountMutations 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Height          =   255
            Left            =   8280
            TabIndex        =   22
            Top             =   600
            Width           =   2775
         End
         Begin VB.Label lblCountCrossovers 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Height          =   255
            Left            =   8280
            TabIndex        =   21
            Top             =   240
            Width           =   2775
         End
         Begin VB.Label Label2 
            Caption         =   "Disasters"
            Height          =   255
            Index           =   9
            Left            =   6720
            TabIndex        =   20
            Top             =   1320
            Width           =   1455
         End
         Begin VB.Label Label2 
            Caption         =   "Random offsprings"
            Height          =   255
            Index           =   8
            Left            =   6720
            TabIndex        =   19
            Top             =   960
            Width           =   1455
         End
         Begin VB.Label Label2 
            Caption         =   "Mutations"
            Height          =   255
            Index           =   7
            Left            =   6720
            TabIndex        =   18
            Top             =   600
            Width           =   1455
         End
         Begin VB.Label Label2 
            Caption         =   "Crossovers"
            Height          =   255
            Index           =   6
            Left            =   6720
            TabIndex        =   17
            Top             =   240
            Width           =   1455
         End
         Begin VB.Label lblActualMutationRate 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Height          =   255
            Left            =   2640
            TabIndex        =   16
            Top             =   1320
            Width           =   2775
         End
         Begin VB.Label Label2 
            Caption         =   "Mutationrate"
            Height          =   255
            Index           =   5
            Left            =   1080
            TabIndex        =   15
            Top             =   1320
            Width           =   1455
         End
         Begin VB.Label lblGenerations 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Height          =   255
            Left            =   2640
            TabIndex        =   14
            Top             =   240
            Width           =   2775
         End
         Begin VB.Label Label2 
            Caption         =   "Generations"
            Height          =   255
            Index           =   4
            Left            =   1080
            TabIndex        =   13
            Top             =   240
            Width           =   1455
         End
         Begin VB.Label lblHighestFitness 
            BorderStyle     =   1  'Fixed Single
            Height          =   255
            Left            =   2640
            TabIndex        =   11
            Top             =   960
            Width           =   2775
         End
         Begin VB.Label lblLowestFitness 
            BorderStyle     =   1  'Fixed Single
            Height          =   255
            Left            =   2640
            TabIndex        =   10
            Top             =   600
            Width           =   2775
         End
         Begin VB.Label Label2 
            Caption         =   "Highest fitness"
            Height          =   255
            Index           =   1
            Left            =   1080
            TabIndex        =   9
            Top             =   960
            Width           =   1455
         End
         Begin VB.Label Label2 
            Caption         =   "Lowest fitness"
            Height          =   255
            Index           =   0
            Left            =   1080
            TabIndex        =   8
            Top             =   600
            Width           =   1455
         End
      End
      Begin VB.Frame Frame1 
         Height          =   5535
         Left            =   120
         TabIndex        =   1
         Top             =   360
         Width           =   12015
         Begin VB.ListBox lstGenes 
            BeginProperty Font 
               Name            =   "Courier"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   4935
            Left            =   120
            TabIndex        =   6
            Top             =   360
            Width           =   11775
         End
         Begin VB.Label Label1 
            Caption         =   "Index"
            Height          =   255
            Index           =   0
            Left            =   240
            TabIndex        =   5
            Top             =   120
            Width           =   495
         End
         Begin VB.Label Label1 
            Caption         =   "Fitness"
            Height          =   255
            Index           =   1
            Left            =   1080
            TabIndex        =   4
            Top             =   120
            Width           =   495
         End
         Begin VB.Label Label1 
            Caption         =   "Genes"
            Height          =   255
            Index           =   2
            Left            =   3720
            TabIndex        =   3
            Top             =   120
            Width           =   495
         End
      End
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Close"
      Height          =   375
      Left            =   11640
      TabIndex        =   2
      Top             =   6240
      Width           =   735
   End
   Begin VB.Label lblDescription 
      Caption         =   "Label4"
      Height          =   255
      Left            =   1920
      TabIndex        =   26
      Top             =   6360
      Width           =   9495
   End
   Begin VB.Label Label3 
      Caption         =   "Settings description :"
      Height          =   255
      Left            =   120
      TabIndex        =   25
      Top             =   6360
      Width           =   1815
   End
End
Attribute VB_Name = "frmGenAlgShowChromo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdexit_Click()

    
    Unload Me
    
End Sub

Public Sub RefreshList(ByVal GenAlg As clsGeneticAlgorithm)
    '
    ' Fill the list
    '
    Dim strLine                 As String
    Dim strHulp                 As String
    
    Dim lngIndex                As Long
    
    lstGenes.Clear
    
    For lngIndex = 0 To (GenAlg.PopulationCount - 1)
        ' index
        strLine = Space$(5)
        RSet strLine = lngIndex
        
        ' Fitness
        strHulp = Space$(20)
        RSet strHulp = GenAlg.ShowFitness(lngIndex)
        strLine = strLine & "  " & strHulp
    
        strHulp = GenAlg.ShowChromosomestring(lngIndex, "TRUE")
        strLine = strLine & "   " & strHulp
    
        lstGenes.AddItem strLine
        
    Next lngIndex
    
    lblDescription.Caption = GenAlg.Description
    
    lblGenerations.Caption = GenAlg.Generation
    
    lblLowestFitness.Caption = GenAlg.FitnessLowest
    lblHighestFitness.Caption = GenAlg.FitnessHighest
    
    lblActualMutationRate.Caption = GenAlg.ActualMutationRate
    
    lblCountCrossovers.Caption = GenAlg.CounterCrossovers
    lblCountMutations.Caption = GenAlg.CounterMutations
    lblCountRandomOffsprings.Caption = GenAlg.CounterRandomOffsprings
    lblCountDisasters.Caption = GenAlg.CounterDisasters
    
    lstStats.Clear
    
    If GenAlg.KeepStatistics = True Then
        lblWarningStats.Visible = False
        lstStats.Visible = True
        For lngIndex = 0 To (GenAlg.Generation - 1) ' not the last generation.. possible error
            ' generation
            strLine = Space$(6)
            RSet strLine = lngIndex
        
            ' lowest fitness
            strHulp = Space$(20)
            LSet strHulp = GenAlg.StatisticsLowestFitness(lngIndex)
            strLine = strLine & " | " & strHulp
        
            ' highest fitness
            strHulp = Space$(20)
            LSet strHulp = GenAlg.StatisticsHighestFitness(lngIndex)
            strLine = strLine & " | " & strHulp
        
            ' Fitness standard deviation
            strHulp = Space$(20)
            LSet strHulp = GenAlg.StatisticsStandardDeviation(lngIndex)
            strLine = strLine & " | " & strHulp
    
            ' Social divercity
            strHulp = Space$(4)
            RSet strHulp = GenAlg.StatisticsSocialDivercity(lngIndex)
            strLine = strLine & " | " & strHulp
    
            ' social disaster generation counter + occured
            strHulp = Space$(6)
            RSet strHulp = GenAlg.StatisticsDisasterGenerationCounter(lngIndex)
            strLine = strLine & " | " & strHulp
            If GenAlg.StatisticsDisasterOccured(lngIndex) = True Then
                strHulp = "TRUE "
            Else
                strHulp = "FALSE"
            End If
            strLine = strLine & " " & strHulp
        
    
            lstStats.AddItem strLine
        Next lngIndex
    Else
        lblWarningStats.Visible = True
        lstStats.Visible = False
    End If
    
    
    '
    ' Print an overview of the settings in the picturebox
    '
    
    ' empty it
    PictBox.Cls
    
    ' population size
    PictBox.Print "General"
    PictBox.Print "Population size : " & GenAlg.PopulationSize
    PictBox.Print ""
    
    ' encoding
    PictBox.Print "Encoding"
    Select Case GenAlg.ChromosomeType
        Case GAEncodingBinary
            PictBox.Print "Encodingtype : Binary"
            PictBox.Print Space$(5) & "Binary gene length : " & GenAlg.BinaryGeneLength

        Case GAEncodingAlphabetic
            PictBox.Print "Encodingtype : Alphabetic"
            PictBox.Print Space$(5) & "Alphabetic gene length : " & GenAlg.AplhabeticGeneLength

        Case GAEncodingLongNbr
                PictBox.Print "Encodingtype : Long integer"
                PictBox.Print Space$(5) & "Long gene minimum value : " & GenAlg.LongGeneMinValue
                PictBox.Print Space$(5) & "Long gene maximum value : " & GenAlg.LongGeneMaxValue

        Case Else
                PictBox.Print "Encodingtype : Double (real values)"
                PictBox.Print Space$(5) & "Double gene minimum value : " & GenAlg.DoubleGeneMinValue
                PictBox.Print Space$(5) & "Double gene maximum value : " & GenAlg.DoubleGeneMaxValue
    End Select

    ' number of genes per chromosome
    PictBox.Print "Number of genes per chromosome : " & GenAlg.GenesPerChromosome
    PictBox.Print ""

    ' selection method
    PictBox.Print "Selection"
    Select Case GenAlg.SelectionMethod
        Case GASelectRank
            PictBox.Print "Selection method : Rank"
        
        Case GASelectRouletteWheel
            PictBox.Print "Selection method : Roulette wheel"

        Case GASelectTournament
            PictBox.Print "Selection method : Tournament"
            PictBox.Print Space$(5) & "Tournament size : " & GenAlg.TournamentSize

    End Select
    PictBox.Print ""

    ' random offspring generations
    If GenAlg.RandomOffspringGeneration = True Then
        PictBox.Print "Random offspring generation : Yes"
    Else
        PictBox.Print "Random offspring generation : No"
    End If
    PictBox.Print ""

    ' crossoverrate
    PictBox.Print "Crossover"
    PictBox.Print "Crossover rate : " & GenAlg.CrossoverRate

    ' crossovermethod
    Select Case GenAlg.CrossoverMethod
        Case GACrossoverOnePoint
            PictBox.Print "Crossover method : one point"

        Case GACrossoverTwoPoint
            PictBox.Print "Crossover method : two point"

        Case GACrossoverUniform
            PictBox.Print "Crossover method : uniform"

        Case GACrossoverHalfUniform
            PictBox.Print "Crossover method : half-uniform"

        Case GACrossoverEdgeRecombination
            PictBox.Print "Crossover method : Edge recombination"
    End Select

    ' crossover full gene
    If GenAlg.CrossoverFullGene = True Then
        PictBox.Print "Crossover full gene : Yes"
    Else
        PictBox.Print "Crossover full gene : No"
    End If
    PictBox.Print ""

    
    PictBox2.Print "Mutation"
    ' Mutationrate
    PictBox2.Print "Mutation rate : " & GenAlg.MutationRate
    PictBox2.Print "Actual Mutation rate : " & GenAlg.ActualMutationRate

    ' Mutation type
    Select Case GenAlg.MutationMethod
        Case GAMutationRateFixed
            PictBox2.Print "Mutation type : Fixed"

        Case GAMutationRateAdaptive
            PictBox2.Print "Mutation type : Adaptive"
            PictBox2.Print Space$(5) & "Adapt after (generations) : " & GenAlg.AMRGenerations
    End Select

    ' Mutation bitlike for long and double
    If GenAlg.MutationBitlikeLongDouble = False Then
        PictBox2.Print "Mutate bit-like for long/double : No"
        PictBox2.Print "Bit-like % of maximum : " & GenAlg.MutationBitlikePercentage
    Else
        PictBox2.Print "Mutate bit-like for long/double : Yes"
    End If

    ' mutate full gene
    If GenAlg.MutateFullGene = True Then
        PictBox2.Print "Mutate full gene : Yes"
    Else
        PictBox2.Print "Mutate full gene : No"
    End If
    PictBox2.Print ""

    PictBox2.Print "Social disasters"
    ' social disaster % diversity
    If GenAlg.SocialDisasterDiversity = 0 Then
        PictBox2.Print "Social disaster turned off"
    Else
        PictBox2.Print "Social disaster lowest diversity : " & GenAlg.SocialDisasterDiversity

        ' check every
        PictBox2.Print "Check diversity every : " & GenAlg.SocialDisasterGenerations

        ' social disaster method
        If GenAlg.SocialDisasterMethod = GASocialDisasterPacking Then
            PictBox2.Print "Social disaster method : Packing"
        Else
            PictBox2.Print "Social disaster method : Judgement Day"
        End If
    End If
    PictBox2.Print ""

    ' reproduction method
    PictBox2.Print "Reproduction"
    Select Case GenAlg.ReproductionMethod
        Case GAReproductionReplaceWeakest
            PictBox2.Print "Reproduction method : Replace weakest"

        Case GAReproductionReplaceParents
            PictBox2.Print "Reproduction method : Replace parents"

        Case GAReproductionReplaceRandom
            PictBox2.Print "Reproduction method : Replace random"
    End Select
    PictBox2.Print ""
    
    ' statistics
    If GenAlg.KeepStatistics = True Then
        PictBox2.Print "Keep full statistics"
    Else
        PictBox2.Print "Do not keep full statistics"
    End If
    
    
End Sub

