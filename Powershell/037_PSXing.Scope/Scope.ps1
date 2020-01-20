Write-Host "x is $x"

$x = 200

Write-Host "IN the script, x is $x"

function Foo {
    Write-Host "In the function, x is $x"

    $x = 300

    Write-Host "Now, x is $x in the function"
}

Foo

Write-Host "At this point in the script, x is $x"

Set-Variable -Name z -Scope Global -Value 500
$Global:z = 500
