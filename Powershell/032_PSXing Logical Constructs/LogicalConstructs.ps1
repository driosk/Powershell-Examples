# powershell is not a scripting language but it has a scripting language.
# it does have logical constructs. 

# if () {}

$procs = Get-Process

if ($procs.count -gt 200) {
    Write-Host "You have a lot of processes"
}   elseif ($procs.count -lt 5) {
    Write-Host "Very few processes!"
}   elseif ($procs[0].Name -like 'a*') {
    Write-Host "The first process starts with A"
}   else {
    Write-Host "Less than 100 processes!"
}