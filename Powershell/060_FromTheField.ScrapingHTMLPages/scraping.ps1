help Invoke-WebRequest -ShowWindow

$response = Invoke-WebRequest -Uri https://www.google.com/search?q=powershell+don+jones


$response.allelements.count

$response.allelements[2]

$response | gm

$response.links | ft innerhtml,href -AutoSize

$response.content -match "<span"

$Matches[0]
