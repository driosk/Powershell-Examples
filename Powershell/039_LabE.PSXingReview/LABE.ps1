<#
Get-WmiObject –Class Win32_OperatingSystem –ComputerName DC |
Select @{n='ComputerName';e={$_.__SERVER}},
       OSArchitecture
       
Get-WmiObject –Class Win32_Processor –ComputerName DC |
Select –First 1 –Property @{n='ProcArchitecture';
                            e={$_.AddressWidth}}
#>