gmo -ListAvailable | ? {$_.Name -like "sche*"}

<#
ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   1.0.0.0    ScheduledTasks                      {Get-ScheduledTask, Set-ScheduledTask, Register-ScheduledTask, Unregister-ScheduledTask...}
#>
help gmo

gmo -ListAvailable | ? {$_.Name -like "sche*"} | select -expand ExportedCommands

<#
Key                               Value
---                               -----
Get-ScheduledTask                 Get-ScheduledTask
Set-ScheduledTask                 Set-ScheduledTask
Register-ScheduledTask            Register-ScheduledTask
Unregister-ScheduledTask          Unregister-ScheduledTask
Enable-ScheduledTask              Enable-ScheduledTask
Export-ScheduledTask              Export-ScheduledTask
New-ScheduledTask                 New-ScheduledTask
New-ScheduledTaskAction           New-ScheduledTaskAction
New-ScheduledTaskPrincipal        New-ScheduledTaskPrincipal
New-ScheduledTaskSettingsSet      New-ScheduledTaskSettingsSet
New-ScheduledTaskTrigger          New-ScheduledTaskTrigger
Start-ScheduledTask               Start-ScheduledTask
Get-ScheduledTaskInfo             Get-ScheduledTaskInfo
Get-ClusteredScheduledTask        Get-ClusteredScheduledTask
Set-ClusteredScheduledTask        Set-ClusteredScheduledTask
Register-ClusteredScheduledTask   Register-ClusteredScheduledTask
Unregister-ClusteredScheduledTask Unregister-ClusteredScheduledTask
#>

gcm -noun *scheduled*

schtasks

# PSSCheduledJob powershell 3 and later even in windows 7.

Get-Command -Module PSSCheduledJob

<#
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Add-JobTrigger                                     1.1.0.0    PSScheduledJob
Cmdlet          Disable-JobTrigger                                 1.1.0.0    PSScheduledJob
Cmdlet          Disable-ScheduledJob                               1.1.0.0    PSScheduledJob
Cmdlet          Enable-JobTrigger                                  1.1.0.0    PSScheduledJob
Cmdlet          Enable-ScheduledJob                                1.1.0.0    PSScheduledJob
Cmdlet          Get-JobTrigger                                     1.1.0.0    PSScheduledJob
Cmdlet          Get-ScheduledJob                                   1.1.0.0    PSScheduledJob
Cmdlet          Get-ScheduledJobOption                             1.1.0.0    PSScheduledJob
Cmdlet          New-JobTrigger     #When                                1.1.0.0    PSScheduledJob
Cmdlet          New-ScheduledJobOption                             1.1.0.0    PSScheduledJob
Cmdlet          Register-ScheduledJob                              1.1.0.0    PSScheduledJob
Cmdlet          Remove-JobTrigger                                  1.1.0.0    PSScheduledJob
Cmdlet          Set-JobTrigger                                     1.1.0.0    PSScheduledJob
Cmdlet          Set-ScheduledJob                                   1.1.0.0    PSScheduledJob
Cmdlet          Set-ScheduledJobOption                             1.1.0.0    PSScheduledJob
Cmdlet          Unregister-ScheduledJob                            1.1.0.0    PSScheduledJob
#>

# with psscheduledjob tells powershell to create a taks in task scheduler with whatever cmd you run. It runs PS
# commands and the results gets cached to disk. XML

# Whenyou open powershell it scans the disks, presents results as job, and to see them you run the recieve-job command.
# They'll remain on disk but we can set how much to leave cached.

# Scheduled tasks runs the job.

# New-JobTrigger define when
# Get-ScheduledJobOption   define characteristics

# Register-ScheduledJob with triggers and optional joboptions

#Unregister from task scheduler

Get-JobTrigger
Get-ScheduledJob
Get-ScheduledJobOption

help New-JobTrigger
<#
New-JobTrigger [-Once] -At <DateTime> [-RandomDelay <TimeSpan>] [-RepeatIndefinitely] [-RepetitionDuration <TimeSpan>]
    [-RepetitionInterval <TimeSpan>] [<CommonParameters>]

    New-JobTrigger [-Daily] -At <DateTime> [-DaysInterval <Int32>] [-RandomDelay <TimeSpan>] [<CommonParameters>]

    New-JobTrigger [-Weekly] -At <DateTime> -DaysOfWeek {Sunday | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday}
    [-RandomDelay <TimeSpan>] [-WeeksInterval <Int32>] [<CommonParameters>]

    New-JobTrigger [-AtLogOn] [-RandomDelay <TimeSpan>] [-User <String>] [<CommonParameters>]

    New-JobTrigger [-AtStartup] [-RandomDelay <TimeSpan>] [<CommonParameters>]
#>
# Moving away from logon scripts

