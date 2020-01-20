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
        
        $sql = "DELETE FROM DiskData WHERE ComputerName = '$($inputobject.ComputerName)' AND DriveLetter = '$($inputobject.drive)'"
        Write-Debug "Executing $sql"

        
        $command.CommandText = $sql
        #$reader = $command.ExecuteReader() #returns sqldatareader object
        $reader = $command.ExecuteNonQuery() | Out-Null

        $sql = "INSERT INTO DiskData (
            ComputerName,
            DriveLetter,
            FreeSpace,
            Size,
            FreePercent
            )
            VALUES(
            '$($inputobject.computername)',
            '$($inputobject.drive)',
            '$($inputobject.freespace)',
            '$($inputobject.size)',
            '$($inputobject.freepercent)'
            )"
        Write-Debug "Executing $sql"
        
        $command.CommandText = $sql
        $reader = $command.ExecuteNonQuery() | Out-Null
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

New-Object -TypeName System.Data.OleDb.OleDbConnection # If a different database. Make the type to match. 