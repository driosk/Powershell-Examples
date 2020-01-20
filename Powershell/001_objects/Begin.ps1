<#
Objects: Just a data structure
Exploring objects
Finding Documentation
The ETS and adaptation
Properties, methods, events
Playing with DateTime and String objects


Powershell written in .net


#>

Get-Service
Get-Service | gm
Get-Service | Get-Member
System.ServiceProcess.ServiceController
Get-ADUser | gm
Get-Process | gm -View All
Get-Process | gm -View Adapted
Get-Process | gm -View Extended
Get-Process | gm -View Base
$x = "hello"
$x | Get-Member
$x.Length
$x.Replace('ll','xx')
$x
$x.ToUpper()
$x.ToLower()
Get-Command -Name *date*
$d = Get-Date
$d.Hour

# Subtract             Method         timespan Subtract(datetime value), datetime Subtract(timespan value)
$d.AddDays(90)
$d.Year
$d
$d.AddDays(-90)
$d.AddDays(-90).Year #chaining
$d.AddDays(-90).ToShortDateString()


$procs = Get-Process
$procs[0].cpu

$procs = Get-Process -Name notepad
$procs
<#
Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName                                                                                                                                 
-------  ------    -----      -----     ------     --  -- -----------                                                                                                                                 
    228      13     3148      14220       0.09   2496   2 notepad                                                                                                                                     
    232      13     3212      14596       0.05  11676   2 notepad                                                                                                                                     
    232      13     3212      14676       0.16  13224   2 notepad
#>
$procs[0].PM
$procs[0].Kill()


# Row = Object
# Column = Property
