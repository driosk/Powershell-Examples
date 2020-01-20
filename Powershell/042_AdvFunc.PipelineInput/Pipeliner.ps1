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
        [string]$DriveType = 'Local'
    )
    BEGIN { }
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
            Get-WmiObject @params |
            Select-Object   @{name = 'Drive'; expression = { $_.DeviceID } },
            @{name = 'Size(GB)'; expression = { $_.Size / 1GB -as [int] } },
            @{name = 'FreeSpace(GB)'; expression = { $_.FreeSpace / 1GB -as [int] } },
            @{name = 'FreePercent'; expression = { ($_.FreeSpace / $_.Size).tostring("P") } },
            PSComputerName
                
        }
    }
    END { }
}