# Core Commands: Selecting, sorting, measuring, and more


get-process | sort ws

get-process | sort ws -Descending | Select-Object -First 5
get-process | sort ws -Descending | Select -last 5
Get-Process | sort -Property name,ws
Get-Process | sort -Property ws | select -First 5 -Property Name
Get-Process | sort -Property ws | select -First 5 -Property Name,WS
Get-Process | sort -Property ws | select -First 5 -Property Name,WS,VM,PM
Get-Process | sort -Property ws | select -First 5 -Property Name,WS,VM,PM,CPU # now a list

Get-Process | select name,ws,vm,pm | sort CPU

Get-Process | select name,ws,vm,pm | gm
<#
Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
Name        NoteProperty string Name=ApplicationFrameHost
PM          NoteProperty long PM=19476480
VM          NoteProperty long VM=2203583864832
WS          NoteProperty long WS=33689600
#>

Get-Service | Group-Object -Property Status
Get-Service | Group -Property Status
Get-Process | Measure-Object -Property WS -Maximum -Minimum -Average -Sum
Get-Process | Measure -Property WS -Max -Min -Ave -Sum
<#
Count    : 202
Average  : 33510105.980198
Sum      : 6769041408
Maximum  : 427089920
Minimum  : 8192
Property : WS
#>
Get-Command -Noun object

Get-Process | sort ws | select -First 5 | measure -Property ws -Sum -Average
Get-Process | sort ws | select -First 5 | measure -Property ws -Sum -Average | gm

Get-Process | select -Property * -First 1
<#
WorkingSet                 : 33673216
PagedMemorySize            : 19476480
PrivateMemorySize          : 19476480
VirtualMemorySize          : 265641984
TotalProcessorTime         : 00:00:01.3593750
#>

Get-Process | Select-Object -Property Name,Id,@{},@{},CPU
Get-Process | Select-Object -Property Name,Id,@{name='';expression={}},@{label='';expression={}},CPU
Get-Process | Select-Object -Property Name,Id,@{name='VM(MB)';expression={ $_.VM / 1MB }} , @{label='PM(MB)';expression={ $_.PM / 1MB }}
Get-Process | Select-Object -Property Name,Id,@{name='VM(MB)';expression={ $_.VM / 1MB -as [int] }} , @{label='PM(MB)';expression={ $_.PM / 1MB -as [int]}},cpu
Get-Process | Select-Object -Property Name,Id,@{n='VM(MB)';e={ $_.VM / 1MB -as [int] }} , @{l='PM(MB)';e={ $_.PM / 1MB -as [int]}},cpu

help Select-Object
Get-Process | Select-Object -Property id,`
name,
@{
    n='PM(MB)';
    e={ $_.PM / 1MB -as [int]}
}

Get-ADUser driosx
$test = Get-ADUser driosx -Properties lastlogontimestamp
$test.lastlogontimestamp | gm
Get-ADUser -Filter {Enabled -eq $true} -Properties Name,LastLogon,lastlogontimestamp,samaccountname |
Select-Object Name,Manager,@{n='LastLogonTimeStamp';e={[DateTime]::FromFileTime($_.lastlogon)}}

Invoke-Command -ComputerName ILCSDC0,ILCSDC1 { Get-ADUser -Filter {Enabled -eq $true} -Properties Name,LastLogon,lastlogontimestamp,samaccountname |
Select-Object Name,Manager,@{ n='LastLogon'; e={ [DateTime]::FromFileTime($_.lastlogon) } } } | Sort-Object -Descending

Invoke-Command -ComputerName ILCSDC0,ILCSDC1 { Get-ADUser -Filter {Enabled -eq $true} -Properties * |
Select-Object Name,@{ n='LastLogon'; e={ [DateTime]::FromFileTime($_.lastlogon) } } } | Sort-Object -Property PSComputerName

Invoke-Command -ComputerName ILCSDC0,ILCSDC1 { Get-ADUser -Filter {Enabled -eq $true} -Properties * |
Select-Object Name,@{ n='LastLogon'; e={ [DateTime]::FromFileTime($_.lastlogon) } } } | Sort-Object -Property name

Invoke-Command -ComputerName ILCSDC0,ILCSDC1 { Get-ADUser driosx -Properties * |
Select-Object Name,samaccountname,@{ n='LastLogon'; e={ [DateTime]::FromFileTime($_.lastlogon) } } } | ft

$test.lastlogon.DateTime::FromFileTime($_)

Get-Process | Select-Object -Property Name,Id,@{ n='VM(MB)'; e={ $_.vm / 1MB -as [int] } } -First 5
Get-Process | Select-Object -Property Name,Id,@{ n='VM(MB)'; e={ $PSItem.vm / 1MB -as [int] } } -First 5

