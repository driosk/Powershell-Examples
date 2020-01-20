# need to use WMI or CIM. 

Get-WmiObject -Class win32_service -Filter "state <> 'Runing' AND startmode = 'auto'"
$cred = Get-Credential
Invoke-Command -ComputerName (gc .\computers.txt) `
-ScriptBlock {Get-WmiObject -Class win32_service -Filter "state <> 'Runing' AND startmode = 'auto'"} `
-Credential $cred -AsJob

<#
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
1      Job1            RemoteJob       Running       True            CRITHOS,ILCSDC0,I... Get-WmiObject -Class w...
#>

Get-WmiObject -Class win32_service -Filter "state <> 'Runing' AND startmode = 'auto'" -ComputerName (gc .\computers.txt) `
-Credential $cred -AsJob

<#
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
11     Job11           WmiJob          Running       True            CRITHOS,ILCSDC0,I... Get-WmiObject -Class w...
#>

Get-Job

Receive-Job -id 21 | Export-Csv .\Remotejob.csv
Receive-Job -id 30 | Export-Csv .\WmiJob.csv

Import-Csv .\Remotejob.csv

Import-Csv .\WmiJob.csv

# This produces a Job object, this makes the next cmd's first parameter -Job
Invoke-Command -ComputerName (gc .\computers.txt) `
-ScriptBlock {Get-WmiObject -Class win32_service -Filter "state <> 'Runing' AND startmode = 'auto'"} `
-Credential $cred -AsJob | Wait-Job -Any | Receive-Job | Export-Csv .\automatedJob.csv

help Wait-Job

<#
Wait-Job [-Filter] <Hashtable> [-Any] [-Force] [-Timeout <Int32>] [<CommonParameters>]

    Wait-Job [-Id] <Int32[]> [-Any] [-Force] [-Timeout <Int32>] [<CommonParameters>]

    Wait-Job [-InstanceId] <Guid[]> [-Any] [-Force] [-Timeout <Int32>] [<CommonParameters>]

    Wait-Job [-Job] <Job[]> [-Any] [-Force] [-Timeout <Int32>] [<CommonParameters>]

    Wait-Job [-Name] <String[]> [-Any] [-Force] [-Timeout <Int32>] [<CommonParameters>]

    Wait-Job [-State] {NotStarted | Running | Completed | Failed | Stopped | Blocked | Suspended | Disconnected | Suspending | Stopping | AtBreakpoint}     
    [-Any] [-Force] [-Timeout <Int32>] [<CommonParameters>]
#>

Invoke-Command -ComputerName ILCSDC0 -ScriptBlock {Get-Process} -Credential $cred -AsJob |
Wait-Job -Any | Receive-Job

Invoke-Command -ComputerName ILCSDC0 -ScriptBlock {Get-Process} -Credential $cred -AsJob |
Wait-Job -state Completed | Receive-Job

<#
Wait-Job : The input object cannot be bound to any parameters for the command either because the command does not take pipeline input or the input and its 
properties do not match any of the parameters that take pipeline input.
At line:2 char:1
+ Wait-Job -state Completed | Receive-Job
+ ~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (System.Manageme...n.PSRemotingJob:PSObject) [Wait-Job], ParameterBindingException
    + FullyQualifiedErrorId : InputObjectNotBound,Microsoft.PowerShell.Commands.WaitJobCommand
#>

