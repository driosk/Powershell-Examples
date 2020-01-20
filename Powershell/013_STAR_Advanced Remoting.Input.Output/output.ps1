Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 10 } -ComputerName ILCSDC0,ILCSDC1
Invoke-Command -ScriptBlock { Get-EventLog -LogName Security -Newest 10 } -ComputerName ILCSDC0,ILCSDC1 | gm

# TypeName: Deserialized.System.Diagnostics.EventLogEntry#Security/Microsoft-Windows-Security-Auditing/4672

Get-EventLog -LogName Security -Newest 10 -ComputerName ILCSDC0 # RPC/DCOM ?
Get-EventLog -LogName Security -Newest 10 -ComputerName ILCSDC0 | gm

<#
TypeName: System.Diagnostics.EventLogEntry#Security/Microsoft-Windows-Security-Auditing/4769

Name                      MemberType     Definition
----                      ----------     ----------
Disposed                  Event          System.EventHandler Disposed(System.Object, System.EventArgs)
CreateObjRef              Method         System.Runtime.Remoting.ObjRef CreateObjRef(type requestedType)
Dispose                   Method         void Dispose(), void IDisposable.Dispose()
Equals                    Method         bool Equals(System.Diagnostics.EventLogEntry otherEntry), bool Equals(System.Object obj)
GetHashCode               Method         int GetHashCode()
GetLifetimeService        Method         System.Object GetLifetimeService()
GetObjectData             Method         void ISerializable.GetObjectData(System.Runtime.Serialization.SerializationInfo info, System.Runtime.Serializati...
GetType                   Method         type GetType()
InitializeLifetimeService Method         System.Object InitializeLifetimeService()
ToString                  Method         string ToString()
Category                  Property       string Category {get;}
CategoryNumber            Property       int16 CategoryNumber {get;}
Container                 Property       System.ComponentModel.IContainer Container {get;}
Data                      Property       byte[] Data {get;}
EntryType                 Property       System.Diagnostics.EventLogEntryType EntryType {get;}
Index                     Property       int Index {get;}
InstanceId                Property       long InstanceId {get;}
MachineName               Property       string MachineName {get;}
Message                   Property       string Message {get;}
ReplacementStrings        Property       string[] ReplacementStrings {get;}
Site                      Property       System.ComponentModel.ISite Site {get;set;}
Source                    Property       string Source {get;}
TimeGenerated             Property       datetime TimeGenerated {get;}
TimeWritten               Property       datetime TimeWritten {get;}
UserName                  Property       string UserName {get;}
EventID                   ScriptProperty System.Object EventID {get=$this.get_EventID() -band 0xFFFF;}
#> # Same as running get-eventlog locally

# Anything I get remotely consists of an xml output that gets deserialized,
# we can only see what was able to be serialized.

# deserialized is a brochure of the car, it can't turn on, but it has all the properties of the car.

# using native commands give you serialized data. Remoting is deserialized(snapshots).

# Remoting works over http

# Native uses other forms of remoting.

Get-Process -ComputerName ILCSDC0

Get-Process -ComputerName DC -Name dns | stop-process #not supported on remote machines
Invoke-Command -ScriptBlock {Get-Process -Name dns} -computername ILCSDC0 | Stop-Process

stop-process notepad | gm

Invoke-Command -ScriptBlock {Get-Process -Name dns | Stop-Process} -computername ILCSDC0
# Keep most of the processing to the remote computer.

Invoke-Command -ScriptBlock {Get-Process} -ComputerName ILCSDC0.critsol.net | sort vm -Descending | select -first 10 |
Format-Table -Property id,name,vm -AutoSize # Not like this
<#
  Id Name                           VM
  -- ----                           --
4604 wsmprovhost         2200033157120
5480 wsmprovhost         2199675506688
3144 wsmprovhost         2199663636480
2652 MsMpEng             2199563972608
2748 svchost             2199355092992
4888 explorer            2199335903232
2724 dns                 2199326244864
 648 lsass               2199296180224
4580 SearchUI            2199293771776
4160 ShellExperienceHost 2199271907328
#>
Invoke-Command -ScriptBlock {Get-Process | sort vm -desc | select -first 10} -ComputerName ILCSDC0.critsol.net |
Format-Table -Property id,name,vm -AutoSize # Like this, still same output but for demo purposes,
#we want to do as much on the remote host as possible other than formatting final output.

# Once we're formatting, we only care about properties.

Invoke-Command -ScriptBlock {Get-Process | sort vm -desc | select -first 10} -ComputerName ILCSDC0,ILCSDC1 |
Format-Table -Property id,name,vm,pscomputername -AutoSize

<#
Id Name                           VM PSComputerName
  -- ----                           -- --------------
4604 wsmprovhost         2200033157120 ILCSDC0
4632 wsmprovhost         2199677923328 ILCSDC0
5480 wsmprovhost         2199675506688 ILCSDC0
2652 MsMpEng             2199563972608 ILCSDC0
2748 svchost             2199355092992 ILCSDC0
4888 explorer            2199335903232 ILCSDC0
2724 dns                 2199326244864 ILCSDC0
 648 lsass               2199296180224 ILCSDC0
5340 wsmprovhost         2199677427712 ILCSDC1
2560 MsMpEng             2199564013568 ILCSDC1
1160 explorer            2199329284096 ILCSDC1
2456 dns                 2199326294016 ILCSDC1
2400 svchost             2199320068096 ILCSDC1
4580 SearchUI            2199293771776 ILCSDC0
4160 ShellExperienceHost 2199272955904 ILCSDC0
4452 SearchUI            2199293820928 ILCSDC1
 640 lsass               2199281258496 ILCSDC1
2316 ShellExperienceHost 2199271796736 ILCSDC1
 968 LogonUI             2199259938816 ILCSDC1
1380 svchost             2199247831040 ILCSDC1
#>

Invoke-Command -ScriptBlock {Get-Process} -ComputerName ILCSDC0.critsol.net |
sort vm -Descending | select -first 10 | Format-Table -Property id,name,vm,pscomputername -AutoSize

<#
PS C:\users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\11_PersistentRemoting.PSSESSIONS> Invoke-Command -ScriptBlock {Get-Process} -ComputerName ILCSDC0.critsol.net |
>> sort vm -Descending | select -first 10 | Format-Table -Property id,name,vm,pscomputername -AutoSize

  Id Name                           VM PSComputerName
  -- ----                           -- --------------
4604 wsmprovhost         2200032632832 ILCSDC0.critsol.net
5480 wsmprovhost         2199675506688 ILCSDC0.critsol.net
2572 wsmprovhost         2199663583232 ILCSDC0.critsol.net
2652 MsMpEng             2199563972608 ILCSDC0.critsol.net
2748 svchost             2199351947264 ILCSDC0.critsol.net
4888 explorer            2199335903232 ILCSDC0.critsol.net
2724 dns                 2199325720576 ILCSDC0.critsol.net
 648 lsass               2199296180224 ILCSDC0.critsol.net
4580 SearchUI            2199293771776 ILCSDC0.critsol.net
4160 ShellExperienceHost 2199272955904 ILCSDC0.critsol.net
#>

$logname = read-host "Enter name of log to retrieve"
Invoke-Command -ComputerName ILCSDC0 -ScriptBlock {Get-EventLog -LogName $logname -Newest 10} # Get's interpreted as raw text.

$logname = read-host "Enter name of log to retrieve"
$quantity = Read-Host "How many recent entries to retrieve"

Invoke-Command -ComputerName ILCSDC0 -ScriptBlock {param($x,$y) Get-EventLog -LogName $x -Newest $y} -ArgumentList $logname,$quantity

function subtract {
    $x = 10
    $x = 5
    $x - $y}

$logname = 'security'
$quantity = 12
Invoke-Command -ComputerName ILCSDC0 -ScriptBlock {
    param($ln,$q) Get-EventLog -LogName $ln -Newest $q
} -ArgumentList $logname,$quantity


# In version Powershell version 3 onward
$logname = 'security'
$quantity = 12
Invoke-Command -ComputerName ILCSDC0 -ScriptBlock {
    param($ln,$q) Get-EventLog -LogName $using:logname -Newest $using:quantity
}
# $using: # it assumes what follows is a variablename from the local computer and substitutes.

# What if you want different parameters? Not with invoke-command.










