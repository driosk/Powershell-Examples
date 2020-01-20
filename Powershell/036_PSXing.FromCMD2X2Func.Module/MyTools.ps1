function Get-LatestSecurityLog{
    param (
        [string]$ComputerName
    )
    Get-EventLog -LogName Security -Newest 50 -ComputerName $ComputerName
}

function Get-OSInfo {
    param(
        [string]$ComputerName
    )
    Get-CimInstance -ClassName Win32_BIOS -ComputerName $ComputerName
}
Get-LatestSecurityLog -ComputerName $ComputerName

$env:PSModulePath

C:\Users\DRIOSX\Documents\WindowsPowerShell\Modules;
C:\Program Files\WindowsPowerShell\Modules;
C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

<#

    Directory: C:\Users\driosx\Documents\WindowsPowerShell\modules


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----        12/5/2019   9:13 AM                MyTools
#>

<#
PS C:\Users\driosx\Documents\MyScripts> help Get-OSInfo

NAME
    Get-OSInfo

SYNTAX
    Get-OSInfo [[-ComputerName] <string>]


ALIASES
    None


REMARKS
    None
#>