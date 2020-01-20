function Get-CompSysInfo {
    param (
        [string[]]$ComputerName
    )
    Begin {}
    PROCESS{ # runs once for each input piped in.
        if ($_ -ne $null) {
            $ComputerName = $_ 
        }
        foreach ($computer in $ComputerName) {
            Get-WmiObject -Class win32_computersystem -ComputerName $computer |
            Select-Object -Property Name,Manufacturer,Model
        }
    }
    END{}
}