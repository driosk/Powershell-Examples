$name = Read-Host "Enter server name"
switch -regex ($name) {
        "DC" { 
            Write-Host "Is a domain controller" 
        }
        "FS" {
            Write-Host "Is a file server" 
        }
        "^NYC" {
            Write-Host "Is in New York" 
        }
        "^LON" {
            Write-Host "Is in London" 
        }
}


#In Regex * = 0 or more. 
# ^ is an anchor

if ($name -match "DC") {Write-Host "Is a domain controller"}
if ($name -match "FS") {Write-Host "Is a File Server"}
if ($name -match "^NYC") {Write-Host "Is in New York"}
if ($name -match "^LON") {Write-Host "Is in London"}