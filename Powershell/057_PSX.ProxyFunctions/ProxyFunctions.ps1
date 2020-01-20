# Take an existing PS command and put a wrapper around it.

# ConverTTo-html and go to a file
# we'll make export-html that does both in one go.

# we'll take export-csv cmdlet. We'll take away the delimiter parameter.

$metadata = New-Object System.Management.Automation.CommandMetadata (Get-Command ConvertTo-Html)
[System.Management.Automation.ProxyCommand]::Create($metadata) | Out-File ConvertTo-Html.ps1

$metadata = New-Object System.Management.Automation.CommandMetadata (Get-Command ConvertTo-Csv)
[System.Management.Automation.ProxyCommand]::Create($metadata) | Out-File ConvertTo-Csv.ps1

<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\57_PSX.ProxyFunctions> [System.Management.Automation.ProxyCommand]

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     False    ProxyCommand                             System.Object
#>


[System.Management.Automation.ProxyCommand] | gm -Static


<#
ypeName: System.Management.Automation.ProxyCommand

Name                      MemberType Definition
----                      ---------- ----------
Create                    Method     static string Create(System.Management.Automation.CommandMetadata commandMetadata), static str...
Equals                    Method     static bool Equals(System.Object objA, System.Object objB)
GetBegin                  Method     static string GetBegin(System.Management.Automation.CommandMetadata commandMetadata)
GetCmdletBindingAttribute Method     static string GetCmdletBindingAttribute(System.Management.Automation.CommandMetadata commandMe...
GetDynamicParam           Method     static string GetDynamicParam(System.Management.Automation.CommandMetadata commandMetadata)
GetEnd                    Method     static string GetEnd(System.Management.Automation.CommandMetadata commandMetadata)
GetHelpComments           Method     static string GetHelpComments(psobject help)
GetParamBlock             Method     static string GetParamBlock(System.Management.Automation.CommandMetadata commandMetadata)
GetProcess                Method     static string GetProcess(System.Management.Automation.CommandMetadata commandMetadata)
ReferenceEquals           Method     static bool ReferenceEquals(System.Object objA, System.Object objB)
#>


# Accessing the original command you need to qualify it.

Get-Process | Microsoft.PowerShell.Utility\Export-Csv -Delimiter

# So it is not a security boundry but a convienience boundry.


# Using a constrained endpoint, you can only use the new command. Like with Powershell Remoting.