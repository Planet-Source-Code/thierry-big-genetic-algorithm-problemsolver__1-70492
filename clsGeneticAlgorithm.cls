VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsGeneticAlgorithm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' =====================================
'
'   Genetic Algorithm class
'
'        By Thierry Van Mol
'
'   First public release
'   version 1.0.0
'   2007 - 2008
'   email : thierry.van.mol@hotmail.com
'
' =====================================



'
' Constants
' +++++++++++++++++++++++++++++++++++++++++++++++++++

' Version
Private Const cVersion = "1.0.0"

' Maximum times to spin the roulettewheel before trying Rank
Private Const cRouletteWheelSpinMax As Integer = 3  ' when spinning the roulettewheel, a check is done to ensure both
                                                    ' chromosomes are different (not the value, but the index).
                                                    ' This constant is the number of times to spin the wheel
                                                    ' before jumping to Rank selection method

Private Const cCrossoverUniform As Double = 0.5     ' Probability of a swap in uniform crossover
                                                    ' 0.5 = 50% chance the bit will be swapped
                                                    
Private Const cLongMaxLength As Integer = 11        ' Maximum length of a long, used to convert a
                                                    ' long to a string. Range is -2,147,483,648 to 2,147,483,647
                                                    ' so (not counting the thousand separator)
                                                    ' maximum number of digits  : 10
                                                    ' eventual minus sign       :  1
                                                    ' 10 + 1                    = 11
                                                    '
                                                    ' However in order to maximize the functionality
                                                    ' of the GA, the length to use is calculated and
                                                    ' filled in mintLongActualLength
                                                    
Private Const cDoubleMaxLength As Integer = 22      ' Maximum length of a double number, used to convert
                                                    ' a double to a string
                                                    ' range is -1.79769313486231E308 to -4.94065645841247E-324 for negative
                                                    ' values; 4.94065645841247E-324 to 1.79769313486232E308 for positive values
                                                    ' maximum accuracy of double : 15 digits
                                                    ' place for the decimal point:  1
                                                    ' place for negative sign    :  1
                                                    ' place for 'E' character    :  1
                                                    ' place for negative power   :  1
                                                    ' maximum power              :  3 digits
                                                    ' 15 + 1 + 1 + 1 + 1 + 3     = 22
                                                    '
                                                    ' However in order to maximize the functionality
                                                    ' of the GA, the length to use is calculated and
                                                    ' filled in mintDoubleActualLength

'
' Events definition
' ++++++++++++++++++++++++++++++++++++++++++++++++++

' New Gene event
Public Event NewGeneString(ByRef strGene As String)

Public Event NewGeneLong(ByRef lngGene As Long)

Public Event NewGeneDouble(ByRef dblGene As Double)

' Fitness event
Public Event EvaluateFitness(ByVal lngIndex As Long, ByRef dblFitness As Double)

' New chromosome event
Public Event NewChromosome(ByRef NewStringGenes() As String, ByRef NewLongGenes() As Long, ByRef NewDoubleGenes() As Double, ByVal intOrigin As GANewChromosomeOriginType)

' Error
Public Event GAError(ByVal ErrorCode As Long, ByVal ErrorDescription As String)



'
' Class variables
' used with properties
' +++++++++++++++++++++++++++++++++++++++++++++++++++

Private mGeneration             As Long     ' the generation counter (set to 1 at CREATEPOPULATION
                                            ' and incremented during REPRODUCTION)

Private Chromosome()            As ChromosomeindividualType
                                            ' The chromosome...

Private mChromosomeType         As Integer  ' the type of chromosome we are going
                                            ' to use. defined in GAEncodingType
                                            ' 1 = binary string
                                            ' 2 = Alphabetical
                                            ' 3 = long numbers
                                            ' 4 = Double numbers

Private mGenesPerChromosome     As Integer  ' howmany genes are there in a chromosome

Private mBinaryGeneLength       As Integer  ' how long is one gene (howmany characters can
                                            ' a binary gene be)
                                            ' when encodingtype = binary

Private mAlphabeticGeneLength   As Integer  ' how long is one gene (howmany characters can
                                            ' an alphabetic gene be)
                                            ' when encodingtype = alphabetical

Private mLongGeneMaxValue       As Long     ' what is the maximumvalue of a long numerical gene
                                            ' when encodingtype = long numbers

Private mLongGeneMinValue       As Long     ' what is the minimumvalue of a long numerical gene
                                            ' when encodingtype = long numbers

Private mDoubleGeneMinValue     As Double   ' what is the minimumvalue of a double numerical gene
                                            ' when encodingtype = double numbers

Private mDoubleGeneMaxValue     As Double   ' what is the maximumvalue of a double numerical gene
                                            ' when encodingtype = double numbers

Private mSelectionMethod        As Integer  ' the selectionmethod used during the Selection process
                                            ' see the GASelectionMethod enumeration
                                            ' Can be Range, Roulette wheel or Tournament

Private mTournamentSize         As Long     ' the size of the selection pool of a Tournament during
                                            ' Tournament selection

Private mCrossoverRate          As Double   ' the corssoverrate

Private mMutationRate           As Double   ' the mutationrate - for fixed mutation
                                            ' or starting value for adaptive mutationrate

Private mActualMutationRate     As Double   ' the actual mutationrate to use
                                            ' if fixed it's the same as mMutationRate
                                            ' if AMR then this value changes by 0.01

Private mMutationBitlikeLongDouble As Boolean ' For long/double encoding only. And only if NOT full gene
                                            ' mutation !
                                            ' If FALSE, a small value will be randomly added / subtracted from
                                            ' the gene-value
                                            ' If TRUE, normal element-like mutation (just like binary encoding)
                                            ' will be used

Private mMutationBitlikePercentage As Double ' See mMutationBitlikeLongDouble
                                            ' This is the percentage of the maximum value for a gene.
                                            ' The random value to be added or subtracted will lie within
                                            ' this percentage's range.

Private mReproductionMethod     As Integer  ' the reproductionmethod used
                                            ' see the GAReproductionType enumeration
                                            ' Can be weakest, random or parents
                                            
Private mCrossoverFullGenes     As Boolean  ' If TRUE the crossover happens on a full gene
                                            ' if FALSE corssover can happen anywhere
                                            ' in the chromosome

Private mRandomOffspringGeneration As Boolean ' If TRUE a test is done before crossover to check
                                              ' that both selected chromosomes have different
                                              ' genetic material. If they are the same one of them
                                              ' is replaced by a new random chromosome

Private mCrossoverMethod        As Integer  ' The crossover technique to use
                                            ' one point, two point, uniform or half uniform
                                            ' see GACrossoverType

Private mMutateFullGenes        As Boolean  ' If TRUE the mutation happens on a full gene
                                            ' if FALSE mutation can happen anywhere
                                            ' in the chromosome

Private mMutationMethod         As Integer  ' can be fixed or adaptive
                                            ' See GAMutationType
                                            ' Fixed : the rate in mMutationrate is always taken
                                            ' Adaptive : When the standard deviation of the fitness
                                            ' values stays a number of generations the same (set in
                                            ' mAMRGenerations) then the mutatiorate is increased
                                            ' by 0.01 with a maximum of 1.0
                                            ' If the standard deviation of the fitness values is
                                            ' different for the set number of generations, it is
                                            ' decreased by 0.01, with mMutationRate as minimum

Private mAMRGenerations         As Long     ' number of generations that the standard deviation
                                            ' has to be the same before mutationrate increase
                                            ' for AMR (or different for a decrease)
                                            
Private mSocDisGeneticDiv       As Double   ' Social disaster genetic diversity percentage

Private mSocDisMethod           As Integer  ' Social disaster method (see GASocialDisasterType)
                                            ' Can be packing or Judgement day
                                            
Private mSocDisGenerations      As Long     ' the amount of generations between
                                            ' each check if a social disaster
                                            ' should occur

Private mDescription            As String   ' small description for these settings

Private mPopulationSize         As Long     ' the populationsize as set in the GA control panel

Private mlngSelectedIndex1      As Long     ' The indexes of the two selected chromosomes for
Private mlngSelectedIndex2      As Long     ' reproduction

Private mAMRCounter             As Long     ' counter for AMR when std.dev. is the same
Private mAMRCounterDiff         As Long     ' counter for AMR when std.dev. is different
Private mAMRFitnessStdDev       As Double   ' the value of the std.dev. for AMR


' Counters
Private mCrossoverCounter       As Long     ' counters...just to count howmany times
Private mMutationCounter        As Long     ' something occurs...
Private mRandomOffspringCounter As Long     '
Private mSocialDisasterCounter  As Long     '


' Statistics
Private mblnKeepStatistics      As Boolean  ' keep the statistics or not
Private mStatistics()           As StatisticsType ' the array



'
' Class variables
' used internally
' ++++++++++++++++++++++++++++++++++++++++++++++++

Private mblnSorted              As Boolean  ' = TRUE if the chromosome array is sorted by fitness
                                            ' = FALSE when the array has to be sorted because a chromosome
                                            '   has changed...
                                            ' This sort is necessary to determine the best (lowest) and worst
                                            ' (highest) chromosomes (fitness wise).
                                            
Private mblnAllFitnessCalculated As Boolean ' = TRUE all fitnesses have been calculated
                                            ' = FALSE at least one fitness must be recalculated
                                            
Private mSocDisGenCounter       As Long     ' counter for social disaster generations

Private blnCallFromEvaluate     As Boolean  ' used in EVALUATE
                                            ' if a social disaster occured the population has to be
                                            ' re-evaluated. The sub evaluate calls itself
                                            ' but if the user has set the generation-counter
                                            ' for social disasters to 1, an endless loop (not exactly
                                            ' endless because an out-of-stack error will end it eventually)
                                            ' occurs. This boolean makes it possible to jump
                                            ' out
                                                  
Private mintLongActualLength    As Integer  ' The calculated actual length of a long
                                            ' see the constant cLongMaxLength
                                                  
Private mintDoubleActualLength  As Integer  ' The calculated actual length of a double
                                            ' see the constant cDoubleMaxLength
                                                  



' -----------------------------------------------------------------
' Properties
' -----------------------------------------------------------------

' howmany chromosomes are there
Public Property Get PopulationCount() As Long
    PopulationCount = LngNull(UBound(Chromosome())) + 1
End Property

' the type of chromosome used, defined in GAEncodingType
Public Property Get ChromosomeType() As Integer
    ChromosomeType = mChromosomeType
End Property

Public Property Let ChromosomeType(ByVal vNewValue As Integer)
    mChromosomeType = vNewValue
End Property

' howmany genes are there in a chromosome
Public Property Get GenesPerChromosome() As Integer
    GenesPerChromosome = mGenesPerChromosome
End Property

Public Property Let GenesPerChromosome(ByVal vNewValue As Integer)
    mGenesPerChromosome = vNewValue
End Property

' howmany characters is one BINARY gene (when encodingtype = binary)
Public Property Get BinaryGeneLength() As Integer
    BinaryGeneLength = mBinaryGeneLength
End Property

Public Property Let BinaryGeneLength(ByVal vNewValue As Integer)
    mBinaryGeneLength = vNewValue
End Property

' howmany characters is one ALPHABETIC gene (when encodingtype = alphabetic)
Public Property Get AplhabeticGeneLength() As Integer
    AplhabeticGeneLength = mAlphabeticGeneLength
End Property

Public Property Let AplhabeticGeneLength(ByVal vNewValue As Integer)
    mAlphabeticGeneLength = vNewValue
End Property

' what is the maximumvalue of a long numerical gene (when encodingtype = long numbers)
Public Property Get LongGeneMaxValue() As Long
    LongGeneMaxValue = mLongGeneMaxValue
End Property

Public Property Let LongGeneMaxValue(ByVal vNewValue As Long)
    mLongGeneMaxValue = vNewValue
End Property

' what is the minimumvalue of a long numerical gene (when encodingtype = long numbers)
Public Property Get LongGeneMinValue() As Long
    LongGeneMinValue = mLongGeneMinValue
End Property

Public Property Let LongGeneMinValue(ByVal vNewValue As Long)
    mLongGeneMinValue = vNewValue
End Property

' what is the minimumvalue of a double numerical gene (when encodingtype = double numbers)
Public Property Get DoubleGeneMinValue() As Double
    DoubleGeneMinValue = mDoubleGeneMinValue
End Property

Public Property Let DoubleGeneMinValue(ByVal vNewValue As Double)
    mDoubleGeneMinValue = vNewValue
End Property

' what is the maximumvalue of a double numerical gene (when encodingtype = double numbers)
Public Property Get DoubleGeneMaxValue() As Double
    DoubleGeneMaxValue = mDoubleGeneMaxValue
End Property

Public Property Let DoubleGeneMaxValue(ByVal vNewValue As Double)
    mDoubleGeneMaxValue = vNewValue
End Property

' Selectionmethod. Range, roulette wheel or tournament
Public Property Get SelectionMethod() As Integer
    SelectionMethod = mSelectionMethod
End Property

Public Property Let SelectionMethod(ByVal vNewValue As Integer)
    mSelectionMethod = vNewValue
End Property

' the size of the selection pool for tournament selection
Public Property Get TournamentSize() As Long
    TournamentSize = mTournamentSize
End Property

Public Property Let TournamentSize(ByVal vNewValue As Long)
    mTournamentSize = vNewValue
End Property

' the highest Fitness score in the current population = WORST
Public Property Get FitnessHighest() As Double
    If mblnSorted = False Then
        Call QuickSortFitness(0, (PopulationCount - 1))
    End If
    FitnessHighest = Chromosome(PopulationCount - 1).Fitness
End Property

' the lowest Fitness score in the current population = BEST
Public Property Get FitnessLowest() As Double
    If mblnSorted = False Then
        Call QuickSortFitness(0, (PopulationCount - 1))
    End If
    FitnessLowest = Chromosome(0).Fitness
End Property

' the sum of all Fitness scores in the current population
Public Property Get FitnessSum() As Double
    
    Dim lngloop                 As Long

    Dim dblHelp                 As Double
    
    dblHelp = 0

    For lngloop = 0 To (PopulationCount - 1)
        dblHelp = dblHelp + Abs(Chromosome(lngloop).Fitness)
    Next lngloop

    FitnessSum = dblHelp

End Property

' The index of the first selected chromosome for reproduction
Public Property Get SelectedChromosomeIndex1() As Long
    SelectedChromosomeIndex1 = mlngSelectedIndex1
End Property

Public Property Let SelectedChromosomeIndex1(ByVal vNewValue As Long)
    mlngSelectedIndex1 = vNewValue
End Property

' The index of the second selected chromosome for reproduction
Public Property Get SelectedChromosomeIndex2() As Long
    SelectedChromosomeIndex2 = mlngSelectedIndex2
End Property

Public Property Let SelectedChromosomeIndex2(ByVal vNewValue As Long)
    mlngSelectedIndex2 = vNewValue
End Property

' the corssoverrate
Public Property Get CrossoverRate() As Double
    CrossoverRate = mCrossoverRate
End Property

Public Property Let CrossoverRate(ByVal vNewValue As Double)
    mCrossoverRate = vNewValue
End Property

' the mutationrate - for fixed or startvalue for adaptive
Public Property Get MutationRate() As Double
    MutationRate = mMutationRate
End Property

Public Property Let MutationRate(ByVal vNewValue As Double)
    mMutationRate = vNewValue
End Property

' Reproductionmethod. replace weakest, replace random or replace parents
Public Property Get ReproductionMethod() As Integer
    ReproductionMethod = mReproductionMethod
End Property

Public Property Let ReproductionMethod(ByVal vNewValue As Integer)
    mReproductionMethod = vNewValue
End Property

' Do we crossover on a full gene or anywhere in the chromosome
Public Property Let CrossoverFullGene(ByVal vNewValue As Boolean)
    mCrossoverFullGenes = vNewValue
End Property

Public Property Get CrossoverFullGene() As Boolean
    CrossoverFullGene = mCrossoverFullGenes
End Property

' Test both chromos before crossover for equality, if equal replace one
Public Property Let RandomOffspringGeneration(ByVal vNewValue As Boolean)
    mRandomOffspringGeneration = vNewValue
End Property

Public Property Get RandomOffspringGeneration() As Boolean
    RandomOffspringGeneration = mRandomOffspringGeneration
End Property

' Crossovermethod. one or two point, uniform or half uniform
Public Property Get CrossoverMethod() As Integer
    CrossoverMethod = mCrossoverMethod
End Property

Public Property Let CrossoverMethod(ByVal vNewValue As Integer)
    mCrossoverMethod = vNewValue
End Property

' Do we mutate on a full gene or anywhere in the chromosome
Public Property Let MutateFullGene(ByVal vNewValue As Boolean)
    mMutateFullGenes = vNewValue
End Property

Public Property Get MutateFullGene() As Boolean
    MutateFullGene = mMutateFullGenes
End Property

Public Property Get MeanAverage() As Double
    If PopulationCount <> 0 Then
        MeanAverage = FitnessSum / PopulationCount
    Else
        MeanAverage = 0
    End If
End Property

' the mutationmethod, fixed or adaptive
Public Property Get MutationMethod() As Integer
    MutationMethod = mMutationMethod
End Property

Public Property Let MutationMethod(ByVal vNewValue As Integer)
    mMutationMethod = vNewValue
End Property

' the actual mutationrate - for fixed or startvalue for adaptive
Public Property Get ActualMutationRate() As Double
    ActualMutationRate = mActualMutationRate
End Property

' AMR generations
Public Property Get AMRGenerations() As Long
    AMRGenerations = mAMRGenerations
End Property

Public Property Let AMRGenerations(ByVal vNewValue As Long)
    mAMRGenerations = vNewValue
End Property

' Long/double encoding bitlike mutation or not
Public Property Let MutationBitlikeLongDouble(ByVal vNewValue As Boolean)
    mMutationBitlikeLongDouble = vNewValue
