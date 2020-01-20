function Get-ComputerSystemInfo{
    Get-WmiObject -Class win32_computersystem -ComputerName ILCSDC0 |
    Select-Object -Property Name,Manufacturer,Model
        }

# one option to call function is . sourcing

. .\function.ps1

# other way is to call the function in the script.

Get-ComputerSystemInfo