# Weeks INterval every other week or integer of weeks.

$trigger = New-JobTrigger -AtLogOn

# you can have multiple triggers procing off the job but disable them individually.

help Register-ScheduledJob

<#
Register-ScheduledJob [-Name] <String> [-FilePath] <String> [-ArgumentList <Object[]>] [-Authentication {Default | Basic | Negotiate |
    NegotiateWithImplicitCredential | Credssp | Digest | Kerberos}] [-Confirm] [-Credential <PSCredential>] [-InitializationScript <ScriptBlock>]
    [-MaxResultCount <Int32>] [-RunAs32] [-RunEvery <TimeSpan>] [-RunNow] [-ScheduledJobOption <ScheduledJobOptions>] [-Trigger
    <ScheduledJobTrigger[]>] [-WhatIf] [<CommonParameters>]

    Register-ScheduledJob [-Name] <String> [-ScriptBlock] <ScriptBlock> [-ArgumentList <Object[]>] [-Authentication {Default | Basic | Negotiate
    | NegotiateWithImplicitCredential | Credssp | Digest | Kerberos}] [-Confirm] [-Credential <PSCredential>] [-InitializationScript
    <ScriptBlock>] [-MaxResultCount <Int32>] [-RunAs32] [-RunEvery <TimeSpan>] [-RunNow] [-ScheduledJobOption <ScheduledJobOptions>] [-Trigger
    <ScheduledJobTrigger[]>] [-WhatIf] [<CommonParameters>]
#>

help New-ScheduledJobOption

<#
SYNTAX
    New-ScheduledJobOption [-ContinueIfGoingOnBattery] [-DoNotAllowDemandStart] [-HideInTaskScheduler] [-IdleDuration <TimeSpan>] [-IdleTimeout
    <TimeSpan>] [-MultipleInstancePolicy {None | IgnoreNew | Parallel | Queue | StopExisting}] [-RequireNetwork] [-RestartOnIdleResume]
    [-RunElevated] [-StartIfIdle] [-StartIfOnBattery] [-StopIfGoingOffIdle] [-WakeToRun] [<CommonParameters>]
#>

$option = New-ScheduledJobOption -RequireNetwork -WakeToRun