End Property

Public Property Get MutationBitlikeLongDouble() As Boolean
    MutationBitlikeLongDouble = mMutationBitlikeLongDouble
End Property

' Long/Double bitlike mutation
Public Property Get MutationBitlikePercentage() As Double
    MutationBitlikePercentage = mMutationBitlikePercentage
End Property

Public Property Let MutationBitlikePercentage(ByVal vNewValue As Double)
    mMutationBitlikePercentage = vNewValue
End Property

' Social disaster genetic diversity
Public Property Get SocialDisasterDiversity() As Double
    SocialDisasterDiversity = mSocDisGeneticDiv
End Property

Public Property Let SocialDisasterDiversity(ByVal vNewValue As Double)
    mSocDisGeneticDiv = vNewValue
End Property

' Social disaster method
Public Property Get SocialDisasterMethod() As Integer
    SocialDisasterMethod = mSocDisMethod
End Property

Public Property Let SocialDisasterMethod(ByVal vNewValue As Integer)
    mSocDisMethod = vNewValue
End Property

' the amount of generations between each check for an eventual social disaster
Public Property Get SocialDisasterGenerations() As Long
    SocialDisasterGenerations = mSocDisGenerations
End Property

Public Property Let SocialDisasterGenerations(ByVal vNewValue As Long)
    mSocDisGenerations = vNewValue
End Property

' Description
Public Property Get Description() As String
    Description = mDescription
End Property

Public Property Let Description(ByVal vNewValue As String)
    mDescription = vNewValue
End Property

' Version
Public Property Get Version() As String
    Version = cVersion
End Property

' PopulationSize as set in the GA control panel
Public Property Get PopulationSize() As Long
    PopulationSize = mPopulationSize
End Property

Public Property Let PopulationSize(ByVal vNewValue As Long)
    mPopulationSize = vNewValue
End Property

'
' -----------------------------------------------------

' Counters
Public Property Get CounterCrossovers() As Long
    CounterCrossovers = mCrossoverCounter
End Property

Public Property Get CounterMutations() As Long
    CounterMutations = mMutationCounter
End Property

Public Property Get CounterRandomOffsprings() As Long
    CounterRandomOffsprings = mRandomOffspringCounter
End Property

Public Property Get CounterDisasters() As Long
    CounterDisasters = mSocialDisasterCounter
End Property

' Generation
Public Property Get Generation() As Long
    Generation = mGeneration
End Property

' Keep statistics info
Public Property Let KeepStatistics(ByVal vNewValue As Boolean)
    mblnKeepStatistics = vNewValue
End Property

Public Property Get KeepStatistics() As Boolean
    KeepStatistics = mblnKeepStatistics
End Property

' Statistics - lowest fitness
Public Property Get StatisticsLowestFitness(ByVal lngGeneration As Long) As Double
    StatisticsLowestFitness = mStatistics(lngGeneration).LowestFitness
End Property

' Statistics - Highest fitness
Public Property Get StatisticsHighestFitness(ByVal lngGeneration As Long) As Double
    StatisticsHighestFitness = mStatistics(lngGeneration).HighestFitness
End Property

' Statistics - Highest fitness
Public Property Get StatisticsStandardDeviation(ByVal lngGeneration As Long) As Double
    StatisticsStandardDeviation = mStatistics(lngGeneration).StandardDeviation
End Property

' Statistics - Social diverscity
Public Property Get StatisticsSocialDivercity(ByVal lngGeneration As Long) As Long
    StatisticsSocialDivercity = mStatistics(lngGeneration).SocialDivercity
End Property

' Statistics - Selection method
Public Property Get StatisticsSelectionMethod(ByVal lngGeneration As Long) As Integer
    StatisticsSelectionMethod = mStatistics(lngGeneration).SelectionMethod
End Property

' Statistics - RouletteWheelOverflow
Public Property Get StatisticsRouletteWheelOverflow(ByVal lngGeneration As Long) As Boolean
    StatisticsRouletteWheelOverflow = mStatistics(lngGeneration).RouletteWheelOverflow
End Property

' Statistics - MutationRate
Public Property Get StatisticsMutationRate(ByVal lngGeneration As Long) As Double
    StatisticsMutationRate = mStatistics(lngGeneration).MutationRate
End Property

' Statistics - Disaster generation counter
Public Property Get StatisticsDisasterGenerationCounter(ByVal lngGeneration As Long) As Long
    StatisticsDisasterGenerationCounter = mStatistics(lngGeneration).SocialDisasterGenCounter
End Property

' Statistics - DisasterOccured
Public Property Get StatisticsDisasterOccured(ByVal lngGeneration As Long) As Boolean
    StatisticsDisasterOccured = mStatistics(lngGeneration).SocialDisasterOccured
End Property

' Statistics - Bestchromosome
Public Property Get StatisticsBestChromosome(ByVal lngGeneration As Long) As String
    StatisticsBestChromosome = mStatistics(lngGeneration).BestChromosome
End Property



' -----------------------------------------------------------------
' Class Procedures
' -----------------------------------------------------------------


Private Sub Class_Initialize()
    '
    ' What is the system decimal-symbol
    ' Used for localization on non-english (or different country-settings)
    ' OS versions. The decimal-point-symbol can clash with the VB comma-symbol
    ' leading to errors when dealing with doubles.
    strCurrentsystemDecimalSeparator = Trim$(Format$("0.00", "#.##"))
    
    mGeneration = 0
    blnCallFromEvaluate = False
    
    
    ' default values for the properties
    ' ---------------------------------
    
    ' Default selectionmethod = Rank
    SelectionMethod = GASelectRank

    ' default reproductionmethod = replace weakest
    ReproductionMethod = GAReproductionReplaceWeakest

    ' default CrossoverRate
    CrossoverRate = 0.7
    
    ' default Mutationrate
    MutationRate = 0.05
    
    ' Tournament size
    TournamentSize = 5
    
    ' crossoverfullegene
    CrossoverFullGene = False
    
    ' Crossovermethode
    CrossoverMethod = GACrossoverOnePoint
    
    ' RandomOffspringGeneration
    RandomOffspringGeneration = True
    
    ' mutatefullgene
    MutateFullGene = False
    
    ' MutationMethod
    MutationMethod = GAMutationRateFixed
    
    ' AMR generations
    AMRGenerations = 10
    
    ' bitlike mutation for long or double
    MutationBitlikeLongDouble = False
    
    ' percentage af maximum for the random value for bitlike mutation
    MutationBitlikePercentage = 10
    
    ' Social desaster
    SocialDisasterDiversity = 0
    
    ' social disaster method
    SocialDisasterMethod = GASocialDisasterJudgementDay
    
    ' amount of generations between each social disaster check
    SocialDisasterGenerations = 25
    
    ' nothing is calculated
    mblnAllFitnessCalculated = False
    
    ' nothing is sorted
    mblnSorted = False
    
    ' do not keep statistics
    mblnKeepStatistics = False
    
    ' Clear the counters
    Call ClearCounters
    
End Sub

Public Sub CREATEPOPULATION(ByVal lngPopulationTotal As Long)
    '
    ' creates the initial population
    ' lngPopulationTotal is the amount of chromosomes wanted
    '
    On Local Error GoTo errorhandler
    
    Dim lngX                    As Long
    
    ' clear the chromosome array
    Call Clear
    
    ' create population
    For lngX = 0 To (lngPopulationTotal - 1)
        Call AddChromosome(lngX)
    Next lngX
    
    ' reset counters
    Call ClearCounters
    
    ' set the actual mutationrate to the fixed mutationrate
    mActualMutationRate = mMutationRate
    
    ' set generation to 1
    mGeneration = 1
    
    ' social disaster generation counter
    mSocDisGenCounter = 0
    
Exit Sub

errorhandler:

    RaiseEvent GAError(LngNull(Err.Number), "Error in CREATEPOPULATION ! " & Err.Description)
    
End Sub

Public Sub Clear()
    '
    ' Clear the chromosome array
    '
    ReDim Chromosome(0)

    mblnSorted = False
    mblnAllFitnessCalculated = False
    
End Sub

Public Sub ClearAllFitness()
    '
    ' sets all the chromosomes' fitnesses to a high number
    ' this forces all chromosomes to be re-evaluated the next evaluation
    ' sequence.
    ' NOT called from within the class, must be called
    ' from the main generation-loop should it be necessary
    
    Dim lngloop                 As Long


    For lngloop = 0 To (PopulationCount - 1)
        Chromosome(lngloop).Fitness = 1E+300
        Chromosome(lngloop).RecalculateFitness = True
    Next lngloop
    
    
End Sub

Private Function AddChromosome(ByVal lngChromoNbr As Long)
    '
    ' Add a new individual chromosome to the population
    ' Called from CreatePopulation
    '
    On Local Error GoTo errorhandler
    
    
    Dim NewChromosome           As ChromosomeindividualType
    
    ReDim Preserve Chromosome(lngChromoNbr)

    NewChromosome = CreateRandomChromosome(1)
    
    ReDim Preserve Chromosome(lngChromoNbr)
    
    Chromosome(lngChromoNbr) = NewChromosome
    
    ' this chromosome did not yet went through the fitness test,
    ' set it's fitness to a very high ( = bad) number
    Chromosome(lngChromoNbr).Fitness = 1E+300
    Chromosome(lngChromoNbr).RecalculateFitness = True
    
    mblnAllFitnessCalculated = False
    mblnSorted = False
    
Exit Function

errorhandler:

    RaiseEvent GAError(LngNull(Err.Number), "Error in AddChromosome ! " & Err.Description)
    
End Function

Private Function CreateRandomChromosome(ByVal intOrigin As Integer) As ChromosomeindividualType
    '
    ' Returns a random chromosome
    '
    ' intOrigin : from where is this function called
    '     1     Createpoplation                         GANewChromosomeCreatePopulation
    '     2     Selection (Random offspring Generation) GANewChromosomeROG
    '     3     Social disaster                         GANewChromosomeSocialDisaster

    Dim intGeneCounter          As Integer
    
    Dim strNewGenes()           As String
    Dim lngNewGenes()           As Long
    Dim dblNewGenes()           As Double
    
    
    
    ReDim strNewGenes(0)
    ReDim lngNewGenes(0)
    ReDim dblNewGenes(0)
    
    
    For intGeneCounter = 0 To (mGenesPerChromosome - 1)
        
        Select Case mChromosomeType
            Case GAEncodingBinary  ' Binarystring
                ReDim Preserve strNewGenes(intGeneCounter)
                strNewGenes(intGeneCounter) = RandomBinaryGene
                
            Case GAEncodingAlphabetic ' alphabetic characters
                ReDim Preserve strNewGenes(intGeneCounter)
                strNewGenes(intGeneCounter) = RandomAlphabeticGene
                
            Case GAEncodingLongNbr  ' Long numbers
                ReDim Preserve lngNewGenes(intGeneCounter)
                lngNewGenes(intGeneCounter) = RandomLongGene
                
            Case GAEncodingDouble   ' Double numbers (real numbers)
                ReDim Preserve dblNewGenes(intGeneCounter)
                dblNewGenes(intGeneCounter) = RandomDoubleGene
                
        End Select
    
    Next intGeneCounter
    
    ' raise the newchromosome-event, allowing the main usercode
    ' to override the newly created chromosome and use a custom-made
    ' one
    RaiseEvent NewChromosome(strNewGenes(), lngNewGenes(), dblNewGenes(), intOrigin)

    
    ' insert the new chromosome in the array
    ReDim CreateRandomChromosome.Genes(0)
    For intGeneCounter = 0 To (mGenesPerChromosome - 1)
        ReDim Preserve CreateRandomChromosome.Genes(intGeneCounter)
        Select Case mChromosomeType
            Case GAEncodingBinary  ' Binarystring
                CreateRandomChromosome.Genes(intGeneCounter).GeneString = strNewGenes(intGeneCounter)
                
            Case GAEncodingAlphabetic ' alphabetic characters
                CreateRandomChromosome.Genes(intGeneCounter).GeneString = strNewGenes(intGeneCounter)
                
            Case GAEncodingLongNbr  ' Long numbers
                CreateRandomChromosome.Genes(intGeneCounter).GeneLong = lngNewGenes(intGeneCounter)
                
            Case GAEncodingDouble   ' Double numbers (real numbers)
                CreateRandomChromosome.Genes(intGeneCounter).GeneDouble = dblNewGenes(intGeneCounter)
                
        End Select
    Next intGeneCounter
    
    CreateRandomChromosome.RecalculateFitness = True
    
End Function

Private Function RandomBinaryGene() As String
    '
    ' Returns a random binary gene
    '
    Dim strGene                 As String
    
    Dim intBitCounter           As Integer
    
    strGene = Space$(mBinaryGeneLength)
    Randomize (Sin(Timer) * Timer - Rnd * Timer)
    For intBitCounter = 1 To mBinaryGeneLength
        ' randomize
        If Rnd < 0.5 Then
            Mid$(strGene, intBitCounter, 1) = "0"
        Else
            Mid$(strGene, intBitCounter, 1) = "1"
        End If
    Next intBitCounter
    
    ' raise the newgene-event, allowing the main code
    ' to override this random gene with a custom made one
    RaiseEvent NewGeneString(strGene)
    
    RandomBinaryGene = strGene
    
End Function

Private Function RandomAlphabeticGene() As String
    '
    ' Returns a random alphabetic gene
    '
    Dim strGene                 As String
                
    Dim intGene                 As Integer
    Dim intLoop                 As Integer
    
    Randomize (Sin(Timer) * Timer - Rnd * Timer)
    strGene = ""
    
    For intLoop = 1 To mAlphabeticGeneLength
    
        intGene = Int((Rnd * 26) + 1) + 64
    
        strGene = strGene & Chr$(intGene)
    Next intLoop
    
    ' raise the newgene-event, allowing the main code
    ' to override this random gene with a custom made one
    RaiseEvent NewGeneString(strGene)
    
    RandomAlphabeticGene = strGene

End Function

Private Function RandomLongGene() As Long
    '
    ' Returns a random Long number gene
    '
                
    Dim lngGene                 As Long
                
    Randomize (Sin(Timer) * Timer - Rnd * Timer)
    
    lngGene = ((mLongGeneMaxValue - mLongGeneMinValue + 1) * Rnd + mLongGeneMinValue)
    If lngGene > mLongGeneMaxValue Then
        lngGene = mLongGeneMaxValue
    Else
        If lngGene < mLongGeneMinValue Then
            lngGene = mLongGeneMinValue
        End If
    End If
    
    ' raise the newgene-event, allowing the main code
    ' to override this random gene with a custom made one
    RaiseEvent NewGeneLong(lngGene)
    
    RandomLongGene = lngGene
    
End Function

Private Function RandomDoubleGene() As Double
    '
    ' Returns a random double number gene
    '
    Dim dblGene                 As Double
                
    Randomize (Sin(Timer) * Timer - Rnd * Timer)
    
    dblGene = ((mDoubleGeneMaxValue - mDoubleGeneMinValue + 1) * Rnd + mDoubleGeneMinValue)
    
    If dblGene > mDoubleGeneMaxValue Then
        dblGene = mDoubleGeneMaxValue
    Else
        If dblGene < mDoubleGeneMinValue Then
            dblGene = mDoubleGeneMinValue
        End If
    End If
    
    
    ' raise the newgene-event, allowing the main code
    ' to override this random gene with a custom made one
    RaiseEvent NewGeneDouble(dblGene)
        
    RandomDoubleGene = dblGene
    
End Function

Public Sub EVALUATE()
    '
    '
    ' Raises the EvaluateFitness-event allowing the main app to calculate
    ' the fitness for each chromosome
    '
    '
    On Local Error GoTo errorhandler
    
    Dim lngIndex                As Long
    Dim lngStart                As Long
    Dim lngEnd                  As Long
    
    Dim dblFitnessValue         As Double

    Dim dblStdDev               As Double
    
    lngStart = 0
    lngEnd = (PopulationCount - 1)
    
    
    For lngIndex = lngStart To lngEnd
        
        If Chromosome(lngIndex).RecalculateFitness = True Then
        
            dblFitnessValue = Chromosome(lngIndex).Fitness
        
            RaiseEvent EvaluateFitness(lngIndex, dblFitnessValue)
        
            Chromosome(lngIndex).Fitness = dblFitnessValue
            Chromosome(lngIndex).RecalculateFitness = False
    
        End If
    Next lngIndex

    ' the chromosome-array has changed, it has to be sorted
    mblnSorted = False

    ' all fitnesses where calculated
    mblnAllFitnessCalculated = True

    ' standard deviation
    dblStdDev = CalculateStandardDeviation

    ' Statistics
    If mblnKeepStatistics = True Then
        If blnCallFromEvaluate = False Then
            ReDim Preserve mStatistics(Generation)
            mStatistics(Generation).HighestFitness = FitnessHighest
            mStatistics(Generation).LowestFitness = FitnessLowest
            mStatistics(Generation).StandardDeviation = dblStdDev
            mStatistics(Generation).SocialDisasterOccured = False
            mStatistics(Generation).SocialDisasterGenCounter = mSocDisGenCounter
            mStatistics(Generation).BestChromosome = ShowChromosomestring(0, "TRUE")
        End If
    End If

    '
    ' ADAPTIVE MUTATION RATE
    '
    If mMutationMethod = GAMutationRateAdaptive Then
        ' if the stabdard deviation stays the same for
        ' the set number of generations (in
        ' AMRGenerations / mAMRGenerations) then
        ' increase the actualmutationrate with 0.01
        If mAMRFitnessStdDev = dblStdDev Then
            mAMRCounter = mAMRCounter + 1
            mAMRCounterDiff = 0
        Else
            mAMRFitnessStdDev = dblStdDev
            mAMRCounterDiff = mAMRCounterDiff + 1
            mAMRCounter = 0
        End If
    
        If mAMRCounter >= mAMRGenerations Then
            mActualMutationRate = mActualMutationRate + 0.01
            If mActualMutationRate > 1 Then
                mActualMutationRate = 1
            End If
            mAMRCounter = 0
        End If
        
        If mAMRCounterDiff >= mAMRGenerations Then
            mActualMutationRate = mActualMutationRate - 0.01
            If mActualMutationRate < mMutationRate Then
                mActualMutationRate = mMutationRate
            End If
            mAMRCounterDiff = 0
        End If
    End If
    
    ' Statistics
    If mblnKeepStatistics = True Then
        If blnCallFromEvaluate = False Then
            mStatistics(Generation).MutationRate = mActualMutationRate
            mStatistics(Generation).SocialDivercity = GeneticDiversity
        End If
    End If
    
    
    '
    ' SOCIAL DISASTER
    '
    If mSocDisGenCounter >= mSocDisGenerations Then
        If blnCallFromEvaluate = False Then
            Call SocialDisaster
        
            blnCallFromEvaluate = True
            Call EVALUATE
            blnCallFromEvaluate = False
            
            mSocDisGenCounter = 0
            
        End If
        
    End If
    
