VERSION 5.00
Begin VB.Form frmSwitchboard 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Big Genetic Algorithm"
   ClientHeight    =   6750
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8850
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6750
   ScaleWidth      =   8850
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame4 
      Caption         =   "The GA-control panel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   120
      TabIndex        =   13
      Top             =   3600
      Width           =   8535
      Begin VB.CommandButton cmdControlPanel 
         Caption         =   "GA control panel"
         Height          =   375
         Left            =   4680
         TabIndex        =   5
         Top             =   360
         Width           =   3615
      End
      Begin VB.Label lblControlPanel 
         Caption         =   "Using the supplied control panel"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   480
         MouseIcon       =   "frmSwitchboard.frx":0000
         MousePointer    =   99  'Custom
         TabIndex        =   16
         Top             =   360
         Width           =   3855
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Examples"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2415
      Left            =   120
      TabIndex        =   10
      Top             =   1080
      Width           =   8535
      Begin VB.CommandButton cmdKnapsack 
         Caption         =   "0/1 knapsack problem"
         Height          =   375
         Left            =   4680
         TabIndex        =   4
         Top             =   1800
         Width           =   3615
      End
      Begin VB.CommandButton cmdCircles 
         Caption         =   "Draw the biggest circle"
         Height          =   375
         Left            =   4680
         TabIndex        =   1
         Top             =   360
         Width           =   3615
      End
      Begin VB.CommandButton cmdTSP 
         Caption         =   "The Traveling Salesman"
         Height          =   375
         Left            =   4680
         TabIndex        =   3
         Top             =   1320
         Width           =   3615
      End
      Begin VB.CommandButton cmdValueGrid 
         Caption         =   "Fill the grid"
         Height          =   375
         Left            =   4680
         TabIndex        =   2
         Top             =   840
         Width           =   3615
      End
      Begin VB.Label lblGrid 
         Caption         =   "Find the numbers in the grid"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   480
         MouseIcon       =   "frmSwitchboard.frx":030A
         MousePointer    =   99  'Custom
         TabIndex        =   15
         Top             =   960
         Width           =   3735
      End
      Begin VB.Label lblTSP 
         Caption         =   "The Traveling Salesman problem"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   480
         MouseIcon       =   "frmSwitchboard.frx":0614
         MousePointer    =   99  'Custom
         TabIndex        =   14
         Top             =   1440
         Width           =   3735
      End
      Begin VB.Label lblCircles 
         Caption         =   "Draw the biggest non-intersecting circle"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   480
         MouseIcon       =   "frmSwitchboard.frx":091E
         MousePointer    =   99  'Custom
         TabIndex        =   12
         Top             =   480
         Width           =   3735
      End
      Begin VB.Label lblKnapsack 
         Caption         =   "The 0/1 knapsack problem"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   480
         MouseIcon       =   "frmSwitchboard.frx":0C28
         MousePointer    =   99  'Custom
         TabIndex        =   11
         Top             =   1920
         Width           =   3735
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "New to Genetic Algorithms ? Start here ! (example 1)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   120
      TabIndex        =   8
      Top             =   120
      Width           =   8535
      Begin VB.CommandButton cmdIntro 
         Caption         =   "Introduction : Explaining Genetic Algorithms"
         Height          =   375
         Left            =   4680
         TabIndex        =   0
         Top             =   360
         Width           =   3615
      End
      Begin VB.Label lblIntroduction 
         Caption         =   "what is a genetic algorithm and how does it work ?"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   480
         MouseIcon       =   "frmSwitchboard.frx":0F32
         MousePointer    =   99  'Custom
         TabIndex        =   9
         Top             =   360
         Width           =   3975
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Documentation"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1455
      Left            =   120
      TabIndex        =   7
      Top             =   4680
      Width           =   8535
      Begin VB.Label lblMutateCroxxoverValues 
         Caption         =   "Mutation and crossover of long and double values"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   4680
         MouseIcon       =   "frmSwitchboard.frx":123C
         MousePointer    =   99  'Custom
         TabIndex        =   25
         Top             =   720
         Width           =   3735
      End
      Begin VB.Label lblSpecialTech 
         Caption         =   "Special techniques : Co-evolution..."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   4680
         MouseIcon       =   "frmSwitchboard.frx":1546
         MousePointer    =   99  'Custom
         TabIndex        =   22
         Top             =   1080
         Width           =   3615
      End
      Begin VB.Label lblUseInYourProjects 
         Caption         =   "Using the class in your own projects"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   4680
         MouseIcon       =   "frmSwitchboard.frx":1850
         MousePointer    =   99  'Custom
         TabIndex        =   21
         Top             =   360
         Width           =   3735
      End
      Begin VB.Label lblLocalOptima 
         Caption         =   "Local optima and how to fight it"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   480
         MouseIcon       =   "frmSwitchboard.frx":1B5A
         MousePointer    =   99  'Custom
         TabIndex        =   19
         Top             =   1080
         Width           =   3615
      End
      Begin VB.Label lblHowdoesitwork 
         Caption         =   "How does the class work ?"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   480
         MouseIcon       =   "frmSwitchboard.frx":1E64
         MousePointer    =   99  'Custom
         TabIndex        =   18
         Top             =   360
         Width           =   3735
      End
      Begin VB.Label lblClassProp 
         Caption         =   "The properties, methods and events of the class"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   480
         MouseIcon       =   "frmSwitchboard.frx":216E
         MousePointer    =   99  'Custom
         TabIndex        =   17
         Top             =   720
         Width           =   3615
      End
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      Height          =   375
      Left            =   7920
      TabIndex        =   6
      Top             =   6240
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "email : thierry.van.mol@hotmail.com"
      Height          =   255
      Left            =   3720
      TabIndex        =   24
      Top             =   6360
      Width           =   2655
   End
   Begin VB.Label lblInfo 
      Caption         =   "By Thierry Van Mol   Version 1.0  2007-2008"
      Height          =   255
      Left            =   120
      TabIndex        =   23
      Top             =   6360
      Width           =   3375
   End
   Begin VB.Label lblAbout 
      Caption         =   "About..."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   6960
      MouseIcon       =   "frmSwitchboard.frx":2478
      MousePointer    =   99  'Custom
      TabIndex        =   20
      Top             =   6360
      Width           =   855
   End
