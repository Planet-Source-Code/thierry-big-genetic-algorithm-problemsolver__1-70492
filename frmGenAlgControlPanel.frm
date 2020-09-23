VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmGenAlgControlPanel 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Genetic Algorithm Control Panel"
   ClientHeight    =   8070
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   12405
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8070
   ScaleWidth      =   12405
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame9 
      Caption         =   "Overview current settings"
      Height          =   7335
      Left            =   9000
      TabIndex        =   52
      Top             =   120
      Width           =   3255
      Begin VB.PictureBox Pictbox 
         AutoRedraw      =   -1  'True
         Height          =   6975
         Left            =   120
         ScaleHeight     =   6915
         ScaleWidth      =   2955
         TabIndex        =   53
         Top             =   240
         Width           =   3015
      End
   End
   Begin TabDlg.SSTab SSTab1 
      Height          =   6015
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   8775
      _ExtentX        =   15478
      _ExtentY        =   10610
      _Version        =   393216
      Tabs            =   4
      TabsPerRow      =   4
      TabHeight       =   520
      TabCaption(0)   =   "Encoding"
      TabPicture(0)   =   "frmGenAlgControlPanel.frx":0000
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Frame1"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Frame8"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).ControlCount=   2
      TabCaption(1)   =   "Selection and crossover"
      TabPicture(1)   =   "frmGenAlgControlPanel.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Frame2"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "Frame7"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).ControlCount=   2
      TabCaption(2)   =   "Mutation and disasters"
      TabPicture(2)   =   "frmGenAlgControlPanel.frx":0038
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "Frame5"
      Tab(2).Control(0).Enabled=   0   'False
      Tab(2).Control(1)=   "Frame6"
      Tab(2).Control(1).Enabled=   0   'False
      Tab(2).ControlCount=   2
      TabCaption(3)   =   "Reproduction and stats."
      TabPicture(3)   =   "frmGenAlgControlPanel.frx":0054
      Tab(3).ControlEnabled=   0   'False
      Tab(3).Control(0)=   "Frame3"
      Tab(3).Control(0).Enabled=   0   'False
      Tab(3).Control(1)=   "Frame11"
      Tab(3).Control(1).Enabled=   0   'False
      Tab(3).ControlCount=   2
      Begin VB.Frame Frame6 
         Caption         =   "Social disasters"
         Height          =   2295
         Left            =   -74880
         TabIndex        =   71
         Top             =   3480
         Width           =   8535
         Begin VB.TextBox txtDisasterGenerations 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   6720
            TabIndex        =   75
            Top             =   600
            Width           =   615
         End
         Begin VB.TextBox txtSocialDisasterPercent 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7680
            TabIndex        =   74
            Top             =   240
            Width           =   495
         End
         Begin VB.OptionButton optSocialDisaster 
            Caption         =   "Judgement Day"
            Height          =   255
            Index           =   1
            Left            =   1560
            TabIndex        =   73
            Top             =   1320
            Value           =   -1  'True
            Width           =   1695
         End
         Begin VB.OptionButton optSocialDisaster 
            Caption         =   "Packing"
            Height          =   255
            Index           =   0
            Left            =   1560
            TabIndex        =   72
            Top             =   1800
            Width           =   1695
         End
         Begin VB.Label Label2 
            Caption         =   "Disaster method"
            Height          =   255
            Index           =   3
            Left            =   240
            TabIndex        =   80
            Top             =   1080
            Width           =   2055
         End
         Begin VB.Label Label2 
            Caption         =   "generations"
            Height          =   255
            Index           =   2
            Left            =   7440
            TabIndex        =   79
            Top             =   600
            Width           =   855
         End
         Begin VB.Label Label2 
            Caption         =   "Check genetic diversity each"
            Height          =   255
            Index           =   1
            Left            =   240
            TabIndex        =   78
            Top             =   600
            Width           =   5055
         End
         Begin VB.Label Label3 
            Caption         =   "%"
            Height          =   255
            Left            =   8160
            TabIndex        =   77
            Top             =   240
            Width           =   135
         End
         Begin VB.Label Label2 
            Caption         =   "Social disaster when genetic diversity is lower than"
            Height          =   255
            Index           =   0
            Left            =   240
            TabIndex        =   76
            Top             =   240
            Width           =   5295
         End
      End
      Begin VB.Frame Frame5 
         Caption         =   "Mutation"
         Height          =   2895
         Left            =   -74880
         TabIndex        =   58
         Top             =   480
         Width           =   8535
         Begin VB.TextBox txtAMRgenerations 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7680
            TabIndex        =   65
            Top             =   1200
            Width           =   615
         End
         Begin VB.CheckBox chkMutateFullGene 
            Caption         =   "Mutate full gene (If checked this overrules adding or subtracting a value for long or double encoding)"
            Height          =   255
            Left            =   240
            TabIndex        =   64
            Top             =   2400
            Width           =   7815
         End
         Begin VB.TextBox txtMutationRate 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7680
            TabIndex        =   63
            Top             =   240
            Width           =   615
         End
         Begin VB.OptionButton optMutationRate 
            Caption         =   "Adaptive"
            Height          =   255
            Index           =   1
            Left            =   3960
            TabIndex        =   62
            Top             =   840
            Width           =   1335
         End
         Begin VB.OptionButton optMutationRate 
            Caption         =   "Fixed"
            Height          =   255
            Index           =   0
            Left            =   1560
            TabIndex        =   61
            Top             =   840
            Value           =   -1  'True
            Width           =   1215
         End
         Begin VB.CheckBox chkLongDoubleMutatebit 
            Caption         =   "For long / double encoding : add or subtract a value from gene instead of bit-type mutation"
            Height          =   255
            Left            =   240
            TabIndex        =   60
            Top             =   1680
            Width           =   7815
         End
         Begin VB.TextBox txtLongDoubleBitMutationPercent 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7680
            TabIndex        =   59
            Top             =   2040
            Width           =   495
         End
         Begin VB.Label Label1 
            Caption         =   "Mutation type"
            Height          =   255
            Index           =   4
            Left            =   240
            TabIndex        =   70
            Top             =   600
            Width           =   2775
         End
         Begin VB.Label Label1 
            Caption         =   "Increase mutationrate after equal stdDev. for howmany generations"
            Height          =   255
            Index           =   0
            Left            =   2400
            TabIndex        =   69
            Top             =   1200
            Width           =   4815
         End
         Begin VB.Label Label1 
            Caption         =   "MutationRate (Fixed or startingpoint for Adaptive mutation rate) :"
            Height          =   255
            Index           =   3
            Left            =   240
            TabIndex        =   68
            Top             =   240
            Width           =   4575
         End
         Begin VB.Label Label14 
            Caption         =   "Percentage of maximum for random value to add/subtract"
            Height          =   255
            Left            =   2400
            TabIndex        =   67
            Top             =   2040
            Width           =   4935
         End
         Begin VB.Label Label15 
            Caption         =   "%"
            Height          =   255
            Left            =   8160
            TabIndex        =   66
            Top             =   2040
            Width           =   135
         End
      End
      Begin VB.Frame Frame11 
         Caption         =   "Statistics"
         Height          =   1215
         Left            =   -74880
         TabIndex        =   56
         Top             =   3120
         Width           =   8535
         Begin VB.CheckBox chkStats 
            Caption         =   "Keep full statistics"
            Height          =   255
            Left            =   360
            TabIndex        =   57
            Top             =   480
            Width           =   7935
         End
      End
      Begin VB.Frame Frame8 
         Caption         =   "Encoding"
         Height          =   4335
         Left            =   120
         TabIndex        =   41
         Top             =   1560
         Width           =   8535
         Begin VB.TextBox txtLonggeneminvalue 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7200
            TabIndex        =   8
            Text            =   "0"
            Top             =   1560
            Width           =   1095
         End
         Begin VB.TextBox txtdoublegenMax 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7200
            TabIndex        =   12
            Text            =   "1000"
            Top             =   3000
            Width           =   1095
         End
         Begin VB.TextBox txtdoublegenMin 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7200
            TabIndex        =   11
            Text            =   "0"
            Top             =   2520
            Width           =   1095
         End
         Begin VB.TextBox txtLonggenemaxvalue 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7200
            TabIndex        =   9
            Text            =   "1000"
            Top             =   2040
            Width           =   1095
         End
         Begin VB.TextBox txtAlphagenelength 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7200
            TabIndex        =   6
            Text            =   "3"
            Top             =   1080
            Width           =   1095
         End
         Begin VB.TextBox txtBInaryGenelength 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7200
            TabIndex        =   4
            Text            =   "3"
            Top             =   600
            Width           =   1095
         End
         Begin VB.TextBox txtGenesPerChromosome 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7200
            TabIndex        =   13
            Text            =   "3"
            Top             =   3720
            Width           =   1095
         End
         Begin VB.OptionButton optEncoding 
            Caption         =   "Double (real numbers)"
            Height          =   255
            Index           =   3
            Left            =   1080
            TabIndex        =   10
            Top             =   2520
            Width           =   2295
         End
         Begin VB.OptionButton optEncoding 
            Caption         =   "Long integers"
            Height          =   255
            Index           =   2
            Left            =   1080
            TabIndex        =   7
            Top             =   1560
            Width           =   2295
         End
         Begin VB.OptionButton optEncoding 
            Caption         =   "Alphabetic"
            Height          =   255
            Index           =   1
            Left            =   1080
            TabIndex        =   5
            Top             =   1080
            Width           =   2295
         End
         Begin VB.OptionButton optEncoding 
            Caption         =   "Binary"
            Height          =   255
            Index           =   0
            Left            =   1080
            TabIndex        =   3
            Top             =   600
            Value           =   -1  'True
            Width           =   2295
         End
         Begin VB.Label Label16 
            Caption         =   "Minimum value for long integer gene"
            Height          =   255
            Left            =   4320
            TabIndex        =   81
            Top             =   1560
            Width           =   2775
         End
         Begin VB.Label Label10 
            Caption         =   "Encoding type :"
            Height          =   255
            Left            =   240
            TabIndex        =   48
            Top             =   240
            Width           =   2295
         End
         Begin VB.Label Label9 
            Caption         =   "Maximum value for double gene"
            Height          =   255
            Left            =   4320
            TabIndex        =   47
            Top             =   3000
            Width           =   2775
         End
         Begin VB.Label Label8 
            Caption         =   "Minimum value for double gene"
            Height          =   255
            Left            =   4320
            TabIndex        =   46
            Top             =   2520
            Width           =   2775
         End
         Begin VB.Label Label7 
            Caption         =   "Maximum value for long integer gene"
            Height          =   255
            Left            =   4320
            TabIndex        =   45
            Top             =   2040
            Width           =   2775
         End
         Begin VB.Label Label6 
            Caption         =   "Alphabetic gene length"
            Height          =   255
            Left            =   4320
            TabIndex        =   44
            Top             =   1080
            Width           =   2415
         End
         Begin VB.Label Label5 
            Caption         =   "Binary gene length"
            Height          =   255
            Left            =   4320
            TabIndex        =   43
            Top             =   600
            Width           =   2175
         End
         Begin VB.Line Line1 
            X1              =   240
            X2              =   8280
            Y1              =   3480
            Y2              =   3480
         End
         Begin VB.Label Label4 
            Caption         =   "Number of genes per chromosome"
            Height          =   255
            Left            =   240
            TabIndex        =   42
            Top             =   3720
            Width           =   6375
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Reproduction"
         Height          =   2535
         Left            =   -74880
         TabIndex        =   40
         Top             =   480
         Width           =   8535
         Begin VB.OptionButton optReproductionmethod 
            Caption         =   "Replace weakest"
            Height          =   255
            Index           =   0
            Left            =   1440
            TabIndex        =   26
            Top             =   720
            Value           =   -1  'True
            Width           =   2295
         End
         Begin VB.OptionButton optReproductionmethod 
            Caption         =   "Replace parents"
            Height          =   255
            Index           =   1
            Left            =   1440
            TabIndex        =   27
            Top             =   1320
            Width           =   2295
         End
         Begin VB.OptionButton optReproductionmethod 
            Caption         =   "Replace random"
            Height          =   255
            Index           =   2
            Left            =   1440
            TabIndex        =   28
            Top             =   1920
            Width           =   2295
         End
         Begin VB.Label Label13 
            Caption         =   "Reproduction method"
            Height          =   255
            Left            =   240
            TabIndex        =   51
            Top             =   360
            Width           =   6375
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "Crossover"
         Height          =   3135
         Left            =   -74880
         TabIndex        =   38
         Top             =   2760
         Width           =   8535
         Begin VB.OptionButton optCrossover 
            Caption         =   "Edge recombination"
            Height          =   255
            Index           =   4
            Left            =   1320
            TabIndex        =   24
            Top             =   2160
            Width           =   2175
         End
         Begin VB.CheckBox chkCrossoverFullgene 
            Caption         =   "Crossover full gene"
            Height          =   255
            Left            =   240
            TabIndex        =   25
            Top             =   2640
            Value           =   1  'Checked
            Width           =   7455
         End
         Begin VB.OptionButton optCrossover 
            Caption         =   "One point"
            Height          =   255
            Index           =   0
            Left            =   1320
            TabIndex        =   20
            Top             =   720
            Value           =   -1  'True
            Width           =   2175
         End
         Begin VB.OptionButton optCrossover 
            Caption         =   "two point"
            Height          =   255
            Index           =   1
            Left            =   1320
            TabIndex        =   21
            Top             =   1080
            Width           =   2055
         End
         Begin VB.OptionButton optCrossover 
            Caption         =   "Uniform"
            Height          =   255
            Index           =   2
            Left            =   1320
            TabIndex        =   22
            Top             =   1440
            Width           =   2295
         End
         Begin VB.OptionButton optCrossover 
            Caption         =   "Half uniform"
            Height          =   255
            Index           =   3
            Left            =   1320
            TabIndex        =   23
            Top             =   1800
            Width           =   2175
         End
         Begin VB.TextBox txtCrossoverRate 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7680
            TabIndex        =   19
            Top             =   360
            Width           =   615
         End
         Begin VB.Label Label12 
            Caption         =   "Crossover method"
            Height          =   255
            Left            =   240
            TabIndex        =   50
            Top             =   360
            Width           =   4335
         End
         Begin VB.Label Label1 
            Caption         =   "CrossoverRate :"
            Height          =   255
            Index           =   2
            Left            =   5400
            TabIndex        =   39
            Top             =   360
            Width           =   1815
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Selection method"
         Height          =   2175
         Left            =   -74880
         TabIndex        =   36
         Top             =   480
         Width           =   8535
         Begin VB.CheckBox chkRandomOffspringGeneration 
            Caption         =   "Random Offspring Generation"
            Height          =   255
            Left            =   240
            TabIndex        =   18
            Top             =   1800
            Width           =   8055
         End
         Begin VB.OptionButton optSelectMethod 
            Caption         =   "Rank"
            Height          =   255
            Index           =   0
            Left            =   1320
            TabIndex        =   14
            Top             =   480
            Value           =   -1  'True
            Width           =   1095
         End
         Begin VB.OptionButton optSelectMethod 
            Caption         =   "Roulette wheel"
            Height          =   255
            Index           =   1
            Left            =   1320
            TabIndex        =   15
            Top             =   960
            Width           =   1815
         End
         Begin VB.OptionButton optSelectMethod 
            Caption         =   "Tournament"
            Height          =   255
            Index           =   2
            Left            =   1320
            TabIndex        =   16
            Top             =   1440
            Width           =   1575
         End
         Begin VB.TextBox txtTournamentSize 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   7680
            TabIndex        =   17
            Text            =   "20"
            Top             =   1440
            Width           =   615
         End
         Begin VB.Label Label11 
            Caption         =   "Parent selection type"
            Height          =   255
            Left            =   240
            TabIndex        =   49
            Top             =   240
            Width           =   3135
         End
         Begin VB.Label lblGenAlgParam 
            Caption         =   "Tournament size"
            Height          =   255
            Index           =   4
            Left            =   5400
            TabIndex        =   37
            Top             =   1440
            Width           =   1335
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "General settings"
         Height          =   975
         Left            =   120
         TabIndex        =   32
         Top             =   480
         Width           =   8535
         Begin VB.TextBox txtPopSize 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   1680
            TabIndex        =   2
            Top             =   600
            Width           =   975
         End
         Begin VB.TextBox txtDescript 
            Height          =   285
            Left            =   1680
            MaxLength       =   100
            TabIndex        =   1
            Top             =   240
            Width           =   6615
         End
         Begin VB.Label Label1 
            Caption         =   "Population size :"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   35
            Top             =   600
            Width           =   1335
         End
         Begin VB.Label Label1 
            Caption         =   "Description"
            Height          =   255
            Index           =   5
            Left            =   120
            TabIndex        =   34
            Top             =   240
            Width           =   1215
         End
      End
   End
   Begin MSComDlg.CommonDialog CommonDialog 
      Left            =   120
      Top             =   8640
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save..."
      Height          =   375
      Left            =   1080
      TabIndex        =   30
      Top             =   7560
      Width           =   735
   End
   Begin VB.CommandButton cmdLoad 
      Caption         =   "Load..."
      Height          =   375
      Left            =   120
      TabIndex        =   29
      Top             =   7560
      Width           =   735
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   11520
      TabIndex        =   33
      Top             =   7560
      Width           =   735
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   10560
      TabIndex        =   31
      Top             =   7560
      Width           =   735
   End
   Begin VB.Frame Frame10 
      Caption         =   "Info"
      Height          =   1335
      Left            =   120
      TabIndex        =   54
      Top             =   6120
      Width           =   8775
      Begin VB.Label lblInfo 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00FF0000&
         Height          =   975
         Left            =   120
         TabIndex        =   55
         Top             =   240
         Width           =   8535
      End
   End
