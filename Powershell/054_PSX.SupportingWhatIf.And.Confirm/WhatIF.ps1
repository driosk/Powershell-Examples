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