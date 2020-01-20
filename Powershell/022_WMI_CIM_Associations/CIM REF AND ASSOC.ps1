$disks = Get-CimInstance -ClassName Win32_LogicalDisk -KeyOnly

$disks | select DeviceID

<#
DeviceID
--------
C:
D:
#>

$disks[1]
$disks[0].DeviceID

# Will have relationships to other classes in the system

Get-CimAssociatedInstance -InputObject $disks[0] -ResultClassName Win32_DiskPartition
<#
Name             NumberOfBlocks          BootPartition           PrimaryPartition        Size                   Index
----             --------------          -------------           ----------------        ----                   -----
Disk #0, Part... 264101012               False                   True                    135219718144           2
#> 
Get-CimAssociatedInstance -InputObject $disks[0] -ResultClassName Win32_DiskPartition | fl *

<#
Index                       : 2
Status                      : 
StatusInfo                  : 
Name                        : Disk #0, Partition #2
Caption                     : Disk #0, Partition #2
Description                 : GPT: Basic Data      
InstallDate                 : 
Availability                : 
ConfigManagerErrorCode      : 
ConfigManagerUserConfig     :
CreationClassName           : Win32_DiskPartition
DeviceID                    : Disk #0, Partition #2
ErrorCleared                :
ErrorDescription            :
LastErrorCode               :
PNPDeviceID                 :
PowerManagementCapabilities :
PowerManagementSupported    : 
SystemCreationClassName     : Win32_ComputerSystem
SystemName                  : CRITHOS
Access                      :
BlockSize                   : 512
ErrorMethodology            :
NumberOfBlocks              : 264101012
Purpose                     :
Bootable                    : False
PrimaryPartition            : True
BootPartition               : False
DiskIndex                   : 0
HiddenSectors               :
RewritePartition            :
Size                        : 135219718144
StartingOffset              : 644874240
Type                        : GPT: Basic Data
PSComputerName              :
CimClass                    : root/cimv2:Win32_DiskPartition
CimInstanceProperties       : {Caption, Description, InstallDate, Name...}
CimSystemProperties         : Microsoft.Management.Infrastructure.CimSystemProperties
#>

$s = Get-CimInstance -ClassName win32_service -Filter "name='bits'"
$s
Get-CimAssociatedInstance -InputObject $s -Association win32_dependentservice

<#
ProcessId Name  StartMode State   Status ExitCode
--------- ----  --------- -----   ------ --------
700       RpcSs Auto      Running OK     0
#>

$s | fl *

<#
Name                    : BITS
Status                  : OK
ExitCode                : 0
DesktopInteract         : False
ErrorControl            : Normal
PathName                : C:\WINDOWS\System32\svchost.exe -k netsvcs -p
ServiceType             : Share Process
StartMode               : Auto
Caption                 : Background Intelligent Transfer Service
Description             : Transfers files in the background using idle network bandwidth. If the service is disabled, then any
                          applications that depend on BITS, such as Windows Update or MSN Explorer, will be unable to automatically    
                          download programs and other information.
InstallDate             :
CreationClassName       : Win32_Service
Started                 : True
SystemCreationClassName : Win32_ComputerSystem
SystemName              : CRITHOS
AcceptPause             : False
AcceptStop              : True
DisplayName             : Background Intelligent Transfer Service
ServiceSpecificExitCode : 0
StartName               : LocalSystem
State                   : Running
TagId                   : 0
CheckPoint              : 0
DelayedAutoStart        : True
ProcessId               : 3640
WaitHint                : 0
PSComputerName          :
CimClass                : root/cimv2:Win32_Service
CimInstanceProperties   : {Caption, Description, InstallDate, Name...}
CimSystemProperties     : Microsoft.Management.Infrastructure.CimSystemProperties
#>

$s | select -expand CimInstanceProperties

Get-WmiObject -Class win32_service -filter "name='bits'" | fl *


<#
PSComputerName          : CRITHOS
Name                    : BITS
Status                  : OK
ExitCode                : 0
DesktopInteract         : False
ErrorControl            : Normal
PathName                : C:\WINDOWS\System32\svchost.exe -k netsvcs -p
ServiceType             : Share Process
StartMode               : Auto
__GENUS                 : 2
__CLASS                 : Win32_Service
__SUPERCLASS            : Win32_BaseService
__DYNASTY               : CIM_ManagedSystemElement
__RELPATH               : Win32_Service.Name="BITS"
__PROPERTY_COUNT        : 26
#####LOOK###__DERIVATION            : {Win32_BaseService, CIM_Service, CIM_LogicalElement, CIM_ManagedSystemElement}
__SERVER                : CRITHOS
__NAMESPACE             : root\cimv2
__PATH                  : \\CRITHOS\root\cimv2:Win32_Service.Name="BITS"
AcceptPause             : False
AcceptStop              : True
Caption                 : Background Intelligent Transfer Service
CheckPoint              : 0
CreationClassName       : Win32_Service
DelayedAutoStart        : True
Description             : Transfers files in the background using idle network bandwidth. If the service is disabled, then any 
                          applications that depend on BITS, such as Windows Update or MSN Explorer, will be unable to automatically    
                          download programs and other information.
DisplayName             : Background Intelligent Transfer Service
InstallDate             :
ProcessId               : 3640
ServiceSpecificExitCode : 0
Started                 : True
StartName               : LocalSystem
State                   : Running
SystemCreationClassName : Win32_ComputerSystem
SystemName              : CRITHOS
TagId                   : 0
WaitHint                : 0
Scope                   : System.Management.ManagementScope
Path                    : \\CRITHOS\root\cimv2:Win32_Service.Name="BITS"
Options                 : System.Management.ObjectGetOptions
ClassPath               : \\CRITHOS\root\cimv2:Win32_Service
Properties              : {AcceptPause, AcceptStop, Caption, CheckPoint...}
SystemProperties        : {__GENUS, __CLASS, __SUPERCLASS, __DYNASTY...}
Qualifiers              : {dynamic, Locale, provider, UUID}
Site                    :
Container               :
#>

gcm -noun cim*
<#
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Get-CimAssociatedInstance -once you have a class   1.0.0.0    CimCmdlets
Cmdlet          Get-CimClass  -class def                           1.0.0.0    CimCmdlets
Cmdlet          Get-CimInstance -particular instance of class      1.0.0.0    CimCmdlets
Cmdlet          Get-CimSession                                     1.0.0.0    CimCmdlets
Cmdlet          Invoke-CimMethod                                   1.0.0.0    CimCmdlets
Cmdlet          New-CimInstance                                    1.0.0.0    CimCmdlets
Cmdlet          New-CimSession                                     1.0.0.0    CimCmdlets
Cmdlet          New-CimSessionOption                               1.0.0.0    CimCmdlets
Cmdlet          Register-CimIndicationEvent                        1.0.0.0    CimCmdlets
Cmdlet          Remove-CimInstance                                 1.0.0.0    CimCmdlets
Cmdlet          Remove-CimSession                                  1.0.0.0    CimCmdlets
Cmdlet          Set-CimInstance                                    1.0.0.0    CimCmdlets
#>

#(A)<>(B)<>(C) 