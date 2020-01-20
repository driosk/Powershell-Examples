# WWF you have activities. 
#  psworkflow and psworkflow utility

workflow MyComplicatedTask {
    param (
        [string]$foldername
    )

    $myvar = 5

    Write-Output -InputObject "Myvar is $myvar"

    $myvar += 5

    Write-Output -InputObject "Myvar is $myvar"
    
    InlineScript {
        $myvar += 100
        Write-Output -InputObject "In the inline myvar is $myvar"
    }

    Write-Output -InputObject "After the inline myvar is $myvar"
}

MyComplicatedTask



<#
$PSComputerName when run they'll provide values to -PSComputerName parameter. 

MyComplicatedTask -PSComputerName ILCSDC0

Workflow will send instruction to both computers. 

$PSCredential -PSCredential

$PSPersist -PSPersist

$PSParameterCollection

lets you set unique parameters for each computer. 

Saves when you set variables. 

help about_checkpoint-workflow

Saves the state and data. 
#>

Get-PSSessionConfiguration