End
Attribute VB_Name = "frmGenAlgControlPanel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim GenAlgCP                    As clsGeneticAlgorithm
Attribute GenAlgCP.VB_VarHelpID = -1

Public Property Let ReadSettings(ByVal vNewValue As clsGeneticAlgorithm)
    Set GenAlgCP = vNewValue
    
    Call ShowCurrentSettings
    
End Property

Private Sub chkCrossoverFullgene_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "Crossover full gene. If this is checked the cut will happen at a gene's boundary. No gene's will ever be cut."
End Sub

Private Sub chkLongDoubleMutatebit_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "For long or double encoding, and NOT full gene mutation ! If checked a small value will be added/subtracted (random) from the gene-value. If not checked one position in the gene will be swapped with a random number ( = bitlike mutation)"
End Sub

Private Sub chkMutateFullGene_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "Mutate full gene. If checked the the mutation occurs on a full gene (an entire gene will be generated randomly). If not checked the mutation will happen on bit-level."
End Sub

Private Sub chkRandomOffspringGeneration_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "Random offspring generation. If both parents' chromosomes have identic genetic material (they are the same) then one of them is replaced by a new randomly generated chromosome"
End Sub

Private Sub chkStats_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "Keep full statistcs. If checked, the class will store statistics for every generation. They can be viewed in the second tab on the statistics-form. For use while tailoring the settings. Not advisable on machines with little memory and a great many generations."
End Sub

