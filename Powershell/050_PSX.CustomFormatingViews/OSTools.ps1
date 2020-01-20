function Get-SystemDetails {
    <#
    .SYNOPSIS
        Gets basic system information from one or more computers via WMI
    .DESCRIPTION
        See synopsis. This is not complex.
    .PARAMETER ComputerName
        The name of the Host to Query
    .EXAMPLE
        Get-SystemDetails -Computername DC
        Gets system info from the computer named DC.
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
            $os     = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer
            $cs     = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computer
            $bios   = Get-WmiObject -Class Win32_BIOS -ComputerName $computer

            $props  = @{
                'ComputerName'  =   $cs.__SERVER;
                'OSVersion'     =   $os.version;
                'SPVersion'     =   $os.servicepackmajorversion;
                'OSBuild'       =   $os.buildnumber;
                'Manufacturer'  =   $cs.Manufacturer;
                'Model'         =   $cs.model;
                'BIOSSerial'    =   $bios.serialnumber
            }
            $obj = New-Object -TypeName psobject -Property $props
            $obj.psobject.typenames.insert(0,'CriticalSolutions.OSTools.SystemDetails')
            Write-Output $obj
        }
    }
}

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
                $props  = [ordered]@{
                    'ComputerName'  =   $computer;
                    'Drive'         =   $disk.DeviceID;
                    'FreeSpace'     =   "{0:N2}" -f ($disk.FreeSpace / 1GB);
                    'Size'          =   "{0:N2}" -f ($disk.size / 1GB);
                    'FreePercent'   =   ($disk.FreeSpace / $disk.size).tostring("P")
                }
                $obj = New-Object -TypeName psobject -Property $props
                Write-Output $obj
            }
        }
    }
}

<#


PS C:\Users\driosx.CRIT\documents\WindowsPowerShell\modules\OSTools> dir


    Directory: C:\Users\driosx.CRIT\documents\WindowsPowerShell\modules\OSTools


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        12/7/2019   4:06 PM            935 OSTools.Format.ps1xml
-a----        12/7/2019   4:04 PM           3127 OSTools.psm1

#>

New-ModuleManifest -Path OSTools.psd1 -RootModule .\OStools.psm1 -FormatsToProcess .\ostools.format.psm1xml
# You can add custom view for all your modules in the same xml.