Exit Sub

errorhandler:

    RaiseEvent GAError(LngNull(Err.Number), "Error in EVALUATE ! " & Err.Description)

End Sub

Private Sub QuickSortFitness(ByVal lngFirst As Long, ByVal lngLast As Long)
    '
    ' Quicksort in order to sort the chromosomes by their fitness.
    '
    '            I got this version of quicksort years ago from
    '            a website (I believe from www.gamedev.net but
    '            I'm not sure). Original code was in C and Quickbasic.
    '            The quickbasic version was rewritten by me
    '            several times over the past years until
    '            the version you see here. I use it in
    '            several of my projects.
    '
    
    Dim lngLow                  As Long
    Dim lngHigh                 As Long
    
    Dim dblMidValue             As Double
    
    Dim HelpChromo              As ChromosomeindividualType
    
    lngLow = lngFirst
    lngHigh = lngLast
    
    ' take the absolute value of fitness
    dblMidValue = Abs(Chromosome((lngFirst + lngLast) \ 2).Fitness)
    Do
        While Abs(Chromosome(lngLow).Fitness) < dblMidValue
            lngLow = lngLow + 1
        Wend
        While Abs(Chromosome(lngHigh).Fitness) > dblMidValue
            lngHigh = lngHigh - 1
        Wend
        If lngLow <= lngHigh Then
            GoSub swap
            lngLow = lngLow + 1
            lngHigh = lngHigh - 1
        End If
    Loop While lngLow <= lngHigh
    If lngFirst < lngHigh Then QuickSortFitness lngFirst, lngHigh
    If lngLow < lngLast Then QuickSortFitness lngLow, lngLast
    
    ' the chromosome-array is sorted
    mblnSorted = True
    
Exit Sub

swap:
    HelpChromo = Chromosome(lngLow)
    Chromosome(lngLow) = Chromosome(lngHigh)
    Chromosome(lngHigh) = HelpChromo
    
Return

End Sub

Public Sub SELECTION(Optional varSelectionMethod As Variant)
    '
    ' Selects two chromosomes for reproduction
    '
    ' the property SelectionMethod is normaly used to specify
    ' the method of selection (range, roulettewheel or tournament)
    ' the optional variant varSelectionMethod can however
    ' be used to specify the selectionmethod, allowing
    ' code that automatically alternates selectionmethods
    '
    '
    '
    '
    On Local Error GoTo errorhandler
    
    Dim intMethod               As Integer
    Dim intX                    As Integer
    Dim intRouletteCounter      As Integer ' howmany times has roulettewheel been spun ?
    
    Dim dblRunningFitness       As Double
    Dim dblHulp                 As Double
    Dim dblChosenFitness        As Double
    
    Dim lngloop                 As Long
    Dim lngHulp                 As Long
    Dim lngChosenIndex          As Long
    Dim lngChromo1              As Long
    Dim lngChromo2              As Long
    
    Dim blnChromosAreIdentic    As Boolean  ' used in random offspring generation
    
    
    
    lngChromo1 = 0
    lngChromo2 = 0
    
    
    If IsMissing(varSelectionMethod) Then
        intMethod = mSelectionMethod
    Else
        intMethod = IntNull(varSelectionMethod)
    End If

    
    ' Statistics
    If mblnKeepStatistics = True Then
        mStatistics(Generation).SelectionMethod = intMethod
        mStatistics(Generation).RouletteWheelOverflow = False
    End If


    ' Sort the chromosome array ?
    If mblnSorted = False Then
        Call QuickSortFitness(0, (PopulationCount - 1))
    End If

    Do
        Select Case intMethod
            Case GASelectRank
                ' Select the parents based on rank.
                GoSub Rank
            
            Case GASelectRouletteWheel
                ' select the parents based on a weighted roulette wheel
                ' (the weight being the sort order). The sort is by fitness
                ' so a lower chromosome index is a better one.
                GoSub RouletteWheel
                If intRouletteCounter > cRouletteWheelSpinMax Then
                    GoSub Rank
    
                    ' Statistics
                    If mblnKeepStatistics = True Then
                        mStatistics(Generation).RouletteWheelOverflow = True
                    End If
                
                End If
                
            Case GASelectTournament
                ' Organize a tournament. Select 'TournamentSize' members randomly out of the population.
                ' The fitttest of this group is selected for reproduction.
                ' Do this a second time to obtain both parents
                GoSub Tournament
                
        End Select
    Loop Until lngChromo1 <> lngChromo2 ' make sure both parents are different chromosomes

    mlngSelectedIndex1 = lngChromo1
    mlngSelectedIndex2 = lngChromo2


    ' --------------------------------------
    ' RandomOffspringGeneration
    ' --------------------------------------
    '
    If mRandomOffspringGeneration = True Then
        GoSub GenerateARandomOffspring
        
    End If


Exit Sub

'
' -----------------------------------------------------------
' Rank selection
' -----------------------------------------------------------
'
Rank:
    '
    ' All individuals are sorted by their fitness, two
    ' of them are chosen randomly
    '
    Do
        For intX = 1 To 2

            lngHulp = Int((Rnd * (PopulationCount)))
            If lngHulp > (PopulationCount - 1) Then
                lngHulp = PopulationCount - 1
            End If

            If intX = 1 Then
                lngChromo1 = lngHulp
            Else
                lngChromo2 = lngHulp
            End If

        Next intX
    Loop Until lngChromo1 <> lngChromo2
    
Return

'
' -----------------------------------------------------------
' Spin the Roulettewheel
' -----------------------------------------------------------
'
RouletteWheel:
    ' A roulette wheel uses an imaginary wheel and creates
    ' pies of varying sizes for each member. A standard (or 'normal')
    ' roulette wheel creates pie-sizes related to the fitness of
    ' each member.
    ' The positive side of this is that roulette wheel tends to
    ' attain convergence very quickly.
    ' The negative side is that the normal roulette wheel tends
    ' to attain convergence very quickly... leading to local optima.
    ' The reason for this is that roulette wheel cannot handle
    ' huge fitness differences correctly.
    '
    ' To solve this problem the fitness values are weighted. This means
    ' the size of each 'pie' is not directly related to the size of
    ' the fitnessscore, but more to the position within the sorted
    ' fitnessscores...
    '
    ' The pie-sizes are chosen by position in a fitness-sorted population. So
    ' for 100 members, sorted by fitness from 0 (fittest) to 99 (worst) :
    ' individual 0 gets a pie of 100, individual 1 gets a pie of 99, 3 of 98... until
    ' element 99 gets a pie of 1. In this way the repartition is smoother
    '
    ' This can be done easily with a running sum, but I had trouble
    ' with problems generating huge differences in fitnessscores..
    ' So I used a different approach : filling piestart and pieend
    ' Later I found what the problem was and how to solve it, but this
    ' code was allready done and worked flawlessly, so I decided
    ' to keep it this way...
    '
    ' First, create the pies of the wheel
    ' fill in the PieStart and PieEnd fields
    ' for every chromosome. Chromosomes with fitness score closer to 0
    ' get a bigger piece than those with a higher fitness
    ' Since they are sorted by fitness, their index is a measurement
    ' for the pie segment. Lower index means a bigger pie
    
    dblRunningFitness = 0
    dblHulp = PopulationCount
    
    For lngloop = 0 To (PopulationCount - 1)
        dblRunningFitness = dblRunningFitness + 1
        Chromosome(lngloop).PiePieceStart = dblRunningFitness
        dblRunningFitness = dblRunningFitness + dblHulp
        
        Chromosome(lngloop).PiePieceEnd = dblRunningFitness
    
        dblHulp = dblHulp - 1
    Next lngloop
    
    '
    ' Now spin the wheel
    '
    intRouletteCounter = 0
    Do
        For intX = 1 To 2
            ' witch chromosome is the lukcy one ?
            dblHulp = ((Rnd * Abs(Int(dblRunningFitness))) + 1)
            If dblHulp > Chromosome(PopulationCount - 1).PiePieceEnd Then
                dblHulp = Chromosome(PopulationCount - 1).PiePieceEnd
            End If
            
            For lngloop = 0 To (PopulationCount - 1)
        
                If dblHulp >= Chromosome(lngloop).PiePieceStart And dblHulp <= Chromosome(lngloop).PiePieceEnd Then
                    If intX = 1 Then
                        lngChromo1 = lngloop
                    Else
                        lngChromo2 = lngloop
                    End If
                    Exit For
                    
                End If
            Next lngloop
        
        Next intX
        '
        ' As stated, Roulette wheel can converge quickly, but is prone
        ' to arrive quickly at local optima if many chromosomes start to look alike
        ' and have the same fitnessscore.
        ' In an attempt to avoid local optima a counter is used to track
        ' howmany times same fitnessscored-chromosomes are chosen.
        ' If this maximum is reached then jump out of roulette wheel
        ' and use Rank
        If Chromosome(lngChromo1).Fitness = Chromosome(lngChromo2).Fitness Then
            intRouletteCounter = intRouletteCounter + 1
            If intRouletteCounter > cRouletteWheelSpinMax Then
                intMethod = GASelectRank
                Exit Do
            End If
        End If
    Loop Until Chromosome(lngChromo1).Fitness <> Chromosome(lngChromo2).Fitness
    
Return

'
' -----------------------------------------------------------
' Tournament
' -----------------------------------------------------------
'
Tournament:
    '
    ' Select a number of random individuals from the population
    ' (the number being 'TournamentSize'). Pick the individual
    ' with the best fitness from this selection.
    ' Repeat this process a second time...
    ' You end up with two individuals.. your chosen elements.
    '
    Do
        For intX = 1 To 2
            Randomize (Timer * intX)
            
            dblChosenFitness = 1E+32
            lngChosenIndex = PopulationCount + 2
            
            For lngloop = 0 To (mTournamentSize - 1)
                lngHulp = Int((Rnd * (PopulationCount)))
                If lngHulp > (PopulationCount - 1) Then
                    lngHulp = PopulationCount - 1
                End If
                
                If Chromosome(lngHulp).Fitness < dblChosenFitness Then
                    dblChosenFitness = Chromosome(lngHulp).Fitness
                    lngChosenIndex = lngHulp
                End If
            Next lngloop
            
            If intX = 1 Then
                lngChromo1 = lngChosenIndex
            Else
                lngChromo2 = lngChosenIndex
            End If
        
        Next intX
    Loop Until lngChromo1 <> lngChromo2

Return

'
' -----------------------------------------------------------
' Random offspring generation
' -----------------------------------------------------------
'
GenerateARandomOffspring:
    ' test if both chromosomes have identic genetic material
    ' if so, replace one with random genes
    
    ' The way I implemented Random offspring Generation differs from the most used
    ' method.
    ' Normaly Random offspring Generation is used as follows :
    ' before the crossover, both parents have their genetic material compared, and if
    ' they are the same crossover does not occur (it would not change anything since
    ' they are identical) but one or two children are randomly created.
    '
    ' My version of Random offspring Generation is a bit different. I test both
    ' parents if they are identical. If so I replace one of the parents with a new
    ' random chromosome and I allow crossover to take place.
    ' I figured that this way helped against premature convergence a bit more since I
    ' get rid of at least one identical chromosome. Allowing crossover to occur
    ' between the new random parent and the original, creating two children in the
    ' process, helps the required diversity in genetic material.
    
    blnChromosAreIdentic = True
    For intX = 0 To (mGenesPerChromosome - 1)
        Select Case mChromosomeType
            Case GAEncodingBinary, GAEncodingAlphabetic
                If Chromosome(mlngSelectedIndex1).Genes(intX).GeneString <> Chromosome(mlngSelectedIndex2).Genes(intX).GeneString Then
                    blnChromosAreIdentic = False
                End If
                                        
            Case GAEncodingLongNbr
                If Chromosome(mlngSelectedIndex1).Genes(intX).GeneLong <> Chromosome(mlngSelectedIndex2).Genes(intX).GeneLong Then
                    blnChromosAreIdentic = False
                End If
                   
            Case GAEncodingDouble
                If Chromosome(mlngSelectedIndex1).Genes(intX).GeneDouble <> Chromosome(mlngSelectedIndex2).Genes(intX).GeneDouble Then
                    blnChromosAreIdentic = False
                End If
                   
        End Select
        
        If blnChromosAreIdentic = False Then
            Exit For
        End If
    Next intX
    
    If blnChromosAreIdentic = True Then
        ' replace the second selected chromosome with a new random chromosome
        Chromosome(mlngSelectedIndex2) = CreateRandomChromosome(2)
        Chromosome(mlngSelectedIndex2).Fitness = 1E+300
        Chromosome(mlngSelectedIndex2).RecalculateFitness = True
        mblnSorted = False
        mblnAllFitnessCalculated = False
        '
        ' Not necessary to call the fitness-evaluation routine now,
        ' next step is reproduction, and no matter what fitness this
        ' new chromosome has, it will be used as a parent...
        ' It's fitness will be calcumated together with the
        ' two children
        '
        ' counter
        mRandomOffspringCounter = mRandomOffspringCounter + 1
        
    End If
    
Return

'
'
'

errorhandler:

    RaiseEvent GAError(LngNull(Err.Number), "Error in SELECTION ! " & Err.Description)

End Sub

