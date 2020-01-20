function Get-DiskLowCapacity {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]]
        $ComputerName
    )
    PROCESS{
        foreach ($computer in $ComputerName) {
            $disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "drivetype='fixed'" -ComputerName $computer
            if ($disk.FreeSpace / $disk.Space -lt .2) {
                $disk | select DeviceID,FreeSpace,Space
            }
        }
    }
}