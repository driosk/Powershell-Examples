# Find which services are set to autostart but are not started.
Get-WmiObject -Class win32_service -computername ILCSDC0 -Credential crit\driosx
<#
ExitCode  : 0
Name      : WinDefend
ProcessId : 2652
StartMode : Auto
State     : Running
Status    : OK

ExitCode  : 0
Name      : WinHttpAutoProxySvc
ProcessId : 492
StartMode : Manual
State     : Running
Status    : OK

ExitCode  : 0
Name      : Winmgmt
ProcessId : 1204
StartMode : Auto
State     : Running
Status    : OK

ExitCode  : 0
Name      : WinRM
ProcessId : 3156
StartMode : Auto
State     : Running
Status    : OK

ExitCode  : 0
Name      : wisvc
ProcessId : 0
StartMode : Manual
State     : Stopped
Status    : OK
#>


Get-WmiObject -Class win32_service -computername ILCSPSWA -Credential crit\driosx |
where {$_state -ne 'Running' -and $_startmode -eq 'Auto'} # Too much

# Better way to filter farthest to the left

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

# With filter you need to know the underlying tech implementation

# In WMI comparison operators are:
<#
=
>
<
<> not equal to
LIKE 'string' for string comparisons.
% is wildcard ex: LIKE '%start%'
single quotes for strings
#>

Get-WmiObject -Class win32_service -computername ILCSPSWA -Credential crit\driosx `
-Filter " state <> 'running' and startmode = 'auto' "

<#
ExitCode  : 0
Name      : MapsBroker
ProcessId : 0
StartMode : Auto
State     : Stopped
Status    : OK

ExitCode  : 0
Name      : RemoteRegistry
ProcessId : 0
StartMode : Auto
State     : Stopped
Status    : OK

ExitCode  : 0
Name      : sppsvc
ProcessId : 0
StartMode : Auto
State     : Stopped
Status    : OK

ExitCode  : 0
Name      : TrustedInstaller
ProcessId : 0
StartMode : Auto
State     : Stopped
Status    : OK

ExitCode  : 0
Name      : WbioSrvc
ProcessId : 0
StartMode : Auto
State     : Stopped
Status    : OK
#>

Get-WmiObject -Class win32_service -ComputerName ILCSPSWA `
-Filter "state <> 'running' and startmode = 'auto' and name like 'Remote%'" -Credential crit\driosx
# filter is not case sensitive 'remote%'
<#
ExitCode  : 0
Name      : RemoteRegistry
ProcessId : 0
StartMode : Auto
State     : Stopped
Status    : OK
#>

# Vbscript wmi query

# Select * from Win32_DiskDrive

$wql = 'Select * from Win32_DiskDrive'
Get-WmiObject -Class Win32_LogicalDisk

<#
DeviceID     : C:
DriveType    : 3
ProviderName :
FreeSpace    : 75819569152
Size         : 135219716096
VolumeName   :

DeviceID     : D:
DriveType    : 5
ProviderName :
FreeSpace    : 0
Size         : 1298604032
VolumeName   : unraid
#>
Get-WmiObject -Class Win32_LogicalDisk -Filter 'drivetype=3'
<#
DeviceID     : C:
DriveType    : 3
ProviderName :
FreeSpace    : 75819302912
Size         : 135219716096
VolumeName   :
#>

# Corresponding WQL

$wql = 'Select * from Win32_LogicalDisk WHERE drivetype=3'
Get-WmiObject -Query $wql

