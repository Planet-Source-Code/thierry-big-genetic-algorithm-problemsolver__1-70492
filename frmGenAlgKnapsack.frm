VERSION 5.00
Begin VB.Form frmGenAlgKnapsack 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "0/1 Knapsack problem"
   ClientHeight    =   7785
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9990
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7785
   ScaleWidth      =   9990
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdTextfile 
      Caption         =   "Show explanation text"
      Height          =   375
      Left            =   120
      TabIndex        =   71
      Top             =   6720
      Width           =   2415
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      Height          =   375
      Left            =   9120
      TabIndex        =   29
      Top             =   7200
      Width           =   735
   End
   Begin VB.CommandButton cmdCalculate 
      Caption         =   "Start"
      Height          =   375
      Left            =   3600
      TabIndex        =   25
      Top             =   6720
      Width           =   1935
   End
   Begin VB.CommandButton cmdGAControlPanel 
      Caption         =   "GA control panel..."
      Height          =   375
      Left            =   3600
      TabIndex        =   26
      Top             =   7200
      Width           =   1935
   End
   Begin VB.TextBox txtGenerations 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   5880
      TabIndex        =   24
      Text            =   "10000"
      Top             =   6240
      Width           =   735
   End
   Begin VB.CommandButton cmdStop 
      Caption         =   "Stop"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5760
      TabIndex        =   28
      Top             =   7200
      Width           =   1935
   End
   Begin VB.CommandButton cmdShowChromo 
      Caption         =   "Pause and show stats"
      Enabled         =   0   'False
      Height          =   375
      Left            =   5760
      TabIndex        =   27
      Top             =   6720
      Width           =   1935
   End
   Begin VB.Frame Frame6 
      Caption         =   "0-1 knapsack problem"
      Height          =   4815
      Left            =   120
      TabIndex        =   0
      Top             =   1320
      Width           =   9735
      Begin VB.Frame Frame1 
         Caption         =   "Iterations"
         Height          =   4335
         Left            =   5400
         TabIndex        =   72
         Top             =   360
         Width           =   4215
         Begin VB.Label lblItValue 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   4
            Left            =   3360
            TabIndex        =   155
            Top             =   3840
            Width           =   495
         End
         Begin VB.Label lblItValue 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   3
            Left            =   2760
            TabIndex        =   154
            Top             =   3840
            Width           =   495
         End
         Begin VB.Label lblItValue 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   2
            Left            =   2160
            TabIndex        =   153
            Top             =   3840
            Width           =   495
         End
         Begin VB.Label lblItValue 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   1
            Left            =   1560
            TabIndex        =   152
            Top             =   3840
            Width           =   495
         End
         Begin VB.Label lblItValue 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   0
            Left            =   960
            TabIndex        =   151
            Top             =   3840
            Width           =   495
         End
         Begin VB.Label lblItRemain 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   4
            Left            =   3360
            TabIndex        =   150
            Top             =   3480
            Width           =   495
         End
         Begin VB.Label lblItRemain 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   3
            Left            =   2760
            TabIndex        =   149
            Top             =   3480
            Width           =   495
         End
         Begin VB.Label lblItRemain 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   2
            Left            =   2160
            TabIndex        =   148
            Top             =   3480
            Width           =   495
         End
         Begin VB.Label lblItRemain 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   1
            Left            =   1560
            TabIndex        =   147
            Top             =   3480
            Width           =   495
         End
         Begin VB.Label lblItRemain 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   0
            Left            =   960
            TabIndex        =   146
            Top             =   3480
            Width           =   495
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   49
            Left            =   3600
            TabIndex        =   145
            Top             =   2640
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   48
            Left            =   3600
            TabIndex        =   144
            Top             =   2400
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   47
            Left            =   3600
            TabIndex        =   143
            Top             =   2160
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   46
            Left            =   3600
            TabIndex        =   142
            Top             =   1920
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   45
            Left            =   3600
            TabIndex        =   141
            Top             =   1680
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   44
            Left            =   3600
            TabIndex        =   140
            Top             =   1440
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   43
            Left            =   3600
            TabIndex        =   139
            Top             =   1200
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   42
            Left            =   3600
            TabIndex        =   138
            Top             =   960
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   41
            Left            =   3600
            TabIndex        =   137
            Top             =   720
            Width           =   135
         End
         Begin VB.Label lblItVolume 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   4
            Left            =   3360
            TabIndex        =   136
            Top             =   3120
            Width           =   495
         End
         Begin VB.Label lblItVolume 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   3
            Left            =   2760
            TabIndex        =   135
            Top             =   3120
            Width           =   495
         End
         Begin VB.Label lblItVolume 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   2
            Left            =   2160
            TabIndex        =   134
            Top             =   3120
            Width           =   495
         End
         Begin VB.Label lblItVolume 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   1
            Left            =   1560
            TabIndex        =   133
            Top             =   3120
            Width           =   495
         End
         Begin VB.Label lblItVolume 
            Alignment       =   1  'Right Justify
            BorderStyle     =   1  'Fixed Single
            Caption         =   "0"
            Height          =   255
            Index           =   0
            Left            =   960
            TabIndex        =   132
            Top             =   3120
            Width           =   495
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   40
            Left            =   3600
            TabIndex        =   131
            Top             =   480
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   39
            Left            =   3000
            TabIndex        =   130
            Top             =   2640
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   38
            Left            =   3000
            TabIndex        =   129
            Top             =   2400
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   37
            Left            =   3000
            TabIndex        =   128
            Top             =   2160
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   36
            Left            =   3000
            TabIndex        =   127
            Top             =   1920
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   35
            Left            =   3000
            TabIndex        =   126
            Top             =   1680
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   34
            Left            =   3000
            TabIndex        =   125
            Top             =   1440
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   33
            Left            =   3000
            TabIndex        =   124
            Top             =   1200
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   32
            Left            =   3000
            TabIndex        =   123
            Top             =   960
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   31
            Left            =   3000
            TabIndex        =   122
            Top             =   720
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   30
            Left            =   3000
            TabIndex        =   121
            Top             =   480
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   29
            Left            =   2400
            TabIndex        =   120
            Top             =   2640
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   28
            Left            =   2400
            TabIndex        =   119
            Top             =   2400
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   27
            Left            =   2400
            TabIndex        =   118
            Top             =   2160
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   26
            Left            =   2400
            TabIndex        =   117
            Top             =   1920
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   25
            Left            =   2400
            TabIndex        =   116
            Top             =   1680
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   24
            Left            =   2400
            TabIndex        =   115
            Top             =   1440
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   23
            Left            =   2400
            TabIndex        =   114
            Top             =   1200
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   22
            Left            =   2400
            TabIndex        =   113
            Top             =   960
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   21
            Left            =   2400
            TabIndex        =   112
            Top             =   720
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   20
            Left            =   2400
            TabIndex        =   111
            Top             =   480
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   19
            Left            =   1800
            TabIndex        =   110
            Top             =   2640
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   18
            Left            =   1800
            TabIndex        =   109
            Top             =   2400
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   17
            Left            =   1800
            TabIndex        =   108
            Top             =   2160
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   16
            Left            =   1800
            TabIndex        =   107
            Top             =   1920
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   15
            Left            =   1800
            TabIndex        =   106
            Top             =   1680
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   14
            Left            =   1800
            TabIndex        =   105
            Top             =   1440
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   13
            Left            =   1800
            TabIndex        =   104
            Top             =   1200
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   12
            Left            =   1800
            TabIndex        =   103
            Top             =   960
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   11
            Left            =   1800
            TabIndex        =   102
            Top             =   720
            Width           =   135
         End
         Begin VB.Label Label6 
            Caption         =   "Value"
            Height          =   255
            Index           =   8
            Left            =   120
            TabIndex        =   101
            Top             =   3840
            Width           =   615
         End
         Begin VB.Label Label6 
            Caption         =   "Remaining space :"
            Height          =   255
            Index           =   7
            Left            =   120
            TabIndex        =   100
            Top             =   3480
            Width           =   855
         End
         Begin VB.Label Label6 
            Caption         =   "Volume"
            Height          =   255
            Index           =   6
            Left            =   120
            TabIndex        =   99
            Top             =   3120
            Width           =   615
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   10
            Left            =   1800
            TabIndex        =   98
            Top             =   480
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   9
            Left            =   1200
            TabIndex        =   97
            Top             =   2640
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   8
            Left            =   1200
            TabIndex        =   96
            Top             =   2400
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   7
            Left            =   1200
            TabIndex        =   95
            Top             =   2160
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   6
            Left            =   1200
            TabIndex        =   94
            Top             =   1920
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   5
            Left            =   1200
            TabIndex        =   93
            Top             =   1680
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   4
            Left            =   1200
            TabIndex        =   92
            Top             =   1440
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   3
            Left            =   1200
            TabIndex        =   91
            Top             =   1200
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   2
            Left            =   1200
            TabIndex        =   90
            Top             =   960
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   1
            Left            =   1200
            TabIndex        =   89
            Top             =   720
            Width           =   135
         End
         Begin VB.Label lblIterResult 
            Caption         =   "X"
            Height          =   255
            Index           =   0
            Left            =   1200
            TabIndex        =   88
            Top             =   480
            Width           =   135
         End
         Begin VB.Label Label8 
            Caption         =   "5"
            Height          =   255
            Index           =   4
            Left            =   3600
            TabIndex        =   87
            Top             =   240
            Width           =   255
         End
         Begin VB.Label Label8 
            Caption         =   "4"
            Height          =   255
            Index           =   3
            Left            =   3000
            TabIndex        =   86
            Top             =   240
            Width           =   255
         End
         Begin VB.Label Label8 
            Caption         =   "3"
            Height          =   255
            Index           =   2
            Left            =   2400
            TabIndex        =   85
            Top             =   240
            Width           =   255
         End
         Begin VB.Label Label8 
            Caption         =   "2"
            Height          =   255
            Index           =   1
            Left            =   1800
            TabIndex        =   84
            Top             =   240
            Width           =   255
         End
         Begin VB.Label Label8 
            Caption         =   "1"
            Height          =   255
            Index           =   0
            Left            =   1200
            TabIndex        =   83
            Top             =   240
            Width           =   255
         End
         Begin VB.Label Label5 
            Caption         =   "Item 1"
            Height          =   255
            Index           =   20
            Left            =   120
            TabIndex        =   82
            Top             =   480
            Width           =   735
         End
         Begin VB.Label Label5 
            Caption         =   "Item 2"
            Height          =   255
            Index           =   19
            Left            =   120
            TabIndex        =   81
            Top             =   720
            Width           =   735
         End
         Begin VB.Label Label5 
            Caption         =   "Item 3"
            Height          =   255
            Index           =   18
            Left            =   120
            TabIndex        =   80
            Top             =   960
            Width           =   735
         End
         Begin VB.Label Label5 
            Caption         =   "Item 4"
            Height          =   255
            Index           =   17
            Left            =   120
            TabIndex        =   79
            Top             =   1200
            Width           =   735
         End
         Begin VB.Label Label5 
            Caption         =   "Item 5"
            Height          =   255
            Index           =   16
            Left            =   120
            TabIndex        =   78
            Top             =   1440
            Width           =   735
         End
         Begin VB.Label Label5 
            Caption         =   "Item 6"
            Height          =   255
            Index           =   15
            Left            =   120
            TabIndex        =   77
            Top             =   1680
            Width           =   735
         End
         Begin VB.Label Label5 
            Caption         =   "Item 7"
            Height          =   255
            Index           =   14
            Left            =   120
            TabIndex        =   76
            Top             =   1920
            Width           =   735
         End
         Begin VB.Label Label5 
            Caption         =   "Item 8"
            Height          =   255
            Index           =   13
            Left            =   120
            TabIndex        =   75
            Top             =   2160
            Width           =   735
         End
         Begin VB.Label Label5 
            Caption         =   "Item 9"
            Height          =   255
            Index           =   12
            Left            =   120
            TabIndex        =   74
            Top             =   2400
            Width           =   735
         End
         Begin VB.Label Label5 
            Caption         =   "Item 10"
            Height          =   255
            Index           =   11
            Left            =   120
            TabIndex        =   73
            Top             =   2640
            Width           =   735
         End
      End
      Begin VB.CommandButton cmdRandom 
         Caption         =   "Random"
         Height          =   255
         Index           =   1
         Left            =   2280
         TabIndex        =   22
         Top             =   3720
         Width           =   855
      End
      Begin VB.CommandButton cmdRandom 
         Caption         =   "Random"
         Height          =   255
         Index           =   0
         Left            =   1200
         TabIndex        =   11
         Top             =   3720
         Width           =   855
      End
      Begin VB.TextBox txtValue 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   9
         Left            =   2400
         TabIndex        =   21
         Text            =   "100"
         Top             =   3000
         Width           =   495
      End
      Begin VB.TextBox txtValue 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   8
         Left            =   2400
         TabIndex        =   20
         Text            =   "100"
         Top             =   2760
         Width           =   495
      End
      Begin VB.TextBox txtValue 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   7
         Left            =   2400
         TabIndex        =   19
         Text            =   "100"
         Top             =   2520
         Width           =   495
      End
      Begin VB.TextBox txtValue 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   6
         Left            =   2400
         TabIndex        =   18
         Text            =   "100"
         Top             =   2280
         Width           =   495
      End
      Begin VB.TextBox txtValue 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   5
         Left            =   2400
         TabIndex        =   17
         Text            =   "100"
         Top             =   2040
         Width           =   495
      End
      Begin VB.TextBox txtValue 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   4
         Left            =   2400
         TabIndex        =   16
         Text            =   "100"
         Top             =   1800
         Width           =   495
      End
      Begin VB.TextBox txtValue 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   3
         Left            =   2400
         TabIndex        =   15
         Text            =   "100"
         Top             =   1560
         Width           =   495
      End
      Begin VB.TextBox txtValue 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   2
         Left            =   2400
         TabIndex        =   14
         Text            =   "100"
         Top             =   1320
         Width           =   495
      End
      Begin VB.TextBox txtValue 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   1
         Left            =   2400
         TabIndex        =   13
         Text            =   "100"
         Top             =   1080
         Width           =   495
      End
      Begin VB.TextBox txtValue 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   0
         Left            =   2400
         TabIndex        =   12
         Text            =   "100"
         Top             =   840
         Width           =   495
      End
      Begin VB.TextBox txtKnapSackVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   2280
         TabIndex        =   23
         Text            =   "800"
         Top             =   4080
         Width           =   615
      End
      Begin VB.TextBox txtVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   9
         Left            =   1320
         TabIndex        =   10
         Text            =   "100"
         Top             =   3000
         Width           =   495
      End
      Begin VB.TextBox txtVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   8
         Left            =   1320
         TabIndex        =   9
         Text            =   "100"
         Top             =   2760
         Width           =   495
      End
      Begin VB.TextBox txtVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   7
         Left            =   1320
         TabIndex        =   8
         Text            =   "100"
         Top             =   2520
         Width           =   495
      End
      Begin VB.TextBox txtVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   6
         Left            =   1320
         TabIndex        =   7
         Text            =   "100"
         Top             =   2280
         Width           =   495
      End
      Begin VB.TextBox txtVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   5
         Left            =   1320
         TabIndex        =   6
         Text            =   "100"
         Top             =   2040
         Width           =   495
      End
      Begin VB.TextBox txtVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   4
         Left            =   1320
         TabIndex        =   5
         Text            =   "100"
         Top             =   1800
         Width           =   495
      End
      Begin VB.TextBox txtVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   3
         Left            =   1320
         TabIndex        =   4
         Text            =   "100"
         Top             =   1560
         Width           =   495
      End
      Begin VB.TextBox txtVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   2
         Left            =   1320
         TabIndex        =   3
         Text            =   "100"
         Top             =   1320
         Width           =   495
      End
      Begin VB.TextBox txtVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   1
         Left            =   1320
         TabIndex        =   2
         Text            =   "100"
         Top             =   1080
         Width           =   495
      End
      Begin VB.TextBox txtVolume 
         Alignment       =   1  'Right Justify
         Height          =   285
         Index           =   0
         Left            =   1320
         TabIndex        =   1
         Text            =   "100"
         Top             =   840
         Width           =   495
      End
      Begin VB.Label lblVolumeRemaining 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         Height          =   255
         Left            =   4320
         TabIndex        =   64
         Top             =   2040
         Width           =   975
      End
      Begin VB.Label Label6 
         Caption         =   "Remaining space :"
         Height          =   255
         Index           =   5
         Left            =   3600
         TabIndex        =   63
         Top             =   1800
         Width           =   1215
      End
      Begin VB.Label lblKnapsackValue 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         Height          =   255
         Left            =   4320
         TabIndex        =   62
         Top             =   2760
         Width           =   975
      End
      Begin VB.Label Label6 
         Caption         =   "Knapsack value :"
         Height          =   255
         Index           =   4
         Left            =   3600
         TabIndex        =   61
         Top             =   2520
         Width           =   1215
      End
      Begin VB.Label lblVolumeUsed 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         Height          =   255
         Left            =   4320
         TabIndex        =   60
         Top             =   1440
         Width           =   975
      End
      Begin VB.Label Label6 
         Caption         =   "Volume used :"
         Height          =   255
         Index           =   3
         Left            =   3600
         TabIndex        =   59
         Top             =   1200
         Width           =   1215
      End
      Begin VB.Label lblInKnapSack 
         Caption         =   "X"
         Height          =   255
         Index           =   9
         Left            =   3120
         TabIndex        =   58
         Top             =   3000
         Width           =   255
      End
      Begin VB.Label lblInKnapSack 
         Caption         =   "X"
         Height          =   255
         Index           =   8
         Left            =   3120
         TabIndex        =   57
         Top             =   2760
         Width           =   255
      End
      Begin VB.Label lblInKnapSack 
         Caption         =   "X"
         Height          =   255
         Index           =   7
         Left            =   3120
         TabIndex        =   56
         Top             =   2520
         Width           =   255
      End
      Begin VB.Label lblInKnapSack 
         Caption         =   "X"
         Height          =   255
         Index           =   6
         Left            =   3120
         TabIndex        =   55
         Top             =   2280
         Width           =   255
      End
      Begin VB.Label lblInKnapSack 
         Caption         =   "X"
         Height          =   255
         Index           =   5
         Left            =   3120
         TabIndex        =   54
         Top             =   2040
         Width           =   255
      End
      Begin VB.Label lblInKnapSack 
         Caption         =   "X"
         Height          =   255
         Index           =   4
         Left            =   3120
         TabIndex        =   53
         Top             =   1800
         Width           =   255
      End
      Begin VB.Label lblInKnapSack 
         Caption         =   "X"
         Height          =   255
         Index           =   3
         Left            =   3120
         TabIndex        =   52
         Top             =   1560
         Width           =   255
      End
      Begin VB.Label lblInKnapSack 
         Caption         =   "X"
         Height          =   255
         Index           =   2
         Left            =   3120
         TabIndex        =   51
         Top             =   1320
         Width           =   255
      End
      Begin VB.Label lblInKnapSack 
         Caption         =   "X"
         Height          =   255
         Index           =   1
         Left            =   3120
         TabIndex        =   50
         Top             =   1080
         Width           =   255
      End
      Begin VB.Label lblInKnapSack 
         Caption         =   "X"
         Height          =   255
         Index           =   0
         Left            =   3120
         TabIndex        =   49
         Top             =   840
         Width           =   255
      End
      Begin VB.Label Label6 
         Caption         =   "Result"
         Height          =   255
         Index           =   2
         Left            =   3120
         TabIndex        =   48
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label Label7 
         Caption         =   "(Should be smaller than total volume)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3000
         TabIndex        =   47
         Top             =   4080
         Width           =   2175
      End
      Begin VB.Label lblTot 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "1000"
         Height          =   255
         Index           =   1
         Left            =   2280
         TabIndex        =   46
         Top             =   3360
         Width           =   615
      End
      Begin VB.Label Label5 
         Caption         =   "Totals"
         Height          =   255
         Index           =   10
         Left            =   240
         TabIndex        =   45
         Top             =   3360
         Width           =   735
      End
      Begin VB.Label lblTot 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "1000"
         Height          =   255
         Index           =   0
         Left            =   1200
         TabIndex        =   44
         Top             =   3360
         Width           =   615
      End
      Begin VB.Label Label5 
         Caption         =   "Item 10"
         Height          =   255
         Index           =   9
         Left            =   240
         TabIndex        =   43
         Top             =   3000
         Width           =   735
      End
      Begin VB.Label Label5 
         Caption         =   "Item 9"
         Height          =   255
         Index           =   8
         Left            =   240
         TabIndex        =   42
         Top             =   2760
         Width           =   735
      End
      Begin VB.Label Label5 
         Caption         =   "Item 8"
         Height          =   255
         Index           =   7
         Left            =   240
         TabIndex        =   41
         Top             =   2520
         Width           =   735
      End
      Begin VB.Label Label5 
         Caption         =   "Item 7"
         Height          =   255
         Index           =   6
         Left            =   240
         TabIndex        =   40
         Top             =   2280
         Width           =   735
      End
      Begin VB.Label Label6 
         Caption         =   "Value"
         Height          =   255
         Index           =   1
         Left            =   2400
         TabIndex        =   39
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label Label6 
         Caption         =   "Volume (cost)"
         Height          =   255
         Index           =   0
         Left            =   1080
         TabIndex        =   38
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label Label5 
         Caption         =   "Item 6"
         Height          =   255
         Index           =   5
         Left            =   240
         TabIndex        =   37
         Top             =   2040
         Width           =   735
      End
      Begin VB.Label Label5 
         Caption         =   "Item 5"
         Height          =   255
         Index           =   4
         Left            =   240
         TabIndex        =   36
         Top             =   1800
         Width           =   735
      End
      Begin VB.Label Label5 
         Caption         =   "Item 4"
         Height          =   255
         Index           =   3
         Left            =   240
         TabIndex        =   35
         Top             =   1560
         Width           =   735
      End
      Begin VB.Label Label5 
         Caption         =   "Item 3"
         Height          =   255
         Index           =   2
         Left            =   240
         TabIndex        =   34
         Top             =   1320
         Width           =   735
      End
      Begin VB.Label Label5 
         Caption         =   "Item 2"
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   33
         Top             =   1080
         Width           =   735
      End
      Begin VB.Label Label5 
         Caption         =   "Item 1"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   32
         Top             =   840
         Width           =   735
      End
      Begin VB.Label Label4 
         Caption         =   "Knapsack volume"
         Height          =   255
         Left            =   240
         TabIndex        =   31
         Top             =   4080
         Width           =   1575
      End
   End
   Begin VB.Label Label11 
      Caption         =   "Normally this problem is solved using dynamic programming.  This is an example of multiple iterations for a complex problem."
      Height          =   255
      Left            =   840
      TabIndex        =   159
      Top             =   1080
      Width           =   8895
   End
   Begin VB.Label lblIteration 
      Alignment       =   1  'Right Justify
      Caption         =   "0"
      Height          =   255
      Left            =   1440
      TabIndex        =   158
      Top             =   6240
      Width           =   255
   End
   Begin VB.Label Label10 
      Caption         =   "of 5"
      Height          =   255
      Left            =   1800
      TabIndex        =   157
      Top             =   6240
      Width           =   855
   End
   Begin VB.Label Label9 
      Caption         =   "Iteration :"
      Height          =   255
      Left            =   240
      TabIndex        =   156
      Top             =   6240
      Width           =   1095
   End
   Begin VB.Line Line1 
      X1              =   9840
      X2              =   120
      Y1              =   6600
      Y2              =   6600
   End
   Begin VB.Label lblGenerations 
      Height          =   255
      Left            =   8280
      TabIndex        =   70
      Top             =   6240
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "Generations :"
      Height          =   255
      Index           =   1
      Left            =   6960
      TabIndex        =   69
      Top             =   6240
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Howmany generations"
      Height          =   255
      Left            =   3600
      TabIndex        =   68
      Top             =   6240
      Width           =   2055
   End
   Begin VB.Label Label2 
      Caption         =   "This is the 0-1 variant of the  problem. The 0-1 knapsack problem restricts the number of each kind of item to zero or one."
      Height          =   255
      Index           =   2
      Left            =   840
      TabIndex        =   67
      Top             =   840
      Width           =   9015
   End
   Begin VB.Label Label2 
      Caption         =   $"frmGenAlgKnapsack.frx":0000
      Height          =   495
      Index           =   1
      Left            =   840
      TabIndex        =   66
      Top             =   360
      Width           =   9015
   End
   Begin VB.Label Label1 
      Caption         =   "Problem"
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   65
      Top             =   120
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "The typical knapsack problem is defined as follows :"
      Height          =   255
      Index           =   0
      Left            =   840
      TabIndex        =   30
      Top             =   120
      Width           =   8895
   End