Register-ScheduledJob -Name "get processes at logon" -ScriptBlock {Get-Process} -MaxResultCount 2 -Trigger $trigger `
-ScheduledJobOption $option

<#
Id         Name            JobTriggers     Command                                  Enabled
--         ----            -----------     -------                                  -------
1          get processe... 1               Get-Process                              True
#>

Get-ScheduledJob

<#
InvocationInfo         : Microsoft.PowerShell.ScheduledJob.ScheduledJobInvocationInfo
Definition             : System.Management.Automation.JobDefinition
Options                : Microsoft.PowerShell.ScheduledJob.ScheduledJobOptions
Credential             :
JobTriggers            : {1}
Id                     : 1
GlobalId               : a41adab3-55c4-4871-b75c-c29d91c68696
Name                   : get processes at logon
Command                : Get-Process
ExecutionHistoryLength : 2
Enabled                : True
PSExecutionPath        : powershell.exe
PSExecutionArgs        : -NoLogo -NonInteractive -WindowStyle Hidden -Command "Import-Module PSScheduledJob; $jobDef =
                         [Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition]::LoadFromStore('get processes at
                         logon', 'C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs');
#>

Get-ScheduledJob | select -expand JobTriggers

<#
Id         Frequency       Time                   DaysOfWeek              Enabled
--         ---------       ----                   ----------              -------
1          AtLogon                                                        True
#>

Import-Module PSScheduledJob

Get-Job
<#
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
2      get processe... PSScheduledJob  Completed     True            localhost            Get-Process
#>
Get-Job | fl

<#
Definition      : Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition
Location        : localhost
StatusMessage   :
HasMoreData     : True
Command         : Get-Process
StartParameters : {}
JobStateInfo    : Completed
Finished        : System.Threading.ManualResetEvent
InstanceId      : 987896d7-e3a7-411c-acfb-5e32770377e1
Id              : 2
Name            : get processes at logon
ChildJobs       : {}
PSBeginTime     : 12/4/2019 1:50:39 PM
PSEndTime       : 12/4/2019 1:52:59 PM
PSJobTypeName   : PSScheduledJob
Output          : {System.Diagnostics.Process (audiodg), System.Diagnostics.Process (conhost),
                  System.Diagnostics.Process (conhost), System.Diagnostics.Process (conhost)...}
Error           : {}
Progress        : {}
Verbose         : {}
Debug           : {}
Warning         : {}
State           : Completed
#>

Receive-Job -Id 2

<#
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    193      12     7044      10936    42     4.05   4680 audiodg
     58       7     1956       7704    59     0.11   3640 conhost
     43       5     1464       3276    28     0.00   4984 conhost
     43       5     1516       2004    28     0.00   5092 conhost
    279      13     1940       3864    46     0.69    468 csrss
     93       9     1232       3508    39     0.03    536 csrss
    153      10     1780      12132    52     0.30   4444 csrss
    189      17    15168      25728    91     0.05   1016 dwm
    206      22    12064      39352   138     0.27   2984 dwm
   1578      75    49268     109296   511     2.53   5072 explorer
      0       0        0          4     0               0 Idle
    377      28    13484      29020   260     0.20    820 LogonUI
   1087      27     7692      16628    45    21.19    628 lsass
    306      12     3332       9656    45     0.13   4420 MpCmdRun
    645      65   190540     162296   610   557.47   1500 MsMpEng
    275     184    10484       5672    57     0.45   3728 NisSrv
    372      26    58136      65876   592     0.73   2972 powershell
    429      28    74524      55108   605     0.47   3980 powershell
    378      28    98936      97216   672     2.70   4760 powershell
    221      11     1836       6564    86     0.09   1380 rdpclip
    700      70    37212      39476   329    22.97   2576 SearchIndexer
    231      10     5376       8416    30     3.00    620 services
     47       2      308       1028     4     0.05    356 smss
    404      22     5960      12140    78     1.06   1200 spoolsv
    485      15     6248      13760    48     7.19    700 svchost
    408      15     4504       8360    28     4.84    740 svchost
    675      25    24384      29588    95     2.13    852 svchost
    609      26    79684      87408   142   693.31    876 svchost
   2155     377   160368     176700   754   196.22    904 svchost
    607      32    10424      16636   119     2.67    952 svchost
   1587     505    93360     106996  1536    40.52   1040 svchost
    483      39    19204      25612   109     4.36   1228 svchost
    388      17     7184      16528   109     0.50   1372 svchost
    350    3860     4324      12168    84     6.08   2792 svchost
    157      21    16752      16196   236     3.97   4968 svchost
    805       0     6412       1812    10   206.86      4 System
    444      27    14564      23808  1229     4.81   2540 taskhost
    226      20     3276       8928   256     0.16   2808 taskhostex
    280      17    79828      85140   387   184.48   3968 TiWorker
    112       8     2988       6140    31    19.94   3716 TrustedInstaller
     77       8      824       3932    40     0.09    516 wininit
    123       7     1664       7728    53     0.06    568 winlogon
    154       8     1520      10712    55     0.16   2704 winlogon
    129       9     2520       7084    35            1564 WmiPrvSE
    352      22     4436       2604    83     0.14   3276 wmpnetwk
    247      13     1724       6244    67     0.03   2820 WUDFHost
#>

# Where is disk file?

Get-ScheduledJob | fl

<#
InvocationInfo         : Microsoft.PowerShell.ScheduledJob.ScheduledJobInvocationInfo
Definition             : System.Management.Automation.JobDefinition
Options                : Microsoft.PowerShell.ScheduledJob.ScheduledJobOptions
Credential             :
JobTriggers            : {1}
Id                     : 3
GlobalId               : a41adab3-55c4-4871-b75c-c29d91c68696
Name                   : get processes at logon
Command                : Get-Process
ExecutionHistoryLength : 2
Enabled                : True
PSExecutionPath        : powershell.exe
PSExecutionArgs        : -NoLogo -NonInteractive -WindowStyle Hidden -Command "Import-Module PSScheduledJob; $jobDef =
                         [Microsoft.PowerShell.ScheduledJob.ScheduledJobDefinition]::LoadFromStore('get processes at
                         logon', 'C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs');
                         $jobDef.Run()"
#>

<#
    Directory: C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs


Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         12/4/2019   1:42 PM            get processes at logon


PS C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs> cd '.\get processes at logon'
PS C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\get processes at logon> dir


    Directory: C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\get processes at logon


Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         12/4/2019   1:51 PM            Output
-a---         12/4/2019   1:42 PM       7613 ScheduledJobDefinition.xml


PS C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\get processes at logon\Output> dir


    Directory: C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\get processes at logon\Output


Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d----         12/4/2019   1:51 PM            20191204-135039-923

PS C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\get processes at logon\Output> cd .\201912
04-135039-923
PS C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\get processes at logon\Output\20191204-135
039-923> dir


    Directory: C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\get processes at
    logon\Output\20191204-135039-923


Mode                LastWriteTime     Length Name
----                -------------     ------ ----
-a---         12/4/2019   1:53 PM     556334 Results.xml
-a---         12/4/2019   1:53 PM       8093 Status.xml


PS C:\Users\driosx\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\get processes at logon\Output\20191204-135
039-923>
#>

