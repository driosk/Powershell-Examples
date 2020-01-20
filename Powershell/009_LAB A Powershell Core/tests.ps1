New-PSDrive -Name test -root \\ilcsinfwds1\share\ -psprovider FileSystem -Persist

$ht = @{‘key1’=’value1’;’key2’=’value2’}

<#
$ht

Name                           Value
----                           -----
key1                           value1
key2                           value2
#>

$email = ‘don.jones@lab.pri’
$regex = “([a-z]+)\.([a-z]+)@”
$email -match $regex
$Matches
<#
Name                           Value
----                           -----
2                              jones
1                              don
0                              don.jones@
#>

$email -replace $regex, '$2.$1@'
# jones.don@lab.pri

Get-ADComputer –filter * |
Select @{n='computername';e={$_.name}} |
Get-WmiObject –class Win32_BIOS # not good

Get-WmiObject # does not accept name as pipeline

Get-ADComputer –filter * |
Select @{n='computername';e={$_.name}} |
Get-Hotfix
help Get-HotFix # you cannot pipe input to get-hotfix

Get-HotFix -ComputerName (Get-ADComputer –filter * | select -ExpandProperty name)

Get-Process | ft -Property ID,Name,@{n='VM(GB)';e={$_.VM / 1GB  };formatstring='N2'},@{n='PM(MB)';e={$_.PM / 1MB  };formatstring='N2'},@{n='WS(MB)';e={$_.WS / 1MB  };formatstring='N2'} -AutoSize

help Format-Table

get-history | Select-Object ID,CommandLine,@{n='ElapsedTime';e={$_.startexecutiontime}} | ft

<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\6_Default Parameters> get-history | gm


   TypeName: Microsoft.PowerShell.Commands.HistoryInfo

Name               MemberType Definition
----               ---------- ----------
Clone              Method     Microsoft.PowerShell.Commands.HistoryInfo Clone()
Equals             Method     bool Equals(System.Object obj)
GetHashCode        Method     int GetHashCode()
GetType            Method     type GetType()
ToString           Method     string ToString()
CommandLine        Property   string CommandLine {get;}
EndExecutionTime   Property   datetime EndExecutionTime {get;}
ExecutionStatus    Property   System.Management.Automation.Runspaces.PipelineState ExecutionStatus {get;}
Id                 Property   long Id {get;}
StartExecutionTime Property   datetime StartExecutionTime {get;}
#>

get-history | Select-Object -property ID,CommandLine,@{n='ElapsedTime';e={$_.endexecutiontime - $_.startexecutiontime}} | Sort-Object -Property ElapsedTime `
-Descending | ft -AutoSize -Property Id,ElapsedTime,CommandLine -Wrap