End
Attribute VB_Name = "frmGenAlgKnapsack"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim WithEvents GenAlg           As clsGeneticAlgorithm
Attribute GenAlg.VB_VarHelpID = -1

Dim blnDoLoop                   As Boolean

Dim intBestVolume               As Integer
Dim intBestValue                As Integer

Dim strBestChromosome           As String

Private Sub cmdCalculate_Click()
    '
    ' Kapsack problem
    '
    Dim lngGeneration           As Long

    Dim intIteration            As Integer
    
    
    Call ClearIterations

    cmdExit.Enabled = False
    txtGenerations.Enabled = False
    cmdGAControlPanel.Enabled = False
    cmdCalculate.Enabled = False
    cmdShowChromo.Enabled = True
    cmdStop.Enabled = True
    
    
    For intIteration = 1 To 5
    
        lblIteration.Caption = intIteration
        
        
        lblGenerations.Caption = ""

        intBestVolume = 0
        intBestValue = 0
        strBestChromosome = ""
        Call ShowResult(0)

        ' clear the GA
        Call GenAlg.Clear


        ' Start
        ' create the initial population
        '
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
    
        If blnDoLoop = False Then
            Exit For
        End If
        
        Call ShowResult(intIteration)

    Next intIteration
    
    MsgBox "Stopped"
    
    cmdExit.Enabled = True
    cmdCalculate.Enabled = True
    txtGenerations.Enabled = True
    cmdGAControlPanel.Enabled = True
    cmdShowChromo.Enabled = False
    cmdStop.Enabled = False

