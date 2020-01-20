[CmdletBinding()]
param (
    [Parameter(
        Mandatory=$true,
        ValueFromPipeline=$true
    )]
    [string]$ComputerName,

    
    [Parameter(
        Mandatory=$true
        )]
    [int]$MinimumFreeDiskPercentage
)

Get-DiskDetails -Computername $ComputerName |
Where FreePercent -lt $MinimumFreeDiskPercentage |
Select ComputerName,FreePercent,Drive |
Format-Table -AutoSize |
Out-File ProblemDisks.txt

#Send-MailMessage -Attachments (ProblemDisks.txt) -to admin@company.com -from drios@company.com