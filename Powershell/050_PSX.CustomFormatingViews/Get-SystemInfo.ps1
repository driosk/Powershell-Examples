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
            $obj.psobject.typename.insert(0,'My.Awesome.System.Info')

            Write-Debug     "Produced Custom object"
            Write-Output    $obj
        }
    }
}
Get-SystemInfo -ComputerName ILCSDC0,ILCSDC1

<#
Table to make. 

Computername
SPVersion
OSVersion
OptimalArchitecture 

So 4 columns. 
Need a unique typename. 
#>

# Update-FormatData -AppendPath C:\MyView.Format.ps1.xml

<#
Computer  SPVer OSVer      ArchMatch?
--------  ----- -----      ----------
localhost 0     10.0.18363 True
ILCSWS007 1     6.1.7601   True
ILCSDC0   0     10.0.14393 True
ILCSDC1   0     10.0.14393 True
ILCSRCA   0     10.0.17763 True
ILCSICA   0     10.0.17763 True
CS-WSUS   0     10.0.14393 True
CS-RAS    0     10.0.17763 True
#>