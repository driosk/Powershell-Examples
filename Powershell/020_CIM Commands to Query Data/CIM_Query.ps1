Get-Command -Noun cim*

<#
CommandType     Name                                               Version    Source        
-----------     ----                                               -------    ------
Cmdlet          Get-CimAssociatedInstance                          1.0.0.0    CimCmdlets    
Cmdlet          Get-CimClass                                       1.0.0.0    CimCmdlets     
Cmdlet          Get-CimInstance                                    1.0.0.0    CimCmdlets     
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

# CIM CLass / CIM Instance.

# Everything starts at the namespace

# Starts with Class Definitions (CIM Class defines a potentially manageable object) 
# When you have a manageable object, you have and instance of the corresponding class.

help Get-CimClass

<#
SYNTAX
    Get-CimClass [[-ClassName] <String>] [[-Namespace] <String>] [-ComputerName <String[]>] [-MethodName <String>]
    [-OperationTimeoutSec <UInt32>] [-PropertyName <String>] [-QualifierName <String>] [<CommonParameters>]

    Get-CimClass [[-ClassName] <String>] [[-Namespace] <String>] [-MethodName <String>] [-OperationTimeoutSec <UInt32>]
    [-PropertyName <String>] [-QualifierName <String>] -CimSession <CimSession[]> [<CommonParameters>]
#>

Get-CimClass -ClassName win32_bios -Namespace root\cimv2

<#
   NameSpace: ROOT/cimv2

CimClassName                        CimClassMethods      CimClassProperties
------------                        ---------------      ------------------
Win32_BIOS                          {}                   {Caption, Description, InstallDate, Name...}
#>

Get-CimClass -ClassName win32_bios -Namespace root\cimv2 | fl *
<#
CimClassName        : Win32_BIOS # Inherits from superclass CIM_BIOSElement and adds win specific implementations.
CimSuperClassName   : CIM_BIOSElement # Generic Vendor Nuetral Class
CimSuperClass       : ROOT/cimv2:CIM_BIOSElement
CimClassProperties  : {Caption, Description, InstallDate, Name...}
CimClassQualifiers  : {Locale, UUID, dynamic, provider}
CimClassMethods     : {}
CimSystemProperties : Microsoft.Management.Infrastructure.CimSystemProperties
#>

Get-CimClass -ClassName win32_bios -Namespace root\cimv2 | select -ExpandProperty CimClassProperties

<#
Name               : Caption
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MaxLen, read}
ReferenceClassName :

Name               : Description
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {read}
ReferenceClassName :

Name               : InstallDate
Value              :
CimType            : DateTime
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : Name
Value              :
CimType            : String
Flags              : Property, Key, ReadOnly, NullValue
Qualifiers         : {read, key, maxlen}
ReferenceClassName :

Name               : Status
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MaxLen, read, ValueMap}
ReferenceClassName :

Name               : BuildNumber
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {Mappingstrings, Maxlen, read}
ReferenceClassName :

Name               : CodeSet
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {Maxlen, read}
ReferenceClassName :

Name               : IdentificationCode
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {Mappingstrings, Maxlen, read}
ReferenceClassName :

Name               : LanguageEdition
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {Mappingstrings, Maxlen, read}
ReferenceClassName :

Name               : Manufacturer
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {Mappingstrings, Maxlen, read}
ReferenceClassName : 

Name               : OtherTargetOS
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {Maxlen, ModelCorrespondence, read}
ReferenceClassName :

Name               : SerialNumber
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {Mappingstrings, Maxlen, read}
ReferenceClassName :

Name               : SoftwareElementID
Value              :
CimType            : String
Flags              : Property, Key, ReadOnly, NullValue
Qualifiers         : {key, maxlen, read}
ReferenceClassName :

Name               : SoftwareElementState
Value              : 
CimType            : UInt16
Flags              : Property, Key, ReadOnly, NullValue
Qualifiers         : {key, read}
ReferenceClassName :

Name               : TargetOperatingSystem
Value              :
CimType            : UInt16
Flags              : Property, Key, ReadOnly, NullValue
Qualifiers         : {key, Mappingstrings, ModelCorrespondence, read}
ReferenceClassName :

Name               : Version
Value              :
CimType            : String
Flags              : Property, Key, ReadOnly, NullValue
Qualifiers         : {key, Mappingstrings, Maxlen, read...}
ReferenceClassName :

Name               : PrimaryBIOS
Value              : 
CimType            : Boolean
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : BiosCharacteristics
Value              :
CimType            : UInt16Array
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : BIOSVersion
Value              :
CimType            : StringArray
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {read}
ReferenceClassName :

