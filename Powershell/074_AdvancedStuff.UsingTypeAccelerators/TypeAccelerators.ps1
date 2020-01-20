# Treat the following data as this type

[string]$x = 55
$x | gm
# TypeName:System.String

[int]$y = "55"
[int]$y = "here"

[xml]$data = Get-Content .\procs.xml
[xml]$data = Get-Content .\serverdata1.xml
$data.computers
$data.computers.computer.biosserial

$connectionstring = "SQL CONNECTION STRING"
$connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
[void]$connection.open($($connectionstring)) # instead of piping to out-null

$user = [adsi]"WinNT://ILCSWS008/Administrator,user"
$user
<#
PS C:\WINDOWS\system32> $user


distinguishedName : 
Path              : WinNT://ILCSWS008/Administrator,user




PS C:\WINDOWS\system32> 
#>
$user | gm

<#
   TypeName: System.DirectoryServices.DirectoryEntry

Name                        MemberType Definition                                                                                   
----                        ---------- ----------                                                                                   
ConvertDNWithBinaryToString CodeMethod static string ConvertDNWithBinaryToString(psobject deInstance, psobject dnWithBinaryInstance)
ConvertLargeIntegerToInt64  CodeMethod static long ConvertLargeIntegerToInt64(psobject deInstance, psobject largeIntegerInstance)   
AutoUnlockInterval          Property   System.DirectoryServices.PropertyValueCollection AutoUnlockInterval {get;set;}               
BadPasswordAttempts         Property   System.DirectoryServices.PropertyValueCollection BadPasswordAttempts {get;set;}              
Description                 Property   System.DirectoryServices.PropertyValueCollection Description {get;set;}                      
FullName                    Property   System.DirectoryServices.PropertyValueCollection FullName {get;set;}                         
HomeDirDrive                Property   System.DirectoryServices.PropertyValueCollection HomeDirDrive {get;set;}                     
HomeDirectory               Property   System.DirectoryServices.PropertyValueCollection HomeDirectory {get;set;}                    
LastLogin                   Property   System.DirectoryServices.PropertyValueCollection LastLogin {get;set;}                        
LockoutObservationInterval  Property   System.DirectoryServices.PropertyValueCollection LockoutObservationInterval {get;set;}       
LoginHours                  Property   System.DirectoryServices.PropertyValueCollection LoginHours {get;set;}                       
LoginScript                 Property   System.DirectoryServices.PropertyValueCollection LoginScript {get;set;}                      
MaxBadPasswordsAllowed      Property   System.DirectoryServices.PropertyValueCollection MaxBadPasswordsAllowed {get;set;}           
MaxPasswordAge              Property   System.DirectoryServices.PropertyValueCollection MaxPasswordAge {get;set;}                   
MaxStorage                  Property   System.DirectoryServices.PropertyValueCollection MaxStorage {get;set;}                       
MinPasswordAge              Property   System.DirectoryServices.PropertyValueCollection MinPasswordAge {get;set;}                   
MinPasswordLength           Property   System.DirectoryServices.PropertyValueCollection MinPasswordLength {get;set;}                
Name                        Property   System.DirectoryServices.PropertyValueCollection Name {get;set;}                             
objectSid                   Property   System.DirectoryServices.PropertyValueCollection objectSid {get;set;}                        
Parameters                  Property   System.DirectoryServices.PropertyValueCollection Parameters {get;set;}                       
PasswordAge                 Property   System.DirectoryServices.PropertyValueCollection PasswordAge {get;set;}                      
PasswordExpired             Property   System.DirectoryServices.PropertyValueCollection PasswordExpired {get;set;}                  
PasswordHistoryLength       Property   System.DirectoryServices.PropertyValueCollection PasswordHistoryLength {get;set;}            
PrimaryGroupID              Property   System.DirectoryServices.PropertyValueCollection PrimaryGroupID {get;set;}                   
Profile                     Property   System.DirectoryServices.PropertyValueCollection Profile {get;set;}                          
UserFlags                   Property   System.DirectoryServices.PropertyValueCollection UserFlags {get;set;} 
#>

