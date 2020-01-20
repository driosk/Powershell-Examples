param(
    [string]$ComputerName
)
Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName
Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ComputerName
Get-WmiObject -Class Win32_BIOS -ComputerName $ComputerName