Name               : CurrentLanguage
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : EmbeddedControllerMajorVersion
Value              :
CimType            : UInt8
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : EmbeddedControllerMinorVersion
Value              :
CimType            : UInt8
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : InstallableLanguages
Value              :
CimType            : UInt16
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : ListOfLanguages
Value              :
CimType            : StringArray
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : ReleaseDate
Value              :
CimType            : DateTime
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {read}
ReferenceClassName :

Name               : SMBIOSBIOSVersion
Value              :
CimType            : String
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : SMBIOSMajorVersion
Value              :
CimType            : UInt16
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : SMBIOSMinorVersion
Value              :
CimType            : UInt16
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : SMBIOSPresent
Value              :
CimType            : Boolean
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : SystemBiosMajorVersion
Value              : 
CimType            : UInt8
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :

Name               : SystemBiosMinorVersion
Value              :
CimType            : UInt8
Flags              : Property, ReadOnly, NullValue
Qualifiers         : {MappingStrings, read}
ReferenceClassName :
#>
# Tab completion only works locally
Get-CimClass -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct

Get-CimClass -Namespace root/SecurityCenter2 -ClassName AntiVirusProduct | 
select -ExpandProperty CimClassProperties

Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiSpywareProduct
Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiSpywareProduct | 
select *

<#
displayName              : Windows Defender
instanceGuid             : {D68DDC3A-831F-4fae-9E44-DA132C1ACF46}
pathToSignedProductExe   : windowsdefender://
pathToSignedReportingExe : %ProgramFiles%\Windows Defender\MsMpeng.exe
productState             : 397568
timestamp                : Wed, 12 Jun 2019 16:00:04 GMT
PSComputerName           : ###NOTHING HERE DUDE###
CimClass                 : ROOT/SecurityCenter2:AntiSpywareProduct
CimInstanceProperties    : {displayName, instanceGuid, pathToSignedProductExe, pathToSignedReportingExe...}
CimSystemProperties      : Microsoft.Management.Infrastructure.CimSystemProperties
#>
 
# Doesn't output sytem classes __SystemClass

gwmi -Namespace root\SecurityCenter2 -Class AntiSpywareProduct

