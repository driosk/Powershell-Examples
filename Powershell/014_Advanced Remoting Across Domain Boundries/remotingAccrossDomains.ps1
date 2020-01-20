# Using ADCS or external CA.

cd WSMan:\localhost
cd .\client
dir

<#
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


PS WSMan:\localhost> cd .\Client\                                                                                                      PS WSMan:\localhost\Client> dir                                                                                                        

   WSManConfig: Microsoft.WSMan.Management\WSMan::localhost\Client

Type            Name                           SourceOfValue   Value
----            ----                           -------------   -----
System.String   NetworkDelayms                                 5000
System.String   URLPrefix                                      wsman
System.String   AllowUnencrypted                               false
Container       Auth
Container       DefaultPorts
System.String   TrustedHosts


PS WSMan:\localhost\Client>
#>

# need ip address to send packets but the name is what you need to trust. 
#Use dns forwarder or host file

Set-Item -Path .\TrustedHosts eve.edn.life

invoke-command -ScriptBlock {get-eventlog -LogName Security -newest 10} -ComputerName ILCSDC0,eve.edn.life 

invoke-command -ScriptBlock {get-eventlog -LogName Security -newest 10} -ComputerName ILCSDC0,eve.edn.life -Credential Administrator 

# both domains have user administrator and both were the same password. 
# Not secure at all. 
Clear-Item -Path .\TrustedHosts
Set-Item -Path .\trustedhosts '' # also works
New-WSManInstance -ResourceURI winrm/config/Listener -SelectorSet @{address='*';Transport='HTTPS'}`
-ValueSet @{hostname='eve.edn.life';certificatethumbprint='9943592C291C5F9C8703DCEB7D692D78BFA06FA9'}

# Port needs to be opened port tcp:5986 the ssl port for WSMAN

# on local computer import trusted root CA either manually or through GPO. 

Enter-PSSession -ComputerName eve.edn.life -UseSSL -Credential FOREIGN\Administrator







