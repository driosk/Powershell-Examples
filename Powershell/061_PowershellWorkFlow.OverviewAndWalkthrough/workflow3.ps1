workflow MyComplicatedTask {
    param (
        [string]$folderpaths
    )
    foreach -parallel ($item in $folderpaths) {
        new-item -ItemType Directory -Name $folder
    }
    
    parallel {#Might not run in order.
        Get-Process
        Get-Service
        Get-EventLog -LogName Security -Newest 100
    }
    parallel {
        sequence {#This will.
            Get-Process
            Get-Service
            Get-EventLog -LogName Security -Newest 100
        }
        sequence {
            Get-ADComputer -Filter *
            Get-ADUser -Filter *
        }
    }

}

MyComplicatedTask -PSComputerName ILCSDC0,ILCSDC1 -folderpaths "C:\temp\One","C:\temp\three","C:\temp\three"