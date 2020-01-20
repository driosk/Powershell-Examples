filter Get-ComputerSysInfo{
Get-WmiObject -Class win32_computersystem -ComputerName $_ |
        Select-Object -Property Name,Manufacturer,Model
}

Get-Content .\computers.txt | Get-ComputerSysInfo