<#
__GENUS                  : 2
__CLASS                  : AntiSpywareProduct
__SUPERCLASS             :
__DYNASTY                : AntiSpywareProduct
__RELPATH                : AntiSpywareProduct.instanceGuid="{D68DDC3A-831F-4fae-9E44-DA132C1ACF46}"
__PROPERTY_COUNT         : 6
__DERIVATION             : {}
__SERVER                 : CRITHOS
__NAMESPACE              : ROOT\SecurityCenter2
__PATH                   : \\CRITHOS\ROOT\SecurityCenter2:AntiSpywareProduct.instanceGuid="{D68DDC3A-831F-4fae-9E44-DA132C1ACF46}"     
displayName              : Windows Defender
instanceGuid             : {D68DDC3A-831F-4fae-9E44-DA132C1ACF46}
pathToSignedProductExe   : windowsdefender://
pathToSignedReportingExe : %ProgramFiles%\Windows Defender\MsMpeng.exe
productState             : 397568
timestamp                : Wed, 12 Jun 2019 16:00:04 GMT
PSComputerName           : CRITHOS
#>

Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntiSpywareProduct | gm
<#
Name                      MemberType Definition
----                      ---------- ----------
Clone                     Method     System.Object ICloneable.Clone()
Dispose                   Method     void Dispose(), void IDisposable.Dispose()
Equals                    Method     bool Equals(System.Object obj)
GetCimSessionComputerName Method     string GetCimSessionComputerName()
GetCimSessionInstanceId   Method     guid GetCimSessionInstanceId()
GetHashCode               Method     int GetHashCode()
GetObjectData             Method     void GetObjectData(System.Runtime.Serialization.SerializationInfo info, System.Runtime.Seriali...
GetType                   Method     type GetType()
ToString                  Method     string ToString()
displayName               Property   string displayName {get;set;}
instanceGuid              Property   string instanceGuid {get;set;}
pathToSignedProductExe    Property   string pathToSignedProductExe {get;set;}
pathToSignedReportingExe  Property   string pathToSignedReportingExe {get;set;}
productState              Property   uint32 productState {get;set;}
PSComputerName            Property   string PSComputerName {get;}
timestamp                 Property   string timestamp {get;set;}
#>
gwmi -Namespace root\SecurityCenter2 -Class AntiSpywareProduct | gm

<#
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

gwmi -class win32_operatingsystem | fl *
<#
PSComputerName                            : CRITHOS
Status                                    : OK
Name                                      : Microsoft Windows 10 Pro|C:\WINDOWS|\Device\Harddisk0\Partition4
FreePhysicalMemory                        : 1606636
FreeSpaceInPagingFiles                    : 3509424
FreeVirtualMemory                         : 1514208
__GENUS                                   : 2
__CLASS                                   : Win32_OperatingSystem
__SUPERCLASS                              : CIM_OperatingSystem
__DYNASTY                                 : CIM_ManagedSystemElement
__RELPATH                                 : Win32_OperatingSystem=@
__PROPERTY_COUNT                          : 64
__DERIVATION                              : {CIM_OperatingSystem, CIM_LogicalElement, CIM_ManagedSystemElement}
__SERVER                                  : CRITHOS
__NAMESPACE                               : root\cimv2
__PATH                                    : \\CRITHOS\root\cimv2:Win32_OperatingSystem=@
BootDevice                                : \Device\HarddiskVolume2
BuildNumber                               : 18363
BuildType                                 : Multiprocessor Free
Caption                                   : Microsoft Windows 10 Pro
CodeSet                                   : 1252
CountryCode                               : 1
CreationClassName                         : Win32_OperatingSystem
CSCreationClassName                       : Win32_ComputerSystem
CSDVersion                                :
CSName                                    : CRITHOS
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
InstallDate                               : 20190612104653.000000-360
LargeSystemCache                          :
LastBootUpTime                            : 20191201151740.408154-360
LocalDateTime                             : 20191203120910.968000-360
Locale                                    : 0409
Manufacturer                              : Microsoft Corporation
MaxNumberOfProcesses                      : 4294967295
MaxProcessMemorySize                      : 137438953344
MUILanguages                              : {en-US}
NumberOfLicensedUsers                     :
NumberOfProcesses                         : 210
NumberOfUsers                             : 29
OperatingSystemSKU                        : 48
Organization                              :
OSArchitecture                            : 64-bit
OSLanguage                                : 1033
OSProductSuite                            : 256
OSType                                    : 18
OtherTypeDescription                      :
PAEEnabled                                : 
PlusProductID                             :
PlusVersionNumber                         :
PortableOperatingSystem                   : False
Primary                                   : True
ProductType                               : 1
RegisteredUser                            : Dthos
SerialNumber                              : 00342-50427-25868-AAOEM
ServicePackMajorVersion                   : 0
ServicePackMinorVersion                   : 0
SizeStoredInPagingFiles                   : 3877528
SuiteMask                                 : 272
SystemDevice                              : \Device\HarddiskVolume4
SystemDirectory                           : C:\WINDOWS\system32
SystemDrive                               : C:
TotalSwapSpaceSize                        :
TotalVirtualMemorySize                    : 10167828
TotalVisibleMemorySize                    : 6290300
Version                                   : 10.0.18363
WindowsDirectory                          : C:\WINDOWS
Scope                                     : System.Management.ManagementScope
Path                                      : \\CRITHOS\root\cimv2:Win32_OperatingSystem=@
Options                                   : System.Management.ObjectGetOptions
ClassPath                                 : \\CRITHOS\root\cimv2:Win32_OperatingSystem
Properties                                : {BootDevice, BuildNumber, BuildType, Caption...}
SystemProperties                          : {__GENUS, __CLASS, __SUPERCLASS, __DYNASTY...}
Qualifiers                                : {dynamic, Locale, provider, Singleton...}
Site                                      : 
Container                                 :
#>

Get-CimInstance -ClassName Win32_OperatingSystem | fl *
<#
Status                                    : OK
Name                                      : Microsoft Windows 10 Pro|C:\WINDOWS|\Device\Harddisk0\Partition4
FreePhysicalMemory                        : 1619920
FreeSpaceInPagingFiles                    : 3509680
FreeVirtualMemory                         : 1533656
Caption                                   : Microsoft Windows 10 Pro
Description                               :
InstallDate                               : 6/12/2019 11:46:53 AM
CreationClassName                         : Win32_OperatingSystem
CSCreationClassName                       : Win32_ComputerSystem
CSName                                    : CRITHOS
CurrentTimeZone                           : -360
Distributed                               : False
LastBootUpTime                            : 12/1/2019 3:17:40 PM
LocalDateTime                             : 12/3/2019 12:10:25 PM
MaxNumberOfProcesses                      : 4294967295
MaxProcessMemorySize                      : 137438953344
NumberOfLicensedUsers                     :
NumberOfProcesses                         : 209
NumberOfUsers                             : 29
OSType                                    : 18
OtherTypeDescription                      :
SizeStoredInPagingFiles                   : 3877528
TotalSwapSpaceSize                        :
TotalVirtualMemorySize                    : 10167828
TotalVisibleMemorySize                    : 6290300
Version                                   : 10.0.18363
BootDevice                                : \Device\HarddiskVolume2
BuildNumber                               : 18363
BuildType                                 : Multiprocessor Free
CodeSet                                   : 1252
CountryCode                               : 1
CSDVersion                                :
DataExecutionPrevention_32BitApplications : True
DataExecutionPrevention_Available         : True
DataExecutionPrevention_Drivers           : True
DataExecutionPrevention_SupportPolicy     : 2
Debug                                     : False
EncryptionLevel                           : 256
ForegroundApplicationBoost                : 2
LargeSystemCache                          :
Locale                                    : 0409
Manufacturer                              : Microsoft Corporation
MUILanguages                              : {en-US}
OperatingSystemSKU                        : 48
Organization                              :
OSArchitecture                            : 64-bit
OSLanguage                                : 1033
OSProductSuite                            : 256
PAEEnabled                                :
PlusProductID                             :
PlusVersionNumber                         :
PortableOperatingSystem                   : False
Primary                                   : True
ProductType                               : 1
RegisteredUser                            : Dthos
SerialNumber                              : 00342-50427-25868-AAOEM
ServicePackMajorVersion                   : 0
ServicePackMinorVersion                   : 0
SuiteMask                                 : 272
SystemDevice                              : \Device\HarddiskVolume4
SystemDirectory                           : C:\WINDOWS\system32
SystemDrive                               : C:
WindowsDirectory                          : C:\WINDOWS
PSComputerName                            :
CimClass                                  : root/cimv2:Win32_OperatingSystem
CimInstanceProperties                     : {Caption, Description, InstallDate, Name...}
CimSystemProperties                       : Microsoft.Management.Infrastructure.CimSystemProperties
#> # Dates are in READABLE FORMAT!!!!!!!!!!


gwmi -class win32_operatingsystem | gm

# TypeName: System.Management.ManagementObject#root\cimv2\Win32_OperatingSystem

Get-CimClass -ClassName Win32_OperatingSystem | select -expand cimclassmethods

<#
Name                 ReturnType Parameters                            Qualifiers
----                 ---------- ----------                            ----------
Reboot                   UInt32 {}                                    {Implemented, MappingStrings, Override, Privileges...}
Shutdown                 UInt32 {}                                    {Implemented, MappingStrings, Override, Privileges...}
Win32Shutdown            UInt32 {Flags, Reserved}                     {Implemented, MappingStrings, Privileges, ValueMap}
Win32ShutdownTracker     UInt32 {Comment, Flags, ReasonCode, Timeout} {Implemented, MappingStrings, Privileges, ValueMap}   
SetDateTime              UInt32 {LocalDateTime}                       {Implemented, Privileges, ValueMap}
#>

Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName ILCSDC0

# Cim side works with methods a little bit differently.

gwmi -class win32_operatingsystem -ComputerName ILCSDC0

Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName ILCSWS008

# DMTF Resource URI used to acces a non-DMTF (distributed management task force) class.

# Cim class only exist over PSv3 and onward.

Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName ILCSWS007

<#
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName ILCSWS007
Get-CimInstance : The WS-Management service cannot process the request. A DMTF resource URI was used to access a
non-DMTF class. Try again using a non-DMTF resource URI.
At line:1 char:1
+ Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName ILCSWS ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (root\cimv2:Win32_OperatingSystem:String) [Get-CimInstance], CimException
    + FullyQualifiedErrorId : HRESULT 0x80338139,Microsoft.Management.Infrastructure.CimCmdlets.GetCimInstanceCommand
    + PSComputerName        : ILCSWS007
#>


gwmi -Class win32_operatingsystem -ComputerName ILCSWS007

# CIM can emulate the old protocol. 

help Get-CimInstance

<#
Get-CimInstance [-ClassName] <String> [-ComputerName <String[]>] [-Filter <String>]      
    [-KeyOnly] [-Namespace <String>] [-OperationTimeoutSec <UInt32>] [-Property <String[]>]  
    [-QueryDialect <String>] [-Shallow] [<CommonParameters>]
    
    Get-CimInstance [-Namespace <String>] [-OperationTimeoutSec <UInt32>] [-QueryDialect     
    <String>] [-ResourceUri <Uri>] [-Shallow] -CimSession <CimSession[]> -Query <String>     
    [<CommonParameters>]

    Get-CimInstance [-InputObject] <CimInstance> [-OperationTimeoutSec <UInt32>]
    [-ResourceUri <Uri>] -CimSession <CimSession[]> [<CommonParameters>]
#>

Get-CimInstance -ComputerName ILCSDC0 -ClassName win32_bios -Property SerialNumber

# This gets you the whole instance but only the one property filled in. 