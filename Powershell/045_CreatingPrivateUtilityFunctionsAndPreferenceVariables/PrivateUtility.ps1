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
            if (Test-Connection -ComputerName $computer -Quiet) {
                $works = $true
                try {
                    Get-WmiObject -Class Win32_BIOS -ErrorAction Stop -ComputerName $ComputerName
                } catch {
                    $works = $false
                }
            }
            if ($works) {
                $os = Get-WmiObject -ComputerName $computer -Class Win32_OperatingSystem
                if ($LogOff)    { $arg = 0 }
                if ($Restart)   { $arg = 2 }
                if ($Shutdown)  { $arg = 1 }
                if ($PowerOff)  { $arg = 8 }
                if ($Force)     {$arg += 4}
                $os.Win32Shutdown($arg)
            }
        }
    }
}