Public Sub REPRODUCTION(Optional varCrossoverMethod As Variant, Optional varReproductionMethod As Variant)
    '
    ' Reproduce the two selected chromosomes
    '
    ' The genes from two chosen chromosomes are copied
    ' to buffers.
    ' The crossover and mutation is applied.
    ' (Or edge recombination...)
    '
    ' varCrossoverMethod    : by default CrossoverMethod is used to know
    '                         what method of crossover to use, but this way you can
    '                         override this by code
    '
    ' varReproductionMethod : by default Reproductionmethod is used to know which
    '                         method to reproduce. By using this variant however
    '                         you can change this for this reproduction-cycle
    '
    
    On Local Error GoTo errorhandler
    
    Dim intX                    As Integer  '
    Dim intY                    As Integer  ' For-next counters
    Dim intZ                    As Integer  '
    
    Dim intPosition1            As Integer  ' Position within a gene,
    Dim intPosition2            As Integer  ' used in half-uniform
    Dim intPosBuffer            As Integer  ' crossover method
    
    Dim intCrossoverPoint       As Integer  ' Crossoverpoints for one-point
    Dim intCrossoverPoint2      As Integer  ' and two-point crossover
    
    Dim intGeneToMutate         As Integer  ' what gene to mutate
    Dim intBitToMutate          As Integer  ' what bit (or element) to mutate inside that gene
    
    Dim intReproductionMethod   As Integer  ' reproductionmethod
    Dim intCrossoverMethod      As Integer  ' crossovermethod
    
    Dim intGeneIndexNodeHead    As Integer  '
    Dim intNodeLoop             As Integer  ' Edge recombination
    Dim intLowestedges          As Integer  ' work variabels
    Dim intReorderEdges         As Integer  '
    Dim intNodeMapIndex         As Integer  '
    Dim intNodeMapUbound        As Integer  '
    Dim intEdgeLoop             As Integer  '
    Dim intLowestedgesUbound    As Integer  '
    Dim arintLowestedges()      As Integer  ' lowestedgesarray used in edge-recombination
    
    Dim strBuffer               As String
    Dim strbufferMask           As String
    Dim strChar                 As String
    Dim strNodeHead             As String
    
    Dim lngBuffer               As Long
    Dim lngChromoToReplace1     As Long
    Dim lngChromoToReplace2     As Long
    Dim lngParentIndex          As Long
    
    Dim dblHelp                 As Double
    Dim dblBuffer               As Double
    Dim dblLongDoubleMutateValue As Double
    
    Dim blnHeadNodeExists       As Boolean
    Dim blnEdgeNodeExists       As Boolean
    Dim blnReorderEdges         As Boolean
    Dim blnNodeExistsInOffspring As Boolean
    Dim blnCrossoverPointOK     As Boolean
    
    Dim strGenesChromo1()       As String   ' These are workbuffers
    Dim strGenesChromo2()       As String   ' used in the reproduction
    Dim lngGenesChromo1()       As Long     ' to hold the genes from the two
    Dim lngGenesChromo2()       As Long     ' reproducing chromosomes
    Dim dblGenesChromo1()       As Double   ' There are 3 type (string, long and double)
    Dim dblGenesChromo2()       As Double   ' to hold all the possible encodings
    Dim strChromo1              As String
    Dim strChromo2              As String
    Dim strChromo1Mask          As String   ' Mask used in mutation and crossover for long and double
    Dim strChromo2Mask          As String   ' encoding. See function CreateMask
    
    Dim intHUpositions()        As Integer  ' for half-uniform crossover this is the list of indexes
                                            ' inside the two parents string with nonmatching
                                            ' bits.
    
    Dim Nodemap()               As NodemapEdgeRecombType ' the nodemap used in edge-recombination
    
    
    
    ' redim the buffers used in the reproduction sequence
    ReDim strGenesChromo1(mGenesPerChromosome)
    ReDim strGenesChromo2(mGenesPerChromosome)
    ReDim lngGenesChromo1(mGenesPerChromosome)
    ReDim lngGenesChromo2(mGenesPerChromosome)
    ReDim dblGenesChromo1(mGenesPerChromosome)
    ReDim dblGenesChromo2(mGenesPerChromosome)
    strChromo1 = ""
    strChromo2 = ""
    
    
    
    Randomize (Cos(Timer) * Timer - Rnd * Timer)
    

    '
    ' Calculate actual length of string tu hold long or double genes
    ' Used when long or double encoding is used, to minimize the impact of
    ' too many leading zeroes (unused because of minimum and
    ' maximum values for the encoding)
    Select Case mChromosomeType
        Case GAEncodingLongNbr
            intX = CalculateActualLongGeneMaxLength(mlngSelectedIndex1)
            intY = CalculateActualLongGeneMaxLength(mlngSelectedIndex2)
            If intX > intY Then
                mintLongActualLength = intX
            Else
                mintLongActualLength = intY
            End If
            
        Case GAEncodingDouble
            intX = CalculateActualDoubleGeneMaxLength(mlngSelectedIndex1)
            intY = CalculateActualDoubleGeneMaxLength(mlngSelectedIndex2)
            If intX > intY Then
                mintDoubleActualLength = intX
            Else
                mintDoubleActualLength = intY
            End If
            
        Case Else
            ' default VB max length
            ' not used in other encodings anyway...
            mintLongActualLength = cLongMaxLength
            mintDoubleActualLength = cDoubleMaxLength
    
    End Select
    



    ' --------------------------------------
    ' Transfer the selected parents to the workbuffers
    ' --------------------------------------
    '       Parents are copied to workbuffers (stringbuffers for all type of chromosomes
    '       because they are used in non-full-gene crossover
    '       All modifications happen in those buffers
    '
    GoSub TransferParentsToWorkBuffers

    
    '
    ' What crossovermethod to use ?
    If Not IsMissing(varCrossoverMethod) Then
        intCrossoverMethod = IntNull(varCrossoverMethod)
    Else
        intCrossoverMethod = mCrossoverMethod
    End If
    
    '
    ' What reproduction manner will be used ?
    If Not IsMissing(varReproductionMethod) Then
        intReproductionMethod = IntNull(varReproductionMethod)
    Else
        intReproductionMethod = mReproductionMethod
    End If
                
    '
    ' If crossovermethod is edge-recombination, then
    ' crossover is always on full gene
    If intCrossoverMethod = GACrossoverEdgeRecombination Then
        mCrossoverFullGenes = True
    End If
                
                
                
                
                
    ' -----------------------------
    ' Crossover
    ' -----------------------------
    '
    
    If Rnd < mCrossoverRate Then
        
        '
        '
        ' -----------------------------------------
        '  BEGIN CROSSOVER
        ' -----------------------------------------
        '
                    
                    
        If mCrossoverFullGenes = True Then
            ' crossoverfullgenes
            GoSub CrossoverTheFullGenes
            
        Else
            ' Crossover anywhere in the gene
            '       Use the stringbuffer to do the work.
            '       with help of the helpbuffer
            GoSub CrossoverAnywhereInTheGenes
            
            '
            ' Set the helpbufferchromosome back in the workingbuffer
            '
            GoSub TransferHelpbuffersToWorkBuffers
            
        End If
                
        ' counter
        mCrossoverCounter = mCrossoverCounter + 1
                
    End If
    
    
    
    '
    '
    ' -----------------------------------------
    '  BEGIN MUTATION
    ' -----------------------------------------
    '
    
    ' Mutation cannot happen on edge-recombination
    ' It would introduce doubles and/or impossible edges
    
    If intCrossoverMethod <> GACrossoverEdgeRecombination Then

        Randomize (Sin(Timer) * Timer - Rnd * Timer)
    
        If mMutateFullGenes = True Then
            '
            ' Mutate a full gene
        
            GoSub MutateThefullGene
        
        Else
            '
            ' Mutate only 1 element (bit) in a chromosome
    
            GoSub MutateAnywhereInGene

        End If
    End If
    
    '
    '
    ' At this point two parent chromosomes have
    ' exchanged genetic material and eventualy mutated (depending on CrossoverRate and MutationRate)
    ' This means that right now we have :
    '   - the index of parent1 in mlngSelectedIndex1 / SelectedChromosomeIndex1
    '   - the index of parent2 in mlngSelectedIndex2 / SelectedChromosomeIndex2
    '   - the newly created offsprings in their buffers strGenesChromo1/strGenesChromo2, lngGenesChromo1/lngGenesChromo2 and dblGenesChromo1/dblGenesChromo2
    '   - the method of reproduction in intReproductionMethod
    ' So we can proceed...
    '

    ' Reproduce
    ' what method of reproduction to use
    Select Case intReproductionMethod
        Case GAReproductionReplaceParents
            GoSub ReplaceParents
        
        Case GAReproductionReplaceRandom
            GoSub ReplaceRandom
            
        Case Else  ' GAReproductionReplaceWeakest
            GoSub ReplaceWeakest
    
    End Select
    
    ' The actual replacement
    ' edge recombination makes only one child
    If intCrossoverMethod <> GACrossoverEdgeRecombination Then
        For intX = 0 To (mGenesPerChromosome - 1)
            Select Case mChromosomeType
                Case GAEncodingBinary, GAEncodingAlphabetic
                    Chromosome(lngChromoToReplace1).Genes(intX).GeneString = strGenesChromo1(intX)
                    Chromosome(lngChromoToReplace2).Genes(intX).GeneString = strGenesChromo2(intX)

                Case GAEncodingLongNbr
                    If lngGenesChromo1(intX) > mLongGeneMaxValue Then
                        lngGenesChromo1(intX) = mLongGeneMaxValue
                    Else
                        If lngGenesChromo1(intX) < mLongGeneMinValue Then
                            lngGenesChromo1(intX) = mLongGeneMinValue
                        End If
                    End If
                    
                    If lngGenesChromo2(intX) > mLongGeneMaxValue Then
                        lngGenesChromo2(intX) = mLongGeneMaxValue
                    Else
                        If lngGenesChromo2(intX) < mLongGeneMinValue Then
                            lngGenesChromo2(intX) = mLongGeneMinValue
                        End If
                    End If
                    Chromosome(lngChromoToReplace1).Genes(intX).GeneLong = lngGenesChromo1(intX)
                    Chromosome(lngChromoToReplace2).Genes(intX).GeneLong = lngGenesChromo2(intX)

                Case GAEncodingDouble
                    If dblGenesChromo1(intX) < mDoubleGeneMinValue Then
                        dblGenesChromo1(intX) = mDoubleGeneMinValue
                    Else
                        If dblGenesChromo1(intX) > mDoubleGeneMaxValue Then
                            dblGenesChromo1(intX) = mDoubleGeneMaxValue
                        End If
                    End If
                    If dblGenesChromo2(intX) < mDoubleGeneMinValue Then
                        dblGenesChromo2(intX) = mDoubleGeneMinValue
                    Else
                        If dblGenesChromo2(intX) > mDoubleGeneMaxValue Then
                            dblGenesChromo2(intX) = mDoubleGeneMaxValue
                        End If
                    End If
                    Chromosome(lngChromoToReplace1).Genes(intX).GeneDouble = dblGenesChromo1(intX)
                    Chromosome(lngChromoToReplace2).Genes(intX).GeneDouble = dblGenesChromo2(intX)

            End Select
        Next intX

        Chromosome(lngChromoToReplace1).Fitness = 1E+300 ' set the fitness of the new chromosomes
        Chromosome(lngChromoToReplace2).Fitness = 1E+300 ' to a high number
    
        Chromosome(lngChromoToReplace1).RecalculateFitness = True
        Chromosome(lngChromoToReplace2).RecalculateFitness = True
    
    Else
        ' edge recombination
        ' - Only 1 child in strGenesChromo1
        ' - the child is always a string (strGenesChromo1)
        '   however it can be all chromosometypes
        For intX = 0 To (mGenesPerChromosome - 1)
            Select Case mChromosomeType
                Case GAEncodingBinary, GAEncodingAlphabetic
                    Chromosome(lngChromoToReplace1).Genes(intX).GeneString = strGenesChromo1(intX)

                Case GAEncodingLongNbr
                    If LngNull(strGenesChromo1(intX)) > mLongGeneMaxValue Then
                        Chromosome(lngChromoToReplace1).Genes(intX).GeneLong = mLongGeneMaxValue
                    Else
                        If LngNull(strGenesChromo1(intX)) < mLongGeneMinValue Then
                            Chromosome(lngChromoToReplace1).Genes(intX).GeneLong = mLongGeneMinValue
                        Else
                            Chromosome(lngChromoToReplace1).Genes(intX).GeneLong = LngNull(strGenesChromo1(intX))
                        End If
                    End If

                Case GAEncodingDouble
                    If DblNull(strGenesChromo1(intX)) < mDoubleGeneMinValue Then
                        Chromosome(lngChromoToReplace1).Genes(intX).GeneDouble = mDoubleGeneMinValue
                    Else
                        If DblNull(strGenesChromo1(intX)) > mDoubleGeneMaxValue Then
                            Chromosome(lngChromoToReplace1).Genes(intX).GeneDouble = mDoubleGeneMaxValue
                        Else
                            Chromosome(lngChromoToReplace1).Genes(intX).GeneDouble = DblNull(strGenesChromo1(intX))
                        End If
                    End If

            End Select
        Next intX

        Chromosome(lngChromoToReplace1).Fitness = 1E+300 ' set the fitness of the new chromosomes
    
        Chromosome(lngChromoToReplace1).RecalculateFitness = True
        
    End If
    
    ' the chromosome-array has changed, it has to be sorted
    mblnSorted = False
    ' the fitness must be evaluated
    mblnAllFitnessCalculated = False

    
    ' generation counter
    mGeneration = mGeneration + 1
    
    ' social disaster generation counter
    mSocDisGenCounter = mSocDisGenCounter + 1
    
Exit Sub

'
' +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
' SUBROUTINES
' +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'


'
' -----------------------------------------------------------
' Transfer the selected parents to the workbuffers
' -----------------------------------------------------------
'
TransferParentsToWorkBuffers:
    ' what are the genes in chromosome1 and chromosome2
    ' and place them in a buffer
    For intX = 0 To (mGenesPerChromosome - 1)
        Select Case mChromosomeType
            Case GAEncodingBinary, GAEncodingAlphabetic
                strGenesChromo1(intX) = Chromosome(mlngSelectedIndex1).Genes(intX).GeneString
                strGenesChromo2(intX) = Chromosome(mlngSelectedIndex2).Genes(intX).GeneString
                
            Case GAEncodingLongNbr
                lngGenesChromo1(intX) = Chromosome(mlngSelectedIndex1).Genes(intX).GeneLong
                lngGenesChromo2(intX) = Chromosome(mlngSelectedIndex2).Genes(intX).GeneLong
                ' also fill the stringbuffer (used if crossoverfullgene = FALSE)
                strGenesChromo1(intX) = Space$(mintLongActualLength)
                RSet strGenesChromo1(intX) = StrNull(Chromosome(mlngSelectedIndex1).Genes(intX).GeneLong)
                strGenesChromo2(intX) = Space$(mintLongActualLength)
                RSet strGenesChromo2(intX) = StrNull(Chromosome(mlngSelectedIndex2).Genes(intX).GeneLong)
                
            Case GAEncodingDouble
                dblGenesChromo1(intX) = Chromosome(mlngSelectedIndex1).Genes(intX).GeneDouble
                dblGenesChromo2(intX) = Chromosome(mlngSelectedIndex2).Genes(intX).GeneDouble
                ' also fill the stringbuffer (used if crossoverfullgene = FALSE)
                strGenesChromo1(intX) = Space$(mintDoubleActualLength)
                RSet strGenesChromo1(intX) = StrNull(Chromosome(mlngSelectedIndex1).Genes(intX).GeneDouble)
                strGenesChromo2(intX) = Space$(mintDoubleActualLength)
                RSet strGenesChromo2(intX) = StrNull(Chromosome(mlngSelectedIndex2).Genes(intX).GeneDouble)
            
        End Select
    Next intX

    ' Fill the chromosome-string-buffer
    Select Case mChromosomeType
        Case GAEncodingBinary, GAEncodingAlphabetic
            strChromo1 = InternalShowChromosomestring(mlngSelectedIndex1)
            strChromo2 = InternalShowChromosomestring(mlngSelectedIndex2)
            
        Case GAEncodingLongNbr
            strChromo1 = InternalShowChromosomestring(mlngSelectedIndex1, mintLongActualLength)
            strChromo2 = InternalShowChromosomestring(mlngSelectedIndex2, mintLongActualLength)
            
        Case GAEncodingDouble
            strChromo1 = InternalShowChromosomestring(mlngSelectedIndex1, , mintDoubleActualLength)
            strChromo2 = InternalShowChromosomestring(mlngSelectedIndex2, , mintDoubleActualLength)
    
    End Select
    
    ' fill the masks
    strChromo1Mask = String$(Len(strChromo1), ">")
    strChromo2Mask = String$(Len(strChromo2), ">")
    
    If (mChromosomeType = GAEncodingLongNbr Or mChromosomeType = GAEncodingDouble) And mCrossoverFullGenes = False Then
        ' fill the mask for both chromosomes
        strChromo1Mask = CreateMask(mlngSelectedIndex1)
        strChromo2Mask = CreateMask(mlngSelectedIndex2)
    End If

Return


'
' -----------------------------------------------------------
' Crossover full genes
' -----------------------------------------------------------
'
CrossoverTheFullGenes:
    ' Crossover full genes only
        
    Select Case intCrossoverMethod
        Case GACrossoverOnePoint
            ' at what point to crossover ?
            intCrossoverPoint = Int(Rnd * mGenesPerChromosome) + 1
            ' swap everything after intCrossoverPoint between chromosome1 and chromosome2
            For intX = intCrossoverPoint To (mGenesPerChromosome - 1)
                Select Case mChromosomeType
                    Case GAEncodingBinary, GAEncodingAlphabetic
                        strBuffer = strGenesChromo1(intX)
                        strGenesChromo1(intX) = strGenesChromo2(intX)
                        strGenesChromo2(intX) = strBuffer
                        
                    Case GAEncodingLongNbr
                        lngBuffer = lngGenesChromo1(intX)
                        lngGenesChromo1(intX) = lngGenesChromo2(intX)
                        lngGenesChromo2(intX) = lngBuffer
                
                    Case GAEncodingDouble
                        dblBuffer = dblGenesChromo1(intX)
                        dblGenesChromo1(intX) = dblGenesChromo2(intX)
                        dblGenesChromo2(intX) = dblBuffer
                
                End Select
            Next intX
        
        Case GACrossoverTwoPoint
            ' two point crossover
            Do
                intCrossoverPoint = Int(Rnd * mGenesPerChromosome) + 1
                intCrossoverPoint2 = Int(Rnd * mGenesPerChromosome) + 1
            Loop Until intCrossoverPoint <> intCrossoverPoint2
            If intCrossoverPoint > intCrossoverPoint2 Then
                intY = intCrossoverPoint
                intCrossoverPoint = intCrossoverPoint2
                intCrossoverPoint2 = intY
            End If
            ' do the swap
            For intX = intCrossoverPoint To intCrossoverPoint2
                Select Case mChromosomeType
                    Case GAEncodingBinary, GAEncodingAlphabetic
                        strBuffer = strGenesChromo1(intX)
                        strGenesChromo1(intX) = strGenesChromo2(intX)
                        strGenesChromo2(intX) = strBuffer
                        
                    Case GAEncodingLongNbr
                        lngBuffer = lngGenesChromo1(intX)
                        lngGenesChromo1(intX) = lngGenesChromo2(intX)
                        lngGenesChromo2(intX) = lngBuffer
                
                    Case GAEncodingDouble
                        dblBuffer = dblGenesChromo1(intX)
                        dblGenesChromo1(intX) = dblGenesChromo2(intX)
                        dblGenesChromo2(intX) = dblBuffer
                
                End Select
            Next intX
            
        Case GACrossoverUniform
            ' uniform
            ' swap elements in both parents depending on a random propability
            For intX = 0 To (mGenesPerChromosome - 1)
                Select Case mChromosomeType
                    Case GAEncodingBinary, GAEncodingAlphabetic
                        If strGenesChromo1(intX) <> strGenesChromo2(intX) Then
                            If Rnd < cCrossoverUniform Then
                                strBuffer = strGenesChromo1(intX)
                                strGenesChromo1(intX) = strGenesChromo2(intX)
                                strGenesChromo2(intX) = strBuffer
                            End If
                        End If
                        
                    Case GAEncodingLongNbr
                        If lngGenesChromo1(intX) <> lngGenesChromo2(intX) Then
                            If Rnd < cCrossoverUniform Then
                                lngBuffer = lngGenesChromo1(intX)
                                lngGenesChromo1(intX) = lngGenesChromo2(intX)
                                lngGenesChromo2(intX) = lngBuffer
                            End If
                        End If
                    
                    Case GAEncodingDouble
                        If dblGenesChromo1(intX) <> dblGenesChromo2(intX) Then
                            If Rnd < cCrossoverUniform Then
                                dblBuffer = dblGenesChromo1(intX)
                                dblGenesChromo1(intX) = dblGenesChromo2(intX)
                                dblGenesChromo2(intX) = dblBuffer
                            End If
                        End If
                
                End Select
            Next intX
        
        Case GACrossoverHalfUniform
            ' Half uniform, only half the nonmatching genes will be swapped
            ReDim intHUpositions(0)
            intY = 0 ' holds the amount of differing genes
            For intX = 0 To (mGenesPerChromosome - 1)
                Select Case mChromosomeType
                    Case GAEncodingBinary, GAEncodingAlphabetic
                        If strGenesChromo1(intX) <> strGenesChromo2(intX) Then
                            intY = intY + 1
                            ReDim Preserve intHUpositions(intY)
                            intHUpositions(intY) = intX
                        End If
                        
                    Case GAEncodingLongNbr
                        If lngGenesChromo1(intX) <> lngGenesChromo2(intX) Then
                            intY = intY + 1
                            ReDim Preserve intHUpositions(intY)
                            intHUpositions(intY) = intX
                        End If
                        
                    Case GAEncodingDouble
                        If dblGenesChromo1(intX) <> dblGenesChromo2(intX) Then
                            intY = intY + 1
                            ReDim Preserve intHUpositions(intY)
                            intHUpositions(intY) = intX
                        End If
                
                End Select
            
            Next intX
            
            If intY > 0 Then
                ' jumble the positions, so that random genes of half of the
                ' nonmatching ones will be swapped
                For intX = 0 To (mGenesPerChromosome - 1)
                    intPosition1 = Int(Rnd * intY) + 1
                    intPosition2 = Int(Rnd * intY) + 1
                    intPosBuffer = intHUpositions(intPosition1)
                    intHUpositions(intPosition1) = intHUpositions(intPosition2)
                    intHUpositions(intPosition2) = intPosBuffer
                Next intX
                '
                ' now perform the swap on half the nonmatching genes
                For intX = 1 To Int((intY / 2) + 0.5)
                    Select Case mChromosomeType
                        Case GAEncodingBinary, GAEncodingAlphabetic
                            strBuffer = strGenesChromo1(intHUpositions(intX))
                            strGenesChromo1(intHUpositions(intX)) = strGenesChromo2(intHUpositions(intX))
                            strGenesChromo2(intHUpositions(intX)) = strBuffer
                        
                        Case GAEncodingLongNbr
                            lngBuffer = lngGenesChromo1(intHUpositions(intX))
                            lngGenesChromo1(intHUpositions(intX)) = lngGenesChromo2(intHUpositions(intX))
                            lngGenesChromo2(intHUpositions(intX)) = lngBuffer
                
                        Case GAEncodingDouble
                            dblBuffer = dblGenesChromo1(intHUpositions(intX))
                            dblGenesChromo1(intHUpositions(intX)) = dblGenesChromo2(intHUpositions(intX))
                            dblGenesChromo2(intHUpositions(intX)) = dblBuffer
                    
                    End Select
                
                Next intX
            
            End If
        
        Case GACrossoverEdgeRecombination
            ' edge recombination
            GoSub EdgeRecombination
            
    End Select


