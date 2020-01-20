# +-/*

5 -eq 5
5 -ne 10
5 -gt 3
3 -lt 10
5 -ge 5
5 -le 10
"hello" -like "*L*"

Get-Service | Where-Object -FilterScript {<#true or false#>}

Get-Service | Where-Object -FilterScript { $_.Status -eq 'Running'}

Get-Service | Where-Object -FilterScript { $_.Status -eq 'Running' -and $_.Name -like 's*'} | Format-Wide
Get-Service | Where-Object -FilterScript { $_.Status -eq 'Running' -and $_.Name -like 's*'} | Format-Wide

Get-Service | ? {$_.Status -eq 'Running' -and $_.Name -like 's*'}
gsv | ? {$_.Status -eq 'Running' -and $_.Name -like 's*'}

Get-Process | ? { $_.Responding }
Get-Process | ? { -not $_.Responding }

Get-Service | ? {$_.Status -eq 'Running'}
Get-Service | where 'Status' -eq 'Running' # can only do one comparison
Get-Service | ? {}

help get-service -Full

Get-Service -Name s*

help get-aduser -Full

Get-ADUser -Filter {samaccountname -eq 'drios'}

Get-Service | where {$_.Status -eq 'running'}
(get-service).where({$_.Status -eq 'running'})
(Get-Service) | gm


