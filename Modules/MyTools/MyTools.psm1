function Get-LatestSecurityLog{
    param (
        [string]$ComputerName
    )
    Get-EventLog -LogName Security -Newest 50 -ComputerName $ComputerName
}
function Get-OSInfo {
    param(
        [string]$ComputerName
    )
    Get-CimInstance -ClassName Win32_BIOS -ComputerName $ComputerName
}
function Get-SysInfo {
    param(
        [string[]]$ComputerName
    )
    foreach ($comp in $ComputerName) {
        $os =   Get-WmiObject -Class Win32_OperatingSystem -ComputerName $Comp
        $cs =   Get-WmiObject -Class Win32_ComputerSystem -ComputerName $Comp
        $bios = Get-WmiObject -Class Win32_BIOS -ComputerName $Comp

        $props = [ordered]@{
                    'ComputerName'= $Comp;
                    'OSVersion'   = $os.version;
                    'SPVersion'   = $os.servicepackmajorversion;
                    'Mfgr'        = $cs.manufacturer;
                    'Model'       = $cs.model;
                    'RAM'         = $cs.TotalPhysicalMemory;
                    'BIOSSerial'  = $bios.serialnumber  
        }
        # Write-Output $props

        $obj = New-Object -TypeName psobject -Property $props

        Write-Output $obj
    }
}