End Sub

Private Sub cmdexit_Click()
    
    GenAlg.Clear

    Set GenAlg = Nothing
    
    Unload Me
    
End Sub

Private Sub cmdGAControlPanel_Click()

    Load frmGenAlgControlPanel
    frmGenAlgControlPanel.ReadSettings = GenAlg
    
    frmGenAlgControlPanel.Show vbModal

End Sub

Private Sub cmdRandom_Click(Index As Integer)
    '
    ' Fill volumes and values with random numbers
    '
    Dim intX                    As Integer
    
    Randomize Timer * 2.4
    
    For intX = 0 To 9
        If Index = 0 Then
            ' volumes
            txtVolume(intX).Text = Int(Rnd * 200) + 1
        Else
            ' values
            txtValue(intX).Text = Int(Rnd * 200) + 1
        End If
    Next intX
    
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

    Call Shell("Notepad.exe " & App.Path & "\Documentation\01Knapsack.txt", vbNormalFocus)

End Sub

Private Sub Form_Load()

    Set GenAlg = New clsGeneticAlgorithm

    blnDoLoop = False

    Call GenAlg.ReadGASettings(App.Path & "\GA\knapsack.GA")
    
    Call ClearIterations
    
    Call ShowResult(0)
    
End Sub

Private Sub GenAlg_EvaluateFitness(ByVal lngIndex As Long, dblFitness As Double)
    '
    ' Calculate the fitness
    '

    Dim intX                    As Integer

    Dim lngGeneNumber           As Long

    Dim strGene                 As String

    Dim intCost                 As Integer
    Dim intValue                As Integer

    intCost = 0
    intValue = 0

    ' for each gene in a chromosome
    For intX = 0 To (GenAlg.GenesPerChromosome - 1)
        strGene = GenAlg.ShowGenestring(lngIndex, intX)
        If strGene = "1" Then
            intCost = intCost + IntNull(txtVolume(intX).Text)
            intValue = intValue + IntNull(txtValue(intX).Text)
        End If
    Next intX

    ' if the cost is bigger than the volume of the knapsack...
    If intCost > IntNull(txtKnapSackVolume.Text) Then
        ' bad chromosome
        dblFitness = 1E+32
    Else
        If intCost >= intBestVolume And intValue >= intBestValue Then

            strBestChromosome = GenAlg.ShowChromosomestring(lngIndex)
            intBestVolume = intCost
            intBestValue = intValue

            Call ShowResult(0)
        End If

        dblFitness = DblNull(lblTot(1).Caption) - DblNull(intValue) + DblNull(lblVolumeRemaining.Caption)
                     ' Maximum value       -        current value        +       space remaining
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

