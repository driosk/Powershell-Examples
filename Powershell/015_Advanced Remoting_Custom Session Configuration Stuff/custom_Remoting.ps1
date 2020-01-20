# Only accessable to a particular user/group

help New-ADGroup
New-ADGroup -Name HelpDesk -GroupScope Global -GroupCategory Security -SamAccountName HelpDesk

New-ADUser -Name Rhonda -SamAccountName Rhonda -PasswordNeverExpires $true -AccountPassword (ConvertTo-SecureString `
-AsPlainText "p@ssw0rd" -Force) -Department HelpDesk -Title Technician -City Bowie

Add-ADGroupMember -Identity HelpDesk -Members Rhonda

Get-ADGroup helpdesk | fl *

New-PSSessionConfigurationFile


<#
New-PSSessionConfigurationFile [-Path] <String> [-AliasDefinitions <IDictionary[]>] [-AssembliesToLoad <String[]>] [-Author
    <String>] [-CompanyName <String>] [-Copyright <String>] [-Description <String>] [-EnvironmentVariables <IDictionary>]
    [-ExecutionPolicy {Unrestricted | RemoteSigned | AllSigned | Restricted | Default | Bypass | Undefined}] [-FormatsToProcess
    <String[]>] [-Full] [-FunctionDefinitions <IDictionary[]>] [-GroupManagedServiceAccount <String>] [-Guid <Guid>] [-LanguageMode
    {FullLanguage | RestrictedLanguage | NoLanguage | ConstrainedLanguage}] [-ModulesToImport <Object[]>] [-MountUserDrive]
    [-PowerShellVersion <Version>] [-RequiredGroups <IDictionary>] [-RoleDefinitions <IDictionary>] [-RunAsVirtualAccount]
    [-RunAsVirtualAccountGroups <String[]>] [-SchemaVersion <Version>] [-ScriptsToProcess <String[]>] [-SessionType {Empty |
    RestrictedRemoteServer | Default}] [-TranscriptDirectory <String>] [-TypesToProcess <String[]>] [-UserDriveMaximumSize <Int64>]
    [-VariableDefinitions <Object>] [-VisibleAliases <String[]>] [-VisibleCmdlets <Object[]>] [-VisibleExternalCommands <String[]>]
    [-VisibleFunctions <Object[]>] [-VisibleProviders <String[]>] [<CommonParameters>]
#>

Get-Command -Noun ADAccount
<#
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Disable-ADAccount                                  1.0.0.0    ActiveDirectory
Cmdlet          Enable-ADAccount                                   1.0.0.0    ActiveDirectory
Cmdlet          Search-ADAccount                                   1.0.0.0    ActiveDirectory
Cmdlet          Unlock-ADAccount                                   1.0.0.0    ActiveDirectory
#>
# START HER CUSTOM SESSION
New-PSSessionConfigurationFile -Path .\helpdesk.pssc -ModulesToImport ActiveDirectory `
-VisibleCmdlets 'Enable-ADAccount','Disable-ADAccount'

Get-Content .\helpdesk.pssc

<#
@{

# Version number of the schema used for this document
SchemaVersion = '2.0.0.0'

# ID used to uniquely identify this document
GUID = '0be2f433-224a-43b7-b6d4-61798ba44392'

# Author of this document
Author = 'driosx'

# Description of the functionality provided by these settings
# Description = ''

# Session type defaults to apply for this session configuration. Can be 'RestrictedRemoteServer' (recommended), 'Empty', or 'Default'
SessionType = 'Default'

# Directory to place session transcripts for this session configuration
# TranscriptDirectory = 'C:\Transcripts\'

# Whether to run this session configuration as the machine's (virtual) administrator account
# RunAsVirtualAccount = $true

# Scripts to run when applied to a session
# ScriptsToProcess = 'C:\ConfigData\InitScript1.ps1', 'C:\ConfigData\InitScript2.ps1'

# User roles (security groups), and the role capabilities that should be applied to them when applied to a session
# RoleDefinitions = @{ 'CONTOSO\SqlAdmins' = @{ RoleCapabilities = 'SqlAdministration' }; 'CONTOSO\ServerMonitors' = @{ VisibleCmdlets = 'Get-Process' } }

# Modules to import when applied to a session
ModulesToImport = 'ActiveDirectory'

# Cmdlets to make visible when applied to a session
VisibleCmdlets = 'Enable-ADAccount', 'Disable-ADAccount'

}
#>

#this all defines the capability of the endpoint.

Register-PSSessionConfiguration -Name test -ShowSecurityDescriptorUI

Get-PSSessionConfiguration -Name test | fl *

#OUTPUT
<#
RunAsPassword                 :
ResourceUri                   : http://schemas.microsoft.com/powershell/test
Capability                    : {Shell}
PSVersion                     : 5.1
AutoRestart                   : false
ExactMatch                    : false
RunAsVirtualAccount           : false
SDKVersion                    : 2
Uri                           : http://schemas.microsoft.com/powershell/test
MaxConcurrentCommandsPerShell : 2147483647
IdleTimeoutms                 : 7200000
ParentResourceUri             : http://schemas.microsoft.com/powershell/test
RunAsUser                     :
OutputBufferingMode           : Block
Architecture                  : 64
UseSharedProcess              : false
MaxProcessesPerShell          : 2147483647
Filename                      : %windir%\system32\pwrshplugin.dll
MaxShellsPerUser              : 2147483647
MaxShells                     : 2147483647
SupportsOptions               : true
lang                          : en-US
MaxIdleTimeoutms              : 2147483647
xmlns                         : http://schemas.microsoft.com/wbem/wsman/1/config/PluginConfiguration
Enabled                       : True
SecurityDescriptorSddl        : O:NSG:BAD:P(A;;GA;;;BA)(A;;GXGWGR;;;S-1-5-21-3517127094-4084499969-524712262-1621)S:P(AU;FA;GA;;;WD)(A
                                U;SA;GXGW;;;WD)
Name                          : test
ProcessIdleTimeoutSec         : 0
MaxConcurrentUsers            : 2147483647
MaxMemoryPerShellMB           : 2147483647
RunAsVirtualAccountGroups     :
XmlRenderingType              : text
Permission                    : BUILTIN\Administrators AccessAllowed, CRIT\HelpDesk AccessAllowed
#>

# O:NSG:BAD:P(A;;GA;;;BA)(A;;GXGWGR;;;S-1-5-21-3517127094-4084499969-524712262-1621)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)
Unregister-PSSessionConfiguration -Name test

Enter-PSSession -ComputerName ILCSDC0.critsol.net

Register-PSSessionConfiguration -Path .\helpdesk.pssc -Name HelpDesk `
-SecurityDescriptorSddl 'O:NSG:BAD:P(A;;GA;;;BA)(A;;GXGWGR;;;S-1-5-21-3517127094-4084499969-524712262-1621)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)' `
-NoServiceRestart -RunAsCredential crit\driosx

<#
WARNING: When RunAs is enabled in a Windows PowerShell session configuration, the Windows security model cannot enforce a security
boundary between different user sessions that are created by using this endpoint. Verify that the Windows PowerShell runspace
configuration is restricted to only the necessary set of cmdlets and capabilities.
WARNING: Register-PSSessionConfiguration may need to restart the WinRM service if a configuration using this name has recently been
unregistered, certain system data structures may still be cached. In that case, a restart of WinRM may be required.
All WinRM sessions connected to Windows PowerShell session configurations, such as Microsoft.PowerShell and session configurations
that are created with the Register-PSSessionConfiguration cmdlet, are disconnected.


   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Plugin

Type            Keys                                Name
----            ----                                ----
Container       {Name=HelpDesk}                     HelpDesk
WARNING: Register-PSSessionConfiguration may need to restart the WinRM service if a configuration using this name has recently been
unregistered, certain system data structures may still be cached. In that case, a restart of WinRM may be required.
All WinRM sessions connected to Windows PowerShell session configurations, such as Microsoft.PowerShell and session configurations
that are created with the Register-PSSessionConfiguration cmdlet, are disconnected.
#>
restart-service winrm # on remote computer.

# runas user for testing purposes
runas /user:CRIT\Rhonda "powershell"

Invoke-Command -ConfigurationName helpdesk -ComputerName ILCSDC0.critsol.net `
-ScriptBlock {Enable-ADAccount -Identity donj}

<#
PS C:\> Get-ADUser donj

DistinguishedName : CN=Don J,CN=Users,DC=critsol,DC=net
Enabled           : True
GivenName         : Don
Name              : Don J
ObjectClass       : user
ObjectGUID        : 14f5f8ea-22a5-42ac-8924-f6d1372d4ff4
SamAccountName    : donj
SID               : S-1-5-21-3517127094-4084499969-524712262-1623
Surname           : J
UserPrincipalName : donj@critsol.net
#>

Invoke-Command -ConfigurationName helpdesk -ComputerName ILCSDC0.critsol.net `
-ScriptBlock {Remove-ADUser -Identity donj}

<#
PS C:\> Invoke-Command -ConfigurationName helpdesk -ComputerName ILCSDC0.critsol.net `
>> -ScriptBlock {Remove-ADUser -Identity donj}
The term 'Remove-ADUser' is not recognized as the name of a cmdlet, function, script file, or operable program. Check
the spelling of the name, or if a path was included, verify that the path is correct and try again.
    + CategoryInfo          : ObjectNotFound: (Remove-ADUser:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
    + PSComputerName        : ILCSDC0.critsol.net

PS C:\>
#>

<#
PS C:\> Import-Module ActiveDirectory
PS C:\> Remove-ADUser -Identity donj

Confirm
Are you sure you want to perform this action?
Performing the operation "Remove" on target "CN=Don J,CN=Users,DC=critsol,DC=net".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): A
Remove-ADUser : Access is denied
At line:1 char:1
+ Remove-ADUser -Identity donj
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : PermissionDenied: (donj:ADUser) [Remove-ADUser], UnauthorizedAccessException
    + FullyQualifiedErrorId : ActiveDirectoryCmdlet:System.UnauthorizedAccessException,Microsoft.ActiveDirectory.Manag
   ement.Commands.RemoveADUser

PS C:\>
#>

Enter-PSSession -ConfigurationName helpdesk -ComputerName ILCSDC0 #nope