Private Sub cmdCancel_Click()

    Unload Me

End Sub

Private Sub ShowCurrentSettings()
    '
    ' Show the current settings
    '

    ' Description
    txtDescript.Text = GenAlgCP.Description
    
    ' PopulationSize
    txtPopSize.Text = GenAlgCP.PopulationSize
    
    ' Encoding
    If GenAlgCP.ChromosomeType = GAEncodingBinary Then
        optEncoding(0).Value = True
    Else
        If GenAlgCP.ChromosomeType = GAEncodingAlphabetic Then
            optEncoding(1).Value = True
        Else
            If GenAlgCP.ChromosomeType = GAEncodingLongNbr Then
                optEncoding(2).Value = True
            Else
                optEncoding(3).Value = True
            End If
        End If
    End If
    
    ' binary gene length
    txtBInaryGenelength.Text = GenAlgCP.BinaryGeneLength
    
    ' alphabetic gene length
    txtAlphagenelength.Text = GenAlgCP.AplhabeticGeneLength
    
    ' min length long
    txtLonggeneminvalue.Text = GenAlgCP.LongGeneMinValue
    
    ' max length long
    txtLonggenemaxvalue.Text = GenAlgCP.LongGeneMaxValue
    
    ' min vanlue double
    txtdoublegenMin.Text = GenAlgCP.DoubleGeneMinValue
    
    ' max value double
    txtdoublegenMax.Text = GenAlgCP.DoubleGeneMaxValue
    
    ' genes per chromosome
    txtGenesPerChromosome.Text = GenAlgCP.GenesPerChromosome
    
    ' selection method
    Select Case GenAlgCP.SelectionMethod
        Case GASelectRank
            optSelectMethod(0).Value = True
            
        Case GASelectRouletteWheel
            optSelectMethod(1).Value = True
        
        Case Else ' Tournament
            optSelectMethod(2).Value = True
        
    End Select

    ' tournament size
    txtTournamentSize.Text = GenAlgCP.TournamentSize
    
    ' Crossoverrate
    txtCrossoverRate.Text = GenAlgCP.CrossoverRate
    
    ' crossover full genes
    If GenAlgCP.CrossoverFullGene = True Then
        chkCrossoverFullgene.Value = vbChecked
    Else
        chkCrossoverFullgene.Value = vbUnchecked
    End If
    
    ' Crossover method
    Select Case GenAlgCP.CrossoverMethod
        Case GACrossoverOnePoint
            optCrossover(0).Value = True
            
        Case GACrossoverTwoPoint
            optCrossover(1).Value = True
        
        Case GACrossoverUniform
            optCrossover(2).Value = True
        
        Case GACrossoverHalfUniform
            optCrossover(3).Value = True
        
        Case GACrossoverEdgeRecombination
            optCrossover(4).Value = True
        
    End Select
    
    ' Random offspring generation
    If GenAlgCP.RandomOffspringGeneration = True Then
        chkRandomOffspringGeneration.Value = vbChecked
    Else
        chkRandomOffspringGeneration.Value = vbUnchecked
    End If
    
    ' MutationRate
    txtMutationRate.Text = GenAlgCP.MutationRate

    ' bitlike mutation for long/double
    If GenAlgCP.MutationBitlikeLongDouble = False Then
        chkLongDoubleMutatebit.Value = vbChecked
    Else
        chkLongDoubleMutatebit.Value = vbUnchecked
    End If
    
    ' percentage of max for bitlike mutation
    txtLongDoubleBitMutationPercent.Text = GenAlgCP.MutationBitlikePercentage

    ' Mutate full gene
    If GenAlgCP.MutateFullGene = True Then
        chkMutateFullGene.Value = vbChecked
    Else
        chkMutateFullGene.Value = vbUnchecked
    End If
    
    ' AMR generations
    txtAMRgenerations.Text = GenAlgCP.AMRGenerations

    ' mutation method
    Select Case GenAlgCP.MutationMethod
        Case GAMutationRateFixed
            optMutationRate(0).Value = True
            
        Case GAMutationRateAdaptive
            optMutationRate(1).Value = True
            
    End Select

    ' social disaster diversity
    txtSocialDisasterPercent.Text = GenAlgCP.SocialDisasterDiversity
    
    ' social disaster generations
    txtDisasterGenerations.Text = GenAlgCP.SocialDisasterGenerations
    
    ' social disaster method
    Select Case GenAlgCP.SocialDisasterMethod
        Case GASocialDisasterPacking
            optSocialDisaster(0).Value = True

        Case GASocialDisasterJudgementDay
            optSocialDisaster(1).Value = True
    
    End Select

    ' Reproduction method
    Select Case GenAlgCP.ReproductionMethod
        Case GAReproductionReplaceWeakest
            optReproductionmethod(0).Value = True
            
        Case GAReproductionReplaceParents
            optReproductionmethod(1).Value = True
        
        Case Else ' random
            optReproductionmethod(2).Value = True
        
    End Select
    
    ' statistics
    If GenAlgCP.KeepStatistics = True Then
        chkStats.Value = vbChecked
    Else
        chkStats.Value = vbUnchecked
    End If
    
    
    Call PrintOverview
    
