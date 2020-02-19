New-PSDrive -name win -psprovider filesystem -root C:\windows
[int]$repeat = Read-Host "How many times to repeat the operation"
[string]$repeat = 'fred'
[float]$repeat = 1.5555
[bool]$repeat = $true
$ht = @{'key'='value';'associate this'='with that';'word'='definition'}
$ht
"abcd345saefaf1234" -match "\d+"
"abcd345saefaf1234" -match "[a-z]+(\d+)"
"somebody.something@company.com" -match "([a-z]+)\.[a-z]+@[a-z]+\.com"
"testtest somebody.something@company.com test" -match "[a-z]+\s([a-z]+)\.[a-z]+@[a-z]+\.com"
"testtest somebody.something@company.com test" -match "[a-z]+\s(?'name'[a-z]+)\.[a-z]+@[a-z]+\.com"
"this that those" -replace "that","x"
"this that those" -replace  "\s[a-z]+\s","-"
"Don Jones" -replace "([a-z]+)\s([a-z]+)", '$2 $1'
"Don Jones" -replace "([a-z]+)\s([a-z]+)", '$2, $1'

icacls C:\logs\* /grant "Administrator:(D,WDAC)"
icacls --% C:\logs\* /grant Administrator:(D,WDAC)
$regex = "\[(?'address'\S+)]"
($output -match $regex)[0] -match $regex
$Matches['address']
<#
PS C:\Users\driosx> ($output -match $regex)[0] -match $regex
True

PS C:\Users\driosx> $Matches['address']
10.11.10.60

PS C:\Users\driosx> $Matches

Name                           Value
----                           -----
address                        10.11.10.60
0                              [10.11.10.60]



PS C:\Users\driosx>
#>
get-service | Export-Clixml .\services.xml

Import-Clixml .\services.xml

get-process | Export-Clixml procs.xml

Compare-Object -ReferenceObject (Import-Clixml .\procs.xml) -DifferenceObject (Get-Process) -Property name

<#
name                    SideIndicator
----                    -------------
conhost                 =>
MicrosoftEdgeCP         =>
MicrosoftEdgeCP         =>
MicrosoftEdgeCP         =>
OpenConsole             =>
powershell              =>
powershell              =>
SearchProtocolHost      =>
svchost                 =>
svchost                 =>
Windows.WARP.JITService =>
Windows.WARP.JITService =>
WindowsTerminal         =>
#>

Compare-Object -ReferenceObject (Import-Clixml .\procs.xml) -DifferenceObject (Get-Process) -Property name | ConvertTo-Html | Out-File differences.ConvertTo-Html

Get-EventLog -LogName Security -Newest 10 | Export-Csv C:\recentlogs.csv | Out-File C:\something.csv
change