Get-Process | Get-Member # TypeName: System.Diagnostics.Process .Process is object type.



help Stop-Process -Full #  Stop-Process [-InputObject] <Process[]> [-Confirm] [-Force] [-PassThru] [-WhatIf] [<CommonParameters>]

<#
-InputObject <Process[]>
        Specifies the process objects to stop. Enter a variable that contains the objects, or type a command or expression that gets the objects.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       True (ByValue) # Plan A
        Accept wildcard characters?  false
#>

# Command gets linked up by value to second command.

Get-Service | Stop-Process -WhatIf

Get-Service | gm

ServiceController value
Stop-Process | gm
get-help Stop-Process -Full
<#
Id <Int32[]>
        Specifies the process IDs of the processes to stop. To specify multiple IDs, use commas to separate the IDs. To find the PID of a process, type `Get-Process`.

        Required?                    true
        Position?                    0
        Default value                None
        Accept pipeline input?       True (ByPropertyName)
        Accept wildcard characters?  false
#>

Get-Service | gm -MemberType Properties

<#
Name                MemberType    Definition
----                ----------    ----------
Name                AliasProperty Name = ServiceName
RequiredServices    AliasProperty RequiredServices = ServicesDependedOn
CanPauseAndContinue Property      bool CanPauseAndContinue {get;}
CanShutdown         Property      bool CanShutdown {get;}
CanStop             Property      bool CanStop {get;}
Container           Property      System.ComponentModel.IContainer Container {get;}
DependentServices   Property      System.ServiceProcess.ServiceController[] DependentServices {get;}
DisplayName         Property      string DisplayName {get;set;}
MachineName         Property      string MachineName {get;set;}
ServiceHandle       Property      System.Runtime.InteropServices.SafeHandle ServiceHandle {get;}
ServiceName         Property      string ServiceName {get;set;}
ServicesDependedOn  Property      System.ServiceProcess.ServiceController[] ServicesDependedOn {get;}
ServiceType         Property      System.ServiceProcess.ServiceType ServiceType {get;}
Site                Property      System.ComponentModel.ISite Site {get;set;}
StartType           Property      System.ServiceProcess.ServiceStartMode StartType {get;}
Status              Property      System.ServiceProcess.ServiceControllerStatus Status {get;}
#>

Get-Service | Stop-Process -WhatIf

get-help Get-Service -Full

<#
SYNTAX
    Get-Service [-ComputerName <String[]>] [-DependentServices] -DisplayName <String[]> [-Exclude <String[]>] [-Include <String[]>] [-RequiredServices] [<CommonParameters>]

    Get-Service [-ComputerName <String[]>] [-DependentServices] [-Exclude <String[]>] [-Include <String[]>] [-InputObject <ServiceController[]>] [-RequiredServices] [<CommonParameters>]

    Get-Service [[-Name] <String[]>] [-ComputerName <String[]>] [-DependentServices] [-Exclude <String[]>] [-Include <String[]>] [-RequiredServices] [<CommonParameters>]
#>

Import-Csv .\computers.csv | gm

Import-Csv .\computers.csv | Get-Service -Name *

help New-ADUser

<#
SYNTAX
    New-ADUser [-Name] <String> [-AccountExpirationDate <DateTime>] [-AccountNotDelegated <Boolean>] [-AccountPassword <SecureString>] [-AllowReversiblePasswordEncryption <Boolean>] [-AuthenticationPolicy
    <ADAuthenticationPolicy>] [-AuthenticationPolicySilo <ADAuthenticationPolicySilo>] [-AuthType {Negotiate | Basic}] [-CannotChangePassword <Boolean>] [-Certificates <X509Certificate[]>] [-ChangePasswordAtLogon
    <Boolean>] [-City <String>] [-Company <String>] [-CompoundIdentitySupported <Boolean>] [-Country <String>] [-Credential <PSCredential>] [-Department <String>] [-Description <String>] [-DisplayName <String>]
    [-Division <String>] [-EmailAddress <String>] [-EmployeeID <String>] [-EmployeeNumber <String>] [-Enabled <Boolean>] [-Fax <String>] [-GivenName <String>] [-HomeDirectory <String>] [-HomeDrive <String>] [-HomePage
    <String>] [-HomePhone <String>] [-Initials <String>] [-Instance <ADUser>] [-KerberosEncryptionType {None | DES | RC4 | AES128 | AES256}] [-LogonWorkstations <String>] [-Manager <ADUser>] [-MobilePhone <String>]
    [-Office <String>] [-OfficePhone <String>] [-Organization <String>] [-OtherAttributes <Hashtable>] [-OtherName <String>] [-PassThru] [-PasswordNeverExpires <Boolean>] [-PasswordNotRequired <Boolean>] [-Path
    <String>] [-POBox <String>] [-PostalCode <String>] [-PrincipalsAllowedToDelegateToAccount <ADPrincipal[]>] [-ProfilePath <String>] [-SamAccountName <String>] [-ScriptPath <String>] [-Server <String>]
    [-ServicePrincipalNames <String[]>] [-SmartcardLogonRequired <Boolean>] [-State <String>] [-StreetAddress <String>] [-Surname <String>] [-Title <String>] [-TrustedForDelegation <Boolean>] [-Type <String>]
    [-UserPrincipalName <String>] [-Confirm] [-WhatIf] [<CommonParameters>]
