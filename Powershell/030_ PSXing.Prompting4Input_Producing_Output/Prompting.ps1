# several ways to provide information to you. 
# 6 total. 
# 5 of them are called pipeline. 

# at end of pipeline powershell has to decide what to do with it. 

# there are other pipelines.

# Verbose Pipeline
# Debug Pipeline
# Error Pipeline
# Warning Pipeline

# Info can go into any of these pipelines. 

# step by step stuff is in the Verbose pipeline

# Warning...something went wrong but I'm going to keep going. 

# warning ...console puts yellow into the screen

# error ...console writes red to screen

# Different hosting applications interpret differently. They have different rules for the 5
# pipelines.

Write-Host "This is on the Screen" -ForegroundColor Red -BackgroundColor White

# This does not write to any of the pipelines. 

.\sample.ps1 > .\output.txt
<#
Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        12/4/2019   5:28 PM              0 output.txt
#>

# Write-host draws directly on the screen and can't redirect those. 

# If you use it in a script, you can't capture it with write-host.

write-host "testing" | where {$_.Length -gt 10}

Write-Output "testing" | ? {$_.Length -gt 10}

gcm -Verb write

<#
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           Write-FileSystemCache                              2.0.0.0    Storage
Function        Write-DtcTransactionsTraceSession                  1.0.0.0    MsDtc
Function        Write-PrinterNfcTag                                1.1        PrintManagement
Function        Write-VolumeCache                                  2.0.0.0    Storage
Cmdlet          Write-Debug                                        3.1.0.0    Microsoft.PowerShell.Utility       
Cmdlet          Write-DfsrHealthReport                             2.0.0.0    DFSR
Cmdlet          Write-DfsrPropagationReport                        2.0.0.0    DFSR
Cmdlet          Write-Error                                        3.1.0.0    Microsoft.PowerShell.Utility       
Cmdlet          Write-EventLog                                     3.1.0.0    Microsoft.PowerShell.Management    
Cmdlet          Write-Host                                         3.1.0.0    Microsoft.PowerShell.Utility       
Cmdlet          Write-Information                                  3.1.0.0    Microsoft.PowerShell.Utility       
Cmdlet          Write-Output                                       3.1.0.0    Microsoft.PowerShell.Utility       
Cmdlet          Write-Progress                                     3.1.0.0    Microsoft.PowerShell.Utility        
Cmdlet          Write-Verbose                                      3.1.0.0    Microsoft.PowerShell.Utility        
Cmdlet          Write-Warning                                      3.1.0.0    Microsoft.PowerShell.Utility 
#>

ren .\sample.ps1 Show-WelcomeMessage.ps1

# The Verb SHOW indicates this will not produce output. 

Get-Service | gm

Get-Service > .\output.txt

dir | ft @{n='Length';e={$_.length / 1KB -as [float]}; 'formatstring'='N2'},Name


Read-Host "Enter Something"

Read-Host "Enter Something" | where {$_.Length -gt 10}

<#
Enter Something: somethinggreaterthan10
somethinggreaterthan10
PS ..\30_ PS_Scripting.Prompting4Input_Producing_Output >
#>

$computername = Read-Host "Enter the computer name to query"
$computername
<#
PS ..\30_ PS_Scripting.Prompting4Input_Producing_Output >$computername = Read-Host "Enter the computer name to query"
Enter the computer name to query: ILCSDC0
PS ..\30_ PS_Scripting.Prompting4Input_Producing_Output >$computername
ILCSDC0
#>

Write-Verbose "Hi" -Verbose
# VERBOSE: Hi
$VerbosePreference = 'Continue'
$VerbosePreference = 'SilentlyContinue'

dir > dir.txt 

dir | Out-File dir.txt | copy .\html # nothin in pipeline at last command. 

alias

help Convert-Path -ShowWindow
Get-PSProvider
gc $profile