Private Sub txtKnapSackVolume_GotFocus()
    Call SetTextboxAsSelected(txtKnapSackVolume)
End Sub

Private Sub txtKnapSackVolume_KeyPress(KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub txtValue_Change(Index As Integer)
    lblTot(1).Caption = CalculateTots(1)
End Sub

Private Sub txtValue_GotFocus(Index As Integer)
    Call SetTextboxAsSelected(txtValue(Index))
End Sub

Private Sub txtValue_KeyPress(Index As Integer, KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Sub txtVolume_Change(Index As Integer)
    lblTot(0).Caption = CalculateTots(0)
End Sub

Private Sub txtVolume_GotFocus(Index As Integer)
    Call SetTextboxAsSelected(txtVolume(Index))
End Sub

Private Sub txtVolume_KeyPress(Index As Integer, KeyAscii As Integer)
    KeyAscii = KeyStrokeControlNumerical(KeyAscii, False, False)
End Sub

Private Function CalculateTots(ByVal intWhat As Integer) As Integer
    ' calculate the totals
    ' intWhat = 0   total volume
    ' intWhat = 1   total value
    Dim intX                    As Integer

    Dim intTot                  As Integer

    intTot = 0
    For intX = 0 To 9
        If intWhat = 0 Then
            ' volumes
            intTot = intTot + IntNull(txtVolume(intX).Text)
        Else
            ' values
            intTot = intTot + IntNull(txtValue(intX).Text)
        End If
    Next intX

    CalculateTots = intTot

End Function

Private Sub ShowResult(ByVal intIter As Integer)
    '
    ' Show the result
    '
    ' intIter = iterationnumber, used to show the data in
    ' the current or hisyory-panel
    '
    Dim intX                    As Integer
    Dim intY                    As Integer
    Dim intCost                 As Integer
    Dim intValue                As Integer

    intCost = 0
    intValue = 0

    For intX = 1 To 10
        Select Case intIter
            Case 0
                ' current
                intY = 0 ' Not applicable
                
            Case 1
                intY = 0
            
            Case 2
                intY = 10
            
            Case 3
                intY = 20
            
            Case 4
                intY = 30
            
            Case 5
                intY = 40
            
        End Select
        
        If intIter = 0 Then
            If Mid$(strBestChromosome, intX, 1) = "1" Then
                lblInKnapSack(intX - 1).Caption = "X"
                intCost = intCost + IntNull(txtVolume(intX - 1).Text)
                intValue = intValue + IntNull(txtValue(intX - 1).Text)
            Else
                lblInKnapSack(intX - 1).Caption = ""
            End If
        Else
            If Mid$(strBestChromosome, intX, 1) = "1" Then
                lblIterResult(intY + intX - 1).Caption = "X"
                intCost = intCost + IntNull(txtVolume(intX - 1).Text)
                intValue = intValue + IntNull(txtValue(intX - 1).Text)
            Else
                lblIterResult(intY + intX - 1).Caption = ""
            End If
        End If
        
    Next intX

    Select Case intIter
        Case 0
            ' current
            lblVolumeUsed.Caption = intCost
            lblKnapsackValue.Caption = intValue
            lblVolumeRemaining.Caption = IntNull(txtKnapSackVolume.Text) - intCost
            
        Case Else
            lblItVolume(intIter - 1).Caption = intCost
            lblItValue(intIter - 1).Caption = intValue
            lblItRemain(intIter - 1).Caption = IntNull(txtKnapSackVolume.Text) - intCost
        
    End Select
    
End Sub

Private Sub ClearIterations()
    '
    ' Empties the history-panel
    '
    Dim intX                    As Integer
    
    lblIteration.Caption = 0
    
    For intX = 0 To 49
        lblIterResult(intX).Caption = ""
    Next intX

    For intX = 0 To 4
        lblItVolume(intX).Caption = ""
        lblItRemain(intX).Caption = ""
        lblItValue(intX).Caption = ""
    Next intX

End Sub