Return




'
' -----------------------------------------------------------
' Transfer the helpbuffers to the workbuffers
' -----------------------------------------------------------
'
TransferHelpbuffersToWorkBuffers:
    '
    ' Set the helpbufferchromosome back in the workingbuffer
    '
    For intX = 0 To (mGenesPerChromosome - 1)
        Select Case mChromosomeType
            Case GAEncodingBinary
                strGenesChromo1(intX) = Mid$(strChromo1, (intX * mBinaryGeneLength) + 1, mBinaryGeneLength)
                strGenesChromo2(intX) = Mid$(strChromo2, (intX * mBinaryGeneLength) + 1, mBinaryGeneLength)
                
            Case GAEncodingAlphabetic
                strGenesChromo1(intX) = Mid$(strChromo1, (intX * mAlphabeticGeneLength) + 1, mAlphabeticGeneLength)
                strGenesChromo2(intX) = Mid$(strChromo2, (intX * mAlphabeticGeneLength) + 1, mAlphabeticGeneLength)
            
            Case GAEncodingLongNbr
                intY = mintLongActualLength
                lngGenesChromo1(intX) = LngNull(Mid$(strChromo1, (intX * intY) + 1, intY))
                lngGenesChromo2(intX) = LngNull(Mid$(strChromo2, (intX * intY) + 1, intY))
        
            Case GAEncodingDouble
                intY = mintDoubleActualLength
                dblGenesChromo1(intX) = DblNull(Mid$(strChromo1, (intX * intY) + 1, intY))
                dblGenesChromo2(intX) = DblNull(Mid$(strChromo2, (intX * intY) + 1, intY))
        
        End Select
    Next intX

Return


'
' -----------------------------------------------------------
' Crossover anywhere in the gene
' -----------------------------------------------------------
'
CrossoverAnywhereInTheGenes:
    ' Crossover anywhere in the gene
    '       Use the stringbuffer to do the work.
    '       with help of the helpbuffer
    
    Select Case intCrossoverMethod
        Case GACrossoverOnePoint
            ' One point crossover
            Select Case mChromosomeType
                Case GAEncodingLongNbr, GAEncodingDouble
                    ' check the mask of both chromosomes to be sure
                    ' that crossover may happen on this location
                    blnCrossoverPointOK = False
                    Do
                        intCrossoverPoint = Int(Rnd * (Len(strChromo1)) + 1)
                        If (Mid$(strChromo1Mask, intCrossoverPoint, 1) <> "N" And Mid$(strChromo2Mask, intCrossoverPoint, 1) <> "N") And (Mid$(strChromo1Mask, intCrossoverPoint, 1) = Mid$(strChromo2Mask, intCrossoverPoint, 1)) Then
                            blnCrossoverPointOK = True
                        End If
                    Loop Until blnCrossoverPointOK = True
                Case Else
                    intCrossoverPoint = Int(Rnd * (Len(strChromo1)) + 1)
            End Select
            GoSub OnePointCrossover
        
        Case GACrossoverTwoPoint
            ' two point crossover
            Select Case mChromosomeType
                Case GAEncodingLongNbr, GAEncodingDouble
                    ' check the mask of both chromosomes to be sure
                    ' that crossover may happen on this location
                    blnCrossoverPointOK = False
                    Do
                        Do
                            intCrossoverPoint = Int(Rnd * (Len(strChromo1)) + 1)
                            intCrossoverPoint2 = Int(Rnd * (Len(strChromo1)) + 1)
                        Loop Until intCrossoverPoint <> intCrossoverPoint2
                        If (Mid$(strChromo1Mask, intCrossoverPoint, 1) <> "N" And Mid$(strChromo2Mask, intCrossoverPoint, 1) <> "N") And (Mid$(strChromo1Mask, intCrossoverPoint, 1) = Mid$(strChromo2Mask, intCrossoverPoint, 1)) Then
                            If (Mid$(strChromo1Mask, intCrossoverPoint2, 1) <> "N" And Mid$(strChromo2Mask, intCrossoverPoint2, 1) <> "N") And (Mid$(strChromo1Mask, intCrossoverPoint2, 1) = Mid$(strChromo2Mask, intCrossoverPoint2, 1)) Then
                                blnCrossoverPointOK = True
                            End If
                        End If
                    Loop Until blnCrossoverPointOK = True
            
                Case Else
                    Do
                        intCrossoverPoint = Int(Rnd * (Len(strChromo1)) + 1)
                        intCrossoverPoint2 = Int(Rnd * (Len(strChromo1)) + 1)
                    Loop Until intCrossoverPoint <> intCrossoverPoint2
            End Select
            
            If intCrossoverPoint > intCrossoverPoint2 Then
                intY = intCrossoverPoint
                intCrossoverPoint = intCrossoverPoint2
                intCrossoverPoint2 = intY
            End If
            ' First crossover as in one point
            GoSub OnePointCrossover
            
            ' Now perform the second crossover
            strBuffer = Right$(strChromo1, Len(strChromo2) - (intCrossoverPoint2) + 1)
            Mid$(strChromo1, intCrossoverPoint2, Len(strBuffer)) = Right$(strChromo2, Len(strChromo1) - (intCrossoverPoint2) + 1)
            Mid$(strChromo2, intCrossoverPoint2, Len(strBuffer)) = strBuffer
        
            ' rebuild the masks
            strBuffer = Right$(strChromo1Mask, Len(strChromo2Mask) - (intCrossoverPoint2) + 1)
            Mid$(strChromo1Mask, intCrossoverPoint2, Len(strBuffer)) = Right$(strChromo2Mask, Len(strChromo1Mask) - (intCrossoverPoint2) + 1)
            Mid$(strChromo2Mask, intCrossoverPoint2, Len(strBuffer)) = strBuffer
            
        
        Case GACrossoverUniform
            ' uniform
            ' swap bits in both parents depending on a random propability
            For intX = 1 To Len(strChromo1)
                If Mid$(strChromo1, intX, 1) <> Mid$(strChromo2, intX, 1) Then
                    If Rnd < cCrossoverUniform Then
                        If Mid$(strChromo1Mask, intX, 1) <> "N" And Mid$(strChromo2Mask, intX, 1) <> "N" Then
                            ' perform crossover
                            strBuffer = Mid$(strChromo1, intX, 1)
                            Mid$(strChromo1, intX, 1) = Mid$(strChromo2, intX, 1)
                            Mid$(strChromo2, intX, 1) = strBuffer
                            ' rebuild masks
                            strBuffer = Mid$(strChromo1Mask, intX, 1)
                            Mid$(strChromo1Mask, intX, 1) = Mid$(strChromo2Mask, intX, 1)
                            Mid$(strChromo2Mask, intX, 1) = strBuffer
                        
                        End If
                    End If
                End If
            Next intX
        
        Case GACrossoverHalfUniform
            ' Half uniform, only half the nonmatching bits will be swapped
            ReDim intHUpositions(0)
            intY = 0 ' holds the amount of differing bits
            For intX = 1 To Len(strChromo1)
                If Mid$(strChromo1, intX, 1) <> Mid$(strChromo2, intX, 1) Then
                    If Mid$(strChromo1Mask, intX, 1) <> "N" And Mid$(strChromo2Mask, intX, 1) <> "N" Then
                        intY = intY + 1
                        ReDim Preserve intHUpositions(intY)
                        intHUpositions(intY) = intX
                    End If
                End If
            Next intX
            If intY > 0 Then
                ' jumble the positions, so that random bits of half of the
                ' nonmatching ones will be swapped
                For intX = 1 To Len(strChromo1)
                    intPosition1 = Int(Rnd * intY) + 1
                    intPosition2 = Int(Rnd * intY) + 1
                    intPosBuffer = intHUpositions(intPosition1)
                    intHUpositions(intPosition1) = intHUpositions(intPosition2)
                    intHUpositions(intPosition2) = intPosBuffer
                Next intX
                '
                ' now perform the swap on half the nonmatching files
                For intX = 1 To Int((intY / 2) + 0.5)
                    strBuffer = Mid$(strChromo1, intHUpositions(intX), 1)
                    Mid$(strChromo1, intHUpositions(intX), 1) = Mid$(strChromo2, intHUpositions(intX), 1)
                    Mid$(strChromo2, intHUpositions(intX), 1) = strBuffer
                    ' rebuild masks
                    strBuffer = Mid$(strChromo1Mask, intHUpositions(intX), 1)
                    Mid$(strChromo1Mask, intHUpositions(intX), 1) = Mid$(strChromo2Mask, intHUpositions(intX), 1)
                    Mid$(strChromo2Mask, intHUpositions(intX), 1) = strBuffer
                Next intX
            
            End If
            
    End Select

Return


'
' -----------------------------------------------------------
' Mutata full gene
' -----------------------------------------------------------
'
MutateThefullGene:
    '
    ' Mutate a full gene
    
    ' Mutate a single gene in chromo1 and/or chromo2
    ' if a random numer is smaller than mutationrate
    
    For intX = 1 To 2
    
        If Rnd < mActualMutationRate Then
            intGeneToMutate = Int(Rnd * mGenesPerChromosome)
        
            Select Case mChromosomeType
                Case GAEncodingBinary  ' Binarystring
                    If intX = 1 Then
                        ' First chromosome
                        strGenesChromo1(intGeneToMutate) = RandomBinaryGene
                    
                    Else
                        ' Second chromosome
                        strGenesChromo2(intGeneToMutate) = RandomBinaryGene
                        
                    End If
    
                Case GAEncodingAlphabetic ' alphabetic characters
                    If intX = 1 Then
                        ' First chromosome
                        strGenesChromo1(intGeneToMutate) = RandomAlphabeticGene
                    
                    Else
                        ' Second chromosome
                        strGenesChromo2(intGeneToMutate) = RandomAlphabeticGene
                    
                    End If
    
                Case GAEncodingLongNbr  ' Long numbers
                    If intX = 1 Then
                        ' First chromosome
                        lngGenesChromo1(intGeneToMutate) = RandomLongGene
                    
                    Else
                        ' Second chromosome
                        lngGenesChromo2(intGeneToMutate) = RandomLongGene
                    
                    End If
    
                Case GAEncodingDouble   ' Double numbers (real numbers)
                    If intX = 1 Then
                        ' First chromosome
                        dblGenesChromo1(intGeneToMutate) = RandomDoubleGene
                    
                    Else
                        ' Second chromosome
                        dblGenesChromo2(intGeneToMutate) = RandomDoubleGene
                    
                    End If
        
            End Select
        
            ' counter
            mMutationCounter = mMutationCounter + 1
        
        End If
        
    Next intX

Return


