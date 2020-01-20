# Connect to one or more remote machines. 
# Remoting needs to be enabled on the remote computers

# the protocal to make the connection Web Services Managment or WS-MAN
# in OS WinRM implements the protocol HTTP/S.
# 5985 or 5986

# SSH similar but different. A telnet evolution.

# WSMAN bundles entire command in XML and sent to remote computer. The remote computer executes that, serializes the objects into xml. (like convertto-clixml) When it gets back it 
# gets them and reserializes it as an object. 

# 1:n One to many. Multiple computer execute and results get transfered back to client in xml. 

# Default auth is Kerberos. Need to refer to name as it is in Active Directory.
# There will be mutual authentication in the remoting system. Your credential will be delegated to the remote computer. Whatever you can do, it can do. 
# Audits still done as user. 
# Kerberos handles verifying mutual authentication before credentials are delegated. 

# When you go to an untrusted domain, kerberos is out of the question. Basic will be used and is clear text. 

# Remoting won't let you do basic by default. 

<#
1. Put ssl certificate on that computer. Client computer needs to trust CA for host computer. Once on https creds are encypted. 
2. On Client Computer, Manipulate the "Trusted Hosts" settings. Basic, NTLM
TrustedHost=* lol no way Jose
PowerShell.org books "secrets of powershell remoting"
Server 2012+ have remoting enabled
#>

# if you have any network adapters identified as public and they are connected, windows firewall won't allow exceptions.

Enable-PSRemoting -SkipNetworkProfileCheck

# Windows will create firewall exceptions on private connections.

SDDL : Security Definition Descriptor Language
# Example: O:NSG:BAD:P(A;;GA;;;BA)(A;;GA;;;RM)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)

# No Remoting in GPO via https
# In GPO you can start WinRM automatically but not immediately.
# Allow local port exceptions allow admins to configure firewall locally. 
# Define Inbound port exceptions allows it to happen. admintemplates>network>networkconnections>windowsfirewall>domain profile
cd WSMan:\localhost

<#
PS WSMan:\> dir


   WSManConfig:

ComputerName                                  Type
------------                                  ----
localhost                                     Container
#>

Get-Command -Noun *wsman*
Connect-WSMan -ComputerName ILCSINFWDS1

<#
PS WSMan:\> dir


   WSManConfig:

ComputerName                                  Type
------------                                  ----
localhost                                     Container
ilcsinfwds1                                   Container


PS WSMan:\>

PS WSMan:\> cd .\ilcsinfwds1\
PS WSMan:\ilcsinfwds1> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::ilcsinfwds1

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   MaxEnvelopeSizekb                              500
System.String   MaxTimeoutms                                   60000
System.String   MaxBatchItems                                  32000
System.String   MaxProviderRequests                            4294967295
Container       Client
Container       Service
Container       Shell
Container       Listener
Container       Plugin
Container       ClientCertificate

PS WSMan:\ilcsinfwds1> cd .\Service\
PS WSMan:\ilcsinfwds1\Service> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::ilcsinfwds1\Service

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   RootSDDL                                       O:NSG:BAD:P(A;;GA;;;BA)(A;;GR;;;IU)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)
System.String   MaxConcurrentOperations                        4294967295
System.String   MaxConcurrentOperationsPerUser                 1500
System.String   EnumerationTimeoutms                           240000
System.String   MaxConnections                                 300
System.String   MaxPacketRetrievalTimeSeconds                  120
System.String   AllowUnencrypted                               false
Container       Auth
Container       DefaultPorts
System.String   IPv4Filter                     GPO             *
System.String   IPv6Filter                     GPO             *
System.String   EnableCompatibilityHttpList...                 false
System.String   EnableCompatibilityHttpsLis...                 false
System.String   CertificateThumbprint
System.String   AllowRemoteAccess              GPO             true

