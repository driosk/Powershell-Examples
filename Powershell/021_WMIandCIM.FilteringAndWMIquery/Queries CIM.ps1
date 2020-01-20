Get-CimInstance -ClassName Win32_Service -ComputerName ILCSPSWA `
-Filter "startmode = 'auto' and name like 'remote%' and state <> 'running'"

help Get-CimInstance -Parameter Filter
<#
-Filter [<String>]
    Specifies a where clause to use as a filter. Specify the clause in either the WQL or the CQL query language.

    Note: Do not include the where keyword in the value of the parameter.

    Required?                    false
    Position?                    named
    Default value                none
    Accept pipeline input?       True (ByPropertyName)
    Accept wildcard characters?  false
#>

Get-CimInstance `
-Query "SELECT * FROM win32_service WHERE startmode = 'auto' AND name LIKE 'remote%' AND state <> 'running'" `
-ComputerName ILCSPSWA,ILCSDC0,ILCSDC1

<#
ProcessId Name           StartMode State   Status ExitCode PSComputerName
--------- ----           --------- -----   ------ -------- --------------
0         RemoteRegistry Auto      Stopped OK     0        ILCSPSWA
0         RemoteRegistry Auto      Stopped OK     0        ILCSDC0
0         RemoteRegistry Auto      Stopped OK     0        ILCSDC1
#>


