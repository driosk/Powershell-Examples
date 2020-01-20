function Get-SysDiskDetails {
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
            $disks  = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $computer

            #First Create Nested Object
            $diskcollection = @()
            foreach ($disk in $disks) {
                $diskprops = @{
                    'DriveLetter'   =   $disk.deviceid;
                    'DriveType'     =   $disk.DriveType;
                    'Size'          =   $disk.Size
                }
                $diskobj        =   New-Object -TypeName psobject -Property $diskprops
                $diskcollection +=  $diskobj
            }

            $props  = @{
                'ComputerName'  =   $cs.__SERVER;
                'OSVersion'     =   $os.version;
                'SPVersion'     =   $os.servicepackmajorversion;
                'OSBuild'       =   $os.buildnumber;
                'Manufacturer'  =   $cs.Manufacturer;
                'Model'         =   $cs.model;
                'BIOSSerial'    =   $bios.serialnumber;
                'Disks'         =   $diskcollection
            }
            $obj = New-Object -TypeName psobject -Property $props
            $obj.psobject.typenames.insert(0,'CriticalSolutions.OSTools.SysDiskDetails')
            Write-Output $obj
        }
    } 
}