End Sub

Private Sub cmdLoad_Click()

    CommonDialog.CancelError = True

    On Local Error GoTo errhandler

    CommonDialog.FileName = ""
    CommonDialog.Filter = "GA settings (*.GA)|*.ga|All files|*.*"
    CommonDialog.Flags = cdlOFNExplorer + cdlOFNFileMustExist + cdlOFNHideReadOnly + cdlOFNLongNames + cdlOFNPathMustExist
    CommonDialog.DefaultExt = "GA"
    CommonDialog.InitDir = App.Path & "\GA"
    CommonDialog.FilterIndex = 1
    CommonDialog.ShowOpen

    Call GenAlgCP.ReadGASettings(CommonDialog.FileName)
    
    Call ShowCurrentSettings
    
    Exit Sub
  
errhandler:
    ' User clicked Cancel


End Sub

Private Sub cmdOK_Click()

    Call SetSettings

    Unload Me

End Sub

Private Sub cmdSave_Click()

    CommonDialog.CancelError = True

    On Local Error GoTo errhandler

    CommonDialog.FileName = ""
    CommonDialog.Filter = "GA settings (*.GA)|*.ga|All files|*.*"
    CommonDialog.Flags = cdlOFNExplorer + cdlOFNHideReadOnly + cdlOFNLongNames + cdlOFNPathMustExist
    CommonDialog.DefaultExt = "GA"
    CommonDialog.InitDir = App.Path
    CommonDialog.FilterIndex = 1
    CommonDialog.ShowSave

    Call SetSettings
    
    Call GenAlgCP.SaveGASettings(CommonDialog.FileName)
    
    Exit Sub
  
