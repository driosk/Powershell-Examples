function Export-CSV {
    [CmdletBinding(DefaultParameterSetName='Delimiter', HelpUri='https://go.microsoft.com/fwlink/?LinkID=135203', RemotingCapability='None')]
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [psobject]
        ${InputObject},

        [Parameter(ParameterSetName='UseCulture')]
        [switch]
        ${UseCulture},

        [Alias('NTI')]
        [switch]
        ${NoTypeInformation})

    begin
    {
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
            {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertTo-Csv', [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = {& $wrappedCmd @PSBoundParameters }
            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            throw
        }
    }

    process
    {
        try {
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }

    end
    {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }
    <#

    .ForwardHelpTargetName Microsoft.PowerShell.Utility\ConvertTo-Csv
    .ForwardHelpCategory Cmdlet

    #>
}

function Export-HTML {
    [CmdletBinding(DefaultParameterSetName='Page', HelpUri='https://go.microsoft.com/fwlink/?LinkID=113290', RemotingCapability='None')]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [psobject]
        ${InputObject},

        [Parameter(Position=0)]
        [System.Object[]]
        ${Property},

        # Ouput to File Param Path
        [Parameter(Mandatory=$true)]
        [string]
        $Path,

        [Parameter(ParameterSetName='Page', Position=3)]
        [string[]]
        ${Body},

        [Parameter(ParameterSetName='Page', Position=1)]
        [string[]]
        ${Head},

        [Parameter(ParameterSetName='Page', Position=2)]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Title},

        [ValidateNotNullOrEmpty()]
        [ValidateSet('Table','List')]
        [string]
        ${As},

        [Parameter(ParameterSetName='Page')]
        [Alias('cu','uri')]
        [ValidateNotNullOrEmpty()]
        [uri]
        ${CssUri},

        [Parameter(ParameterSetName='Fragment')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${Fragment},

        [ValidateNotNullOrEmpty()]
        [string[]]
        ${PostContent},

        [ValidateNotNullOrEmpty()]
        [string[]]
        ${PreContent})

    begin
    {
        $_path = $Path
        $PSBoundParameters.Remove('Path') | Out-Null # don't send added parameter to original ConverTo-Html. Returns True, Pipe to Out-Null
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
            {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\ConvertTo-Html', [System.Management.Automation.CommandTypes]::Cmdlet)
            $scriptCmd = {& $wrappedCmd @PSBoundParameters | Out-File -FilePath $_path } # Changing to pipe out to file.
            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            throw
        }
    }

    process
    {
        try {
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }

    end
    {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }
    <#

    .ForwardHelpTargetName Microsoft.PowerShell.Utility\ConvertTo-Html
    .ForwardHelpCategory Cmdlet

    #>


}