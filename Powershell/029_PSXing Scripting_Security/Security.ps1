# ps1 files don't run when doubleclicking file.

<#
sample.ps1 : The term 'sample.ps1' is not recognized as the name of a cmdlet, function, script file, or operable 
program. Check the spelling of the name, or if a path was included, verify that the path is correct and try 
again.
At line:1 char:1
+ sample.ps1
+ ~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (sample.ps1:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
 

Suggestion [3,General]: The command sample.ps1 was not found, but does exist in the current location. 
Windows PowerShell does not load commands from the current location by default. If you trust this command, 
instead type: ".\sample.ps1". See "get-help about_Command_Precedence" for more details.
#>

# if no path, then cmd is loaded into memory. 

Get-ExecutionPolicy

help Set-AuthenticodeSignature

<#
Set-AuthenticodeSignature [-Certificate] <X509Certificate2> [-Confirm] -Content <Byte[]> [-Force]
    [-HashAlgorithm <String>] [-IncludeChain {signer | notroot | all}] -SourcePathOrExtension <String[]>
    [-TimestampServer <String>] [-WhatIf] [<CommonParameters>]

  # Set-AuthenticodeSignature [-FilePath] <String[]> [-Certificate] <X509Certificate2> [-Confirm] [-Force]        
    [-HashAlgorithm <String>] [-IncludeChain {signer | notroot | all}] [-TimestampServer <String>] [-WhatIf]      
    [<CommonParameters>]

    Set-AuthenticodeSignature [-Certificate] <X509Certificate2> [-Confirm] [-Force] [-HashAlgorithm <String>]     
    [-IncludeChain {signer | notroot | all}] -LiteralPath <String[]> [-TimestampServer <String>] [-WhatIf]        
    [<CommonParameters>]
#>

Set-AuthenticodeSignature -FilePath .\security.ps1 -Certificate cert.cer 

Get-AuthenticodeSignature C:\windows\system32\WindowsPowerShell\v1.0\DotNetTypes.format.ps1xml
<#
Directory: C:\windows\system32\WindowsPowerShell\v1.0


SignerCertificate                         Status                              Path
-----------------                         ------                              ----
FF82BC38E1DA5E596DF374C53E3617F7EDA36B06  Valid                               DotNetTypes.format.ps1xml
#>

Get-ExecutionPolicy # Default was restricted
# server r2 and later RemoteSigned. Local will run. Downloaded needs a signature. 

# All signed needs a signature. 

# Urestriced runs everything but remote will produce warning. 

# Bypass is for developers calling powershell. 

cmd
<#
PowerShell[.exe] [-PSConsoleFile <file> | -Version <version>]
    [-NoLogo] [-NoExit] [-Sta] [-Mta] [-NoProfile] [-NonInteractive]
    [-InputFormat {Text | XML}] [-OutputFormat {Text | XML}]
    [-WindowStyle <style>] [-EncodedCommand <Base64EncodedCommand>]
    [-ConfigurationName <string>]
    [-File <filePath> <args>] [-ExecutionPolicy <ExecutionPolicy>]
    [-Command { - | <script-block> [-args <arg-array>]
                  | <string> [<CommandParameters>] } ]

PowerShell[.exe] -Help | -? | /?

-PSConsoleFile
    Loads the specified Windows PowerShell console file. To create a console
    file, use Export-Console in Windows PowerShell.

-Version
    Starts the specified version of Windows PowerShell.
    Enter a version number with the parameter, such as "-version 2.0".

-NoLogo
    Hides the copyright banner at startup.

-NoExit
    Does not exit after running startup commands.

-Sta
    Starts the shell using a single-threaded apartment.
    Single-threaded apartment (STA) is the default.

-Mta
    Start the shell using a multithreaded apartment.

-NoProfile
    Does not load the Windows PowerShell profile.

-NonInteractive
    Does not present an interactive prompt to the user.

-InputFormat
    Describes the format of data sent to Windows PowerShell. Valid values are
    "Text" (text strings) or "XML" (serialized CLIXML format).

-OutputFormat
    Determines how output from Windows PowerShell is formatted. Valid values
    are "Text" (text strings) or "XML" (serialized CLIXML format).

-WindowStyle
    Sets the window style to Normal, Minimized, Maximized or Hidden.

-EncodedCommand
    Accepts a base-64-encoded string version of a command. Use this parameter
    to submit commands to Windows PowerShell that require complex quotation
    marks or curly braces.

-ConfigurationName
    Specifies a configuration endpoint in which Windows PowerShell is run.
    This can be any endpoint registered on the local machine including the
    default Windows PowerShell remoting endpoints or a custom endpoint having
    specific user role capabilities.

-File
    Runs the specified script in the local scope ("dot-sourced"), so that the
    functions and variables that the script creates are available in the
    current session. Enter the script file path and any parameters.
    File must be the last parameter in the command, because all characters
    typed after the File parameter name are interpreted
    as the script file path followed by the script parameters.

-ExecutionPolicy
    Sets the default execution policy for the current session and saves it
    in the $env:PSExecutionPolicyPreference environment variable.
    This parameter does not change the Windows PowerShell execution policy
    that is set in the registry.

-Command
    Executes the specified commands (and any parameters) as though they were
    typed at the Windows PowerShell command prompt, and then exits, unless
    NoExit is specified. The value of Command can be "-", a string. or a
    script block.

    If the value of Command is "-", the command text is read from standard
    input.

    If the value of Command is a script block, the script block must be enclosed
    in braces ({}). You can specify a script block only when running PowerShell.exe
    in Windows PowerShell. The results of the script block are returned to the
    parent shell as deserialized XML objects, not live objects.

    If the value of Command is a string, Command must be the last parameter
    in the command , because any characters typed after the command are
    interpreted as the command arguments.

    To write a string that runs a Windows PowerShell command, use the format:
        "& {<command>}"
    where the quotation marks indicate a string and the invoke operator (&)
    causes the command to be executed.

-Help, -?, /?
    Shows this message. If you are typing a PowerShell.exe command in Windows
    PowerShell, prepend the command parameters with a hyphen (-), not a forward
    slash (/). You can use either a hyphen or forward slash in Cmd.exe.

EXAMPLES
    PowerShell -PSConsoleFile SqlSnapIn.Psc1
    PowerShell -version 2.0 -NoLogo -InputFormat text -OutputFormat XML
    PowerShell -ConfigurationName AdminRoles
    PowerShell -Command {Get-EventLog -LogName security}
    PowerShell -Command "& {Get-EventLog -LogName security}"

    # To use the -EncodedCommand parameter:
    $command = 'dir "c:\program files" '
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
    $encodedCommand = [Convert]::ToBase64String($bytes)
    powershell.exe -encodedCommand $encodedCommand
#>

powershell.exe

# Give those certs to administrators pass them to sign
# script and put it into production for change management.



