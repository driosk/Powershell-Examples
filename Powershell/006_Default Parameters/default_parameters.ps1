$PSDefaultParameterValues # Only available in scope of session. 
$PSDefaultParameterValues = @{}
Get-EventLog -logname security -newest 10
$PSDefaultParameterValues = @{"Get-EventLog:Newest"=10}
Get-EventLog -LogName Application

$PSDefaultParameterValues

$PSDefaultParameterValues.Add("Get-EventLog:LogName","Application")

Get-EventLog

<#
Name                           Value
----                           -----
Get-EventLog:LogName           Application
Get-EventLog:Newest            10
#>

$PSDefaultParameterValues.Remove('Get-EventLog:newest')
$PSDefaultParameterValues['Disabled'] = $true

$PSDefaultParameterValues

<#
Name                           Value
----                           -----
Get-EventLog:LogName           Application
#>

$PSDefaultParameterValues['Disabled'] = $false

$PSDefaultParameterValues.Remove('disabled')
Get-EventLog


# Need profile script to set as default.

$PSDefaultParameterValues

Get-Service -ComputerName ILCSDC0

$PSDefaultParameterValues.Add('*:Computername', 'ILCSWS008')

# $PSDefaultParameterValues.Add('* # Command:Computername # ParameterName', 'CRITHOS # Value')

Get-Service

$PSDefaultParameterValues.Remove('*:Computername')

Get-WmiObject -Class win32_operatingsystem -ComputerName localhost

$PSDefaultParameterValues.Add('Get-*:Computername', 'ILCSWS008')


