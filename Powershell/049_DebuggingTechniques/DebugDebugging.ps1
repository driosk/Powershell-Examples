function Get-SystemInfo {
    [CmdletBinding()] # if not here needs to set outside of func $debugpreference and $Verbosepreference = continue
    param (
        [Parameter()]
        [string[]]$ComputerName
    )
    PROCESS {
        foreach ($computer in $ComputerName) {
            Write-Verbose "Querying $computer"

            $os     =   Get-WmiObject -Class Win32_OperatingSystem  -ComputerName   $computer
            $comp   =   Get-WmiObject -Class Win32_ComputerSystem   -ComputerName   $computer
            $proc   =   Get-WmiObject -Class Win32_Processor        -ComputerName   $computer
            $bios   =   Get-WmiObject -Class Win32_BIOS             -ComputerName   $computer

            Write-Debug "Finished getting WMI Objects"

            if (($os.OSArchitecture -replace '-bit', '' ) -ne ([string]$proc.AddressWidth)) {
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
            $obj = New-Object -Type psobject -Property $props

            Write-Debug     "Produced Custom object"
            Write-Output    $obj
        }
    }
}
# if cmdlet binding you can run with debug and verbose parameters. 
Get-SystemInfo -ComputerName ILCSDC0,localhost -Verbose -Debug 

<# If you suspend
Get-SystemInfo -ComputerName ILCSDC0,localhost -Verbose -Debug 
VERBOSE: Querying ILCSDC0
DEBUG: Finished getting WMI Objects
PS C:\WINDOWS\system32>> ###this means I'm in my scripts Head. 
#>
$os 
<#
SystemDirectory : C:\Windows\system32
Organization    : 
BuildNumber     : 14393
RegisteredUser  : Windows User
SerialNumber    : 00377-10000-00000-AA360
Version         : 10.0.14393
#>
$os.OSArchitecture
#64-bit
$os.OSArchitecture -replace '-bit', ''
# 64
$os.OSArchitecture -replace '-bit', '' | gm
# TypeName: System.String
$proc.AddressWidth
# 64
$proc.AddressWidth | gm
# TypeName: System.UInt16
[string]$proc.AddressWidth | gm
# TypeName: System.String
# type exit then continue.