'
' -----------------------------------------------------------
' Mutate anywhere in the gene (bit level)
' -----------------------------------------------------------
'
MutateAnywhereInGene:
    '
    ' Mutate only 1 element (bit) in a chromosome
    
    For intX = 1 To 2
    
        If Rnd < mActualMutationRate Then
            intGeneToMutate = Int(Rnd * mGenesPerChromosome)
    
            Select Case mChromosomeType
                Case GAEncodingBinary  ' Binarystring
                
                    intBitToMutate = Int(Rnd * mBinaryGeneLength) + 1
                    
                    If intX = 1 Then
                        ' first chromosome
                        If Mid$(strGenesChromo1(intGeneToMutate), intBitToMutate, 1) = "0" Then
                            Mid$(strGenesChromo1(intGeneToMutate), intBitToMutate, 1) = "1"
                        Else
                            Mid$(strGenesChromo1(intGeneToMutate), intBitToMutate, 1) = "0"
                        End If
                    
                    Else
                        ' second chromosome
                        If Mid$(strGenesChromo2(intGeneToMutate), intBitToMutate, 1) = "0" Then
                            Mid$(strGenesChromo2(intGeneToMutate), intBitToMutate, 1) = "1"
                        Else
                            Mid$(strGenesChromo2(intGeneToMutate), intBitToMutate, 1) = "0"
                        End If
                        
                    End If
                    
                Case GAEncodingAlphabetic ' alphabetic characters
                    
                    intBitToMutate = Int(Rnd * mAlphabeticGeneLength) + 1
                    
                    If intX = 1 Then
                        ' first chromosome
                        Do
                            strBuffer = Chr$(Int((Rnd * 26) + 1) + 64)
                        Loop Until Mid$(strGenesChromo1(intGeneToMutate), intBitToMutate, 1) <> strBuffer
                        Mid$(strGenesChromo1(intGeneToMutate), intBitToMutate, 1) = strBuffer
                    
                    Else
                        ' second chromosome
                        Do
                            strBuffer = Chr$(Int((Rnd * 26) + 1) + 64)
                        Loop Until Mid$(strGenesChromo2(intGeneToMutate), intBitToMutate, 1) <> strBuffer
                        Mid$(strGenesChromo2(intGeneToMutate), intBitToMutate, 1) = strBuffer
                    
                    End If
    
                Case GAEncodingLongNbr  ' Long numbers
                    
                    If mMutationBitlikeLongDouble = False Then
                        ' add or subtract a rendom value
                        ' the random value does not exceed a given percentage of the maximum gene-value
                        dblLongDoubleMutateValue = LngNull(Int(Rnd * (mLongGeneMaxValue / 100 * mMutationBitlikePercentage)))
                        If Rnd < 0.5 Then
                            ' add
                            If intX = 1 Then
                                lngGenesChromo1(intGeneToMutate) = lngGenesChromo1(intGeneToMutate) + dblLongDoubleMutateValue
                                If lngGenesChromo1(intGeneToMutate) > mLongGeneMaxValue Then
                                    lngGenesChromo1(intGeneToMutate) = mLongGeneMaxValue
                                Else
                                    If lngGenesChromo1(intGeneToMutate) < mLongGeneMinValue Then
                                        lngGenesChromo1(intGeneToMutate) = mLongGeneMinValue
                                    End If
                                End If
                            Else
                                lngGenesChromo2(intGeneToMutate) = lngGenesChromo2(intGeneToMutate) + dblLongDoubleMutateValue
                                If lngGenesChromo2(intGeneToMutate) > mLongGeneMaxValue Then
                                    lngGenesChromo2(intGeneToMutate) = mLongGeneMaxValue
                                Else
                                    If lngGenesChromo2(intGeneToMutate) < mLongGeneMinValue Then
                                        lngGenesChromo2(intGeneToMutate) = mLongGeneMinValue
                                    End If
                                End If
                            End If
                        Else
                            ' subtract
                            If intX = 1 Then
                                lngGenesChromo1(intGeneToMutate) = lngGenesChromo1(intGeneToMutate) - dblLongDoubleMutateValue
                                If lngGenesChromo1(intGeneToMutate) > mLongGeneMaxValue Then
                                    lngGenesChromo1(intGeneToMutate) = mLongGeneMaxValue
                                Else
                                    If lngGenesChromo1(intGeneToMutate) < mLongGeneMinValue Then
                                        lngGenesChromo1(intGeneToMutate) = mLongGeneMinValue
                                    End If
                                End If
                            Else
                                lngGenesChromo2(intGeneToMutate) = lngGenesChromo2(intGeneToMutate) - dblLongDoubleMutateValue
                                If lngGenesChromo2(intGeneToMutate) > mLongGeneMaxValue Then
                                    lngGenesChromo2(intGeneToMutate) = mLongGeneMaxValue
                                Else
                                    If lngGenesChromo2(intGeneToMutate) < mLongGeneMinValue Then
                                        lngGenesChromo2(intGeneToMutate) = mLongGeneMinValue
                                    End If
                                End If
                            End If
                        
                        End If
                        
                    Else
                        ' Bit-like mutation (as in binary mutation)
                    
                        If intX = 1 Then
                            ' first chromosome
                            strBuffer = String$(mintLongActualLength, "0")
                            RSet strBuffer = Trim$(StrNull(lngGenesChromo1(intGeneToMutate)))
                            strBuffer = Replace$(strBuffer, " ", "0")
                            strbufferMask = CreateMaskLongGene(mlngSelectedIndex1, intGeneToMutate, lngGenesChromo1(intGeneToMutate))
                            
                            Do
                                intBitToMutate = Int(Rnd * Len(strBuffer)) + 1
                                Do
                                    strChar = Chr$(Int(LngNull(Rnd * 10) + 1) + 47)
                                Loop Until Mid$(strBuffer, intBitToMutate, 1) <> strChar
                            Loop Until Mid$(strbufferMask, intBitToMutate, 1) = ">"
                            Mid$(strBuffer, intBitToMutate, 1) = strChar
                            ' make sure the value is not higher than the highest set or lower than the lowest set
                            If LngNull(strBuffer) > mLongGeneMaxValue Then
                                strBuffer = StrNull(mLongGeneMaxValue)
                            Else
                                If LngNull(strBuffer) < mLongGeneMinValue Then
                                    strBuffer = StrNull(mLongGeneMinValue)
                                End If
                            End If
                            strBuffer = Replace$(strBuffer, " ", "0")
                            lngGenesChromo1(intGeneToMutate) = LngNull(strBuffer)
                    
                        Else
                            ' second chromosome
                            strBuffer = String$(mintLongActualLength, "0")
                            RSet strBuffer = Trim$(StrNull(lngGenesChromo2(intGeneToMutate)))
                            strBuffer = Replace$(strBuffer, " ", "0")
                            strbufferMask = CreateMaskLongGene(mlngSelectedIndex2, intGeneToMutate, lngGenesChromo2(intGeneToMutate))
                            
                            Do
                                intBitToMutate = Int(Rnd * Len(strBuffer)) + 1
                                Do
                                    strChar = Chr$(Int(LngNull(Rnd * 10) + 1) + 47)
                                Loop Until Mid$(strBuffer, intBitToMutate, 1) <> strChar
                            Loop Until Mid$(strbufferMask, intBitToMutate, 1) = ">"
                            Mid$(strBuffer, intBitToMutate, 1) = strChar
                            ' make sure the value is not higher than the highest set or lower...
                            If LngNull(strBuffer) > mLongGeneMaxValue Then
                                strBuffer = StrNull(mLongGeneMaxValue)
                            Else
                                If LngNull(strBuffer) < mLongGeneMinValue Then
                                    strBuffer = StrNull(mLongGeneMinValue)
                                End If
                            End If
                            strBuffer = Replace$(strBuffer, " ", "0")
                            lngGenesChromo2(intGeneToMutate) = LngNull(strBuffer)
                    
                        End If
                    End If
                    
                Case GAEncodingDouble   ' Double numbers (real numbers)
                
                    If mMutationBitlikeLongDouble = False Then
                        ' add or subtract a rendom value
                        ' the random value does not exceed a given percentage of the maximum gene-value
                        dblHelp = (((mDoubleGeneMaxValue - mDoubleGeneMinValue) / 100) * mMutationBitlikePercentage)
                        dblLongDoubleMutateValue = DblNull(Int(Rnd * dblHelp)) + mDoubleGeneMinValue
                        If Rnd < 0.5 Then
                            ' add
                            If intX = 1 Then
                                dblGenesChromo1(intGeneToMutate) = dblGenesChromo1(intGeneToMutate) + dblLongDoubleMutateValue
                                If dblGenesChromo1(intGeneToMutate) > mDoubleGeneMaxValue Then
                                    dblGenesChromo1(intGeneToMutate) = mDoubleGeneMaxValue
                                End If
                            Else
                                dblGenesChromo2(intGeneToMutate) = dblGenesChromo2(intGeneToMutate) + dblLongDoubleMutateValue
                                If dblGenesChromo2(intGeneToMutate) > mDoubleGeneMaxValue Then
                                    dblGenesChromo2(intGeneToMutate) = mDoubleGeneMaxValue
                                End If
                            End If
                        Else
                            ' subtract
                            If intX = 1 Then
                                dblGenesChromo1(intGeneToMutate) = dblGenesChromo1(intGeneToMutate) - dblLongDoubleMutateValue
                                If dblGenesChromo1(intGeneToMutate) < mDoubleGeneMinValue Then
                                    dblGenesChromo1(intGeneToMutate) = mDoubleGeneMinValue
                                End If
                            Else
                                dblGenesChromo2(intGeneToMutate) = dblGenesChromo2(intGeneToMutate) - dblLongDoubleMutateValue
                                If dblGenesChromo2(intGeneToMutate) < mDoubleGeneMinValue Then
                                    dblGenesChromo2(intGeneToMutate) = mDoubleGeneMinValue
                                End If
                            End If
                        
                        End If
                        
                    Else
                        ' Bit-like mutation (as in binary mutation)
                
                        If intX = 1 Then
                            strBuffer = String$(mintDoubleActualLength, "0")
                            RSet strBuffer = Trim$(StrNull(dblGenesChromo1(intGeneToMutate)))
                            strBuffer = Replace$(strBuffer, " ", "0")
                            strbufferMask = CreateMaskDoubleGene(mlngSelectedIndex1, intGeneToMutate, dblGenesChromo1(intGeneToMutate))
                            
                            Do
                                intBitToMutate = Int(Rnd * Len(strBuffer)) + 1
                                Do
                                    strChar = Chr$(Int(LngNull(Rnd * 10) + 1) + 47)
                                Loop Until Mid$(strBuffer, intBitToMutate, 1) <> strChar
                            Loop Until Mid$(strbufferMask, intBitToMutate, 1) <> "N"
                            
                            Mid$(strBuffer, intBitToMutate, 1) = strChar
                            ' make sure the gene is between the set values
                            If DblNull(strBuffer) < mDoubleGeneMinValue Then
                                strBuffer = StrNull(mDoubleGeneMinValue)
                            Else
                                If DblNull(strBuffer) > mDoubleGeneMaxValue Then
                                    strBuffer = StrNull(mDoubleGeneMaxValue)
                                End If
                            End If
                            strBuffer = Replace$(strBuffer, " ", "0")
                            dblGenesChromo1(intGeneToMutate) = DblNull(strBuffer)
                    
                        Else
                            ' second chromosome
                            strBuffer = String$(mintDoubleActualLength, "0")
                            RSet strBuffer = Trim$(StrNull(dblGenesChromo2(intGeneToMutate)))
                            strBuffer = Replace$(strBuffer, " ", "0")
                            strbufferMask = CreateMaskDoubleGene(mlngSelectedIndex2, intGeneToMutate, dblGenesChromo2(intGeneToMutate))
                            
                            Do
                                intBitToMutate = Int(Rnd * Len(strBuffer)) + 1
                                Do
                                    strChar = Chr$(Int(LngNull(Rnd * 10) + 1) + 47)
                                Loop Until Mid$(strBuffer, intBitToMutate, 1) <> strChar
                            Loop Until Mid$(strbufferMask, intBitToMutate, 1) <> "N"
                            
                            Mid$(strBuffer, intBitToMutate, 1) = strChar
                            ' make sure the gene is between the set values
                            If DblNull(strBuffer) < mDoubleGeneMinValue Then
                                strBuffer = StrNull(mDoubleGeneMinValue)
                            Else
                                If DblNull(strBuffer) > mDoubleGeneMaxValue Then
                                    strBuffer = StrNull(mDoubleGeneMaxValue)
                                End If
                            End If
                            strBuffer = Replace$(strBuffer, " ", "0")
                            dblGenesChromo2(intGeneToMutate) = DblNull(strBuffer)
        
                        End If
                    End If
        
            End Select
    
            ' counter
            mMutationCounter = mMutationCounter + 1
    
        End If
    
    Next intX
    
Return


'
' -----------------------------------------------------------
' Replace parents
' -----------------------------------------------------------
'
ReplaceParents:
    ' Children replaces their parents
    lngChromoToReplace1 = mlngSelectedIndex1
    lngChromoToReplace2 = mlngSelectedIndex2

Return
    
'
' -----------------------------------------------------------
' Replace random
' -----------------------------------------------------------
'
ReplaceRandom:
    ' children replace two random chromosomes
    lngChromoToReplace1 = LngNull(Int(Rnd * PopulationCount))
    lngChromoToReplace2 = LngNull(Int(Rnd * PopulationCount))

Return
    
'
' -----------------------------------------------------------
' Replace Weakest
' -----------------------------------------------------------
'
ReplaceWeakest:
    ' children replace the two weakest chromosomes from the population
    ' Sort the chromosome array ?
    If mblnSorted = False Then
        Call QuickSortFitness(0, (PopulationCount - 1))
    End If
    lngChromoToReplace1 = PopulationCount - 2
    lngChromoToReplace2 = PopulationCount - 1

Return

'
' -----------------------------------------------------------
' One point crossover
' -----------------------------------------------------------
'
OnePointCrossover:
    strBuffer = Left$(strChromo1, (intCrossoverPoint - 1))
    Mid$(strChromo1, 1, Len(strBuffer)) = Left$(strChromo2, (intCrossoverPoint - 1))
    Mid$(strChromo2, 1, Len(strBuffer)) = strBuffer
    '
    ' also crossover the masks
    strBuffer = Left$(strChromo1Mask, (intCrossoverPoint - 1))
    Mid$(strChromo1Mask, 1, Len(strBuffer)) = Left$(strChromo2Mask, (intCrossoverPoint - 1))
    Mid$(strChromo2Mask, 1, Len(strBuffer)) = strBuffer

Return

'
' -----------------------------------------------------------
' Edge recombination
' -----------------------------------------------------------
'
EdgeRecombination:
    '
    ' Build the nodemap
    '
    ' Loop through both parents. Each unique gene becomes the header of a node
    ' Fill the nodetree with the boundary-genes of each header. Assume first
    ' and last gene of the chromosome to touch, so the first gene has two edge-genes ;
    ' the second and the last gene.
    ' The second gene borders on the first and the third.....
    ' The last gene borders to the one just before it and the first gene...
    
    ReDim Nodemap(0)
    
    intNodeMapIndex = -1
    intNodeMapUbound = -1
    
    For intX = 1 To 2
        If intX = 1 Then
            lngParentIndex = mlngSelectedIndex1
        Else
            lngParentIndex = mlngSelectedIndex2
        End If
        
        For intGeneIndexNodeHead = 0 To (mGenesPerChromosome - 1)
            '
            ' Scan through the entire chromosome, build the nodemap
            ' for every gene
            strNodeHead = ShowGenestring(lngParentIndex, intGeneIndexNodeHead)
            
            ' Does this one allready appear in the nodemap
            blnHeadNodeExists = False
            For intNodeLoop = 0 To intNodeMapUbound
                If Nodemap(intNodeLoop).HeaderElement = strNodeHead Then
                    blnHeadNodeExists = True
                    intNodeMapIndex = intNodeLoop
                    Exit For
                End If
            Next intNodeLoop
                
            If blnHeadNodeExists = False Then
               ' this is a new nodehead
                intNodeMapUbound = intNodeMapUbound + 1
                ReDim Preserve Nodemap(intNodeMapUbound)
                Nodemap(intNodeMapUbound).HeaderElement = strNodeHead
                Nodemap(intNodeMapUbound).UboundEdges = -1
                ReDim Nodemap(intNodeMapUbound).Edges(0)
                intNodeMapIndex = intNodeMapUbound
            End If
                
            '
            ' Now look for the edges of this headergene
            '
            With Nodemap(intNodeMapIndex)
                ' Find the edges and add them to the array
                For intY = 1 To 2
                    If intY = 1 Then
                        ' previous
                        intNodeLoop = intGeneIndexNodeHead - 1
                        If intNodeLoop < 0 Then
                            intNodeLoop = mGenesPerChromosome - 1
                        End If
                    Else
                        ' next
                        intNodeLoop = intGeneIndexNodeHead + 1
                        If intNodeLoop >= mGenesPerChromosome Then
                            intNodeLoop = 0
                        End If
                    End If
                    
                    ' edge
                    strChar = ShowGenestring(lngParentIndex, intNodeLoop)
                    blnEdgeNodeExists = False
                    
                    ' does this one allready exists in the nodemap ?
                    For intEdgeLoop = 0 To .UboundEdges
                        If .Edges(intEdgeLoop).edge = strChar Then
                            blnEdgeNodeExists = True
                            Exit For
                        End If
                    Next intEdgeLoop
                    
                    If blnEdgeNodeExists = False Then
                        ' add this edge to the nodemap
                        .UboundEdges = .UboundEdges + 1
                        ReDim Preserve .Edges(.UboundEdges)
                        .Edges(.UboundEdges).edge = strChar
                        .Edges(.UboundEdges).edgeHeaderIndex = -1
                    End If
                    
                Next intY
            End With
        Next intGeneIndexNodeHead
    Next intX
    '
    ' Fill the headersindexes in the edgeheaderindex for each node
    For intX = 0 To intNodeMapUbound
        For intY = 0 To Nodemap(intX).UboundEdges
            For intZ = 0 To intNodeMapUbound
                If Nodemap(intX).Edges(intY).edge = Nodemap(intZ).HeaderElement Then
                    Nodemap(intX).Edges(intY).edgeHeaderIndex = intZ
                    Exit For
                End If
            Next intZ
        Next intY
    Next intX
    
    ' nodemap is built
    ' It exists in the nodemap-structure
    ' intNodeMapUbound holds the amount of header-nodes.
    ' Inside each structure the UboundEdges holds howmany edge-nodes
    ' The edges-array inside holds the edge and the nodeindex for this edge
    
    ' Only one child is made with edgerecombination
    
    ' Make the child empty
    For intX = 0 To (mGenesPerChromosome - 1)
        strGenesChromo1(intX) = ""
    Next intX

    ' Take the first gene (node) of a random parent
    If Rnd < 0.5 Then
        strNodeHead = ShowGenestring(mlngSelectedIndex1, 0)
    Else
        strNodeHead = ShowGenestring(mlngSelectedIndex2, 0)
    End If

    intX = 0
    Do While intX <= (mGenesPerChromosome - 1)
        ' append the node to the child
        strGenesChromo1(intX) = strNodeHead

        For intY = 0 To intNodeMapUbound
            With Nodemap(intY)
                If .HeaderElement = strNodeHead Then
                    ' this is the nodemap-element for this nodehead
                    ' do nothing
                    intNodeMapIndex = intY
                Else
                    blnReorderEdges = False
                    For intZ = 0 To .UboundEdges
                        If .Edges(intZ).edge = strNodeHead Then
                            .Edges(intZ).edge = ""
                            .Edges(intZ).edgeHeaderIndex = -1
                            blnReorderEdges = True
                            Exit For
                        End If
                    Next intZ
                    
                    ' reorder the edges in this node
                    If blnReorderEdges = True Then
                        intReorderEdges = -1
                        For intZ = 0 To .UboundEdges
                            If .Edges(intZ).edge <> "" Then
                                intReorderEdges = intReorderEdges + 1
                                .Edges(intReorderEdges) = .Edges(intZ)
                            End If
                        Next intZ
                        .UboundEdges = intReorderEdges

                    End If

                End If
            End With
        Next intY
        
        ' is the nodelist for the current head empty ?
        blnEdgeNodeExists = False
        With Nodemap(intNodeMapIndex)
            If .UboundEdges <> -1 Then
                ' is not empty
                blnEdgeNodeExists = True
            End If
        End With

        If blnEdgeNodeExists = True Then
            ' Not empty !
            ' Loop through the edges in the nodemap (for this header-element)
            ' and take the one with fewest edges
            ' (Or a random one if there are multiple)

            intLowestedges = 32000
            For intY = 0 To Nodemap(intNodeMapIndex).UboundEdges
                ' search this edge in the headerelements of the nodemap
                If Nodemap(Nodemap(intNodeMapIndex).Edges(intY).edgeHeaderIndex).UboundEdges < intLowestedges Then
                    intLowestedges = Nodemap(Nodemap(intNodeMapIndex).Edges(intY).edgeHeaderIndex).UboundEdges
                End If
            Next intY

            ' what is the lowest edgecount
            ' fill the array with the indexes of the lowest edges
            ReDim arintLowestedges(0)
            intLowestedgesUbound = -1
            For intY = 0 To Nodemap(intNodeMapIndex).UboundEdges
                If Nodemap(Nodemap(intNodeMapIndex).Edges(intY).edgeHeaderIndex).UboundEdges = intLowestedges Then
                    intLowestedgesUbound = intLowestedgesUbound + 1
                    ReDim Preserve arintLowestedges(intLowestedgesUbound)
                    arintLowestedges(intLowestedgesUbound) = Nodemap(intNodeMapIndex).Edges(intY).edgeHeaderIndex
                End If
            Next intY

            If intLowestedgesUbound = 0 Then
                ' only one, so we take this one
                intNodeMapIndex = arintLowestedges(0)
            
            Else
                ' more than one, take random one
                intNodeMapIndex = arintLowestedges(Int(Rnd * (intLowestedgesUbound + 1)))
            
            End If
            
        Else
            If intX < (mGenesPerChromosome - 1) Then
                ' take a random header hat is not yet in the offspring
                Do
                    intY = Int(Rnd * (intNodeMapUbound + 1))
                    blnNodeExistsInOffspring = False
                    For intZ = 0 To intX
                        If strGenesChromo1(intZ) = Nodemap(intY).HeaderElement Then
                            blnNodeExistsInOffspring = True
                            Exit For
                        End If
                    Next intZ
                Loop Until blnNodeExistsInOffspring = False
                intNodeMapIndex = intY
            End If
        End If

        If intX < (mGenesPerChromosome - 1) Then
            ' the new node
            strNodeHead = Nodemap(intNodeMapIndex).HeaderElement
        
        End If
        
        intX = intX + 1
        
    Loop
    '
    ' the new child is now in strGenesChromo1
    '


