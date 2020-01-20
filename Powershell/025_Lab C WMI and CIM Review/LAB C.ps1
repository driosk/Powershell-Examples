Get-WmiObject -Class win32_logicaldisk | where {$_.drivetype -eq 3}

get-wmiobject -Class win32_logicaldisk -Filter "drivetype='3'"

Get-CimInstance -ClassName Win32_Process localhost,ILCSDC0

$win7 = New-CimSession -ComputerName ILCSWS007 -SessionOption (New-CimSessionOption -Protocol Dcom)
Get-CimInstance -ClassName Win32_NTEventlogFile -CimSession $win7

Get-WmiObject -ComputerName win7 -Class Win32_NTEventlogFile -Filter "Logfilename='Application'" | gm
# BackupEvenLog Method

Get-WmiObject -ComputerName win7 -Class Win32_NTEventlogFile -EnableAllPrivileges `
-Filter "Logfilename='Application'" |
Invoke-WmiMethod -Name BackupEventLog -ArgumentList C:\backup.evt 
# Or Clear eventlog.



