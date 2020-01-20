$disk = Get-WmiObject -Class win32_logicaldisk -Filter "deviceid='c:'"

<#
DeviceID     : C:
DriveType    : 3
ProviderName :
FreeSpace    : 18769932288
Size         : 42842714112
VolumeName   :
#>

$disk | gm

<#
  TypeName: System.Management.ManagementObject#root\cimv2\Win32_LogicalDisk

Name                         MemberType   Definition
----                         ----------   ----------
Chkdsk                       Method       System.Management.ManagementBaseObject Chkdsk(System.Boolean FixErrors, Sy...
Reset                        Method       System.Management.ManagementBaseObject Reset()
SetPowerState                Method       System.Management.ManagementBaseObject SetPowerState(System.UInt16 PowerSt...
Access                       Property     System.UInt16 Access {get;set;}
Availability                 Property     System.UInt16 Availability {get;set;}
BlockSize                    Property     System.UInt64 BlockSize {get;set;}
Caption                      Property     System.String Caption {get;set;}
Compressed                   Property     System.Boolean Compressed {get;set;}
ConfigManagerErrorCode       Property     System.UInt32 ConfigManagerErrorCode {get;set;}
ConfigManagerUserConfig      Property     System.Boolean ConfigManagerUserConfig {get;set;}
CreationClassName            Property     System.String CreationClassName {get;set;}
Description                  Property     System.String Description {get;set;}
DeviceID                     Property     System.String DeviceID {get;set;}
DriveType                    Property     System.UInt32 DriveType {get;set;}
ErrorCleared                 Property     System.Boolean ErrorCleared {get;set;}
ErrorDescription             Property     System.String ErrorDescription {get;set;}
ErrorMethodology             Property     System.String ErrorMethodology {get;set;}
FileSystem                   Property     System.String FileSystem {get;set;}
FreeSpace                    Property     System.UInt64 FreeSpace {get;set;}
InstallDate                  Property     System.String InstallDate {get;set;}
LastErrorCode                Property     System.UInt32 LastErrorCode {get;set;}
MaximumComponentLength       Property     System.UInt32 MaximumComponentLength {get;set;}
MediaType                    Property     System.UInt32 MediaType {get;set;}
Name                         Property     System.String Name {get;set;}
NumberOfBlocks               Property     System.UInt64 NumberOfBlocks {get;set;}
PNPDeviceID                  Property     System.String PNPDeviceID {get;set;}
PowerManagementCapabilities  Property     System.UInt16[] PowerManagementCapabilities {get;set;}
PowerManagementSupported     Property     System.Boolean PowerManagementSupported {get;set;}
ProviderName                 Property     System.String ProviderName {get;set;}
Purpose                      Property     System.String Purpose {get;set;}
QuotasDisabled               Property     System.Boolean QuotasDisabled {get;set;}
QuotasIncomplete             Property     System.Boolean QuotasIncomplete {get;set;}
QuotasRebuilding             Property     System.Boolean QuotasRebuilding {get;set;}
Size                         Property     System.UInt64 Size {get;set;}
Status                       Property     System.String Status {get;set;}
StatusInfo                   Property     System.UInt16 StatusInfo {get;set;}
SupportsDiskQuotas           Property     System.Boolean SupportsDiskQuotas {get;set;}
SupportsFileBasedCompression Property     System.Boolean SupportsFileBasedCompression {get;set;}
SystemCreationClassName      Property     System.String SystemCreationClassName {get;set;}
SystemName                   Property     System.String SystemName {get;set;}
VolumeDirty                  Property     System.Boolean VolumeDirty {get;set;}
VolumeName                   Property     System.String VolumeName {get;set;}
VolumeSerialNumber           Property     System.String VolumeSerialNumber {get;set;}
__CLASS                      Property     System.String __CLASS {get;set;}
__DERIVATION                 Property     System.String[] __DERIVATION {get;set;}
__DYNASTY                    Property     System.String __DYNASTY {get;set;}
__GENUS                      Property     System.Int32 __GENUS {get;set;}
__NAMESPACE                  Property     System.String __NAMESPACE {get;set;}
__PATH                       Property     System.String __PATH {get;set;}
__PROPERTY_COUNT             Property     System.Int32 __PROPERTY_COUNT {get;set;}
__RELPATH                    Property     System.String __RELPATH {get;set;}
__SERVER                     Property     System.String __SERVER {get;set;}
__SUPERCLASS                 Property     System.String __SUPERCLASS {get;set;}
PSStatus                     PropertySet  PSStatus {Status, Availability, DeviceID, StatusInfo}
ConvertFromDateTime          ScriptMethod System.Object ConvertFromDateTime();
ConvertToDateTime            ScriptMethod System.Object ConvertToDateTime();
#>

# Careful with set. May not work. Apply common sense. 

# for example: Volume name cannot be changed. 

$disk.VolumeName = 'LOCAL'

# wont work
<#
DeviceID     : C:
DriveType    : 3
ProviderName :
FreeSpace    : 18769932288
Size         : 42842714112
VolumeName   : LOCAL
#> # This is cached in the variable but to make it permanent we call the put() method. 

$disk.put() # Use this to permanently change.
<#
Path          : \\localhost\root\cimv2:Win32_LogicalDisk.DeviceID="C:"
RelativePath  : Win32_LogicalDisk.DeviceID="C:"
Server        : localhost
NamespacePath : root\cimv2
ClassName     : Win32_LogicalDisk
IsClass       : False
IsInstance    : True
IsSingleton   : False
#>

Get-WmiObject -Class win32_logicaldisk -Filter "deviceid='C:'"
<#
DeviceID     : C:
DriveType    : 3
ProviderName :
FreeSpace    : 18770419712
Size         : 42842714112
VolumeName   : LOCAL
#> 

Get-WmiObject win32_operatingsystem | gm

#script method is not a native method and won't be in documentation. 

<#
Name                                      MemberType   Definition
----                                      ----------   ----------
Reboot                                    Method       System.Management.ManagementBaseObject Reboot()
SetDateTime                               Method       System.Management.ManagementBaseObject SetDateTime(System.Str...
Shutdown                                  Method       System.Management.ManagementBaseObject Shutdown()
Win32Shutdown                             Method       System.Management.ManagementBaseObject Win32Shutdown(System.I...
Win32ShutdownTracker                      Method       System.Management.ManagementBaseObject Win32ShutdownTracker(S...
BootDevice                                Property     System.String BootDevice {get;set;}
BuildNumber                               Property     System.String BuildNumber {get;set;}
BuildType                                 Property     System.String BuildType {get;set;}
Caption                                   Property     System.String Caption {get;set;}
CodeSet                                   Property     System.String CodeSet {get;set;}
CountryCode                               Property     System.String CountryCode {get;set;}
CreationClassName                         Property     System.String CreationClassName {get;set;}
CSCreationClassName                       Property     System.String CSCreationClassName {get;set;}
CSDVersion                                Property     System.String CSDVersion {get;set;}
CSName                                    Property     System.String CSName {get;set;}
CurrentTimeZone                           Property     System.Int16 CurrentTimeZone {get;set;}
DataExecutionPrevention_32BitApplications Property     System.Boolean DataExecutionPrevention_32BitApplications {get...
DataExecutionPrevention_Available         Property     System.Boolean DataExecutionPrevention_Available {get;set;}
DataExecutionPrevention_Drivers           Property     System.Boolean DataExecutionPrevention_Drivers {get;set;}
DataExecutionPrevention_SupportPolicy     Property     System.Byte DataExecutionPrevention_SupportPolicy {get;set;}
Debug                                     Property     System.Boolean Debug {get;set;}
Description                               Property     System.String Description {get;set;}
Distributed                               Property     System.Boolean Distributed {get;set;}
EncryptionLevel                           Property     System.UInt32 EncryptionLevel {get;set;}
ForegroundApplicationBoost                Property     System.Byte ForegroundApplicationBoost {get;set;}
FreePhysicalMemory                        Property     System.UInt64 FreePhysicalMemory {get;set;}
FreeSpaceInPagingFiles                    Property     System.UInt64 FreeSpaceInPagingFiles {get;set;}
FreeVirtualMemory                         Property     System.UInt64 FreeVirtualMemory {get;set;}
InstallDate                               Property     System.String InstallDate {get;set;}
LargeSystemCache                          Property     System.UInt32 LargeSystemCache {get;set;}
LastBootUpTime                            Property     System.String LastBootUpTime {get;set;}
LocalDateTime                             Property     System.String LocalDateTime {get;set;}
Locale                                    Property     System.String Locale {get;set;}
Manufacturer                              Property     System.String Manufacturer {get;set;}
MaxNumberOfProcesses                      Property     System.UInt32 MaxNumberOfProcesses {get;set;}
MaxProcessMemorySize                      Property     System.UInt64 MaxProcessMemorySize {get;set;}
MUILanguages                              Property     System.String[] MUILanguages {get;set;}
Name                                      Property     System.String Name {get;set;}
NumberOfLicensedUsers                     Property     System.UInt32 NumberOfLicensedUsers {get;set;}
NumberOfProcesses                         Property     System.UInt32 NumberOfProcesses {get;set;}
NumberOfUsers                             Property     System.UInt32 NumberOfUsers {get;set;}
OperatingSystemSKU                        Property     System.UInt32 OperatingSystemSKU {get;set;}
Organization                              Property     System.String Organization {get;set;}
OSArchitecture                            Property     System.String OSArchitecture {get;set;}
OSLanguage                                Property     System.UInt32 OSLanguage {get;set;}
OSProductSuite                            Property     System.UInt32 OSProductSuite {get;set;}
OSType                                    Property     System.UInt16 OSType {get;set;}
OtherTypeDescription                      Property     System.String OtherTypeDescription {get;set;}
PAEEnabled                                Property     System.Boolean PAEEnabled {get;set;}
PlusProductID                             Property     System.String PlusProductID {get;set;}
PlusVersionNumber                         Property     System.String PlusVersionNumber {get;set;}
Primary                                   Property     System.Boolean Primary {get;set;}
ProductType                               Property     System.UInt32 ProductType {get;set;}
RegisteredUser                            Property     System.String RegisteredUser {get;set;}
SerialNumber                              Property     System.String SerialNumber {get;set;}
ServicePackMajorVersion                   Property     System.UInt16 ServicePackMajorVersion {get;set;}
ServicePackMinorVersion                   Property     System.UInt16 ServicePackMinorVersion {get;set;}
SizeStoredInPagingFiles                   Property     System.UInt64 SizeStoredInPagingFiles {get;set;}
Status                                    Property     System.String Status {get;set;}
SuiteMask                                 Property     System.UInt32 SuiteMask {get;set;}
SystemDevice                              Property     System.String SystemDevice {get;set;}
SystemDirectory                           Property     System.String SystemDirectory {get;set;}
SystemDrive                               Property     System.String SystemDrive {get;set;}
TotalSwapSpaceSize                        Property     System.UInt64 TotalSwapSpaceSize {get;set;}
TotalVirtualMemorySize                    Property     System.UInt64 TotalVirtualMemorySize {get;set;}
TotalVisibleMemorySize                    Property     System.UInt64 TotalVisibleMemorySize {get;set;}
Version                                   Property     System.String Version {get;set;}
WindowsDirectory                          Property     System.String WindowsDirectory {get;set;}
__CLASS                                   Property     System.String __CLASS {get;set;}
__DERIVATION                              Property     System.String[] __DERIVATION {get;set;}
__DYNASTY                                 Property     System.String __DYNASTY {get;set;}
__GENUS                                   Property     System.Int32 __GENUS {get;set;}
__NAMESPACE                               Property     System.String __NAMESPACE {get;set;}
__PATH                                    Property     System.String __PATH {get;set;}
__PROPERTY_COUNT                          Property     System.Int32 __PROPERTY_COUNT {get;set;}
__RELPATH                                 Property     System.String __RELPATH {get;set;}
__SERVER                                  Property     System.String __SERVER {get;set;}
__SUPERCLASS                              Property     System.String __SUPERCLASS {get;set;}
FREE                                      PropertySet  FREE {FreePhysicalMemory, FreeSpaceInPagingFiles, FreeVirtual...
PSStatus                                  PropertySet  PSStatus {Status, Name}
ConvertFromDateTime                       ScriptMethod System.Object ConvertFromDateTime();
ConvertToDateTime                         ScriptMethod System.Object ConvertToDateTime();
#>
# ConvertFromDateTime                       ScriptMethod System.Object ConvertFromDateTime();
# ConvertToDateTime                         ScriptMethod System.Object ConvertToDateTime();
$os = Get-WmiObject win32_operatingsystem | fl *

<#
Status                                    : OK
Name                                      : Microsoft Windows 7 Ultimate |C:\Windows|\Device\Harddisk0\Partition2
FreePhysicalMemory                        : 3169300
FreeSpaceInPagingFiles                    : 4029120
FreeVirtualMemory                         : 7258572
__GENUS                                   : 2
__CLASS                                   : Win32_OperatingSystem
__SUPERCLASS                              : CIM_OperatingSystem
__DYNASTY                                 : CIM_ManagedSystemElement
__RELPATH                                 : Win32_OperatingSystem=@
__PROPERTY_COUNT                          : 63
__DERIVATION                              : {CIM_OperatingSystem, CIM_LogicalElement, CIM_ManagedSystemElement}
__SERVER                                  : ILCSWS007
__NAMESPACE                               : root\cimv2
__PATH                                    : \\ILCSWS007\root\cimv2:Win32_OperatingSystem=@
BootDevice                                : \Device\HarddiskVolume1
BuildNumber                               : 7601
BuildType                                 : Multiprocessor Free
Caption                                   : Microsoft Windows 7 Ultimate
CodeSet                                   : 1252
CountryCode                               : 1
CreationClassName                         : Win32_OperatingSystem
CSCreationClassName                       : Win32_ComputerSystem
CSDVersion                                : Service Pack 1
CSName                                    : ILCSWS007
CurrentTimeZone                           : -360
DataExecutionPrevention_32BitApplications : True
DataExecutionPrevention_Available         : True
DataExecutionPrevention_Drivers           : True
DataExecutionPrevention_SupportPolicy     : 2
Debug                                     : False
Description                               :
Distributed                               : False
EncryptionLevel                           : 256
ForegroundApplicationBoost                : 2
InstallDate                               : 20191130103808.000000-360
LargeSystemCache                          :
LastBootUpTime                            : 20191203011308.594468-360
LocalDateTime                             : 20191204101830.408000-360
Locale                                    : 0409
Manufacturer                              : Microsoft Corporation
MaxNumberOfProcesses                      : 4294967295
MaxProcessMemorySize                      : 2097024
MUILanguages                              : {en-US}
NumberOfLicensedUsers                     : 0
NumberOfProcesses                         : 41
NumberOfUsers                             : 3
OperatingSystemSKU                        : 1
Organization                              :
OSArchitecture                            : 32-bit
OSLanguage                                : 1033
OSProductSuite                            : 256
OSType                                    : 18
OtherTypeDescription                      :
PAEEnabled                                : True
PlusProductID                             :
PlusVersionNumber                         :
Primary                                   : True
ProductType                               : 1
RegisteredUser                            : drios
SerialNumber                              : 00426-074-1459171-85913
ServicePackMajorVersion                   : 1
ServicePackMinorVersion                   : 0
SizeStoredInPagingFiles                   : 4062776
SuiteMask                                 : 272
SystemDevice                              : \Device\HarddiskVolume2
SystemDirectory                           : C:\Windows\system32
SystemDrive                               : C:
TotalSwapSpaceSize                        :
TotalVirtualMemorySize                    : 8123884
TotalVisibleMemorySize                    : 4062776
Version                                   : 6.1.7601
WindowsDirectory                          : C:\Windows
Scope                                     : System.Management.ManagementScope
Path                                      : \\ILCSWS007\root\cimv2:Win32_OperatingSystem=@
Options                                   : System.Management.ObjectGetOptions
ClassPath                                 : \\ILCSWS007\root\cimv2:Win32_OperatingSystem
Properties                                : {BootDevice, BuildNumber, BuildType, Caption...}
SystemProperties                          : {__GENUS, __CLASS, __SUPERCLASS, __DYNASTY...}
Qualifiers                                : {dynamic, Locale, provider, Singleton...}
Site                                      :
Container                                 :
#>

$os.ConvertToDateTime($os.LastBootUpTime)
# Tuesday, December 03, 2019 1:13:08 AM
# Now it is a full datetime object
$os.ConvertToDateTime($os.LastBootUpTime) | gm

# TypeName: System.DateTime

$os.ConvertToDateTime($os.LastBootUpTime).toshortdatestring()   

# 12/3/2019

# Powershell added this to every class that it was told to. 

# Query any class that does have those.
# use the first class script method on a class that doesn't have the method and it will work. 
$os.ConvertToDateTime($newobject.datetime)

$os = Get-WmiObject -Class win32_operatingsystem -ComputerName ILCSWS008

<#
TypeName: System.Management.ManagementObject#root\cimv2\Win32_OperatingSystem

Name                                      MemberType    Definition
----                                      ----------    ----------
PSComputerName                            AliasProperty PSComputerName = __SERVER
Reboot                                    Method        System.Management.ManagementBaseObject Reboot()
SetDateTime                               Method        System.Management.ManagementBaseObject SetDateTime(System.St...
Shutdown                                  Method        System.Management.ManagementBaseObject Shutdown()
Win32Shutdown                             Method        System.Management.ManagementBaseObject Win32Shutdown(System....
Win32ShutdownTracker                      Method        System.Management.ManagementBaseObject Win32ShutdownTracker(.
#>

# $os.Win32Shutdown(4)

Get-WmiObject win32_service -ComputerName ILCSWS008.critsol.net,ILCSDC1.critsol.net

Get-WmiObject win32_service -ComputerName ILCSWS008.critsol.net,ILCSDC1.critsol.net `
-Filter "name='bits'" | select -Property PSComputerName,Name,startmode,State,Status
<#
PSComputerName : ILCSWS008
Name           : BITS
startmode      : Auto
State          : Running
Status         : OK

PSComputerName : ILCSDC1
Name           : BITS
startmode      : Manual
State          : Stopped
Status         : OK
#>
Get-WmiObject win32_service -ComputerName ILCSWS008.critsol.net,ILCSDC1.critsol.net `
-Filter "name='bits'" | gm

<#
Name                    MemberType    Definition
----                    ----------    ----------
PSComputerName          AliasProperty PSComputerName = __SERVER
Change                  Method        System.Management.ManagementBaseObject Change(System.String DisplayName, Syste...
ChangeStartMode         Method        System.Management.ManagementBaseObject ChangeStartMode(System.String StartMode)
Delete                  Method        System.Management.ManagementBaseObject Delete()
GetSecurityDescriptor   Method        System.Management.ManagementBaseObject GetSecurityDescriptor()
InterrogateService      Method        System.Management.ManagementBaseObject InterrogateService()
PauseService            Method        System.Management.ManagementBaseObject PauseService()
ResumeService           Method        System.Management.ManagementBaseObject ResumeService()
SetSecurityDescriptor   Method        System.Management.ManagementBaseObject SetSecurityDescriptor(System.Management...
StartService            Method        System.Management.ManagementBaseObject StartService()
StopService             Method        System.Management.ManagementBaseObject StopService()
UserControlService      Method        System.Management.ManagementBaseObject UserControlService(System.Byte ControlC...
#>

Get-WmiObject win32_service -ComputerName ILCSWS008.critsol.net,ILCSDC1.critsol.net `
-Filter "name='bits'" |
Invoke-WmiMethod -Name StartService

<#
__GENUS          : 2
__CLASS          : __PARAMETERS
__SUPERCLASS     :
__DYNASTY        : __PARAMETERS
__RELPATH        :
__PROPERTY_COUNT : 1
__DERIVATION     : {}
__SERVER         :
__NAMESPACE      :
__PATH           :
ReturnValue      : 10
PSComputerName   :

__GENUS          : 2
__CLASS          : __PARAMETERS
__SUPERCLASS     :
__DYNASTY        : __PARAMETERS
__RELPATH        :
__PROPERTY_COUNT : 1
__DERIVATION     : {}
__SERVER         :
__NAMESPACE      :
__PATH           :
ReturnValue      : 0
PSComputerName   :
#>


Get-WmiObject win32_service -ComputerName ILCSWS008.critsol.net,ILCSDC1.critsol.net `
-Filter "name='bits'" | select -Property PSComputerName,Name,startmode,State,Status
Get-WmiObject win32_service -ComputerName ILCSWS008.critsol.net,ILCSDC1.critsol.net `
-Filter "name='bits'" | select PSComputerName,name,State
<#
PSComputerName : ILCSWS008
Name           : BITS
startmode      : Auto
State          : Running
Status         : OK

PSComputerName : ILCSDC1
Name           : BITS
startmode      : Auto
State          : Running
Status         : OK
#>

# You don't have to get first. 

Invoke-WmiMethod -Class win32_service -ComputerName ILCSWS008.critsol.net -Name StopService -Namespace BITS

Get-WmiObject win32_service -ComputerName ILCSWS008.critsol.net,ILCSDC1.critsol.net `
-Filter "name='bits'" | gm 

# change method

<#
Name                    MemberType    Definition
----                    ----------    ----------
PSComputerName          AliasProperty PSComputerName = __SERVER
Change                  Method        System.Management.ManagementBaseObject Change(System.String DisplayName, Syste...
#>

# you can change each method but you need to give all the others that preceed a NULL but the proceeding can 
# be ommited because they come after. Refer to Pic.

# mof
<#
Managed Object Format
----------------------------
uint32 Change(
  [in] string  DisplayName,
  [in] string  PathName,
  [in] uint32  ServiceType,
  [in] uint32  ErrorControl,
  [in] string  StartMode,
  [in] boolean DesktopInteract,
  [in] string  StartName,
  [in] string  StartPassword,
  [in] string  LoadOrderGroup,
  [in] string  LoadOrderGroupDependencies[],
  [in] string  ServiceDependencies[]
);
#>

# to change password would be 7 nulls and change the password

Get-WmiObject win32_service -ComputerName ILCSWS008.critsol.net | Invoke-WmiMethod -Name change -ArgumentList `
$null,$null,$null,$null,$null,$null,$null,'Password' #WON'T work. Invoke-WmiMethod doesn't like nulls. 

# expects argument list to be Null Terminated, nothing after null. 

Get-WmiObject win32_service -ComputerName ILCSWS008.critsol.net -Filter "name='bits'" |
foreach {$_.change($null,$null,$null,$null,$null,$null,$null,'P@ssw0rd')}

# Whatif only works for cmdlets. Invoke-wmimethod has a whatif. 
<#
$os.method()

get/Invoke-WmiMethod
get/foreach {}

invoke
#>
Get-CimInstance -ClassName win32_service -Filter "name='bits'" `
-ComputerName ILCSWS008.critsol.net |
Invoke-CimMethod -MethodName Change -Arguments @{StartPassword='P@ssw0rd'} 

# no need for a foreach or $nulls.





