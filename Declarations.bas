Attribute VB_Name = "Declarations"
Option Explicit

'
' The datatypes necessary for the Genetic Algotithm class
'

Public Type GeneIndividualType
    GeneString                  As String
    GeneLong                    As Long
    GeneDouble                  As Double
End Type

' The type that holds the chromosome
Public Type ChromosomeindividualType
    Genes()                     As GeneIndividualType
    Fitness                     As Double ' The Fitness score for this chromosome
    PiePieceStart               As Double ' start and end piece of the pie needed
    PiePieceEnd                 As Double ' for the wheel
    RecalculateFitness          As Boolean ' to win time, do not recalculate a fitness if the chromosome hasn't changed
End Type

' Edges for the nodemap - edge recombination
Public Type NodemapEdgesType
    edge                        As String
    edgeHeaderIndex             As Integer
End Type

' Nodemap for edge recombination
Public Type NodemapEdgeRecombType
    HeaderElement               As String   ' header element
    Edges()                     As NodemapEdgesType
    UboundEdges                 As Integer  ' ubound for edges-array (from 0 to (Howmanyedges - 1))
End Type

Public Type StatisticsType
    LowestFitness               As Double   ' Lowest fitness (best) in population
    HighestFitness              As Double   ' Highest fitness (worst) in population
    StandardDeviation           As Double   ' Std.Dev from the fitnesses
    SocialDivercity             As Long     ' Howmany inuque fitness-scores are there
    SelectionMethod             As Integer  ' The selectionmethod used
    RouletteWheelOverflow       As Boolean  ' If selection is RW, has it been changed to Rank ?
    MutationRate                As Double   ' what was the actual mutationrate
    SocialDisasterGenCounter    As Long     ' Social disaster generation counter
    SocialDisasterOccured       As Boolean  ' has a social disaster occured in this generation
    BestChromosome              As String   ' the best chromosome in this generation, all genes
                                            ' are in stringformat with a space in between them
End Type


'
' Enumerations
'


' The different encodingtypes
Public Enum GAEncodingType
    GAEncodingBinary = 1        ' Binary strings
    GAEncodingAlphabetic = 2    ' Alphabetic characters
    GAEncodingLongNbr = 3       ' long numbers
    GAEncodingDouble = 4        ' Double numbers (real numbers)
End Enum

' The possible selectionmethods
Public Enum GASelectionMethod
    GASelectRouletteWheel = 1   ' Roulette wheel
    GASelectTournament = 2      ' Tournament
    GASelectRank = 3            ' Rank Selection
End Enum

' Reproduction - more specific which chromosome will be replaced by new offspring
Public Enum GAReproductionType
    GAReproductionReplaceWeakest = 1 ' replace weakest chromosomes
    GAReproductionReplaceRandom = 2  ' replace random chromosomes
    GAReproductionReplaceParents = 3 ' offspring will replace parents
End Enum

' MutationRate
Public Enum GAMutationType
    GAMutationRateFixed = 1     ' Mutationrate is fixed and doesn't change
    GAMutationRateAdaptive = 2  ' Mutationrate can change during calculation
End Enum

' Crossovertype
Public Enum GACrossoverType
    GACrossoverOnePoint = 1     ' one point crossover
    GACrossoverTwoPoint = 2     ' two point crossover
    GACrossoverUniform = 3      ' uniform crossover
    GACrossoverHalfUniform = 4  ' half uniform crossover
    GACrossoverEdgeRecombination = 5  ' Edge Recombination operator
End Enum

' Social Disaster
Public Enum GASocialDisasterType
    GASocialDisasterJudgementDay = 1 ' judgement day. keep best chromosome, sacrify the rest
    GASocialDisasterPacking = 2      ' packing. Keep best of same group, replace the rest
End Enum

' Origin for new random chromosome
Public Enum GANewChromosomeOriginType   ' When Newchromosome-event is fired, an integer from this
    GANewChromosomeCreatePopulation = 1 ' type is in the arguments. Usefull when co-evolution is
    GANewChromosomeROG = 2              ' used, so that the main app. knows when not to grab chromos
    GANewChromosomeSocialDisaster = 3   ' from other GA's (not during createpopulation)
End Enum


'
' Global variables
'

Global strCurrentsystemDecimalSeparator As String ' Used in KeyStrokeControlNumerical and ConvertCommaToSystemdecimalseparator
                                                  ' and set in the class-ibitialize of the genetic class
                                                  ' this variable holds the systemdecimalsymbol as
                                                  ' set in the windows localization options.
                                                  ' this is to avoid localization problems ( comma symbol being ','
                                                  ' in my country (Belgium) while many other countries use it as
                                                  ' thousand separator with '.' being the comma symbol )
                                                  ' when loading GA-files.