PS WSMan:\ilcsinfwds1\Service> cd .\Auth\
PS WSMan:\ilcsinfwds1\Service\Auth> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::ilcsinfwds1\Service\Auth

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   Basic                                          false
System.String   Kerberos                                       true
System.String   Negotiate                                      true
System.String   Certificate                                    false
System.String   CredSSP                                        false
System.String   CbtHardeningLevel                              Relaxed


PS WSMan:\ilcsinfwds1\Service\Auth>

PS WSMan:\ilcsinfwds1\Service\Auth> cd ..
PS WSMan:\ilcsinfwds1\Service> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::ilcsinfwds1\Service

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   RootSDDL                                       O:NSG:BAD:P(A;;GA;;;BA)(A;;GR;;;IU)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)
System.String   MaxConcurrentOperations                        4294967295
System.String   MaxConcurrentOperationsPerUser                 1500
System.String   EnumerationTimeoutms                           240000
System.String   MaxConnections                                 300
System.String   MaxPacketRetrievalTimeSeconds                  120
System.String   AllowUnencrypted                               false
Container       Auth
Container       DefaultPorts
System.String   IPv4Filter                     GPO             *
System.String   IPv6Filter                     GPO             *
System.String   EnableCompatibilityHttpList...                 false
System.String   EnableCompatibilityHttpsLis...                 false
System.String   CertificateThumbprint
System.String   AllowRemoteAccess              GPO             true


PS WSMan:\ilcsinfwds1\Service> cd .\DefaultPorts\
PS WSMan:\ilcsinfwds1\Service\DefaultPorts> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::ilcsinfwds1\Service\DefaultPorts

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   HTTP                                           5985
System.String   HTTPS                                          5986




#>

# Service winrm related is under service.
<#
PS WSMan:\ilcsinfwds1> cd .\Shell\
PS WSMan:\ilcsinfwds1\Shell> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::ilcsinfwds1\Shell

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   AllowRemoteShellAccess                         true
System.String   IdleTimeout                                    7200000  
System.String   MaxConcurrentUsers                             2147483647 # 10
System.String   MaxShellRunTime                                2147483647
System.String   MaxProcessesPerShell                           2147483647 # 25
System.String   MaxMemoryPerShellMB                            2147483647 # 1024
System.String   MaxShellsPerUser                               2147483647 # 30


PS WSMan:\ilcsinfwds1\Shell>

PS WSMan:\ilcsinfwds1> cd .\Listener\
PS WSMan:\ilcsinfwds1\Listener> ls


   WSManConfig: Microsoft.WSMan.Management\WSMan::ilcsinfwds1\Listener

Type            Keys                                Name
----            ----                                ----
Container       {Transport=HTTP, Address=*}         Listener_1084132640

PS WSMan:\ilcsinfwds1\Listener\Listener_1084132640> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::ilcsinfwds1\Listener\Listener_1084132640

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   Address                                        *
System.String   Transport                                      HTTP
System.String   Port                                           5985
System.String   Hostname
System.String   Enabled                                        true
System.String   URLPrefix                                      wsman
System.String   CertificateThumbprint
System.String   ListeningOn_821910684                          10.11.10.64
System.String   ListeningOn_1770022257                         127.0.0.1
System.String   ListeningOn_1414502903                         ::1
System.String   ListeningOn_1411608058                         fd75:17af:1d1f:cb0e:4471:dc31:ca1b:9dbd
System.String   ListeningOn_253512228                          fd75:17af:1d1f:cb0e:720b:501e:205:a09b
System.String   ListeningOn_2145632486                         fe80::5efe:10.11.10.64%5
System.String   ListeningOn_1830023793                         fe80::4471:dc31:ca1b:9dbd%4


PS WSMan:\ilcsinfwds1\Listener\Listener_1084132640>

PS WSMan:\ilcsinfwds1\Client> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::ilcsinfwds1\Client

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   NetworkDelayms                                 5000
System.String   URLPrefix                                      wsman
System.String   AllowUnencrypted                               false
Container       Auth
Container       DefaultPorts
System.String   TrustedHosts