errhandler:
    ' User clicked Cancel

End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = ""
End Sub

Private Sub Frame1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = ""
End Sub

Private Sub Frame11_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = ""
End Sub

Private Sub Frame2_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = ""
End Sub

Private Sub Frame3_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = ""
End Sub

Private Sub Frame4_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = ""
End Sub

Private Sub Frame5_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = ""
End Sub

Private Sub Frame6_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = ""
End Sub

Private Sub Frame7_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = ""
End Sub

Private Sub optCrossover_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0
            lblInfo.Caption = "One point crossover. A single crossover point on both parents' chromosomes is selected. All data beyond that point in either chromosomes is swapped between the two parents."
        Case 1
            lblInfo.Caption = "Two point crossover. Two points are selected on the parents' chromosomes. Everything between the two points is swapped between the parents"
        Case 2
            lblInfo.Caption = "Uniform crossover. Individual bits in the chromosomes are compared between the two parents. The bits are swapped with a fixed probability (0.5)"
        Case 3
            lblInfo.Caption = "Half uniform crossover. Like uniform crossover but now only half of the nonmatching bits are swapped"
        Case 4
            lblInfo.Caption = "Edge recombination. Special crossover function designed for routing (or travelling salesman) where each gene represents the next destination point in a route"
    End Select

End Sub

Private Sub optEncoding_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0
            lblInfo.Caption = "Binary encoding : genes are stored as a string of 0 and 1"
        Case 1
            lblInfo.Caption = "Alphabetical encoding : genes are stored as a string holding uppercase letters of the alphabet, ranging from A to Z"
        Case 2
            lblInfo.Caption = "Long encoding : genes are numbers with type 'long'"
        Case 3
            lblInfo.Caption = "Double encoding : genes are numbers with type 'double', this encoding type can be used when real values are needed"

    End Select
End Sub

Private Sub optMutationRate_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0
            lblInfo.Caption = "Fixed mutationrate. The chosen mutationrate is fixed and will remain unchanged"
        Case 1
            lblInfo.Caption = "Adaptive mutationrate. The mutationrate will increase with 0.01 every time the standard deviation of the fitness remains unchanged for the chosen number of generations. Likewise it will be decreased by 0.01 if the standard deviation of the fitness is not the same for the chosen number of generations"
    End Select
End Sub

Private Sub optReproductionmethod_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0
            lblInfo.Caption = "Reproduction method Replace weakest. The method how newly created children are introduced into the population. The two new offsprings will replace the two weakest chromosomes"
        Case 1
            lblInfo.Caption = "Reproduction method Replace weakest. The method how newly created children are introduced into the population. The two new offsprings will replace their parents"
        Case 2
            lblInfo.Caption = "Reproduction method Replace weakest. The method how newly created children are introduced into the population. The two new offsprings will replace two random members"
    End Select
End Sub

