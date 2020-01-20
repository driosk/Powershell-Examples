# WMI is going away.
# WMI basics.
# Assumes you know what class to query and what namespace it lives in.

Get-WmiObject -Class win32_service | Select -Property * -First 1

<#
PSComputerName          : CRITHOS
Name                    : AJRouter
Status                  : OK
ExitCode                : 1077
DesktopInteract         : False
ErrorControl            : Normal
PathName                : C:\WINDOWS\system32\svchost.exe -k LocalServiceNetworkRestricted -p
ServiceType             : Share Process
StartMode               : Manual
__GENUS                 : 2
__CLASS                 : Win32_Service
__SUPERCLASS            : Win32_BaseService
__DYNASTY               : CIM_ManagedSystemElement
__RELPATH               : Win32_Service.Name="AJRouter"
__PROPERTY_COUNT        : 26
__DERIVATION            : {Win32_BaseService, CIM_Service, CIM_LogicalElement, CIM_ManagedSystemElement}
__SERVER                : CRITHOS
__NAMESPACE             : root\cimv2
__PATH                  : \\CRITHOS\root\cimv2:Win32_Service.Name="AJRouter"
AcceptPause             : False
AcceptStop              : False
Caption                 : AllJoyn Router Service
CheckPoint              : 0
CreationClassName       : Win32_Service
DelayedAutoStart        : False
Description             : Routes AllJoyn messages for the local AllJoyn clients. If this service is stopped the AllJoyn clients that
                          do not have their own bundled routers will be unable to run.
DisplayName             : AllJoyn Router Service
InstallDate             :
ProcessId               : 0
ServiceSpecificExitCode : 0
Started                 : False
StartName               : NT AUTHORITY\LocalService
State                   : Stopped
SystemCreationClassName : Win32_ComputerSystem
SystemName              : CRITHOS
TagId                   : 0
WaitHint                : 0
Scope                   : System.Management.ManagementScope
Path                    : \\CRITHOS\root\cimv2:Win32_Service.Name="AJRouter"
Options                 : System.Management.ObjectGetOptions
ClassPath               : \\CRITHOS\root\cimv2:Win32_Service
Properties              : {AcceptPause, AcceptStop, Caption, CheckPoint...}
SystemProperties        : {__GENUS, __CLASS, __SUPERCLASS, __DYNASTY...}
Qualifiers              : {dynamic, Locale, provider, UUID}
Site                    :
Container               :
#>

gwmi win32_service -ComputerName localhost | select * -First 1

gwmi win32_bios

gwmi win32_bios | fl *

'ILCSDC0','ILCSDC1','ILCSRCA','ILCSICA','CS-WSUS','ILCSPSWA','ILCSINFWDS1' | Out-File .\computers.txt
Get-Content .\computers.txt

gwmi win32_bios -ComputerName (Get-Content  .\computers.txt)

gwmi win32_bios -ComputerName (type .\computers.txt)

# if one fails it is considered a non-terminating error and it will continue to the next one.

<#
SMBIOSBIOSVersion : 0.0.0
Manufacturer      : EFI Development Kit II / OVMF
Name              : 0.0.0
SerialNumber      :
Version           : BOCHS  - 1

SMBIOSBIOSVersion : 0.0.0
Manufacturer      : EFI Development Kit II / OVMF
Name              : 0.0.0
SerialNumber      :
Version           : BOCHS  - 1
#>

gwmi win32_bios -ComputerName (type .\computers.txt) | ft -Property __SERVER,SerialNumber,Version -AutoSize

# Autosize waits for all data to format to biggest column.

# powersshell v3

gwmi win32_bios | gm

gwmi win32_bios | ft -Property PSComputerName,SerialNumber,Version

gwmi -Class AntiSpywareProduct -Namespace root\securitycenter2
gwmi -Class AntiSpywareProduct -Namespace root\securitycenter2 |
ft displayname,productstate,pathtosignedproductexe -autosize

<#
displayname      productstate pathtosignedproductexe
-----------      ------------ ----------------------
Windows Defender       397568 windowsdefender://
#>

gwmi -Class AntiSpywareProduct -Namespace root\securitycenter2 | gm

<#
__GENUS                  : 2
__CLASS                  : AntiSpywareProduct
__DYNASTY                : AntiSpywareProduct
__RELPATH                : AntiSpywareProduct.instanceGuid="{D68DDC3A-831F-4fae-9E44-DA132C1
                           ACF46}"
__PROPERTY_COUNT         : 6
__DERIVATION             : {}
__SERVER                 : CRITHOS
__PATH                   : \\CRITHOS\ROOT\securitycenter2:AntiSpywareProduct.instanceGuid="{
                           D68DDC3A-831F-4fae-9E44-DA132C1ACF46}"
displayName              : Windows Defender
instanceGuid             : {D68DDC3A-831F-4fae-9E44-DA132C1ACF46}
pathToSignedProductExe   : windowsdefender://
pathToSignedReportingExe : %ProgramFiles%\Windows Defender\MsMpeng.exe
productState             : 397568
PSComputerName           : CRITHOS

#>

gwmi -Class AntiSpywareProduct -Namespace root\securitycenter2 |
ft displayname,productstate,pathtosignedproductexe -autosize
<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\19_WMI Commands to Query Data> gwmi -Class AntiSpywareProduct -Namespace root\securitycenter2 | gm


   TypeName: System.Management.ManagementObject#ROOT\securitycenter2\AntiSpywareProduct

Name                     MemberType    Definition
----                     ----------    ----------
PSComputerName           AliasProperty PSComputerName = __SERVER
displayName              Property      string displayName {get;set;}
instanceGuid             Property      string instanceGuid {get;set;}
pathToSignedProductExe   Property      string pathToSignedProductExe {get;set;}
pathToSignedReportingExe Property      string pathToSignedReportingExe {get;set;}
productState             Property      uint32 productState {get;set;}
timestamp                Property      string timestamp {get;set;}
__CLASS                  Property      string __CLASS {get;set;}
__DERIVATION             Property      string[] __DERIVATION {get;set;}
__DYNASTY                Property      string __DYNASTY {get;set;}
__GENUS                  Property      int __GENUS {get;set;}
__NAMESPACE              Property      string __NAMESPACE {get;set;}
__PATH                   Property      string __PATH {get;set;}
__PROPERTY_COUNT         Property      int __PROPERTY_COUNT {get;set;}
__RELPATH                Property      string __RELPATH {get;set;}
__SERVER                 Property      string __SERVER {get;set;}
__SUPERCLASS             Property      string __SUPERCLASS {get;set;}
ConvertFromDateTime      ScriptMethod  System.Object ConvertFromDateTime();
ConvertToDateTime        ScriptMethod  System.Object ConvertToDateTime();
#>

gwmi win32_bios -ComputerName (type .\computers.txt) -Credential CRIT\driosx
# User credentials cannot be used for local connections.

Get-WmiObject -Class win32_logicaldisk # Need to google.

$os = gwmi win32_operatingsystem
$os | fl *

<#
InstallDate                               : 20190612104653.000000-360
#>

$os.ConvertToDateTime($os.lastbootuptime)
# Sunday, December 1, 2019 3:17:40 PM

$os.ConvertToDateTime($os.lastbootuptime).toshortdatestring()
# 12/1/2019