#>

Get-Help New-ADUser -Full

Import-Csv .\users.csv

Import-Csv .\users.csv | New-ADUser -WhatIf

<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\3_How the PS Pipeline Works> Import-Csv .\users.csv | New-ADUser -WhatIf
What if: Performing the operation "New" on target "CN=Doug,CN=Users,DC=critsol,DC=net".
What if: Performing the operation "New" on target "CN=gregs,CN=Users,DC=critsol,DC=net".
#>

Import-Csv .\users1.csv | New-ADUser -WhatIf
Import-Csv .\users1.csv

Import-Csv .\users1.csv | Select-Object -Property *,@{ n='samaccountname'; e={ $_.Name } }

Import-Csv .\users1.csv | Select-Object -Property *,@{ n='samaccountname'; e={ $_.Name } } | New-ADUser -WhatIf
<#
Get-ADUser driosx -Properties DistinguishedName

<# userspath.csv
name,title,city,department,path
Doug,CIO,Chicago,IT,"OU=IT,OU=Administrative,OU=Accounts,DC=critsol,DC=net"
gregs,Janitor,Denver,Custodial,"OU=IT,OU=Administrative,OU=Accounts,DC=critsol,DC=net"
#>

DistinguishedName : CN=Douglas Rios,OU=Users,OU=IT,OU=Administrative,OU=Accounts,DC=critsol,DC=net
#>
Import-Csv .\users1.csv | Select-Object -Property *,@{ n='samaccountname'; e={ $_.Name } } | New-ADUser -Path "cn=users,dc=critsol,dc=net" -WhatIf
<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\3_How the PS Pipeline Works> Import-Csv .\users1.csv | Select-Object -Property *,@{ n='samaccountname'; e={ $_.Name } } | New-ADUser -Path "cn=users,dc=critsol,dc=net" -WhatIf
What if: Performing the operation "New" on target "CN=Doug,cn=users,dc=critsol,dc=net".
What if: Performing the operation "New" on target "CN=gregs,cn=users,dc=critsol,dc=net".
#>
Import-Csv .\userspath.csv | Select-Object -Property *,@{ n='samaccountname'; e={ $_.Name } } | New-ADUser -WhatIf
<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\3_How the PS Pipeline Works> Import-Csv .\userspath.csv | Select-Object -Property *,@{ n='samaccountname'; e={ $_.Name } } | New-ADUser -WhatIf
What if: Performing the operation "New" on target "CN=Doug,OU=IT,OU=Administrative,OU=Accounts,DC=critsol,DC=net".
What if: Performing the operation "New" on target "CN=gregs,OU=IT,OU=Administrative,OU=Accounts,DC=critsol,DC=net".
#>

Get-ADComputer -Filter *

Get-ADComputer -Filter * | Get-Service

Get-ADComputer -Filter * | Select-Object @{ n='computername'; e={ $_.Name } }

$allcomps = Get-ADComputer -Filter *
$allcomps[0].name
$allcomps

<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\3_How the PS Pipeline Works> Get-ADComputer -Filter * | Select-Object @{n='computername';e={$_.Name}}

computername
------------
ILCSDC1
ILCSRCA
ILCSICA

PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\3_How the PS Pipeline Works> $allcomps = Get-ADComputer -Filter *
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\3_How the PS Pipeline Works> $allcomps[0].name
ILCSDC1
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\3_How the PS Pipeline Works>
#>

Get-ADComputer -Filter * | Select-Object @{ n='computername'; e={ $_.Name } } | Get-Service

<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\3_How the PS Pipeline Works> get-help Get-Service -Parameter name

-Name <String[]>
    Specifies the service names of services to be retrieved. Wildcards are permitted. By default, this cmdlet gets all of the services on the computer.

    Required?                    false
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByPropertyName, ByValue)
    Accept wildcard characters?  false
#>

Get-ADComputer -Filter * | Select-Object @{ n='computername'; e={ $_.Name } } | Get-Service -Name *

help Get-EventLog -Full

Get-EventLog -LogName Security -Newest 10 -ComputerName (Get-ADComputer -Filter *) # won't work
<#
SYNTAX
    Get-EventLog [-LogName] <String> [[-InstanceId] <Int64[]>] [-After <DateTime>] [-AsBaseObject] [-Before <DateTime>] [-ComputerName <String[]>] [-EntryType {Error | Information | FailureAudit | SuccessAudit |
    Warning}] [-Index <Int32[]>] [-Message <String>] [-Newest <Int32>] [-Source <String[]>] [-UserName <String[]>] [<CommonParameters>]

    Get-EventLog [-AsString] [-ComputerName <String[]>] [-List] [<CommonParameters>]
#>

Get-ADComputer -Filter * | select -ExpandProperty name
Get-ADComputer -Filter * | select -ExpandProperty name | gm

Get-EventLog -LogName Security -Newest 10 -ComputerName ( Get-ADComputer -Filter * | select -ExpandProperty name )

