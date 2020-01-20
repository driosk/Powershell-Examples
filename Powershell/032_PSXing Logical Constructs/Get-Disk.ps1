Get-WmiObject -Class Win32_LogicalDisk |
ForEach-Object {
    $disk = $_
    if ($disk.DriveType -eq 2) {
        Write-Host "Drive is floppy"
    }
    elseif ($disk.DriveType -eq 3) {
        Write-Host "There is a fixed drive"
    }
    elseif ($disk.DriveType -eq 5) {
        Write-Host "There is an Optical Disk"
    }
    else {
        Write-Host "Dunno what drive that is"
    }
}