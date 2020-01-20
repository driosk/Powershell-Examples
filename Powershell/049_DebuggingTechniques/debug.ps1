function Get-SystemInfo {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string[]]$ComputerName
    )
    PROCESS {
        foreach ($computer in $ComputerName) {
            $os     =   Get-WmiObject -Class Win32_OperatingSystem  -ComputerName   $computer
            $comp   =   Get-WmiObject -Class Win32_ComputerSystem   -ComputerName   $computer
            $proc   =   Get-WmiObject -Class Win32_Processor        -ComputerName   $computer
            $bios   =   Get-WmiObject -Class Win32_BIOS             -ComputerName   $computer
            if ($os.OSArchitecture -ne $proc.AddressWidth) {
                $optimal = $false
            }
            else {
                $optimal = $true
            }
            $props = @{
                ComputerName        =   $computer;
                OSVersion           =   $os.Version;
                SPVersion           =   $os.ServicePackMajorVersion;
                Mfgr                =   $comp.Manufacturer;
                Model               =   $comp.Model;
                OSArchitecture      =   $os.OSArchitecture;
                ProcArchitecture    =   $proc.AddressWidth;
                BIOSSerial          =   $bios.SerialNumber;
                OptimalArchitecture =   $optimal
            }
            New-Object -Type psobject -Property $props
        }
    }
}