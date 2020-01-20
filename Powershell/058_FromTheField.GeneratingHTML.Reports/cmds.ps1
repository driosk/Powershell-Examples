Get-SystemDetails -ComputerName ILCSDC0 | ConvertTo-Html | Out-File .\HTML\firstreport.html

# To fix -fragment parameter.

Get-SystemDetails -ComputerName ILCSDC0 |
ConvertTo-Html -PreContent '<h1>System</h1>' -Fragment |
Out-File .\HTML\firstreportFragment.html

# Instead to use the HTML fragment we assign it to a variable.
$frag1 = Get-SystemDetails -ComputerName ILCSDC0 |
ConvertTo-Html -PreContent '<h1>System</h1>' -Fragment |
Out-String  # Because it produces a string array and we want a collapsed string


$frag2 = Get-DiskDetails -Computer ILCSDC0 | ConvertTo-Html -PreContent '<h1>Disks</h1>' -Fragment |
Out-String

ConvertTo-Html -Body $frag1,$frag2 -Title "System Report" -PreContent '<h1>System Report</h1><hr />' |
Out-File report.html

ConvertTo-Html -Title "System Report" -PreContent '<h1>System Report</h1><hr />' -Body $frag1,$frag2 |
>> Out-File .\HTML\reportfragCorrected.html

<#
PS C:\Users\driosx.CRIT\Documents> help ConvertTo-EnhancedHTML
NAME
    ConvertTo-EnhancedHTML

SYNOPSIS
    Provides an enhanced version of the ConvertTo-HTML command that includes
    inserting an embedded CSS style sheet, JQuery, and JQuery Data Tables for
    interactivity. Intended to be used with HTML fragments that are produced
    by ConvertTo-EnhancedHTMLFragment. This command does not accept pipeline
    input.


SYNTAX
    ConvertTo-EnhancedHTML [-jQueryURI <String>] [-jQueryDataTableURI <String>] [-CssStyleSheet <String[]>] [-Title <String>] [-PreContent <String>] [-PostContent <String>] -HTMLFragments
    <String[]> [<CommonParameters>]

    ConvertTo-EnhancedHTML [-jQueryURI <String>] [-jQueryDataTableURI <String>] [-CssUri <String[]>] [-Title <String>] [-PreContent <String>] [-PostContent <String>] -HTMLFragments
    <String[]> [<CommonParameters>]


DESCRIPTION


RELATED LINKS

REMARKS
    To see the examples, type: "get-help ConvertTo-EnhancedHTML -examples".
    For more information, type: "get-help ConvertTo-EnhancedHTML -detailed".
    For technical information, type: "get-help ConvertTo-EnhancedHTML -full".
#>


<#
NAME
    ConvertTo-EnhancedHTMLFragment

SYNOPSIS
    Creates an HTML fragment (much like ConvertTo-HTML with the -Fragment switch
    that includes CSS class names for table rows, CSS class and ID names for the
    table, and wraps the table in a <DIV> tag that has a CSS class and ID name.


SYNTAX
    ConvertTo-EnhancedHTMLFragment [-InputObject] <Object[]> [[-EvenRowCssClass]# <String>] [[-OddRowCssClass]# <String>] [[-TableCssID] <String>] [[-DivCssID]# <String>]
    [[-DivCssClass] <String>] [[-TableCssClass]# <String>] [[-As] <String>] [[-Properties] <Object[]>] [[-PreContent] <String>] [-MakeHiddenSection] [-MakeTableDynamic]
    [[-PostContent] <String>] [<CommonParameters>]


DESCRIPTION


RELATED LINKS

REMARKS
    To see the examples, type: "get-help ConvertTo-EnhancedHTMLFragment -examples".
    For more information, type: "get-help ConvertTo-EnhancedHTMLFragment -detailed".
    For technical information, type: "get-help ConvertTo-EnhancedHTMLFragment -full".
#>

Get-SystemDetails -ComputerName ILCSDC0 | ConvertTo-EnhancedHTMLFragment -TableCssID SYSTABLE -DivCssID SYSDIV `
-DivCssClass WHATEVER -TableCssClass TABLEWHATEVER -As List -Properties * -PreContent '<h2>System Details</h2>' `
-PostContent "Retrieved $(Get-Date)"

<#
<h2>System Details</h2>
<div  class="WHATEVER" id="SYSDIV">
<table class="TABLEWHATEVER"id="SYSTABLE"><tr><td>Host :</td><td>ILCSDC0</td></tr><tr><td>BIOSSerial :</td><td></td></tr><tr><td>ComputerName :</td><td>ILCSDC0</td></tr><tr><td>Manufacturer :</td><td>QEMU</td></tr><tr><td>Model :</td><td>Standard PC (i440FX + PIIX, 1996)</td></tr><tr><td>OSBuild :</td><td>14393</td></tr><tr><td>OSVersion :</td><td>10.0.14393</td></tr><tr><td>SPVersion :</td><td>0</td></tr><tr><td>NormalizedBIOSSerial :</td><td></td></tr>
Retrieved 12/09/2019 14:19:46</tbody></table>
</div>

#>


$frag1 =    Get-SystemDetails -ComputerName ILCSDC0 |
            ConvertTo-EnhancedHTMLFragment  -TableCssID SYSTABLE `
                                            -DivCssID SYSDIV `
                                            -DivCssClass WHATEVER `
                                            -TableCssClass TABLEWHATEVER `
                                            -As List `
                                            -Properties * `
                                            -PreContent '<h2>System Details</h2>' |
            Out-String

$frag2 =    Get-SystemDetails -ComputerName ILCSDC0 |
            ConvertTo-EnhancedHTMLFragment  -TableCssID DISKTABLE `
                                            -DivCssID DISKDIV `
                                            -DivCssClass WHATEVER `
                                            -TableCssClass TABLEWHATEVER `
                                            -As Table `
                                            -Properties * `
                                            -EvenRowCssClass 'even' `
                                            -OddRowCssClass 'odd' `
                                            -PreContent '<h2>Disk</h2>' |
            Out-String


Send-MailMessage -Body (Get-Content report.html) -BodyAsHtml -To 'dougrios@critsol.net'