Private Sub optSelectMethod_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0
            lblInfo.Caption = "Selection method - Rank. Rank selection first orders the population by fitness, then two members are randomly selected."
        Case 1
            lblInfo.Caption = "Selection method - Roulette. All chromosomes are placed on an imaginary wheel. Each one recieves a pie piece relative to it's fitness (lower fitness equals bigger pie). The wheel is spun twice and two elements are picked depending on where the wheel stops. THIS IS A MODIFIED VERSION OF ROULETTE TO MINIMIZE LOCAL OPTIMA !"
        Case 2
            lblInfo.Caption = "Selection method - Tournament. Select 'Tournamen Size' random elements and pick the fittest one. This is done twice to obtain two members"
    End Select
End Sub

Private Sub optSocialDisaster_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0
            lblInfo.Caption = "Social disaster method Packing. From each group with same fitness value in the population only one member is kept. All others are randomized"
        Case 1
            lblInfo.Caption = "Social disaster method Judgement Day. Only the fittest chromosome is kept. All others are randomized"
    End Select
End Sub

Private Sub SSTab1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = ""
End Sub


Private Sub txtAlphagenelength_GotFocus()
    Call SetTextboxAsSelected(txtAlphagenelength)
End Sub

Private Sub txtAlphagenelength_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub txtAlphagenelength_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "Howmany characters (from A to Z) can an alphabetic gene hold"
End Sub

Private Sub txtAMRgenerations_GotFocus()
    Call SetTextboxAsSelected(txtAMRgenerations)
End Sub

Private Sub txtAMRgenerations_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, True)
End Sub

Private Sub txtAMRgenerations_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "For adaptive mutationrate : The number of generations that the standard deviation of the fitness has to remain the same before the mutationrate is increased by 0.01. Also the number of generations the standard deviation of the fitness has to be different before the mutationrate is decreased by 0.01"
End Sub

Private Sub txtBInaryGenelength_GotFocus()
    Call SetTextboxAsSelected(txtBInaryGenelength)
End Sub

Private Sub txtBInaryGenelength_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub txtBInaryGenelength_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "How long can a binary gene be. (howmany 0 and 1 characters are ther in a gene)"
End Sub

Private Sub txtCrossoverRate_GotFocus()
    Call SetTextboxAsSelected(txtCrossoverRate)
End Sub

Private Sub txtCrossoverRate_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, True)
End Sub

Private Sub txtCrossoverRate_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "Crossoverrate. A value between 0 and 1 that determines how often the two parents will be recombined. For example a value of 0.7 that means that 70% of the time the parents will be crossed, and 30% of the time nothing will happen."
End Sub

Private Sub txtDescript_GotFocus()
    Call SetTextboxAsSelected(txtDescript)
End Sub

Private Sub txtDescript_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "An optional description for the chosen settings."
End Sub

Private Sub txtDisasterGenerations_GotFocus()
    Call SetTextboxAsSelected(txtDisasterGenerations)
End Sub

Private Sub txtDisasterGenerations_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, True)
End Sub

Private Sub txtDisasterGenerations_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "The number of generations between each check if a social disaster should occur or not"
End Sub

Private Sub txtdoublegenMax_GotFocus()
    Call SetTextboxAsSelected(txtdoublegenMax)
End Sub

Private Sub txtdoublegenMax_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, True)
End Sub

Private Sub txtdoublegenMax_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "The maximum value for a double gene"
End Sub

Private Sub txtdoublegenMin_GotFocus()
    Call SetTextboxAsSelected(txtdoublegenMin)
End Sub

Private Sub txtdoublegenMin_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, True, True)
End Sub

Private Sub txtdoublegenMin_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "The minimum value for a double gene"
End Sub

Private Sub txtGenesPerChromosome_GotFocus()
    Call SetTextboxAsSelected(txtGenesPerChromosome)
End Sub

Private Sub txtGenesPerChromosome_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub txtGenesPerChromosome_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "The number of genes in a chromosome"
End Sub

Private Sub txtLongDoubleBitMutationPercent_GotFocus()
    Call SetTextboxAsSelected(txtLongDoubleBitMutationPercent)
End Sub

Private Sub txtLongDoubleBitMutationPercent_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, True)
End Sub

Private Sub txtLongDoubleBitMutationPercent_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "Percentage of the maximum gene-value (set at encoding) that a random value to add or subtract will not exceed."
End Sub

Private Sub txtLonggenemaxvalue_GotFocus()
    Call SetTextboxAsSelected(txtLonggenemaxvalue)
End Sub

Private Sub txtLonggenemaxvalue_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub txtLonggenemaxvalue_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "The maximum number a long gene can be"
End Sub

Private Sub txtLonggeneminvalue_GotFocus()
    Call SetTextboxAsSelected(txtLonggeneminvalue)
End Sub

Private Sub txtLonggeneminvalue_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, True, False)
End Sub

Private Sub txtLonggeneminvalue_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "The minimum number a long gene can be"
End Sub

Private Sub txtMutationRate_GotFocus()
    Call SetTextboxAsSelected(txtMutationRate)
End Sub

Private Sub txtMutationRate_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, True)
End Sub

Private Sub txtMutationRate_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "Mutationrate. A value between 0 and 1 that determines how often each chromosome is likely to be modified. A value of 0.05 means that a chromosome has 5% chance of having a mutation occur"
End Sub

Private Sub txtPopSize_GotFocus()
    Call SetTextboxAsSelected(txtPopSize)
End Sub

Private Sub txtPopSize_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub txtPopSize_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "The number of chromosomes who will make up your population"
End Sub

Private Sub txtSocialDisasterPercent_GotFocus()
    Call SetTextboxAsSelected(txtSocialDisasterPercent)
End Sub

Private Sub txtSocialDisasterPercent_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, True)
End Sub

Private Sub txtSocialDisasterPercent_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "Social disaster genetic diversity. A number from 0 to 100 representing the percentage of differing fitness values the population must have. If the difference comes below this percentage a social disaster will occur. Setting this to 0 (zero) switches off social disasters"
End Sub

