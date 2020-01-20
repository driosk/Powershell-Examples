$x = 'hello'
$x -is [string]
$x -is [int]
$x -as [int]

56.645654 -as [int]

$x = "5555"
$x -is [string]
$x -as [int]

$x = 'powershell'
$x
$x -like '*shell*'
$x -contains "shell" # False

$x = 1,2,3,4,5,6,'one','two','three','four','five','six'
$x

$x -contains 'two'
$x -contains 'seven'
$x -notcontains 'seven'


$x = 1,2,3,4,5,6,7

7 -in $x
8 -in $x
8 -notin $x


$x = 'powershell'
$x -replace 'l','x'
$x

$arr = 1,2,3,4,5,6,7,8,9
$arr
$arr[0]
$arr[2]
$arr += "one","two","three"
$arr
$arr = $arr + "four","five","six"
$arr -join ','
$list = $arr -join ','
$list
$a = $list -split ","
$a
$arr = 1,2,3,4,5
$arr = ,1
$arr

$x++
$x--

# Bitwise
<#
1 2 4 8 16 32 64 128  8 bits
1 1 1 0 0   0  0  0  = 7
0 1 0 1 0   0  0  0   = 10   7 -band 10 # if 1 in both inputs
0 1 0 0 0   0  0  0  =  2 -band
1 1 1 1 0   0  0  0 = 15  -bor



1 2 4 8 16 32 64 128  8 bits
1 1 1 0 0   0  0  0  = 7
0 1 0 1 0   0  0  0   = 10
1 0 1 1 0   0  0  0 = 13 -bxor 1 if only 1 of inputs is 1.
#>




7 -band 10

7 -bor 10

7 -bxor 10

(5 -gt 1) -and (5 -lt 10)
(5 -gt 1) -and (5 -lt 1)
(5 -gt 1) -or (5 -lt 10)
(5 -gt 1) -xor (5 -lt 10) # false if both true, false if both fasle, true if one or the other is thrue.

<#
And    T    F # if both inputs are true
T      X
F

or     T    F   # either or both inputs are true
T      X    X
F      X

xor    T    F
T           X
F      X
#>
dir > dir.txt
dir | Out-File dir.txt
dir | Out-File dir.txt -Append
dir >> dir.txt
del C:\nothing
del C:\nothing 2> err.txt

1..100 # Puts that many objects into the pipeline.

1..100 | foreach {dir}

# format operator

"{0} {1:N2} {3} {2:N4}" -f "hello",4.5644156546546,6.487354354,"there"
"{0}{1}{3}{2}" -f "james","and","peach","giant"

# hello 4.56 there 6.4874

# Dot Sourcing
.\testscript.ps1
. .\testscript.ps1 # leave those things defined

<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\5_ComparisonOperatorsAndFiltering> . .\testscript.ps1
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\5_ComparisonOperatorsAndFiltering> test
yay!
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\5_ComparisonOperatorsAndFiltering>
#>

. C:\myscripts\lib1.ps1
. C:\myscripts\lib2.ps1

# Use a script Module

