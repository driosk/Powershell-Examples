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
            $wmi_param =   @{   'Class'='Win32_LogicalDisk';
                                'Filter'="DriveType=3";
                                'Credential'='Administrator';
                                'ComputerName'=$computer
                            }
            $select_param = @{'Property'='Name','Manufacturer','Model'}
            Get-WmiObject @wmi_param | Select-Object @select_param
        }
    }
    END { }
}

# Get-CompSysInfo -ComputerName ILCSDC0,ILCSDC1
# Get-Content .\computers.txt | Get-CompSysInfo

#splatting