[CmdletBinding()]
param (
    [Parameter(
        Mandatory                       =$true,
        ValueFromPipeline               =$true,
        ValueFromPipelineByPropertyName =$true
    )]
    [string[]]$ComputerName,

    # Parameter help description
    [Parameter(
        Mandatory=$true
    )]
    [string]$OutputPath
)

BEGIN{
    if (Test-Path $outputpath) {
        #exists
    }
    else {
        mkdir $outputpath | Out-Null
    }
# This part is a here string.
$css = @"
    body {
        font-family:Tahoma;
        font-size:10pt;
        background-color:white;
        color:#333;
    }
    th {
        font-weight:bold;
        color:white;
        background-color:black;
    }
    h2 {
        cursor:pointer;
    }
    h2:hover {
        color:blue;
    }
    .even {
        background-color:#eee;
    }
    .odd {
        color:white;
        background-color:#666;
    }
    .paginate_disabled_previous,
    .paginate_disabled_next {
        padding:4px;
        color:#ddd;
    }
    .paginate_enabled_previous,
    .paginate_enabled_next {
        padding:4px;
        color:blue;
        cursor:pointer;
    }
"@
}

PROCESS{
    foreach ($computer in $ComputerName) {
        
    
        $frag1 =    Get-SystemDetails -ComputerName $computer |
                    ConvertTo-EnhancedHTMLFragment  -TableCssID SYSTABLE `
                                                    -DivCssID SYSDIV `
                                                    -DivCssClass WHATEVER `
                                                    -TableCssClass TABLEWHATEVER `
                                                    -As List `
                                                    -Properties * `
                                                    -MakeHiddenSection `
                                                    -PreContent '<h2>System Details</h2>' |
                    Out-String

        $frag2 =    Get-DiskDetails -ComputerName $computer |
                    ConvertTo-EnhancedHTMLFragment  -TableCssID DISKTABLE `
                                                    -DivCssID DISKDIV `
                                                    -DivCssClass WHATEVER `
                                                    -TableCssClass TABLEWHATEVER `
                                                    -As Table `
                                                    -Properties * `
                                                    -EvenRowCssClass 'even' `
                                                    -OddRowCssClass 'odd' `
                                                    -MakeHiddenSection `
                                                    -PreContent '<h2>Disk</h2>' |
                    Out-String

        $frag3 =    Get-Process -ComputerName $computer |
                    ConvertTo-EnhancedHTMLFragment  -TableCssID PROCTABLE `
                                                    -DivCssID PROCDIV `
                                                    -DivCssClass WHATEVER `
                                                    -TableCssClass TABLEWHATEVER `
                                                    -As Table `
                                                    -Properties Name,ID,VM,PM,WS,CPU `
                                                    -EvenRowCssClass 'even' `
                                                    -OddRowCssClass 'odd' `
                                                    -MakeHiddenSection `
                                                    -MakeTableDynamic `
                                                    -PreContent '<h2>Processes</h2>' |
                    Out-String
        $path = Join-Path -Path $outputpath -ChildPath "$computer.html"
        Write-Verbose "Writing report for $computer to $path"

        ConvertTo-EnhancedHTML  -HTMLFragments $frag1,$frag2,$frag3 `
                                -Title "System report for $computer.critsol.net" `
                                -PreContent "<h1>System report for $computer.critsol.net</h1>" `
                                -PostContent "<br/ ><br/ ><hr />Retreived $(Get-Date)" `
                                -CssStyleSheet $css |
                    Out-File $path
    }
}

END {}