End
Attribute VB_Name = "frmSwitchboard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim GenAlg            As clsGeneticAlgorithm
Attribute GenAlg.VB_VarHelpID = -1

Private Sub cmdCircles_Click()

    frmGenAlgCircles.Show vbModal
    
End Sub

Private Sub cmdControlPanel_Click()

    Load frmGenAlgControlPanel
    frmGenAlgControlPanel.ReadSettings = GenAlg

    frmGenAlgControlPanel.Show vbModal

End Sub

Private Sub cmdexit_Click()
    End
End Sub

Private Sub cmdIntro_Click()

    frmGenAlgExplanation.Show vbModal
    
End Sub

Private Sub cmdKnapsack_Click()

    frmGenAlgKnapsack.Show vbModal
    
End Sub

Private Sub cmdTSP_Click()

    frmGenAlgTSP.Show vbModal
    
End Sub

Private Sub cmdValueGrid_Click()

    frmGenAlgGrid.Show vbModal
    
End Sub

Private Sub Form_Load()

    Set GenAlg = New clsGeneticAlgorithm

    lblInfo.Caption = "By Thierry Van Mol  Version " & GenAlg.Version & " 2007-2008"
    
End Sub

Private Sub lblAbout_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\About.txt", vbNormalFocus)

End Sub

Private Sub lblCircles_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\Circles.txt", vbNormalFocus)

End Sub

Private Sub lblClassProp_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\PropertiesMethodsEvents.txt", vbNormalFocus)

End Sub

Private Sub lblControlPanel_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\GAControlPanel.txt", vbNormalFocus)

End Sub

Private Sub lblGrid_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\fillgrid.txt", vbNormalFocus)

End Sub

Private Sub lblHowdoesitwork_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\HowItWorks.txt", vbNormalFocus)

End Sub

Private Sub lblIntroduction_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\ExplainingGAIntroduction.txt", vbNormalFocus)

End Sub

Private Sub lblKnapsack_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\01Knapsack.txt", vbNormalFocus)

End Sub

Private Sub lblLocalOptima_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\LocalOptima.txt", vbNormalFocus)

End Sub

Private Sub lblMutateCroxxoverValues_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\LongAndDoubleEncoding.txt", vbNormalFocus)

End Sub

Private Sub lblSpecialTech_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\SpecialTechniques.txt", vbNormalFocus)

End Sub

Private Sub lblTSP_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\TSP.txt", vbNormalFocus)

End Sub

Private Sub lblUseInYourProjects_Click()

    Call Shell("Notepad.exe " & App.Path & "\Documentation\UseInYourOwnProjects.txt", vbNormalFocus)

End Sub