Private Sub txtTournamentSize_GotFocus()
    Call SetTextboxAsSelected(txtTournamentSize)
End Sub

Private Sub txtTournamentSize_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub SetSettings()
    '
    ' set the settings as chosen in the CP
    '

    ' Description
    GenAlgCP.Description = Trim$(StrNull(txtDescript.Text))
    
    ' PopulationSize
    GenAlgCP.PopulationSize = LngNull(txtPopSize.Text)
    
    ' encoding
    If optEncoding(0).Value = True Then
        GenAlgCP.ChromosomeType = GAEncodingBinary
    Else
        If optEncoding(1).Value = True Then
            GenAlgCP.ChromosomeType = GAEncodingAlphabetic
        Else
            If optEncoding(2).Value = True Then
                GenAlgCP.ChromosomeType = GAEncodingLongNbr
            Else
                GenAlgCP.ChromosomeType = GAEncodingDouble
            End If
        End If
    End If
    
    ' binary gene length
    GenAlgCP.BinaryGeneLength = IntNull(txtBInaryGenelength.Text)
    
    ' alphabetic gene length
    GenAlgCP.AplhabeticGeneLength = IntNull(txtAlphagenelength.Text)
    
    ' min length long
    GenAlgCP.LongGeneMinValue = LngNull(txtLonggeneminvalue.Text)
    
    ' max length long
    GenAlgCP.LongGeneMaxValue = LngNull(txtLonggenemaxvalue.Text)
    
    ' min vanlue double
    GenAlgCP.DoubleGeneMinValue = DblNull(txtdoublegenMin.Text)
    
    ' max value double
    GenAlgCP.DoubleGeneMaxValue = DblNull(txtdoublegenMax.Text)
    
    ' genes per chromosome
    GenAlgCP.GenesPerChromosome = IntNull(txtGenesPerChromosome.Text)
    
    ' selection method
    If optSelectMethod(0).Value = True Then
        GenAlgCP.SelectionMethod = GASelectRank
    Else
        If optSelectMethod(1).Value = True Then
            GenAlgCP.SelectionMethod = GASelectRouletteWheel
        Else
            GenAlgCP.SelectionMethod = GASelectTournament
        End If
    End If

    ' tournament size
    GenAlgCP.TournamentSize = LngNull(txtTournamentSize.Text)
    
    ' Crossoverrate
    GenAlgCP.CrossoverRate = DblNull(txtCrossoverRate.Text)
    
    ' crossover full genes
    If chkCrossoverFullgene.Value = vbChecked Then
        GenAlgCP.CrossoverFullGene = True
    Else
        GenAlgCP.CrossoverFullGene = False
    End If
    
    ' Crossover method
    If optCrossover(0).Value = True Then
        GenAlgCP.CrossoverMethod = GACrossoverOnePoint
    Else
        If optCrossover(1).Value = True Then
            GenAlgCP.CrossoverMethod = GACrossoverTwoPoint
        Else
            If optCrossover(2).Value = True Then
                GenAlgCP.CrossoverMethod = GACrossoverUniform
            Else
                If optCrossover(3).Value = True Then
                    GenAlgCP.CrossoverMethod = GACrossoverHalfUniform
                Else
                    GenAlgCP.CrossoverMethod = GACrossoverEdgeRecombination
                End If
            End If
        End If
    End If
    
    ' Random offspring generation
    If chkRandomOffspringGeneration.Value = vbChecked Then
        GenAlgCP.RandomOffspringGeneration = True
    Else
        GenAlgCP.RandomOffspringGeneration = False
    End If
    
    ' MutationRate
    GenAlgCP.MutationRate = DblNull(txtMutationRate.Text)

    ' bitlike mutation for long/double
    If chkLongDoubleMutatebit.Value = vbChecked Then
        GenAlgCP.MutationBitlikeLongDouble = False
    Else
        GenAlgCP.MutationBitlikeLongDouble = True
    End If
    
    ' percentage of max for bitlike mutation
    GenAlgCP.MutationBitlikePercentage = DblNull(txtLongDoubleBitMutationPercent.Text)

    ' Mutate full gene
    If chkMutateFullGene.Value = vbChecked Then
        GenAlgCP.MutateFullGene = True
    Else
        GenAlgCP.MutateFullGene = False
    End If
    
    ' AMR generations
    GenAlgCP.AMRGenerations = LngNull(txtAMRgenerations.Text)

    ' mutation method
    If optMutationRate(0).Value = True Then
        GenAlgCP.MutationMethod = GAMutationRateFixed
    Else
        GenAlgCP.MutationMethod = GAMutationRateAdaptive
    End If

    ' social disaster diversity
    GenAlgCP.SocialDisasterDiversity = DblNull(txtSocialDisasterPercent.Text)
    
    ' social disaster generations
    GenAlgCP.SocialDisasterGenerations = LngNull(txtDisasterGenerations.Text)
    
    ' social disaster method
    If optSocialDisaster(0).Value = True Then
        GenAlgCP.SocialDisasterMethod = GASocialDisasterPacking
    Else
        GenAlgCP.SocialDisasterMethod = GASocialDisasterJudgementDay
    End If

    ' Reproduction method
    If optReproductionmethod(0).Value = True Then
        GenAlgCP.ReproductionMethod = GAReproductionReplaceWeakest
    Else
        If optReproductionmethod(1).Value = True Then
            GenAlgCP.ReproductionMethod = GAReproductionReplaceParents
        Else ' random
            GenAlgCP.ReproductionMethod = GAReproductionReplaceRandom
        End If
    End If
    
    ' statistics
    If chkStats.Value = vbChecked Then
        GenAlgCP.KeepStatistics = True
    Else
        GenAlgCP.KeepStatistics = False
    End If
    
End Sub

Private Sub txtTournamentSize_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblInfo.Caption = "For tournament selection method. The number of random elements picked from where the fittest will be chosen"
End Sub

