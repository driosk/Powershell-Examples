<#
switch ($x) {
    condition {  }
    Default {}
}
#>

# help about_Switch

$disk = Get-WmiObject -Class Win32_LogicalDisk | select -First

switch ($disk.DriveType) {
    2 { Write-Host "Floppy" }
    3 { Write-Host "Fixed" }
    5 { Write-Host "Optical" }
    Default { write-host "Dunno" }
}
<#
switch -Wildcard ($name) {
>>     "*DC*" { Write-Host "Is a domain controller" }
>>     "*FS*" { Write-Host "Is a file server" }
>>     "*NYC*" { Write-Host "Is in New York" }
>>     "*LON*" { Write-Host "Is in London" }
#>
$name = Read-Host "Enter server name"
switch -Wildcard ($name) {
    "*DC*" { 
        Write-Host "Is a domain controller"
        break
    }
    "*FS*" {
        Write-Host "Is a file server"
        break
    }
    "*NYC*" {
        Write-Host "Is in New York" 
        break
    }
    "*LON*" {
        Write-Host "Is in London"
        break
    }
}

# LON-FS-02