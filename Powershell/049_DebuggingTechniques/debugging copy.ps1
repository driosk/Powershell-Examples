function Get-DiskLowCapacity {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]]
        $ComputerName
    )
    PROCESS{
        foreach ($computer in $ComputerName) {
            $disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "drivetype='3'" -ComputerName $computer
            if ($disk.FreeSpace / $disk.Size -lt .2) {
                $disk | select DeviceID,FreeSpace,Size
            }
        }
    }
}

<#
NumberOfCores                           : 4
NumberOfEnabledCore                     : 8
NumberOfLogicalProcessors               : 8

on older versions this didn't exist. HyperThreading doubles number of processors. For earlier versions of XP assumptions were 
different. 
#>

Get-DiskLowCapacity -ComputerName localhost,ILCSDC0

$disk.space = 0 # nothing. 

# We meant for it to be size.
<#
Get-DiskLowCapacity -ComputerName localhost,ILCSDC0

DeviceID   FreeSpace         Size
--------   ---------         ----
C:       77239484416 135219716096
C:       24006893568  42354077696



PS C:\WINDOWS\system32>

#>