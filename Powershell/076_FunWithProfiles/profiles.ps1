# profiles loaded by application that runs powershell not powershell itself.

$host

<#
Name             : ConsoleHost
Version          : 5.1.18362.145
InstanceId       : 4e0edf99-2e7f-4363-92cf-bd945d418454
UI               : System.Management.Automation.Internal.Host.InternalHostUserInterface
CurrentCulture   : en-US
CurrentUICulture : en-US
PrivateData      : Microsoft.PowerShell.ConsoleHost+ConsoleColorProxy
DebuggerEnabled  : True
IsRunspacePushed : False
Runspace         : System.Management.Automation.Runspaces.LocalRunspace
#>

$profile # different script by powershell Host.

# Multiple possible profiles

<#
current user/current host
current-user/all hosts
all user / curr host <not used much
all user / all hosts <not used much
#>
# caviats when you remote, it doesn't load profiles. WSMPROVHOST

# profiles only apply when you open the console or the ISE.

help about_Profiles

# Details the order in which it loads them.

windowspowershell\profile.ps1

cd C:\

Set-ExecutionPolicy Restricted #won't run profile script.
powershell -?
powershell -NoProfile

dir function:

<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\75_TheBigGotchasInPowershell> gc function:\prompt

"PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) ";
# .Link
# https://go.microsoft.com/fwlink/?LinkID=225750
# .ExternalHelp System.Management.Automation.dll-help.xml

#>

function promt {
    "$"
}

function prompt {
    "$(Get-Date) `nPS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
}
$host.PrivateData.ErrorForegroundColor = 'green'

$cred = Get-Credential -UserName CRIT\driosx 'Need Admin Password for $cred'

# load module from remote machine

$dc = New-PSSession -ComputerName ILCSDC0
Import-Module -Name ActiveDirectory -PSSession $dc
