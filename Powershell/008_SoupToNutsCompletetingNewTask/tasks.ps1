Get-WindowsFeature -ComputerName ILCSINFWDS1
Get-WindowsFeature -ComputerName ILCSINFWDS1 | Where-Object {$_.installed}

Get-WindowsFeature -ComputerName ILCSINFWDS1 | gm

# TypeName: Microsoft.Windows.ServerManager.Commands.Feature

help Uninstall-WindowsFeature -Full

<#
-Name <Feature[]>
        Specifies a list of features that this cmdlet uninstalls. This parameter does not support wildcard 
        characters.
        
        Required?                    true
        Position?                    1
        Default value                none
        Accept pipeline input?       True (ByValue)
        Accept wildcard characters?  false
#>

# Complex object best to use xml.

Get-WindowsFeature -ComputerName ILCSINFWDS1 | Where-Object {$_.installed} | Export-Clixml .\baseline.xml

Import-Clixml .\baseline.xml | gm

# Still a feature, now serialized but still a feature object. 

Get-WindowsFeature -ComputerName ILCSINFWDS1
Install-WindowsFeature -ComputerName ILCSINFWDS1 -Name telnet-client
Compare-Object -ReferenceObject (Import-Clixml .\baseline.xml) -DifferenceObject `
(Get-WindowsFeature -ComputerName ILCSINFWDS1 | Where-Object {$_.installed} ) -Property name

<#
PS .\8_SoupToNutsCompletetingNewTask> Compare-Object -ReferenceObject (Import-Clixml .\baseline.xml) -DifferenceObject (Get-WindowsFeature -ComputerName ILCSINFWDS1 | Where-Object {$_.installed} ) -Property name

name          SideIndicator
----          -------------
Telnet-Client =>
#>
Compare-Object -ReferenceObject (Import-Clixml .\baseline.xml) -DifferenceObject `
(Get-WindowsFeature -ComputerName ILCSINFWDS1 | Where-Object {$_.installed} ) -Property name | select -ExpandProperty name

Uninstall-WindowsFeature -ComputerName ILCSINFWDS1 -Name (Compare-Object -ReferenceObject (Import-Clixml .\baseline.xml) -DifferenceObject `
(Get-WindowsFeature -ComputerName ILCSINFWDS1 | Where-Object {$_.installed} ) -Property name | select -ExpandProperty name)

<#
Success Restart Needed Exit Code      Feature Result                               
------- -------------- ---------      --------------                               
True    No             Success        {Telnet Client}
#>

Get-WindowsFeature -ComputerName ILCSINFWDS1 | Where-Object {-not $_.installed}

Uninstall-WindowsFeature -ComputerName ILCSINFWDS1 -Name (
    Compare-Object -ReferenceObject (Import-Clixml .\baseline.xml) -DifferenceObject `
    (Get-WindowsFeature -ComputerName ILCSINFWDS1 | Where-Object {$_.installed} ) -Property name | select -ExpandProperty name
)