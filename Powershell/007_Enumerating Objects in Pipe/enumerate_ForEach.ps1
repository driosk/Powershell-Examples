$procs = Get-Process
notepad.exe
$procs = Get-Process -Name notepad
$procs.kill()
$procs
notepad;notepad;notepad

$procs[0].Kill()
$procs[1].Kill()
$procs[2].Kill()

Get-Process -Name notepad | ForEach-Object -Process { $_.kill() }
Get-Process -Name notepad | ForEach { $_.kill() }
Get-Process -Name notepad | % { $_.kill() }
ps notepad | % { $_.kill()}
ps notepad


# notepad 3 objects 
# first object gets sent up the pipe as the 2nd is being created and is being dealt with.
# Foreach is least performance efficient way. 

# for example
Get-Process -Name notepad | Stop-Process

Stop-Process -Name notepad # Fastest

Measure-Command -?

Measure-Command -Expression {notepad;notepad;notepad; Get-Process -Name notepad | foreach {$_.kill()}}
Measure-Command -Expression {notepad;notepad;notepad; Get-Process -Name notepad | % {$_.kill()}}
Measure-Command -Expression {notepad;notepad;notepad; Get-Process -Name notepad | Stop-Process}
Measure-Command -Expression {notepad;notepad;notepad; Stop-Process -Name notepad }

notepad;notepad;notepad;
Measure-Command -Expression { Get-Process -Name notepad | foreach {$_.kill()}}
notepad;notepad;notepad;
Measure-Command -Expression { Get-Process -Name notepad | % {$_.kill()}}
notepad;notepad;notepad;
Measure-Command -Expression { Get-Process -Name notepad | Stop-Process}
notepad;notepad;notepad;
Measure-Command -Expression { Stop-Process -Name notepad }


Get-Process -Name notepad | ForEach-Object {$PSitem.kill()}

Get-Process -Name notepad | ForEach-Object Id

Get-Process -Name notepad | Select-Object -Property Id # Returns and object

Get-Process -Name notepad | select -ExpandProperty Id

Get-Process -Name notepad | ForEach-Object kill

# Get-Process | ForEach-Object name.toupper() #won't work

Get-Process | ForEach-Object {$_.name.toupper()}

<#
APPLICATIONFRAMEHOST
BROWSER_BROKER
CHROME
CHROME
CHROME
CHROME
CHROME
#>

Measure-Command -Expression {Get-Process -Name notepad | ForEach-Object kill}
