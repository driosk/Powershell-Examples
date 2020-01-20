$message = ""
$continue = $true
do {
    Write-Host  "============================================================"
    Write-Host  "                      SUPPORT MENU                          "
    Write-Host  "============================================================"
    if ($message -ne ""){
        Write-Host $message
        Write-Host ""
    }
    Write-Host  "1. Get Sytem Details"
    Write-Host  "2. Get disk information"
    Write-Host  "3. Change Computer State"
    Write-Host  "(Specify: LogOff, Restart, Shutdown, or PowerOff for Action)"
    Write-Host  "X. Quit Menu"
    Write-Host  ""
    $choice = Read-Host "Select Activity"

    switch($choice){
        1       { Get-SystemDetails         }
        2       { Get-DiskDetails           }
        3       { Set-ComputerState -Confirm}
       'X'      { $continue = $false        }
        default { $message = "Unknown choice, try again!" }
    }
    Read-Host "Hit any key to continue"
    Clear-Host
}
while ($continue)

Write-Host "Exited Menu. Have a nice day."