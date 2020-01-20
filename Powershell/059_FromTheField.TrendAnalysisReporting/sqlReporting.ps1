function Get-DiskDetails {
    <#
    .SYNOPSIS
        Gets information on local disks.
    .DESCRIPTION
        See Synopsis, uses WMI.
    .PARAMETER ComputerName
        One or more Computers or IP's to query.
    .EXAMPLE
        Get-DiskDetails -ComputerName DC,CLIENT
        Get disk space details from Computers DC and CLIENT.
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true
        )]
        [string[]]$ComputerName
    )
    PROCESS {
        foreach ($computer in $ComputerName) {
            $disks     = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType='3'" -ComputerName $computer
            foreach ($disk in $disks) {
                $props  = @{
                    'ComputerName'  =   $computer;
                    'Drive'         =   $disk.DeviceID;
                    'FreeSpace'     =   "{0:N2}" -f ($disk.FreeSpace / 1GB);
                    'Size'          =   "{0:N2}" -f ($disk.size / 1GB);
                    'FreePercent'   =   "{0:N2}" -f ($disk.FreeSpace / $disk.size * 100);
                    'Collected'     =   (Get-Date)
                }
                $obj = New-Object -TypeName psobject -Property $props
                $obj.psobject.typenames.insert(0,'Report.OSTools.DiskDetails')
                Write-Output $obj
            }
        }
    }
} #