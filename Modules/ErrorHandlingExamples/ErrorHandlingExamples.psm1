$ExampleDriveTypePreference = 'Local'
$ExampleErrorLogFile = 'C:\Errors.txt'
function Get-DiskSpaceInfo {
    <#
    .SYNOPSIS
        Retrieve basic disk capacity information from
        one or more computers.
    .DESCRIPTION
        See the synopsis. This isn't complex. Note that
        this command uses WMI, not CIM, to connect to
        remote computers. It does not allow you to
        specify alternate credentials.
    .PARAMETER ComputerName
        One or more computer names, or IP addresses, to query.
        For Example:
            Get-DiskSpaceInfo -ComputerName ONE,TWO,THREE
    .PARAMETER LocalOnly
        Specify this to include only local disks in the output.
        This is on by default. 
        To turn it off:
            Get-DiskSpaceInfo -ComputerName CLIENT -LocalOnly:$False
    .EXAMPLE
        Get-DiskSpaceInfo -ComputerName ONE,TWO
        This example retrieves disk space info from computers
        ONE and TWO.
    .EXAMPLE
        Get-DiskSpaceInfo -ComputerName 192.168.4.4
        This example retrieves disk space info from a computer
        that is specified by IP address.
    .LINK 
        http://bing.com
    .LINK
        Get-Content 
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
            Mandatory = $true,
            Position = 1,
            HelpMessage = 'Computer name to query',
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true
        )]
        [Alias('hostname')]
        [Alias('Name')]
        #[ValidateCount(1,3)]
        #[ValidatePattern('\w.critsol\.net')]
        #[ValidateLength(1,40)]
        [string[]]$ComputerName,

        [Parameter(
            Position = 2,
            ValueFromPipelineByPropertyName=$true
            )]
        [ValidateSet('Floppy','Local','Optical')]
        [string]$DriveType = $ExampleDriveTypePreference,
        
        [string]$ErrorLogFile = $ExampleErrorLogFile
    )
    BEGIN {
        Remove-Item -Path $ErrorLogFile -ErrorAction SilentlyContinue
     }
    PROCESS {
        foreach ($computer in $ComputerName) {
                $params = @{
                    'ComputerName' = $computer;
                    'Class'        = 'Win32_LogicalDisk'
                }
                switch ($DriveType) {
                'Local'  {$params.add('Filter', 'DriveType=3'); break}
                'Floppy' {$params.add('Filter', 'DriveType=2'); break}
                'Optical'{$params.add('Filter', 'DriveType=5'); break}
                }
                try{
                Get-WmiObject @params -EA Stop -ErrorVariable myerr |
                Select-Object   @{n = 'Drive';          e = { $_.DeviceID } },
                                @{n = 'Size(GB)';       e = { $_.Size / 1GB -as [int] } },
                                @{n = 'FreeSpace(GB)';  e = { $_.FreeSpace / 1GB -as [int] } },
                                @{n = 'FreePercent';    e = { ($_.FreeSpace / $_.Size).tostring("P") } },
                                PSComputerName
                }
                catch {
                    $computer | Out-File $ErrorLogFile -Append
                    Write-Verbose "Failed to connect to $computer; error is $myerr"
                }
        }
    }
    END { }
}

function Set-ComputerState {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [string[]]$ComputerName,

        [switch]$Force,

        [Parameter(ParameterSetName = 'Logoff')]
        [switch]$LogOff,

        [Parameter(ParameterSetName = 'Restart')]
        [switch]$Restart,

        [Parameter(ParameterSetName = 'Shutdown')]
        [switch]$Shutdown,

        [Parameter(ParameterSetName = 'PowerOff')]
        [switch]$PowerOff
    )
   
    PROCESS {
        foreach ($computer in $ComputerName) {
            if (check $computer) {
                $os = Get-WmiObject -ComputerName $computer -Class Win32_OperatingSystem
                if ($LogOff)    { $arg = 0  }
                if ($Restart)   { $arg = 2  }
                if ($Shutdown)  { $arg = 1  }
                if ($PowerOff)  { $arg = 8  }
                if ($Force)     { $arg += 4 }
                try {
                    $ErrorActionPreference = 'Stop'
                    $os.Win32Shutdown($arg)
                    $ErrorActionPreference = 'Continue'
                }
                catch {
                    
                }
            }
        }
    }
}

function check($computer) {
    $works = $true

    if (Test-Connection $computer -Quiet -Count 2) {
        try {
            gwmi Win32_BIOS -ComputerName $computer -ea Stop | Out-Null
        }
        catch {
            $works = $false
        }
    }
    else {
        $works = $false
    }
    return $works
}
Export-ModuleMember -Variable ExampleDriveTypePreference,ExampleErrorLogFile `
-Function Get-DiskSpaceInfo,Set-ComputerState