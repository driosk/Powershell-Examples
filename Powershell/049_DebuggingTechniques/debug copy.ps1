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

Get-SystemInfo -ComputerName ILCSDC0,localhost

<#
OptimalArchitecture : False -----wrong because comparing the wrong things.
ComputerName        : ILCSDC0
OSVersion           : 10.0.14393
ProcArchitecture    : 64  ------this 
SPVersion           : 0
OSArchitecture      : 64-bit -------compared to this is not the same thing. 
Model               : Standard PC (i440FX + PIIX, 1996)
BIOSSerial          :
Mfgr                : QEMU

OptimalArchitecture : False
ComputerName        : localhost
OSVersion           : 10.0.18363
ProcArchitecture    : 64
SPVersion           : 0
OSArchitecture      : 64-bit
Model               : Virtual Machine
BIOSSerial          : 2296-6916-3248-0804-6177-1356-99
Mfgr                : Microsoft Corporation
#>