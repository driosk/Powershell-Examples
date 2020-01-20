# Look for changeable information.
# Parameters are positional
Param(
    [string]$ComputerName=(Read-Host "Computer to Query"),
    [int]$DriveType = 3 
)

#$cred = Get-Credential
Get-WmiObject -Class win32_logicaldisk -Filter "drivetype=$DriveType" -ComputerName $ComputerName <#-Credential $cred#> |
Select-Object -Property @{name='Computername';expression={$_.__SERVER}},
                        @{name='Drive';expression={$_.deviceid}},
                        @{name='Freespace(GB)';expression={$_.Freespace / 1GB -as [int]}},
                        @{name='Size(GB)';expression={$_.Size / 1GB -as [int]}}
#Get-Diskinfo.ps1 [[-ComputerName] <string>] [[-DriveType] <int>]