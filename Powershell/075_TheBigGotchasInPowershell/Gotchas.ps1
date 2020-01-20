get-process | sort vm | format-table -AutoSize -Property name,vm,pm,id | export-csv processes.csv

# TYPE Microsoft.PowerShell.Commands.Internal.Format.FormatStartData

# format only pipes to 

<#
OUt-host
out-file
out-printer
out-string

#>
# FORMAT TO THE RIGHT AS FAR AS POSSIBLE

Get-Service | where {$_.status -contains '*run*'} #If a collectino contains an object. 

$collection = 1,2,3,4,5,6
$collection -contains '2' # true

Get-Service | where {$_.status -like '*run*'} #wildcard matching strings

help about_Operators
help about_Comparison_Operators

Get-Process | Select-Object -Property name,di,vm,pm,ws

<#  TYPO!!!
Name : YourPhone
di   :
VM   : 2203656781824
PM   : 12677120
WS   : 94208
#>

Get-Process | Select-Object -Property name,id,vm,pm,ws #| sort -Property cpu

Get-Process | Select-Object -Property name,cpu,id,vm,pm,ws | sort -Property pm
Get-Process

Get-WmiObject -Class win32_logicaldisk -filter "drivetype = 3"

help Get-WmiObject -Parameter filter
<#
-Filter <String>
    Specifies a Where clause to use as a filter. Uses the syntax of the WMI Query Language (WQL).

    Important: Do not include the Where keyword in the value of the parameter. For example, the following commands return only the     
    logical disks that have a DeviceID of 'c:' and services that have the name 'WinRM' without using the Where keyword.
    
    `Get-WmiObject Win32_LogicalDisk -filter "DeviceID = 'c:' "`

    `Get-WmiObject win32_service -filter "name='WinRM'"`

    Required?                    false
    Position?                    named
    Default value                None
    Accept pipeline input?       False
    Accept wildcard characters?  false
#>

# not all output is output in powershell. 

get-process | export-csv procs.csv | Format-Table # no output in the pipeline for format table. 

get-service -name bits | stop-service -PassThru | export-csv stopped.csv # Make it have output. 

Get-service | ConvertTo-Html -PreContent '<h2>Serivices</h2>' | out-file report.Html

Get-Process | ConvertTo-Html -PreContent '<h2>Procs</h2>' | out-file report.Html -Append # will be wrong because will have two html doctypes.
# Instead do this:
$frag1 = Get-Process | ConvertTo-Html -PreContent '<h2>Procs</h2>' -Fragment | Out-String
$frag2 = Get-Service | ConvertTo-Html -PreContent '<h2>Serivices</h2>' -Fragment | Out-String

ConvertTo-Html -Body $frag1,$frag2 | Out-File report.html

write-output # to concatinate will use certain things as delimeters. 
# Use double quotations
# if you need anything other than the variable use a subexpression. 