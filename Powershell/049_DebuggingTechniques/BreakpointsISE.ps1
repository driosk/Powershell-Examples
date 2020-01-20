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
# if it changes or relys on anything insert breakpoint.

Get-SystemInfo -ComputerName localhost
<#
get-command -noun psbre*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Disable-PSBreakpoint                               3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Enable-PSBreakpoint                                3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Get-PSBreakpoint                                   3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Remove-PSBreakpoint                                3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Set-PSBreakpoint                                   3.1.0.0    Microsoft.PowerShell.Utility


#>
<#
Set-PSBreakpoint -Script .\BrakPointsISE.ps1 -Variable obj -Mode ReadWrite

ID Script                       Line Command                      Variable                     Action
  -- ------                       ---- -------                      --------                     ------
   3 Get-SystemInfoDebug.ps1                                        obj
#>

# Hit Variable breakpoint on 'C:\Users\driosx.CRIT\Documents\Get-SystemInfoDebug.ps1:$obj' (ReadWrite access)

help Set-PSBreakpoint -ShowWindow

Set-PSBreakpoint -Script .\Get-SystemInfoDebug.ps1 -Command 'Get-WmiObject' -Action {"$computer" | Out-File debug.txt -Append}

<#
ID Script                       Line Command                      Variable                     Action
  -- ------                       ---- -------                      --------                     ------
   4 Get-SystemInfoDebug.ps1           Get-WmiObject                                             "$computer" | Out-File d...
#>
gc debug.txt
<#
PS C:\Users\driosx.CRIT\Documents> gc .\debug.txt
localhost
localhost
localhost
localhost
#>

# Using it while running a script on a server at night. You can setup breakpoints to log to file.

# only works on a script in the console. Otherwise you need to set breakpoints in the script itself.
