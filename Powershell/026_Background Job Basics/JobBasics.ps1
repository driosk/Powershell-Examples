Enter-PSSession -ComputerName ILCSWS007.critsol.net -Credential (Get-Credential)

start-job -ScriptBlock {dir C:\ -Recurse} -Name SuperlongDIRJOB

Get-Job

<#
Id              Name            State      HasMoreData     Location             Command
--              ----            -----      -----------     --------             -------
1               SuperlongDIRJOB Running    True            localhost            dir C:\ -Recurse
#> 

# Has more data means output and is buffering in memory. 
Get-Job

Stop-Job -id 1

Get-Job

<#
Id              Name            State      HasMoreData     Location             Command
--              ----            -----      -----------     --------             -------
1               SuperlongDIRJOB Stopped    True            localhost            dir C:\ -Recurse
#>

Receive-Job -id 1 # lots of output

Get-Job

<#
Id              Name            State      HasMoreData     Location             Command
--              ----            -----      -----------     --------             -------
1               SuperlongDIRJOB Stopped    False           localhost            dir C:\ -Recurse
#>
# Has more data is now not cached in memory. 

Receive-Job -id 1 -Keep 

# job primarily for local computer

Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 100} -ComputerName ILCSWS008,ILCSDC0 `
-Credential (Get-Credential) -AsJob -JobName EventLogGetter

Get-WmiObject -Class win32_logicaldisk -ComputerName ILCSWS007.critsol.net,ILCSDC0.critsol.net -Credential (Get-Credential) `
-AsJob

$cred = Get-Credential

Get-Job

<#
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
1      EventLogGetter  RemoteJob       Completed     True            ILCSWS008,ILCSDC0     Get-EventLog -LogName...
4      Job4            WmiJob          Completed     True            ILCSWS007.critsol... Get-WmiObject -Class w...
#>

Get-Job -id 4 | select -ExpandProperty childjobs
<#
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
5      Job5                            Completed     True            ILCSWS007.critsol...
6      Job6                            Completed     True            ILCSDC0.critsol.net
#>

Get-Job

# Parent job will give you the worst case state of it's child jobs

recieve-job -id 5 # the child job

Get-Job -id 4 | select -expand childjobs

get-job -id 4 | Remove-Job
Receive-Job -id 1 | export-csv eventlog.csv 
Import-Csv .\eventlog.csv | format-table -GroupBy PScomputername

Get-Job

gcm -Noun job

<#
Cmdlet          Debug-Job                                          3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Get-Job                                            3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Receive-Job                                        3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Remove-Job                                         3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Resume-Job                                         3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Start-Job                                          3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Stop-Job                                           3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Suspend-Job                                        3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Wait-Job                                           3.0.0.0    Microsoft.PowerShell.Core
#>

# wait-job makes it wait for a job to complete then continue. 

Invoke-Command -ScriptBlock { dir c:\ -Recurse} -ComputerName ILCSWS008,ILCSDC0 `
-Credential ($cred) -AsJob -JobName DerDir

<#
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
7      DerDir          RemoteJob       Running       True            ILCSWS008,ILCSDC0     dir c:\ -Recurse
#>

Stop-Job -id 7
Get-Job

Remove-Job -id 7

help Invoke-Command

# only talks to 32 computers simultaniously, throttlelimit can increase because processing is happening on local computer. 

help Start-Job

# no remoting option for start-job.

# ENHANCEMENTS IN POWERSHELL v3

Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 100} `
-ComputerName ILCSWS008.critsol.net,ILCSDC0.critsol.net,ILCSDC1.critsol.net `
-Credential ($cred) -AsJob -JobName EventLogJerrrb

get-job -id 10 | select -ExpandProperty childjobs

get-job -id 10 -IncludeChildJob

<#
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
10     EventLogJerrrb  RemoteJob       Completed     True            ILCSWS008.critsol...  Get-EventLog -LogName...
11     Job11                           Completed     True            ILCSWS008.critsol...  Get-EventLog -LogName...
12     Job12                           Completed     True            ILCSDC0.critsol.net   Get-EventLog -LogName...
13     Job13                           Completed     True            ILCSDC1.critsol.net   Get-EventLog -LogName...
#>

get-job -id 10 -ChildJobState Completed

Receive-Job -id 11 -Keep | select -first 10

Get-Job -IncludeChildJob

<#
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
10     EventLogJerrrb  RemoteJob       Completed     True            ILCSWS008.critsol...  Get-EventLog -LogName...
11     Job11                           Completed     True            ILCSWS008.critsol...  Get-EventLog -LogName...
12     Job12                           Completed     True            ILCSDC0.critsol.net   Get-EventLog -LogName...
13     Job13                           Completed     True            ILCSDC1.critsol.net   Get-EventLog -LogName...
#> # Still has data

Receive-Job -id 11 -Keep

gcm -Noun job

# Suspend pause
# Resume continue
Get-Job
Remove-Job# will ask for id if none specified. 
