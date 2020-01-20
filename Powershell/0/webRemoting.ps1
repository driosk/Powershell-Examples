Enter-PSSession -ComputerName CORE-TEST
Get-WindowsFeature | ? {$_.installed}
Get-WindowsFeature | ? {$_.name -like '*webacc*'} | ft -AutoSize
Install-WindowsFeature -Name WindowsPowerShellWebAccess
<#
Success Restart Needed Exit Code      Feature Result
------- -------------- ---------      --------------
True    No             Success        {Application Development, ASP.NET 4.6, Com...
WARNING: For more information about how to finish installing and configuring Windows PowerShell Web Access, see
http://go.microsoft.com/fwlink/?LinkID=221050.

#>

Get-Command -Module PowerShellWebAccess
<#
[ILCSINFWDS1]: PS C:\Users\driosx.CRIT\Documents> Get-Command -Module *WebAccess*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Install-PswaWebApplication                         1.1.0.0    PowerShellWebAccess
Function        Uninstall-PswaWebApplication                       1.1.0.0    PowerShellWebAccess
Cmdlet          Add-PswaAuthorizationRule                          1.1.0.0    PowerShellWebAccess
Cmdlet          Get-PswaAuthorizationRule                          1.1.0.0    PowerShellWebAccess
Cmdlet          Remove-PswaAuthorizationRule                       1.1.0.0    PowerShellWebAccess
Cmdlet          Test-PswaAuthorizationRule                         1.1.0.0    PowerShellWebAccess
#>

help Install-PswaWebApplication

<#
NAME
    Install-PswaWebApplication

SYNTAX
    Install-PswaWebApplication [[-WebApplicationName] <string>] [-WebSiteName <string>] [-UseTestCertificate] [-WhatIf] [-Confirm]
    [<CommonParameters>]


ALIASES
    None


REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Install-PswaWebApplication -Online" or
           go to http://go.microsoft.com/fwlink/?LinkID=254229.
#>

# Has to be https

Install-PswaWebApplication

Add-PswaAuthorizationRule -rulename 'Default Configuration for admins to a computer' -configurationname 'microsoft.powershell' -usergroupname "it admins" -ComputerName 'ILCSDC0.critsol.net'


Add-PswaAuthorizationRule -RuleName 'Default Configuration for admins to a
computer' -configurationname 'microsoft.powershell' -usergroupname "it admins" -ComputerName 'ILCSDC0.critsol.net'


Enable-WSManCredSSP -Role Client -DelegateComputer *.lab.pri

Enable-WSManCredSSP -Role Server

Enter-PSSession -Authentication Credssp CRIT\driosx

Get-WebBinding -protocol https | select *

$newSize = $Host.UI.RawUI.WindowSize
  $newSize.Width = $newSize.Width - 20

  $oldSize = $Host.UI.RawUI.WindowSize

  $Host.UI.RawUI.WindowSize = $newSize

4560646E5D89D991D071BAD9A581CF2081C00A2A

set-webbinding -name "Default Web Site" -IPAddress * -Port 443 -PropertyName certificatehash -Value '4560646E5D89D991D071BAD9A581CF2081C00A2A' -WhatIf

set-webbinding -name "Default Web Site" -BindingInformation "*:443:" -PropertyName certificatehash -Value '4560646E5D89D991D071BAD9A581CF2081C00A2A'