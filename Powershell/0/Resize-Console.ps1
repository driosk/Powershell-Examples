Function Resize-Console {
    <#  .Synopsis Resize PowerShell console window .Description Resize PowerShell console window. Make it bigger, smaller or increase / reduce the width and height by a specified number 
        .Parameter -Bigger Increase the window’s both width and height by 10. .Parameter -Smaller Reduce the window’s both width and height by 10. 
        .Parameter Width Resize the window’s width by passing in an integer. 
        .Parameter Height Resize the window’s height by passing in an integer. 
        .Example # Make the window bigger. Resize-Console -bigger 
        .Example # Make the window smaller. Resize-Console -smaller 
        .Example # Increase the width by 15. Resize-Console -Width 15 
        .Example # Reduce the Height by 10. Resize-Console -Height -10 
        .Example # Reduce the Width by 5 and Increase Height by 10. Resize-Console -Width -5 -Height 10 #>

    [CmdletBinding()]
    PARAM (
        [Parameter(Mandatory = $false, HelpMessage = "Increase Width and Height by 10")][Switch] $Bigger,
        [Parameter(Mandatory = $false, HelpMessage = "Reduce Width and Height by 10")][Switch] $Smaller,
        [Parameter(Mandatory = $false, HelpMessage = "Increase / Reduce Width" )][Int32] $Width,
        [Parameter(Mandatory = $false, HelpMessage = "Increase / Reduce Height" )][Int32] $Height
    )

    #Get Current Buffer Size and Window Size
    $bufferSize = $Host.UI.RawUI.BufferSize
    $WindowSize = $host.UI.RawUI.WindowSize
    If ($Bigger -and $Smaller) {
        Write-Error "Please make up your mind, you can’t go bigger and smaller at the same time!"
    }
    else {
        if ($Bigger) {
            $NewWindowWidth = $WindowSize.Width + 10
            $NewWindowHeight = $WindowSize.Height + 10

            #Buffer size cannot be smaller than Window size
            If ($bufferSize.Width -lt $NewWindowWidth) {
                $bufferSize.Width = $NewWindowWidth
            }
            if ($bufferSize.Height -lt $NewWindowHeight) {
                $bufferSize.Height = $NewWindowHeight
            }
            $WindowSize.Width = $NewWindowWidth
            $WindowSize.Height = $NewWindowHeight

        }
        elseif ($Smaller) {
            $NewWindowWidth = $WindowSize.Width - 10
            $NewWindowHeight = $WindowSize.Height - 10
            $WindowSize.Width = $NewWindowWidth
            $WindowSize.Height = $NewWindowHeight
        }

        if ($Width) {
            #Resize Width
            $NewWindowWidth = $WindowSize.Width + $Width
            If ($bufferSize.Width -lt $NewWindowWidth) {
                $bufferSize.Width = $NewWindowWidth
            }
            $WindowSize.Width = $NewWindowWidth
        }
        if ($Height) {
            #Resize Height
            $NewWindowHeight = $WindowSize.Height + $Height
            If ($bufferSize.Height -lt $NewWindowHeight) {
                $bufferSize.Height = $NewWindowHeight
            }
            $WindowSize.Height = $NewWindowHeight

        }
        #commit resize
        $host.UI.RawUI.BufferSize = $buffersize
        $host.UI.RawUI.WindowSize = $WindowSize
    }

}