PS WSMan:\ilcsinfwds1\Client>
#>
Enter-PSSession -ComputerName ILCSINFWDS1.critsol.net 
Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 10} -ComputerName ILCSINFWDS1,ILCSDC0

<#
Invoke-Command [[-ConnectionUri] <Uri[]>] [-ScriptBlock] <ScriptBlock> [-AllowRedirection] [-ArgumentList <Object[]>] [-AsJob]
[-Authentication {Default | Basic | Negotiate | NegotiateWithImplicitCredential | Credssp | Digest | Kerberos}]
[-CertificateThumbprint <String>] [-ConfigurationName <String>] [-Credential <PSCredential>] [-EnableNetworkAccess]
[-HideComputerName] [-InDisconnectedSession] [-InputObject <PSObject>] [-JobName <String>] [-SessionOption <PSSessionOption>]
[-ThrottleLimit <Int32>] [<CommonParameters>]

Invoke-Command [[-ConnectionUri] <Uri[]>] [-FilePath] <String> [-AllowRedirection] [-ArgumentList <Object[]>] [-AsJob]
[-Authentication {Default | Basic | Negotiate | NegotiateWithImplicitCredential | Credssp | Digest | Kerberos}]
[-ConfigurationName <String>] [-Credential <PSCredential>] [-EnableNetworkAccess] [-HideComputerName] [-InDisconnectedSession]
[-InputObject <PSObject>] [-JobName <String>] [-SessionOption <PSSessionOption>] [-ThrottleLimit <Int32>] [<CommonParameters>]

Invoke-Command [[-ComputerName] <String[]>] [-ScriptBlock] <ScriptBlock> [-ApplicationName <String>] [-ArgumentList <Object[]>]
[-AsJob] [-Authentication {Default | Basic | Negotiate | NegotiateWithImplicitCredential | Credssp | Digest | Kerberos}]
[-CertificateThumbprint <String>] [-ConfigurationName <String>] [-Credential <PSCredential>] [-EnableNetworkAccess]
[-HideComputerName] [-InDisconnectedSession] [-InputObject <PSObject>] [-JobName <String>] [-Port <Int32>] [-SessionName
<String[]>] [-SessionOption <PSSessionOption>] [-ThrottleLimit <Int32>] [-UseSSL] [<CommonParameters>]

Invoke-Command [[-ComputerName] <String[]>] [-FilePath] <String> [-ApplicationName <String>] [-ArgumentList <Object[]>] [-AsJob]
[-Authentication {Default | Basic | Negotiate | NegotiateWithImplicitCredential | Credssp | Digest | Kerberos}]
[-ConfigurationName <String>] [-Credential <PSCredential>] [-EnableNetworkAccess] [-HideComputerName] [-InDisconnectedSession]
[-InputObject <PSObject>] [-JobName <String>] [-Port <Int32>] [-SessionName <String[]>] [-SessionOption <PSSessionOption>]
[-ThrottleLimit <Int32>] [-UseSSL] [<CommonParameters>]

Invoke-Command [[-Session] <PSSession[]>] [-ScriptBlock] <ScriptBlock> [-ArgumentList <Object[]>] [-AsJob] [-HideComputerName]
[-InputObject <PSObject>] [-JobName <String>] [-ThrottleLimit <Int32>] [<CommonParameters>]

Invoke-Command [[-Session] <PSSession[]>] [-FilePath] <String> [-ArgumentList <Object[]>] [-AsJob] [-HideComputerName]
[-InputObject <PSObject>] [-JobName <String>] [-ThrottleLimit <Int32>] [<CommonParameters>]

Invoke-Command [-VMId] <Guid[]> [-ScriptBlock] <ScriptBlock> [-ArgumentList <Object[]>] [-AsJob] [-ConfigurationName <String>]
-Credential <PSCredential> [-HideComputerName] [-InputObject <PSObject>] [-ThrottleLimit <Int32>] [<CommonParameters>]

