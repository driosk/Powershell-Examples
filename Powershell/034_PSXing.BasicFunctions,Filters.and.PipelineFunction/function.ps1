function Get-ComputerSystemInfo {
    param (
       [String[]]$ComputerName
    )
    Write-Host "Input is $input"
   $ComputerName = $input
   Write-Host "Computer name is in $ComputerName"
    Get-WmiObject -Class win32_computersystem -ComputerName $ComputerName |
        Select-Object -Property Name,Manufacturer,Model
}
    #Get-Content .\computers.txt Get-ComputerSystemInfo 
    #Get-ComputerSystemInfo -ComputerName ILCSDCO.critsol.net
    
    #$input gets piped content