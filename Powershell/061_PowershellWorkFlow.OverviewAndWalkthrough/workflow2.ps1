workflow MyComplicatedTask {
    param (
        [string]$foldername
    )

    $obj = New-Object -TypeName psobject # separate inline
    $obj | Add-Member -MemberType NoteProperty -Name Fred -Value 'Barney' #separate inline
    Write-Output -InputObject $obj # only thing ran by workflow. 
}

MyComplicatedTask

# whole thing gets wrapped in inline script. 

# can't checkpoint in inline script. 

#Things it can't do.

<#
Begin Process End

Only support try catch

Can't be interactive. 

Don't support comment based help. 
#>


<#
Things it can do. Paralelism. 

Computers recieve the workflow at the same time. 


#>