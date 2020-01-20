$messages = DATA {
    # culture="de-de"
    ConvertFrom-StringData @"
        Connecting  = Gonna talk to
        Failed      = That did not work
"@
}
Import-LocalizedData -BindingVariable messages
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

            Write-Verbose "$($messages.Connecting) $computer"

            try{
                $os     = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer -ErrorAction Stop
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
            catch{
                Write-Warning "$($messages.failed) $computer"
            }
        }
    } 
}

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
}#

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
                    'FreePercent'   =   "{0:N2}" -f ($disk.FreeSpace / $disk.size * 100 -as [int]);
                    'Collected'     =   (Get-Date)
                }
                $obj = New-Object -TypeName psobject -Property $props
                $obj.psobject.typenames.insert(0,'Report.OSTools.DiskDetails')
                Write-Output $obj
            }
        }
    }
} #

function Save-DiskDetailsToDatabase {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true
        )]
        [object[]]$inputobject
    )
    BEGIN {
        $connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
        $connection.ConnectionString = "Server=CRITHOS\SQLEXPRESS;Database=AdminData;Trusted_Connection=True;"
        $connection.Open() | Out-Null
    }
    PROCESS{
        $command = New-Object -TypeName System.Data.SqlClient.SqlCommand
        $command.Connection = $connection
        
        $sql = "DELETE FROM DiskData WHERE ComputerName = '$($inputobject.ComputerName)' AND DriveLetter = '$($inputobject.Drive)'"
        
        Write-Debug "Executing $sql"  
        $command.CommandText = $sql
        $command.ExecuteNonQuery() | Out-Null

        $sql = "INSERT INTO DiskData (
            ComputerName,
            DriveLetter,
            FreeSpace,
            Size,
            FreePercent
            )
            VALUES(
            '$($inputobject.computername)',
            '$($inputobject.Drive)',
            '$($inputobject.FreeSpace)',
            '$($inputobject.Size)',
            '$($inputobject.FreePercent)'
            )"
        Write-Debug "Executing $sql"
        
        $command.CommandText = $sql
        $command.ExecuteNonQuery() | Out-Null
    }
    END {
        $connection.Close()
    }
}

function Get-ComputerNamesForDiskDetailsFromDatabase {
    
    $connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = "Server=CRITHOS\SQLEXPRESS;Database=AdminData;Trusted_Connection=True;"
    $connection.Open() | Out-Null

    $command = New-Object -TypeName System.Data.SqlClient.SqlCommand
    $command.Connection = $connection
    
    $sql = "SELECT ComputerName FROM DiskData"
    Write-Debug "Executing $sql"
    $command.CommandText = $sql

    $reader = $command.ExecuteReader()

    while ($reader.read()) {
        $computername = $reader.GetSqlString(0).Value
        Write-Output $computername
    }


    $connection.Close()
}

function Set-ComputerState {
    [CmdletBinding(
        SupportsShouldProcess=$true,# Turns on Whatif 
        ConfirmImpact='High' # and confirm.
    )]
    param (
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true
        )]
        [string]$ComputerName,

        # Action
        [Parameter(
            Mandatory=$true
        )]
        [ValidateSet(
            'LogOff',
            'PowerOff',
            'Shutdown',
            'Restart'
        )]
        [string]$Action,

        [switch]$Force
    )

    PROCESS{
        foreach ($computer in $ComputerName) {
            
            switch ($Action) {
                'LogOff'    { $x = 0 }
                'Shutdown'  { $x = 1 }
                'Restart'   { $x = 2 }
                'PowerOff'  { $x = 8 }
            }
            if ($Force) {
                $x += 4
            }

            $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer -EnableAllPrivileges

            if ($pscmdlet.ShouldProcess("$Action $computer")) {
                $os.Win32Shutdown($x) | Out-Null
            }
        }
    }
}