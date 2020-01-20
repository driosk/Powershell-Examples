Enter-PSSession -ComputerName ILCSDC0.critsol.net

Enter-PSSession -computername 192.168.1.31 -Credential Remote\dougrios@gmail.com

$dc = New-PSSession -ComputerName dc.lab.pri
$rdc = New-PSSession -ComputerName rdc.remote.pri -Credential Remote\Administrator

Invoke-Command -Session $dc -ScriptBlock {Import-Module ActiveDirectory}

Import-PSSession -Session $dc -Prefix LAB -Module ActiveDirectory # implicit

<#
Get-LABADUser -Filter * | gm

   TypeName: Deserialized.Microsoft.ActiveDirectory.Management.ADUser

Name               MemberType   Definition
----               ----------   ----------
GetType            Method       type GetType()
ToString           Method       string ToString(), string ToString(string format, System.IFormatProvider formatProvider), string I...
PSComputerName     NoteProperty string PSComputerName=ILCSDC0.critsol.net
PSShowComputerName NoteProperty bool PSShowComputerName=False
RunspaceId         NoteProperty guid RunspaceId=d2d95673-fc43-4da7-8413-9a9accbf4457
DistinguishedName  Property     System.String {get;set;}
Enabled            Property     System.Boolean {get;set;}
GivenName          Property      {get;set;}
Name               Property     System.String {get;set;}
ObjectClass        Property     System.String {get;set;}
ObjectGUID         Property     System.Guid {get;set;}
SamAccountName     Property     System.String {get;set;}
SID                Property     System.String {get;set;}
Surname            Property      {get;set;}
UserPrincipalName  Property      {get;set;}
#>

# Difference on deserialized is you won't see unique methods.

get-exmailbox | set-exmailbox # if this depends on methods it will fail.

Get-LABADUser -Identity driosx
Get-LABADUser -Identity driosx | Set-LABADUser
<#
Many cases deserializing breaks the pipeline. Get-ADUser expects
TypeName: Microsoft.ActiveDirectory.Management.ADUser
#>
Invoke-Command -Session $dc -ScriptBlock {Get-ADUser -Identity driosx | Set-ADUser -Department IT}

Set-LABADUser -identity driosx -department IT

<#
PS C:\users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\11_PersistentRemoting.PSSESSIONS> Set-LABADUser -identity driosx -department IT                                                                                                                        PS C:\users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\11_PersistentRemoting.PSSESSIONS> get-aduser driosx -Properties department

Department        : IT
DistinguishedName : CN=Douglas Rios,OU=Users,OU=IT,OU=Administrative,OU=Accounts,DC=critsol,DC=net
Enabled           : True
GivenName         : Douglas
Name              : Douglas Rios
ObjectClass       : user
ObjectGUID        : e26797ab-9226-454d-b7a8-963fc7e3f133
SamAccountName    : driosx
SID               : S-1-5-21-3517127094-4084499969-524712262-1103
Surname           : Rios
UserPrincipalName : driosx@critsol.net
#>

# Powershell v3

$dc = New-PSSession -ComputerName dc.lab.pri
Get-Module -PSSession $dc -ListAvailable
Import-Module -Name NetAdapter -PSSession $dc -Prefix DC
<#
PS C:\users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\11_PersistentRemoting.PSSESSIONS> Get-DCNetAdapter
Name                      InterfaceDescription                    ifIndex Status       MacAddress             LinkSpeed
----                      --------------------                    ------- ------       ----------             ---------
                                                                        2              52-54-00-BC-2C-BF


PS C:\users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\11_PersistentRemoting.PSSESSIONS>

PS C:\users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\11_PersistentRemoting.PSSESSIONS> get-module
ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   1.0.0.0    ActiveDirectory                     {Add-ADCentralAccessPolicyMember, Add-ADComputerServiceAccount, Add-ADDo...
Manifest   3.1.0.0    Microsoft.PowerShell.Management     {Add-Computer, Add-Content, Checkpoint-Computer, Clear-Content...}
Manifest   3.0.0.0    Microsoft.PowerShell.Security       {ConvertFrom-SecureString, ConvertTo-SecureString, Get-Acl, Get-Authenti...
Manifest   3.1.0.0    Microsoft.PowerShell.Utility        {Add-Member, Add-Type, Clear-Variable, Compare-Object...}
Manifest   3.0.0.0    Microsoft.WSMan.Management          {Connect-WSMan, Disable-WSManCredSSP, Disconnect-WSMan, Enable-WSManCred...
Script     1.0        NetAdapter                          {Disable-DCNetAdapter, Disable-DCNetAdapterBinding, Disable-DCNetAdapter...
Script     2.0.0      PSReadline                          {Get-PSReadLineKeyHandler, Get-PSReadLineOption, Remove-PSReadLineKeyHan...
Script     1.0        tmp_3fgcilxj.mhl                    {Add-LABADCentralAccessPolicyMember, Add-LABADComputerServiceAccount, Ad...


PS C:\users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\11_PersistentRemoting.PSSESSIONS> get-netadapter
Name                      InterfaceDescription                    ifIndex Status       MacAddress             LinkSpeed
----                      --------------------                    ------- ------       ----------             ---------
                                                                       12 Up           00-15-5D-94-B7-0A
                                                                       28 Up           02-00-4C-4F-4F-50


PS C:\users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\11_PersistentRemoting.PSSESSIONS> Get-DCNetAdapter
Name                      InterfaceDescription                    ifIndex Status       MacAddress             LinkSpeed
----                      --------------------                    ------- ------       ----------             ---------
                                                                        2 Up           52-54-00-BC-2C-BF
#>

