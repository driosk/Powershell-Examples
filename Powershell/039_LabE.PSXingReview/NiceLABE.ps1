param(
    [string[]]$ComputerName = 'localhost'
)
foreach ($Computer in $ComputerName) {
    $os =  Get-WmiObject –Class Win32_OperatingSystem –ComputerName $Computer

    $proc = Get-WmiObject –Class Win32_Processor –ComputerName $Computer |
    Select-Object –First 1

    $props = [ordered]@{
        'ComputerName'    = $Computer;
        'OSArchitecture'  = $os.OSArchitecture;
        'ProcArchitecture'= $proc.AddressWidth
    }
    New-Object -TypeName psobject -Property $props
}