Get-WmiObject -class Win32_share -ComputerName ILCSDC0

<#
Name     Path                                         Description        
----     ----                                         -----------        
ADMIN$   C:\Windows                                   Remote Admin       
C$       C:\                                          Default share      
IPC$                                                  Remote IPC         
NETLOGON C:\Windows\SYSVOL\sysvol\critsol.net\SCRIPTS Logon server share 
SYSVOL   C:\Windows\SYSVOL\sysvol                     Logon server share 
#>

Get-WmiObject -class Win32_share -ComputerName ILCSDC0 | gm

<#
   TypeName: System.Management.ManagementObject#root\cimv2\Win32_Share

Name                MemberType    Definition                                                                                          
----                ----------    ----------                                                                                          
PSComputerName      AliasProperty PSComputerName = __SERVER                                                                           
Delete              Method        System.Management.ManagementBaseObject Delete()                                                     
GetAccessMask       Method        System.Management.ManagementBaseObject GetAccessMask()                                              
SetShareInfo        Method        System.Management.ManagementBaseObject SetShareInfo(System.UInt32 MaximumAllowed, System.String D...
AccessMask          Property      uint32 AccessMask {get;set;}                                                                        
AllowMaximum        Property      bool AllowMaximum {get;set;}                                                                        
Caption             Property      string Caption {get;set;}                                                                           
Description         Property      string Description {get;set;}                                                                       
InstallDate         Property      string InstallDate {get;set;}                                                                       
MaximumAllowed      Property      uint32 MaximumAllowed {get;set;}                                                                    
Name                Property      string Name {get;set;}                                                                              
Path                Property      string Path {get;set;}                                                                              
Status              Property      string Status {get;set;}                                                                            
Type                Property      uint32 Type {get;set;}                                                                              
__CLASS             Property      string __CLASS {get;set;}                                                                           
__DERIVATION        Property      string[] __DERIVATION {get;set;}                                                                    
__DYNASTY           Property      string __DYNASTY {get;set;}                                                                         
__GENUS             Property      int __GENUS {get;set;}                                                                              
__NAMESPACE         Property      string __NAMESPACE {get;set;}                                                                       
__PATH              Property      string __PATH {get;set;}                                                                            
__PROPERTY_COUNT    Property      int __PROPERTY_COUNT {get;set;}                                                                     
__RELPATH           Property      string __RELPATH {get;set;}                                                                         
__SERVER            Property      string __SERVER {get;set;}                                                                          
__SUPERCLASS        Property      string __SUPERCLASS {get;set;}                                                                      
PSStatus            PropertySet   PSStatus {Status, Type, Name}                                                                       
ConvertFromDateTime ScriptMethod  System.Object ConvertFromDateTime();                                                                
ConvertToDateTime   ScriptMethod  System.Object ConvertToDateTime(); 
#>

Get-WmiObject -class Win32_share -ComputerName ILCSDC0 | fl *
<#
PS C:\WINDOWS\system32> Get-WmiObject -class Win32_share -ComputerName ILCSDC0 | fl *


PSComputerName   : ILCSDC0
Status           : OK
Type             : 2147483648
Name             : ADMIN$
__GENUS          : 2
__CLASS          : Win32_Share
__SUPERCLASS     : CIM_LogicalElement
__DYNASTY        : CIM_ManagedSystemElement
__RELPATH        : Win32_Share.Name="ADMIN$"
__PROPERTY_COUNT : 10
__DERIVATION     : {CIM_LogicalElement, CIM_ManagedSystemElement}
__SERVER         : ILCSDC0
__NAMESPACE      : root\cimv2
__PATH           : \\ILCSDC0\root\cimv2:Win32_Share.Name="ADMIN$"
AccessMask       : 
AllowMaximum     : True
Caption          : Remote Admin
Description      : Remote Admin
InstallDate      : 
MaximumAllowed   : 
Path             : C:\Windows
Scope            : System.Management.ManagementScope
Options          : System.Management.ObjectGetOptions
ClassPath        : \\ILCSDC0\root\cimv2:Win32_Share
Properties       : {AccessMask, AllowMaximum, Caption, Description...}
SystemProperties : {__GENUS, __CLASS, __SUPERCLASS, __DYNASTY...}
Qualifiers       : {dynamic, Locale, provider, UUID}
Site             : 
Container        : 

PSComputerName   : ILCSDC0
Status           : OK
Type             : 2147483648
Name             : C$
__GENUS          : 2
__CLASS          : Win32_Share
__SUPERCLASS     : CIM_LogicalElement
__DYNASTY        : CIM_ManagedSystemElement
__RELPATH        : Win32_Share.Name="C$"
__PROPERTY_COUNT : 10
__DERIVATION     : {CIM_LogicalElement, CIM_ManagedSystemElement}
__SERVER         : ILCSDC0
__NAMESPACE      : root\cimv2
__PATH           : \\ILCSDC0\root\cimv2:Win32_Share.Name="C$"
AccessMask       : 
AllowMaximum     : True
Caption          : Default share
Description      : Default share
InstallDate      : 
MaximumAllowed   : 
Path             : C:\
Scope            : System.Management.ManagementScope
Options          : System.Management.ObjectGetOptions
ClassPath        : \\ILCSDC0\root\cimv2:Win32_Share
Properties       : {AccessMask, AllowMaximum, Caption, Description...}
SystemProperties : {__GENUS, __CLASS, __SUPERCLASS, __DYNASTY...}
Qualifiers       : {dynamic, Locale, provider, UUID}
Site             : 
Container        : 

PSComputerName   : ILCSDC0
Status           : OK
Type             : 2147483651
Name             : IPC$
__GENUS          : 2
__CLASS          : Win32_Share
__SUPERCLASS     : CIM_LogicalElement
__DYNASTY        : CIM_ManagedSystemElement
__RELPATH        : Win32_Share.Name="IPC$"
__PROPERTY_COUNT : 10
__DERIVATION     : {CIM_LogicalElement, CIM_ManagedSystemElement}
__SERVER         : ILCSDC0
__NAMESPACE      : root\cimv2
__PATH           : \\ILCSDC0\root\cimv2:Win32_Share.Name="IPC$"
AccessMask       : 
AllowMaximum     : True
Caption          : Remote IPC
Description      : Remote IPC
InstallDate      : 
MaximumAllowed   : 
Path             : 
Scope            : System.Management.ManagementScope
Options          : System.Management.ObjectGetOptions
ClassPath        : \\ILCSDC0\root\cimv2:Win32_Share
Properties       : {AccessMask, AllowMaximum, Caption, Description...}
SystemProperties : {__GENUS, __CLASS, __SUPERCLASS, __DYNASTY...}
Qualifiers       : {dynamic, Locale, provider, UUID}
Site             : 
Container        : 

PSComputerName   : ILCSDC0
Status           : OK
Type             : 0
Name             : NETLOGON
__GENUS          : 2
__CLASS          : Win32_Share
__SUPERCLASS     : CIM_LogicalElement
__DYNASTY        : CIM_ManagedSystemElement
__RELPATH        : Win32_Share.Name="NETLOGON"
__PROPERTY_COUNT : 10
__DERIVATION     : {CIM_LogicalElement, CIM_ManagedSystemElement}
__SERVER         : ILCSDC0
__NAMESPACE      : root\cimv2
__PATH           : \\ILCSDC0\root\cimv2:Win32_Share.Name="NETLOGON"
AccessMask       : 
AllowMaximum     : True
Caption          : Logon server share 
Description      : Logon server share 
InstallDate      : 
MaximumAllowed   : 
Path             : C:\Windows\SYSVOL\sysvol\critsol.net\SCRIPTS
Scope            : System.Management.ManagementScope
Options          : System.Management.ObjectGetOptions
ClassPath        : \\ILCSDC0\root\cimv2:Win32_Share
Properties       : {AccessMask, AllowMaximum, Caption, Description...}
SystemProperties : {__GENUS, __CLASS, __SUPERCLASS, __DYNASTY...}
Qualifiers       : {dynamic, Locale, provider, UUID}
Site             : 
Container        : 

PSComputerName   : ILCSDC0
Status           : OK
Type             : 0
Name             : SYSVOL
__GENUS          : 2
__CLASS          : Win32_Share
__SUPERCLASS     : CIM_LogicalElement
__DYNASTY        : CIM_ManagedSystemElement
__RELPATH        : Win32_Share.Name="SYSVOL"
__PROPERTY_COUNT : 10
__DERIVATION     : {CIM_LogicalElement, CIM_ManagedSystemElement}
__SERVER         : ILCSDC0
__NAMESPACE      : root\cimv2
__PATH           : \\ILCSDC0\root\cimv2:Win32_Share.Name="SYSVOL"
AccessMask       : 
AllowMaximum     : True
Caption          : Logon server share 
Description      : Logon server share 
InstallDate      : 
MaximumAllowed   : 
Path             : C:\Windows\SYSVOL\sysvol
Scope            : System.Management.ManagementScope
Options          : System.Management.ObjectGetOptions
ClassPath        : \\ILCSDC0\root\cimv2:Win32_Share
Properties       : {AccessMask, AllowMaximum, Caption, Description...}
SystemProperties : {__GENUS, __CLASS, __SUPERCLASS, __DYNASTY...}
Qualifiers       : {dynamic, Locale, provider, UUID}
Site             : 
Container        : 
#>

$sysvol = [wmi]'\\ILCSDC0\root\cimv2:Win32_Share.Name="SYSVOL"'
<#
PS C:\WINDOWS\system32> $sysvol

Name   Path                     Description        
----   ----                     -----------        
SYSVOL C:\Windows\SYSVOL\sysvol Logon server share 
#>
$sysvol | fl *

<#
PS C:\WINDOWS\system32> $sysvol | fl *


PSComputerName   : ILCSDC0
Status           : OK
Type             : 0
Name             : SYSVOL
__GENUS          : 2
__CLASS          : Win32_Share
__SUPERCLASS     : CIM_LogicalElement
__DYNASTY        : CIM_ManagedSystemElement
__RELPATH        : Win32_Share.Name="SYSVOL"
__PROPERTY_COUNT : 10
__DERIVATION     : {CIM_LogicalElement, CIM_ManagedSystemElement}
__SERVER         : ILCSDC0
__NAMESPACE      : root\cimv2
__PATH           : \\ILCSDC0\root\cimv2:Win32_Share.Name="SYSVOL"
AccessMask       : 
AllowMaximum     : True
Caption          : Logon server share 
Description      : Logon server share 
InstallDate      : 
MaximumAllowed   : 
Path             : C:\Windows\SYSVOL\sysvol
Scope            : System.Management.ManagementScope
Options          : System.Management.ObjectGetOptions
ClassPath        : \\ILCSDC0\root\cimv2:Win32_Share
Properties       : {AccessMask, AllowMaximum, Caption, Description...}
SystemProperties : {__GENUS, __CLASS, __SUPERCLASS, __DYNASTY...}
Qualifiers       : {dynamic, Locale, provider, UUID}
Site             : 
Container        : 
#>

# or you can do

Get-WmiObject -Class Win32_Share -ComputerName ILCSDC0 -Filter "Name='sysvol'"

<#
PS C:\WINDOWS\system32> Get-WmiObject -Class Win32_Share -ComputerName ILCSDC0 -Filter "Name='sysvol'"

Name   Path                     Description        
----   ----                     -----------        
SYSVOL C:\Windows\SYSVOL\sysvol Logon server share 
#>