Invoke-Command [-ScriptBlock] <ScriptBlock> [-ArgumentList <Object[]>] [-AsJob] [-ConfigurationName <String>] -Credential
<PSCredential> [-HideComputerName] [-InputObject <PSObject>] [-ThrottleLimit <Int32>] -VMName <String[]> [<CommonParameters>]

Invoke-Command [-VMId] <Guid[]> [-FilePath] <String> [-ArgumentList <Object[]>] [-AsJob] [-ConfigurationName <String>]
-Credential <PSCredential> [-HideComputerName] [-InputObject <PSObject>] [-ThrottleLimit <Int32>] [<CommonParameters>]

Invoke-Command [-FilePath] <String> [-ArgumentList <Object[]>] [-AsJob] [-ConfigurationName <String>] -Credential <PSCredential>
[-HideComputerName] [-InputObject <PSObject>] [-ThrottleLimit <Int32>] -VMName <String[]> [<CommonParameters>]

Invoke-Command [-ScriptBlock] <ScriptBlock> [-ArgumentList <Object[]>] [-AsJob] [-ConfigurationName <String>] -ContainerId
<String[]> [-HideComputerName] [-InputObject <PSObject>] [-JobName <String>] [-RunAsAdministrator] [-ThrottleLimit <Int32>]
[<CommonParameters>]

Invoke-Command [-FilePath] <String> [-ArgumentList <Object[]>] [-AsJob] [-ConfigurationName <String>] -ContainerId <String[]>
[-HideComputerName] [-InputObject <PSObject>] [-JobName <String>] [-RunAsAdministrator] [-ThrottleLimit <Int32>]
[<CommonParameters>]

Invoke-Command [-ScriptBlock] <ScriptBlock> [-ArgumentList <Object[]>] [-InputObject <PSObject>] [-NoNewScope]
[<CommonParameters>]
#>

# Defalt throttle limit is 32. Affects local computer. A thread is dedicated to every simultanious connection.

Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 10} -ComputerName ILCSINFWDS1,ILCSDC0 -HideComputerName | ft -GroupBy PSComputerName


# The DOUBLE HOP!!!!

# Jumping from one machine thats remoted to another. 
# Credendials by default can't be delegated to another hop. 

# You can allow specific machines to redeligate. Or use CredSSP authentication protocol.

cd wsman:
<#
PS WSMan:\localhost> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   MaxEnvelopeSizekb                              500
System.String   MaxTimeoutms                                   60000
System.String   MaxBatchItems                                  32000
System.String   MaxProviderRequests                            4294967295
Container       Client
Container       Service
Container       Shell
Container       Listener
Container       Plugin
Container       ClientCertificate


PS WSMan:\localhost> cd .\Client\
PS WSMan:\localhost\Client> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Client

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   NetworkDelayms                                 5000
System.String   URLPrefix                                      wsman
System.String   AllowUnencrypted                               false
Container       Auth
Container       DefaultPorts
System.String   TrustedHosts


PS WSMan:\localhost\Client> cd .\Auth\
PS WSMan:\localhost\Client\Auth> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Client\Auth

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   Basic                                          true
System.String   Digest                                         true
System.String   Kerberos                                       true
System.String   Negotiate                                      true
System.String   Certificate                                    true
System.String   CredSSP                                        false

PS WSMan:\localhost> cd .\Service\
PS WSMan:\localhost\Service> cd .\Auth\
PS WSMan:\localhost\Service\Auth> dir


   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Service\Auth

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   Basic                                          false
System.String   Kerberos                                       true
System.String   Negotiate                                      true
System.String   Certificate                                    false
System.String   CredSSP                                        false
System.String   CbtHardeningLevel                              Relaxed


PS WSMan:\localhost\Service\Auth>
#>
Enable-WSManCredSSP -Role Client -DelegateComputer ComputerAllowed (*.critsol.net)
Enable-WSManCredSSP -Role Server #allows to delegate the one hop. 

$client = [xml](get-content Client_Suddenlink-NewHire_Export-20080421.xml)

