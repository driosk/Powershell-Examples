$CorpUserContainerPreference = ''
function New-CorpUser {
    [CmdletBinding(
        SupportsShouldProcess   =   $true,
        ConfirmImpact           =   'Medium'
    )]
    param (
        [Parameter(
            Mandatory                       =   $true,
            ValueFromPipelineByPropertyName =   $true
        )]
        [string]$FirstName,

        [Parameter(
            Mandatory                       =   $true,
            ValueFromPipelineByPropertyName =   $true
        )]
        [string]$LastName,

        [Parameter(
            Mandatory                       =   $true,
            ValueFromPipelineByPropertyName =   $true
        )]
        [string]$Department,

        [Parameter(
            Mandatory                       =   $true,
            ValueFromPipelineByPropertyName =   $true
        )]
        [string]$City,

        [Parameter(
            Mandatory                       =   $true,
            ValueFromPipelineByPropertyName =   $true
        )]
        [string]$PostalCode

    )
    
    PROCESS {
        $logon = "$FirstName.$LastName"

        $params = @{
            'GivenName'     =$FirstName;
            'SurName'       =$LastName;
            'SamAccountName'=$logon;
            'Name'          =$logon;
            'Department'    =$Department;
            'City'          =$City;
            'PostalCode'    =$PostalCode
        }
        if ($CorpUserContainerPreference -eq '') {
            New-ADUser @params
        }
        else {
            New-ADUser @params -Path $CorpUserContainerPreference
        }       
    }
}

Export-ModuleMember -Function New-CorpUser -Variable CorpUserContainerPreference