Return

'
'
'

errorhandler:

    RaiseEvent GAError(LngNull(Err.Number), "Error in REPRODUCTION ! " & Err.Description)

End Sub

Public Function ShowGenestring(ByVal lngIndex As Long, ByVal intGene As Integer) As String
    '
    ' Returns a string-gene ALL TYPES
    '
    ' lngIndex = index of the chromosome
    ' intGene  = the gene inside the chromosome
    
    Select Case mChromosomeType
        Case GAEncodingBinary, GAEncodingAlphabetic
            ShowGenestring = Chromosome(lngIndex).Genes(intGene).GeneString
            
        Case GAEncodingLongNbr
            ShowGenestring = Trim$(StrNull(Chromosome(lngIndex).Genes(intGene).GeneLong))
    
        Case GAEncodingDouble
            ShowGenestring = Trim$(StrNull(Chromosome(lngIndex).Genes(intGene).GeneDouble))
    
    End Select
    
End Function

Public Function ShowChromosomestring(ByVal lngIndex As Long, Optional varInsertSpace As Variant) As String
    '
    ' Returns a string-Chromosome (all types)
    '
    ' lngIndex = index of the chromosome
    ' varInsertSpace (optional) If this is "TRUE" then a space will be inserted
    ' inbetween genes
    '
    ' This function returns a complete chromosome as a string. All genes concateneted together,
    ' regardless of the type of encoding used. All genes are the same length and for numeric
    ' encoding all spaces are filled with 0 (zeroes).
    '
    ' The internal function is called here. Internally the length of a long or double
    ' gene can vary.
    Dim blnSpace                As Boolean
    
    If IsMissing(varInsertSpace) Then
        blnSpace = False
    Else
        If UCase$(StrNull(varInsertSpace)) = "TRUE" Then
            blnSpace = True
        Else
            blnSpace = False
        End If
    End If
    
    If blnSpace = False Then
        ShowChromosomestring = InternalShowChromosomestring(lngIndex, cLongMaxLength, cDoubleMaxLength)
    Else
        ShowChromosomestring = InternalShowChromosomestring(lngIndex, cLongMaxLength, cDoubleMaxLength, "TRUE")
    End If
    
End Function

Private Function InternalShowChromosomestring(ByVal lngIndex As Long, Optional ByVal varLongLength As Variant, Optional ByVal varDoubleLength As Variant, Optional varInsertSpace As Variant) As String
    '
    ' Optimization
    '
    ' Returns a string-Chromosome (all types)
    '
    ' lngIndex = index of the chromosome
    ' varLongLength = the length of the long genes
    ' varDoubleLength = the length of the double genes
    ' varInsertSpace (optional) If this is "TRUE" then a space will be inserted
    ' inbetween genes
    '
    ' This function returns a complete chromosome as a string. All genes concateneted together,
    ' regardless of the type of encoding used. All genes are the same length and for numeric
    ' encoding all spaces are filled with 0 (zeroes).
    ' For long integer encoding : if varLongLength is missing, the length of the gene
    ' will equal VB max (cLongMaxLength = 11), else it will be mintLongActualLength
    ' For double encoding : if varDoubleLength is missing, the length of the gene
    ' will equal VB max (cDoubleMaxLength = 22), else it will be mintDoubleActualLength
    '
    
    Dim strHelp                 As String
    Dim strHelp2                As String
    Dim strSpace                As String
    
    Dim intX                    As Integer
    Dim intLengthLong           As Integer
    Dim intLengthDouble         As Integer
    
    
    strHelp = ""
    
    If IsMissing(varLongLength) Then
        intLengthLong = cLongMaxLength
    Else
        intLengthLong = mintLongActualLength
    End If
    
    If IsMissing(varDoubleLength) Then
        intLengthDouble = cDoubleMaxLength
    Else
        intLengthDouble = mintDoubleActualLength
    End If
    
    If IsMissing(varInsertSpace) Then
        strSpace = ""
    Else
        If UCase$(StrNull(varInsertSpace)) = "TRUE" Then
            strSpace = " "
        Else
            strSpace = ""
        End If
    End If
    
    For intX = 0 To (mGenesPerChromosome - 1)
        If intX = (mGenesPerChromosome - 1) Then
            strSpace = ""
        End If
        
        Select Case mChromosomeType
            Case GAEncodingBinary, GAEncodingAlphabetic
                strHelp = strHelp & Chromosome(lngIndex).Genes(intX).GeneString & strSpace

            Case GAEncodingLongNbr
                strHelp2 = Space$(intLengthLong)
                RSet strHelp2 = Chromosome(lngIndex).Genes(intX).GeneLong
                strHelp2 = Replace$(strHelp2, " ", "0")
                strHelp = strHelp & strHelp2 & strSpace
                
            Case GAEncodingDouble
                strHelp2 = Space$(intLengthDouble)
                RSet strHelp2 = Chromosome(lngIndex).Genes(intX).GeneDouble
                strHelp2 = Replace$(strHelp2, " ", "0")
                strHelp = strHelp & strHelp2 & strSpace
            
        End Select
    Next intX
    
    InternalShowChromosomestring = strHelp
    
End Function

Private Function CalculateActualLongGeneMaxLength(ByVal lngIndex As Long) As Integer
    '
    ' Optimization
    '
    ' lngIndex = index of the chromosome
    '
    ' This function returns the minimum max length a string must have in
    ' order to be able to hold all the values of the genes in the given
    ' chromosome.
    ' The constant cLongMaxLength holds the maximum length a long can have
    ' in VB6 (which is 11)
    ' With problems involving small values (say between 0 and 9999) you end
    ' up with a string of 7 leading zeroes and 4 characters comprising the
    ' value. Crossover and mutation has more chance to happen in the leading
    ' space, creating too high values in the genes, who will be marked as
    ' invalid in the fitness-function. Or to high according to mLongGeneMaxValue.
    '
    ' Using this function minimizes the leading zeroes, maximizing the
    ' use of crossover and mutation.
    '
    
    Dim intX                    As Integer
    Dim intLength               As Integer
    
    Dim strHelp                 As String
    
    intLength = 0
    
    For intX = 0 To (mGenesPerChromosome - 1)
        strHelp = StrNull(Chromosome(lngIndex).Genes(intX).GeneLong)
        If Len(strHelp) > intLength Then
            intLength = Len(strHelp)
        End If
    Next intX

    ' add 1 for posible leading minus sign
    If intLength < cLongMaxLength Then
        intLength = intLength + 1
    End If
    
    CalculateActualLongGeneMaxLength = intLength
    
End Function

Private Function CalculateActualDoubleGeneMaxLength(ByVal lngIndex As Long) As Integer
    '
    ' Optimization
    '
    ' lngIndex = index of the chromosome
    '
    ' This function returns the minimum max length a string must have in
    ' order to be able to hold all the values of the genes in the given
    ' chromosome.
    ' The constant cDoubleMaxLength holds the maximum length a double can have
    ' in VB6 (which is 22)
    ' With problems involving small values you end
    ' up with a string of leading zeroes and a small amount characters comprising the
    ' value. Crossover and mutation has more chance to happen in the leading
    ' space, creating too high values in the genes, who will be marked as
    ' invalid in the fitness-function. Or to high according to mDoubleGeneMaxValue.
    '
    ' Using this function minimizes the leading zeroes, maximizing the
    ' use of crossover and mutation.
    '
    
    Dim intX                    As Integer
    Dim intLength               As Integer
    
    Dim strHelp                 As String
    
    intLength = 0
    
    For intX = 0 To (mGenesPerChromosome - 1)
        strHelp = StrNull(Chromosome(lngIndex).Genes(intX).GeneDouble)
        ' if an exponent is used, to be on the safe side
        ' the length will be maximal
        If InStr(strHelp, "E") <> 0 Then
            intLength = cDoubleMaxLength
            Exit For
        End If
        If Len(strHelp) > intLength Then
            intLength = Len(strHelp)
        End If
    Next intX

    ' add 1 for posible leading minus sign
    If intLength < cDoubleMaxLength Then
        intLength = intLength + 1
    End If

    CalculateActualDoubleGeneMaxLength = intLength
    
End Function

Private Function CreateMask(ByVal lngIndex As Long) As String
    '
    ' lngIndex = index of the chromosome
    '
    ' This function returns a mask used in REPRODUCTION.
    ' Necessary for long and double encoding when mutation or crossover
    ' is NOT used on full-gene.
    ' Mutation and/or crossover happens on 1 or more points inside a full chromosome, but
    ' longs and doubles can have minussigns, decimal symbols,
    ' the 'E' for scientific exponent (and a value following that 'E'..
    ' The mask is filled with 'N' on locations where
    ' mutation/crossover may not occur, and with '>' before the
    ' decimal point and '<' after the decimal point.
    ' Crossover has to occur for both chromosomes before or
    ' after the decimal point.. or you end up with a value
    ' containing two decimal points => error !
    
    Dim strHelp                 As String
    
    Dim intX                    As Integer
    
    strHelp = ""
    
    For intX = 0 To (mGenesPerChromosome - 1)
        Select Case mChromosomeType
            Case GAEncodingBinary, GAEncodingAlphabetic
                strHelp = strHelp & String$(Len(Chromosome(lngIndex).Genes(intX).GeneString), ">")

            Case GAEncodingLongNbr
                strHelp = strHelp & CreateMaskLongGene(lngIndex, intX)
                
            Case GAEncodingDouble
                strHelp = strHelp & CreateMaskDoubleGene(lngIndex, intX)
            
        End Select
    Next intX
    
    CreateMask = strHelp
    
End Function

Private Function CreateMaskLongGene(ByVal lngIndex As Long, ByVal intGene As Integer, Optional ByVal varLongGene As Variant) As String
    '
    ' Create the mask of a given gene for long encoding
    '

    Dim strHelp                 As String
    Dim strHelp2                As String
    
    Dim lngValue                As Long
    
    Dim intX                    As Integer
    
    strHelp = Space$(mintLongActualLength)
    If IsMissing(varLongGene) Then
        lngValue = Chromosome(lngIndex).Genes(intGene).GeneLong
    Else
        lngValue = LngNull(varLongGene)
    End If
    If lngValue < 0 Then
        ' this is a negative number, place the minussign in front
        ' to avoid possible strange results in two point crossover
        RSet strHelp = (lngValue * (-1))
        Mid$(strHelp, 1, 1) = "-"
    Else
        RSet strHelp = lngValue
    End If
    strHelp = Replace$(strHelp, " ", "0")
    strHelp2 = ""
    For intX = 1 To mintLongActualLength
        If InStr("0123456789", Mid$(strHelp, intX, 1)) <> 0 Then
            strHelp2 = strHelp2 & ">" ' before decimal point...
        Else
            strHelp2 = strHelp2 & "N"
        End If
    Next intX
    CreateMaskLongGene = strHelp2

End Function

Private Function CreateMaskDoubleGene(ByVal lngIndex As Long, ByVal intGene As Integer, Optional ByVal varDoubleGene As Variant) As String
    '
    ' Create the mask of a given gene for double encoding
    '

    Dim strHelp                 As String
    Dim strHelp2                As String
    
    Dim intX                    As Integer
    
    Dim dblValue                As Double
    
    Dim blnEncounteredE         As Boolean
    Dim blnBeforeDecimalPoint   As Boolean
    
    strHelp = Space$(mintDoubleActualLength)
    If IsMissing(varDoubleGene) Then
        dblValue = Chromosome(lngIndex).Genes(intGene).GeneDouble
    Else
        dblValue = DblNull(varDoubleGene)
    End If
    If dblValue < 0 Then
        ' this is a negative number, place the minussign in front
        ' to avoid possible strange results in two point crossover
        RSet strHelp = (dblValue * (-1))
        Mid$(strHelp, 1, 1) = "-"
    Else
        RSet strHelp = dblValue
    End If
    strHelp = Replace$(strHelp, " ", "0")
    strHelp2 = String$(mintDoubleActualLength, "N")
    
    blnEncounteredE = False
    blnBeforeDecimalPoint = True
    
    For intX = 1 To mintDoubleActualLength
        If blnEncounteredE = False Then
            If InStr("0123456789", Mid$(strHelp, intX, 1)) <> 0 Then
                If blnBeforeDecimalPoint = True Then
                    Mid$(strHelp2, intX, 1) = ">"
                Else
                    Mid$(strHelp2, intX, 1) = "<"
                End If
            Else
                If InStr(".,", Mid$(strHelp, intX, 1)) <> 0 Then
                    blnBeforeDecimalPoint = False
                End If
                If Mid$(strHelp, intX, 1) = "E" Then
                    blnEncounteredE = True
                End If
            End If
        Else
            ' nothing
        End If
    Next intX
    CreateMaskDoubleGene = strHelp2

End Function

Public Function ShowGenelong(ByVal lngIndex As Long, ByVal intGene As Integer) As Long
    '
    ' Returns a long-gene
    '
    ' lngIndex = index of the chromosome
    ' intGene  = the gene inside the chromosome
    
    ShowGenelong = Chromosome(lngIndex).Genes(intGene).GeneLong
    
End Function

Public Function ShowGenedouble(ByVal lngIndex As Long, ByVal intGene As Integer) As Double
    '
    ' Returns a double-gene
    '
    ' lngIndex = index of the chromosome
    ' intGene  = the gene inside the chromosome
    
    ShowGenedouble = Chromosome(lngIndex).Genes(intGene).GeneDouble
    
End Function

Public Function ShowFitness(ByVal lngIndex As Long) As Double
    '
    ' Returns the fitness of a given chromosome
    '
    ' lngIndex = index of the chromosome

    ShowFitness = Chromosome(lngIndex).Fitness
    
End Function

Private Function CalculateStandardDeviation() As Double
    '
    ' Returns the statistical Standard deviation of the fitnesses
    '
    
    Dim dblMean                 As Double
    Dim dblVariance             As Double
    Dim dblDiff                 As Double
    Dim dblDiffPwr              As Double
    
    Dim lngIndex                As Long
    
    
    dblVariance = 0
    
    dblMean = MeanAverage
    
    For lngIndex = 0 To (PopulationCount - 1)
        dblDiff = Chromosome(lngIndex).Fitness - dblMean
    
        dblDiffPwr = dblDiff ^ 2
        
        dblVariance = dblVariance + dblDiffPwr
        
    Next lngIndex
    
    If PopulationCount <> 0 Then
        CalculateStandardDeviation = dblVariance / PopulationCount
    Else
        CalculateStandardDeviation = 0
    End If

End Function

Public Sub ClearCounters()
    '
    ' Reset the counters to zero
    '
    ReDim mStatistics(0)
    
    mGeneration = 0
    
    mCrossoverCounter = 0
    mMutationCounter = 0
    mRandomOffspringCounter = 0
    mSocialDisasterCounter = 0
    
End Sub

Private Sub SocialDisaster()
    '
    ' Social disaster
    '
    
    On Local Error GoTo errorhandler
    
    Dim lngIndex                As Long
    Dim lngSocDivCounter        As Long

    Dim dblPrevFitness          As Double
    Dim dblPercentage           As Double

    Dim blnFirstOfGroup         As Boolean
    
    Dim NewChromosome           As ChromosomeindividualType

    If mSocDisGeneticDiv <> 0 Then
        ' check the genetic diversity of the population
        '

        lngSocDivCounter = GeneticDiversity
        
        
        '
        ' Howmany different in percentage
        '
        dblPercentage = DblNull(lngSocDivCounter) / DblNull(PopulationCount) * 100
    
        If dblPercentage <= mSocDisGeneticDiv Then
            '
            ' Social disaster has to occur
            '
            Select Case mSocDisMethod
                Case GASocialDisasterPacking
                    '
                    ' Within each group with same values, one
                    ' survives, all the others are randomized
                    '
                    dblPrevFitness = 0
                    blnFirstOfGroup = True
    
                    For lngIndex = 0 To (PopulationCount - 1)
                        ' check howmany different fitness values there are
                        If Chromosome(lngIndex).Fitness <> dblPrevFitness Then
                            dblPrevFitness = Chromosome(lngIndex).Fitness
                            blnFirstOfGroup = True
                
                        End If
                        
                        If blnFirstOfGroup = False Then
                            ' randomize
                            NewChromosome = CreateRandomChromosome(3)

                            Chromosome(lngIndex) = NewChromosome

                            Chromosome(lngIndex).Fitness = 1E+300
                            Chromosome(lngIndex).RecalculateFitness = True
                            
                        Else
                            blnFirstOfGroup = False
                        End If
                    Next lngIndex
                
                Case GASocialDisasterJudgementDay
                    '
                    ' Only the strongest chromosome survives
                    ' all others are randomized
                    '
                    For lngIndex = 1 To (PopulationCount - 1)

                        NewChromosome = CreateRandomChromosome(3)

                        Chromosome(lngIndex) = NewChromosome

                        Chromosome(lngIndex).Fitness = 1E+300
                        Chromosome(lngIndex).RecalculateFitness = True

                    Next lngIndex
    
            End Select
    
            mSocialDisasterCounter = mSocialDisasterCounter + 1
        
            ' Statistics
            If mblnKeepStatistics = True Then
                mStatistics(Generation).SocialDisasterOccured = True
            End If
        
            mblnAllFitnessCalculated = False
            mblnSorted = False
    
        End If
    
    End If

Exit Sub

errorhandler:

    RaiseEvent GAError(LngNull(Err.Number), "Error in SocialDisaster ! " & Err.Description)

