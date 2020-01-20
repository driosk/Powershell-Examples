[CmdletBinding(
    SupportsShouldProcess   = $true,
    ConfirmImpact           = "Low"
)]
param (
    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true
    )]
    [String]$FirstName,

    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true
    )]
    [String]$LastName,

    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true
    )]
    [String]$Department,

    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true
    )]
    [String]$Title,

    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true
    )]
    [String]$City,

    [Parameter(
        Mandatory=$true,
        ValueFromPipelineByPropertyName=$true
    )]
    [String]$PostalCode
)
BEGIN {
    $s = New-CimSession -ComputerName ILCSDSC
}

PROCESS {

    Write-Verbose "Creating user $FirstName.$LastName in AD"
    $adCommand = {
        param($FirstName,$LastName,$City,$PostalCode,$Title,$Department)
        New-ADUser  -SamAccountName "$FirstName.$LastName" `
                    -Name           "$FirstName.$LastName" `
                    -GivenName      "$FirstName" `
                    -Surname        "$LastName" `
                    -City           "$City" `
                    -Department     "$Department" `
                    -PostalCode     "$PostalCode" `
                    -Title          "$Title"
    }
    if ($pscmdlet.ShouldProcess("New user $FirstName.$LastName")) {
        Invoke-Command  -ScriptBlock $adCommand `
                        -ComputerName ILCSDC0 `
                        -ArgumentList $FirstName,$LastName,$City,$PostalCode,$Title,$Department `
                        -ConfigurationName EmployeeProvisioning
    }

    Write-Verbose "Creating $FirstName.$LastName folder"
    if ($pscmdlet.ShouldProcess("Folder for $Firstname.$LastName")) {
        New-Item -ItemType Directory -Path "\\ILCSDSC\C$\Shares\$Firstname.$LastName"
    }

    Write-Verbose "Sharing the folder with permissions"
    
    if ($pscmdlet.ShouldProcess("Share for $FirstName.$LastName")) {
        New-SmbShare    -Name "$FistName.$LastName" `
                        -Path "C:\Shares\$FirstName.$LastName" `
                        -FullAccess "CRIT\$FirstName.$LastName","CRIT\Administrators","DOMAIN\PersonelManagers" `
                        -CimSession $s
    }
}
END {
    Remove-CimSession -CimSession $s
}