# GPO allow delegating fresh credentials
# WinRM Allow CredSSP Auth in WinRM Client GPO

Enter-PSSession -ComputerName ILCSINFWDS1 -Authentication Credssp



# Default Security

Get-PSSessionConfiguration 

<#
 Get-PSSessionConfiguration | gm


   TypeName: Microsoft.PowerShell.Commands.PSSessionConfigurationCommands#PSSessionConfiguration

Name                          MemberType     Definition
----                          ----------     ----------
Equals                        Method         bool Equals(System.Object obj)
GetHashCode                   Method         int GetHashCode()
GetType                       Method         type GetType()
ToString                      Method         string ToString()
Architecture                  NoteProperty   string Architecture=64
AutoRestart                   NoteProperty   string AutoRestart=false
Capability                    NoteProperty   Object[] Capability=System.Object[]
Enabled                       NoteProperty   string Enabled=true
ExactMatch                    NoteProperty   string ExactMatch=true
Filename                      NoteProperty   string Filename=%windir%\system32\pwrshplugin.dll
IdleTimeoutms                 NoteProperty   string IdleTimeoutms=7200000
lang                          NoteProperty   string lang=en-US
MaxConcurrentCommandsPerShell NoteProperty   string MaxConcurrentCommandsPerShell=2147483647
MaxConcurrentUsers            NoteProperty   string MaxConcurrentUsers=2147483647
MaxIdleTimeoutms              NoteProperty   string MaxIdleTimeoutms=2147483647
MaxMemoryPerShellMB           NoteProperty   string MaxMemoryPerShellMB=2147483647
MaxProcessesPerShell          NoteProperty   string MaxProcessesPerShell=2147483647
MaxShells                     NoteProperty   string MaxShells=2147483647
MaxShellsPerUser              NoteProperty   string MaxShellsPerUser=2147483647
Name                          NoteProperty   string Name=microsoft.powershell
OutputBufferingMode           NoteProperty   string OutputBufferingMode=Block
ParentResourceUri             NoteProperty   string ParentResourceUri=http://schemas.microsoft.com/powershell/microsoft.powershell
ProcessIdleTimeoutSec         NoteProperty   string ProcessIdleTimeoutSec=0
PSVersion                     NoteProperty   string PSVersion=5.1
ResourceUri                   NoteProperty   string ResourceUri=http://schemas.microsoft.com/powershell/microsoft.powershell
RunAsPassword                 NoteProperty   string RunAsPassword=
RunAsUser                     NoteProperty   string RunAsUser=
RunAsVirtualAccount           NoteProperty   string RunAsVirtualAccount=false
RunAsVirtualAccountGroups     NoteProperty   string RunAsVirtualAccountGroups=
SDKVersion                    NoteProperty   string SDKVersion=2
SecurityDescriptorSddl        NoteProperty   string SecurityDescriptorSddl=O:NSG:BAD:P(A;;GA;;;BA)(A;;GA;;;IU)(A;;GA;;;RM)S:P(AU;F...
SupportsOptions               NoteProperty   string SupportsOptions=true
Uri                           NoteProperty   string Uri=http://schemas.microsoft.com/powershell/microsoft.powershell
UseSharedProcess              NoteProperty   string UseSharedProcess=false
xmlns                         NoteProperty   string xmlns=http://schemas.microsoft.com/wbem/wsman/1/config/PluginConfiguration
XmlRenderingType              NoteProperty   string XmlRenderingType=text
Permission                    ScriptProperty System.Object Permission {get=trap { continue; }...
#>

<#
 Get-PSSessionConfiguration | Select-Object -Property permission

Permission
----------
NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management Users AccessAllowed
BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management Users AccessAllowed
NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed, BUILTIN\Remote Management Users AccessAllowed
NT AUTHORITY\INTERACTIVE AccessAllowed, BUILTIN\Administrators AccessAllowed
#>

Set-PSSessionConfiguration -ShowSecurityDescriptorUI -Name Microsoft.powershell

