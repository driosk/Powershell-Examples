function Get-CompSysInfo {
    param (
        [string[]]$ComputerName
    )
    BEGIN { }
    PROCESS {
        if ($_ -ne $null) {
            $ComputerName = $_ 
        }
        foreach ($computer in $ComputerName) {
            Get-WmiObject -Class win32_computersystem -ComputerName $computer |
            Select-Object -Property Name, Manufacturer, Model
        }
    }
    END { }
}

Get-CompSysInfo -ComputerName ILCSDC0,ILCSDC1