Private Sub PrintOverview()
    '
    ' Print an overview of the settings in the picturebox
    ' These are the original settings as they where the
    ' moment the form was opened. They are either the defaults
    ' for the GA (if opened from the switchboard) or they
    ' are the settings from the GA on the calling form.
    
    ' empty it
    Pictbox.Cls
    
    ' population size
    Pictbox.Print "General"
    Pictbox.Print "Population size : " & txtPopSize.Text
    Pictbox.Print ""
    
    
    ' encoding
    Pictbox.Print "Encoding"
    If optEncoding(0).Value = True Then
        Pictbox.Print "Encodingtype : Binary"
        Pictbox.Print Space$(5) & "Binary gene length : " & txtBInaryGenelength.Text
    Else
        If optEncoding(1).Value = True Then
            Pictbox.Print "Encodingtype : Alphabetic"
            Pictbox.Print Space$(5) & "Alphabetic gene length : " & txtAlphagenelength.Text
        Else
            If optEncoding(2).Value = True Then
                Pictbox.Print "Encodingtype : Long integer"
                Pictbox.Print Space$(5) & "Long gene minimum value : " & txtLonggeneminvalue.Text
                Pictbox.Print Space$(5) & "Long gene maximum value : " & txtLonggenemaxvalue.Text
            Else
                Pictbox.Print "Encodingtype : Double (real values)"
                Pictbox.Print Space$(5) & "Double gene minimum value : " & txtdoublegenMin.Text
                Pictbox.Print Space$(5) & "Double gene maximum value : " & txtdoublegenMax.Text
            End If
        End If
    End If
    
    ' number of genes per chromosome
    Pictbox.Print "Number of genes per chromosome : " & txtGenesPerChromosome.Text
    Pictbox.Print ""
    
    ' selection method
    Pictbox.Print "Selection"
    If optSelectMethod(0).Value = True Then
        Pictbox.Print "Selection method : Rank"
    Else
        If optSelectMethod(1).Value = True Then
            Pictbox.Print "Selection method : Roulette wheel"
        Else
            Pictbox.Print "Selection method : Tournament"
            Pictbox.Print Space$(5) & "Tournament size : " & txtTournamentSize.Text
        End If
    End If
    Pictbox.Print ""
    
    ' random offspring generations
    If chkRandomOffspringGeneration.Value = vbChecked Then
        Pictbox.Print "Random offspring generation : Yes"
    Else
        Pictbox.Print "Random offspring generation : No"
    End If
    Pictbox.Print ""
    
    ' crossoverrate
    Pictbox.Print "Crossover"
    Pictbox.Print "Crossover rate : " & txtCrossoverRate.Text
    
    ' crossovermethod
    If optCrossover(0).Value = True Then
        Pictbox.Print "Crossover method : one point"
    Else
        If optCrossover(1).Value = True Then
            Pictbox.Print "Crossover method : two point"
        Else
            If optCrossover(2).Value = True Then
                Pictbox.Print "Crossover method : uniform"
            Else
                If optCrossover(3).Value = True Then
                    Pictbox.Print "Crossover method : half-uniform"
                Else
                    Pictbox.Print "Crossover method : Edge recombination"
                End If
            End If
        End If
    End If
    
    ' crossover full gene
    If chkCrossoverFullgene.Value = vbChecked Then
        Pictbox.Print "Crossover full gene : Yes"
    Else
        Pictbox.Print "Crossover full gene : No"
    End If
    Pictbox.Print ""
    
    
    Pictbox.Print "Mutation"
    ' Mutationrate
    Pictbox.Print "Mutation rate : " & txtMutationRate.Text
    
    ' Mutation type
    If optMutationRate(0).Value = True Then
        Pictbox.Print "Mutation type : Fixed"
    Else
        Pictbox.Print "Mutation type : Adaptive"
        Pictbox.Print Space$(5) & "Adapt after (generations) : " & txtAMRgenerations.Text
    End If
    
    ' Mutation bitlike for long and double
    If chkLongDoubleMutatebit.Value = vbChecked Then
        Pictbox.Print "Mutate bit-like for long/double : No"
        Pictbox.Print "Bit-like % of maximum : " & txtLongDoubleBitMutationPercent.Text
    Else
        Pictbox.Print "Mutate bit-like for long/double : Yes"
    End If
    
    ' mutate full gene
    If chkMutateFullGene.Value = vbChecked Then
        Pictbox.Print "Mutate full gene : Yes"
    Else
        Pictbox.Print "Mutate full gene : No"
    End If
    Pictbox.Print ""
    
    Pictbox.Print "Social disasters"
    ' social disaster % diversity
    If LngNull(txtSocialDisasterPercent.Text) = 0 Then
        Pictbox.Print "Social disaster turned off"
    Else
        Pictbox.Print "Social disaster lowest diversity : " & txtSocialDisasterPercent.Text
    
        ' check every
        Pictbox.Print "Check diversity every : " & txtDisasterGenerations.Text
    
        ' social disaster method
        If optSocialDisaster(0).Value = True Then
            Pictbox.Print "Social disaster method : Packing"
        Else
            Pictbox.Print "Social disaster method : Judgement Day"
        End If
    End If
    Pictbox.Print ""
    
    
    ' reproduction method
    Pictbox.Print "Reproduction"
    If optReproductionmethod(0).Value = True Then
        Pictbox.Print "Reproduction method : Replace weakest"
    Else
        If optReproductionmethod(1).Value = True Then
            Pictbox.Print "Reproduction method : Replace parents"
        Else
            Pictbox.Print "Reproduction method : Replace random"
        End If
    End If
    Pictbox.Print ""
    
    
    ' statistics
    If chkStats.Value = vbChecked Then
        Pictbox.Print "Keep full statistics"
    Else
        Pictbox.Print "Do not keep full statistics"
    End If
    
End Sub
