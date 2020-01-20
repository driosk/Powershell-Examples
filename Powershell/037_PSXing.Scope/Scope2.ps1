# Set $z to 9 in console first. 
Write-Host "z is $z"

$Global:z = 500
$z = 200

Write-Host "In the script, z is $z"

function Foo {
    Write-Host "In the function, z is $z"

    $Script:z = 300

    Write-Host "Now, z is $z in the function"
}

Foo

Write-Host "At this point in the script, z is $z"

# Don't mess with other scopes. 

.\ParameterBlock.ps1 -my_z 500