End Sub

Private Function GeneticDiversity() As Long
    '
    ' check the genetic diversity of the population
    '
    Dim dblPrevFitness          As Double
    
    Dim lngDifferentCounter     As Long
    Dim lngIndex                As Long
    
    ' Sort the chromosome array ?
    If mblnSorted = False Then
        Call QuickSortFitness(0, (PopulationCount - 1))
    End If
    
    dblPrevFitness = 0
    lngDifferentCounter = 0
    
    For lngIndex = 0 To (PopulationCount - 1)
        ' check howmany different fitness values there are
        If Chromosome(lngIndex).Fitness <> dblPrevFitness Then
            lngDifferentCounter = lngDifferentCounter + 1
            dblPrevFitness = Chromosome(lngIndex).Fitness
        End If
    Next lngIndex

    GeneticDiversity = lngDifferentCounter

End Function

Public Sub SaveGASettings(ByVal strFile As String)
    '
    ' Saves the settings in a file
    '
    ' strFile : the path and filename
    '
    
    On Local Error GoTo errorhandler
    
    Dim intFile                 As Integer
    
    If Len(Dir$(strFile)) <> 0 Then
        Kill strFile
    End If
    
    intFile = FreeFile
    
    Open strFile For Output As intFile
    
    ' save the settings
    Call SaveParameters(intFile)
    
    Close #intFile

Exit Sub

errorhandler:

    RaiseEvent GAError(LngNull(Err.Number), "Error in SaveGASettings ! " & Err.Description)

End Sub

Private Sub SaveParameters(ByVal intFile As Integer)
    '
    ' Save the GA-settings in the given file
    '

    ' Description
    Print #intFile, "DESCRIPTION : " & Description
    
    ' population size
    Print #intFile, "POPULATIONSIZE : " & PopulationSize
    
    ' encoding
    Print #intFile, "ENCODINGTYPE : " & ChromosomeType
    
    ' binary gene length
    Print #intFile, "BINARYGENELENGTH : " & BinaryGeneLength
    
    ' alphabetic gene length
    Print #intFile, "ALPHABETICGENELENGTH : " & AplhabeticGeneLength
    
    ' Minimum value long
    Print #intFile, "MINVALUELONG : " & LongGeneMinValue
    
    ' maximum value long
    Print #intFile, "MAXVALUELONG : " & LongGeneMaxValue
    
    ' minimum value double
    Print #intFile, "MINVALUEDOUBLE : " & DoubleGeneMinValue
    
    ' Maximum value double
    Print #intFile, "MAXVALUEDOUBLE : " & DoubleGeneMaxValue
    
    ' genes per chromosome
    Print #intFile, "GENESPERCHROMOSOME : " & GenesPerChromosome
    
    ' selection method
    Print #intFile, "SELECTIONMETHOD : " & SelectionMethod
    
    ' tournament size
    Print #intFile, "TOURNAMENTSIZE : " & TournamentSize
    
    ' crossoverfullgene
    Print #intFile, "CROSSOVERFULLGENE : " & CrossoverFullGene
    
    ' crossoverrate
    Print #intFile, "CROSSOVERRATE : " & CrossoverRate
    
    ' crossovermethod
    Print #intFile, "CROSSOVERMETHOD : " & CrossoverMethod
    
    ' random offspring generation
    Print #intFile, "RANDOMOFFSPRINGGENERATION : " & RandomOffspringGeneration
    
    ' mutate full gene
    Print #intFile, "MUTATEFULLGENE : " & MutateFullGene
    
    ' mutationrate
    Print #intFile, "MUTATIONRATE : " & MutationRate
    
    ' mutationmethod
    Print #intFile, "MUTATIONMETHOD : " & MutationMethod
    
    ' AMR generations
    Print #intFile, "AMRGENERATIONS : " & AMRGenerations
    
    ' Bitlike mutation for long or double
    Print #intFile, "BITLIKEMUTATIONLONGDOUBLE : " & MutationBitlikeLongDouble
    
    ' percentage of maxvalue for bitlike mutation
    Print #intFile, "BITLIKEMUTATIONPERCENTAGE : " & MutationBitlikePercentage
    
    ' social disaster percent
    Print #intFile, "SOCIALDISASTERDIVERSITY : " & SocialDisasterDiversity
    
    ' social disaster check every x generations
    Print #intFile, "SOCIALDISASTERGENERATIONS : " & SocialDisasterGenerations
    
    ' social disaster type
    Print #intFile, "SOCIALDISASTERMETHOD : " & SocialDisasterMethod
    
    ' reproduction method
    Print #intFile, "REPRODUCTIONMETHOD : " & ReproductionMethod
    
    ' statistics
    Print #intFile, "KEEPFULLSTATISTICS : " & KeepStatistics

End Sub

Public Sub SaveGAStatistics(ByVal strFile As String)
    '
    ' Saves the statistics in a file
    '
    ' strFile : the path and filename
    '
    
    On Local Error GoTo errorhandler
    
    Dim intFile                 As Integer
    
    Dim lngIndex                As Long
    
    Dim strLine                 As String
    Dim strUnderLine            As String
    Dim strHulp                 As String
    
    If Len(Dir$(strFile)) <> 0 Then
        Kill strFile
    End If
    
    intFile = FreeFile
    
    Open strFile For Output As intFile
    
    '
    ' Header
    Print #intFile, "Genetic Algorithm Statistics"
    Print #intFile, "----------------------------"
    Print #intFile, "Date/time : " & Now
    Print #intFile, ""
    Print #intFile, "GA settings description : " & Description
    Print #intFile, ""
    Print #intFile, "Best chromosome : " & ShowChromosomestring(0, "TRUE")
    Print #intFile, ""
    Print #intFile, "GA SETTINGS"
    Print #intFile, "-----------"
    
    ' save the settings
    ' in this way the settings are also visible in the statistics-file
    Call SaveParameters(intFile)
    
    Print #intFile, ""
    
    '
    ' Counters
    Print #intFile, "COUNTERS"
    Print #intFile, "--------"
    
    Print #intFile, "Generation            : " & Generation
    Print #intFile, "Lowest fitness-score  : " & FitnessLowest
    Print #intFile, "Highest fitness-score : " & FitnessHighest
    Print #intFile, "Crossovers            : " & CounterCrossovers
    Print #intFile, "Mutations             : " & CounterMutations
    Print #intFile, "Actual MutationRate   : " & ActualMutationRate
    Print #intFile, "Random offsprings     : " & CounterRandomOffsprings
    Print #intFile, "Social Disasters      : " & CounterDisasters
    
    Print #intFile, ""
    
    '
    ' Statistics
    Print #intFile, "STATISTICS"
    Print #intFile, "----------"
    
    If KeepStatistics = True Then
        '
        ' header
        Print #intFile, ""
        
        ' generation
        strLine = "Generation"
        strUnderLine = String(13, "-")
        
        ' MutationRate
        strHulp = "Mut.Rate."
        strUnderLine = strUnderLine & String(12, "-")
        strLine = strLine & " | " & strHulp
                
        ' lowest fitness
        strHulp = "Lowest Fitness        "
        strUnderLine = strUnderLine & String(25, "-")
        strLine = strLine & " | " & strHulp
        
        ' Highest fitness
        strHulp = "Highest Fitness       "
        strUnderLine = strUnderLine & String(25, "-")
        strLine = strLine & " | " & strHulp
        
        ' Standard deviation
        strHulp = "Standard deviation    "
        strUnderLine = strUnderLine & String(25, "-")
        strLine = strLine & " | " & strHulp
        
        ' Social diversity
        strHulp = "Soc. Divers."
        strUnderLine = strUnderLine & String(14, "-")
        strLine = strLine & " | " & strHulp
        
        ' Social disaster counter
        strHulp = "SD counter  "
        strUnderLine = strUnderLine & String(14, "-")
        strLine = strLine & " | " & strHulp
    
        ' Disaster occures
        strHulp = "Disaster"
        strUnderLine = strUnderLine & String(11, "-")
        strLine = strLine & " | " & strHulp
        
        ' Roulettewheel overflow
        strHulp = "RW. Overfl."
        strUnderLine = strUnderLine & String(15, "-")
        strLine = strLine & " | " & strHulp
        
        ' Best Chromosome
        strHulp = "Best chromosome"
        strUnderLine = strUnderLine & String(40, "-")
        strLine = strLine & " | " & strHulp
    
    
        Print #intFile, strLine
        Print #intFile, strUnderLine
    
        '
        ' Detail
        For lngIndex = 0 To (Generation - 1)
    
            ' generation
            strLine = Space$(10)
            RSet strLine = lngIndex
            strLine = strLine
        
            ' MutationRate
            strHulp = Space$(9)
            RSet strHulp = Format$(StatisticsMutationRate(lngIndex), "0.00")
            strLine = strLine & " | " & strHulp
            
            ' lowest fitness
            strHulp = Space$(22)
            LSet strHulp = StatisticsLowestFitness(lngIndex)
            strLine = strLine & " | " & strHulp
        
            ' highest fitness
            strHulp = Space$(22)
            LSet strHulp = StatisticsHighestFitness(lngIndex)
            strLine = strLine & " | " & strHulp
        
            ' Fitness standard deviation
            strHulp = Space$(22)
            LSet strHulp = StatisticsStandardDeviation(lngIndex)
            strLine = strLine & " | " & strHulp
    
            ' Social divercity
            strHulp = Space$(12)
            RSet strHulp = StatisticsSocialDivercity(lngIndex)
            strLine = strLine & " | " & strHulp
    
            ' Social disaster counter
            strHulp = Space$(9)
            RSet strHulp = StatisticsDisasterGenerationCounter(lngIndex)
            strLine = strLine & " | " & strHulp
            
            ' Social disaster occured
            If StatisticsDisasterOccured(lngIndex) = True Then
                strHulp = "TRUE "
            Else
                strHulp = "FALSE"
            End If
            strLine = strLine & "    | " & strHulp
    
            ' Roulettewheel overflow
            If StatisticsRouletteWheelOverflow(lngIndex) = True Then
                strHulp = "TRUE "
            Else
                strHulp = "FALSE"
            End If
            strLine = strLine & "    |    " & strHulp
    
            ' Best chromosome
            strLine = strLine & "    | " & StatisticsBestChromosome(lngIndex)
            
            
            
            Print #intFile, strLine
    
        Next lngIndex
    Else
    
        Print #intFile, "No statistics availiable. Statistics recording is disabled."
    
    End If
    
    Close #intFile

Exit Sub

errorhandler:

    RaiseEvent GAError(LngNull(Err.Number), "Error in SaveGAStatistics ! " & Err.Description)

End Sub

Public Sub ReadGASettings(ByVal strFile As String)
    '
    ' LOad the settings from a file
    '
    ' strFile : the path and filename
    '
    
    On Local Error GoTo errorhandler
    
    Dim intFile                 As Integer
    Dim intPos                  As Integer
    
    Dim strLine                 As String
    
    If Len(Dir$(strFile)) <> 0 Then
    
        intFile = FreeFile
        
        Open strFile For Input As intFile
        
        Do Until EOF(intFile)
            Line Input #intFile, strLine
        
            intPos = InStr(strLine, ":")
        
            If intPos <> 0 Then
        
                Select Case Trim$(Left$(strLine, intPos - 1))
                    Case "DESCRIPTION"
                        ' Description
                        Description = Trim$(Right$(strLine, Len(strLine) - intPos))
        
                    Case "POPULATIONSIZE"
                        ' population size
                        PopulationSize = LngNull(Right$(strLine, Len(strLine) - intPos))
        
                    Case "ENCODINGTYPE"
                        ' encoding
                        ChromosomeType = IntNull(Right$(strLine, Len(strLine) - intPos))
    
                    Case "BINARYGENELENGTH"
                        ' binary gene length
                        BinaryGeneLength = IntNull(Right$(strLine, Len(strLine) - intPos))
    
                    Case "ALPHABETICGENELENGTH"
                        ' alphabetic gene length
                        AplhabeticGeneLength = IntNull(Right$(strLine, Len(strLine) - intPos))
    
                    Case "MINVALUELONG"
                        ' minimum value long
                        LongGeneMinValue = LngNull(Right$(strLine, Len(strLine) - intPos))
    
                    Case "MAXVALUELONG"
                        ' maximum value long
                        LongGeneMaxValue = LngNull(Right$(strLine, Len(strLine) - intPos))
    
                    Case "MINVALUEDOUBLE"
                        ' minimum value double
                        DoubleGeneMinValue = DblNull(ConvertCommaToSystemdecimalseparator(Right$(strLine, Len(strLine) - intPos)))
        
                    Case "MAXVALUEDOUBLE"
                        ' Maximum value double
                        DoubleGeneMaxValue = DblNull(ConvertCommaToSystemdecimalseparator(Right$(strLine, Len(strLine) - intPos)))
    
                    Case "GENESPERCHROMOSOME"
                        ' genes per chromosome
                        GenesPerChromosome = IntNull(Right$(strLine, Len(strLine) - intPos))
                    
                    Case "SELECTIONMETHOD"
                        ' selection method
                        SelectionMethod = IntNull(Right$(strLine, Len(strLine) - intPos))
        
                    Case "TOURNAMENTSIZE"
                        ' tournament size
                        TournamentSize = LngNull(Right$(strLine, Len(strLine) - intPos))
                    
                    Case "CROSSOVERFULLGENE"
                        ' crossoverfullgene
                        Select Case UCase$(Trim$(Right$(strLine, Len(strLine) - intPos)))
                            Case "TRUE"
                                CrossoverFullGene = True
        
                            Case "FALSE"
                                CrossoverFullGene = False
                                
                            Case Else
                                CrossoverFullGene = CBool(Trim$(Right$(strLine, Len(strLine) - intPos)))
                        
                        End Select
                        
                    Case "CROSSOVERRATE"
                        ' crossoverrate
                        CrossoverRate = DblNull(ConvertCommaToSystemdecimalseparator(Right$(strLine, Len(strLine) - intPos)))
        
                    Case "CROSSOVERMETHOD"
                        ' crossovermethod
                        CrossoverMethod = IntNull(Right$(strLine, Len(strLine) - intPos))
        
                    Case "RANDOMOFFSPRINGGENERATION"
                        ' random offspring generation
                        Select Case UCase$(Trim$(Right$(strLine, Len(strLine) - intPos)))
                            Case "TRUE"
                                RandomOffspringGeneration = True
                                
                            Case "FALSE"
                                RandomOffspringGeneration = False
                                
                            Case Else
                                RandomOffspringGeneration = CBool(Trim$(Right$(strLine, Len(strLine) - intPos)))
                        
                        End Select
                        
                    Case "MUTATEFULLGENE"
                        ' mutate full gene
                        Select Case UCase$(Trim$(Right$(strLine, Len(strLine) - intPos)))
                            Case "TRUE"
                                MutateFullGene = True
                                
                            Case "FALSE"
                                MutateFullGene = False
                                
                            Case Else
                                MutateFullGene = CBool(Trim$(Right$(strLine, Len(strLine) - intPos)))
                                
                        End Select
                        
                    Case "MUTATIONRATE"
                        ' mutationrate
                        MutationRate = DblNull(ConvertCommaToSystemdecimalseparator(Right$(strLine, Len(strLine) - intPos)))
                    
                    Case "MUTATIONMETHOD"
                        ' mutationmethod
                        MutationMethod = IntNull(Right$(strLine, Len(strLine) - intPos))
                    
                    Case "AMRGENERATIONS"
                        ' AMR generations
                        AMRGenerations = LngNull(Right$(strLine, Len(strLine) - intPos))
        
                    Case "BITLIKEMUTATIONLONGDOUBLE"
                        ' Bitlike mutation for long or double
                        Select Case UCase$(Trim$(Right$(strLine, Len(strLine) - intPos)))
                            Case "TRUE"
                                MutationBitlikeLongDouble = True
                                
                            Case "FALSE"
                                MutationBitlikeLongDouble = False
                                
                            Case Else
                                MutationBitlikeLongDouble = CBool(Trim$(Right$(strLine, Len(strLine) - intPos)))
                                
                        End Select
                        
                    Case "BITLIKEMUTATIONPERCENTAGE"
                        ' percentage of maxvalue for bitlike mutation
                        MutationBitlikePercentage = DblNull(ConvertCommaToSystemdecimalseparator(Right$(strLine, Len(strLine) - intPos)))
        
                    Case "SOCIALDISASTERDIVERSITY"
                        ' social disaster percent
                        SocialDisasterDiversity = DblNull(ConvertCommaToSystemdecimalseparator(Right$(strLine, Len(strLine) - intPos)))
                    
                    Case "SOCIALDISASTERGENERATIONS"
                        ' social disaster check every x generations
                        SocialDisasterGenerations = LngNull(Right$(strLine, Len(strLine) - intPos))
        
                    Case "SOCIALDISASTERMETHOD"
                        ' social disaster type
                        SocialDisasterMethod = IntNull(Right$(strLine, Len(strLine) - intPos))
        
                    Case "REPRODUCTIONMETHOD"
                        ' reproduction method
                        ReproductionMethod = IntNull(Right$(strLine, Len(strLine) - intPos))
            
                    Case "KEEPFULLSTATISTICS"
                        ' statistics
                        Select Case UCase$(Trim$(Right$(strLine, Len(strLine) - intPos)))
                            Case "TRUE"
                                KeepStatistics = True
                                
                            Case "FALSE"
                                KeepStatistics = False
                                
                            Case Else
                                KeepStatistics = CBool(Trim$(Right$(strLine, Len(strLine) - intPos)))
                                
                        End Select
            
            
                End Select
            
            End If
        
        Loop
        
        Close #intFile

    End If

Exit Sub

errorhandler:

    RaiseEvent GAError(LngNull(Err.Number), "Error in ReadGASettings ! " & Err.Description)

End Sub

