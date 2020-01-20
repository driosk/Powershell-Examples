<#
get-content : Cannot find path 'C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\46_AddingErr
orCapturingAndHandling.to.a.Function\doesnot.txt' because it does not exist.
At line:1 char:1
+ get-content doesnot.txt
+ ~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (C:\Users\drios....ion\doesnot.txt:String) [Get-Content], Ite
   mNotFoundException
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand
#>

$error[0] #Latest error
$error[0].CategoryInfo

<#
Category   : ObjectNotFound
Activity   : Get-Content
Reason     : ItemNotFoundException
TargetName : C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\46_AddingErrorCapturingAndHandling.to.a.Function\doesnot.txt
TargetType : String
#>

$error[0].InvocationInfo

<#

MyCommand             : Get-Content
BoundParameters       : {}
UnboundArguments      : {}
ScriptLineNumber      : 1
OffsetInLine          : 1
HistoryId             : 2
ScriptName            :
Line                  : get-content doesnot.txt
PositionMessage       : At line:1 char:1
                        + get-content doesnot.txt
                        + ~~~~~~~~~~~~~~~~~~~~~~~
PSScriptRoot          :
PSCommandPath         :
InvocationName        : get-content
PipelineLength        : 0
PipelinePosition      : 0
ExpectingInput        : False
CommandOrigin         : Internal
DisplayScriptPosition :
#>

# Terminating vs Non-Terminating, most are not terminating unless you set EA to STOP

$error.Clear()
$error
# cd variable: >MaximumErrorCount 256

# changed error count: $MaximumErrorCount = 512 Bad practice to clear that variable.
# Error variable parameter.

Get-Content notexist.txt -ErrorVariable x
$error[0]
$x # Captured into my own variable.

# some cmdlets won't generating a terminating exception.
# if error doesn't stop
try {
    do-something -erroraction -stop -errorvariable x
}
catch {
    do-somethingelse
}
gc .\computers.txt -ErrorVariable x

$x | gm
<#
gm : You must specify an object for the Get-Member cmdlet.
At line:1 char:6
+ $x | gm
+      ~~
    + CategoryInfo          : CloseError: (:) [Get-Member], InvalidOperationException
    + FullyQualifiedErrorId : NoObjectInGetMember,Microsoft.PowerShell.Commands.GetMemberCommand
#>
$x.count
# 0 will be an array. Of zeros if no error.
gc .\cccc.txt -ErrorVariable x
$x.count
# 1
do-something -erroraction -stop -errorvariable x
if ($x.count -gt 0) {
    do-somethingelse
}

# If error doesn't produce a terminating error.

gc -Path .\computers.txt,.\notexists.txt,".\computers copy.txt",.\nope.txt -ev x

$error
<#
gc : Cannot find path 'C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\47_AdvancedPSX.AdvancedErrorHandling\nope.txt' because it
does not exist.
At line:1 char:1
+ gc -Path .\computers.txt,.\notexists.txt,".\computers copy.txt",.\nop ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (C:\Users\drios....ndling\nope.txt:String) [Get-Content], ItemNotFoundException
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand

gc : Cannot find path 'C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\47_AdvancedPSX.AdvancedErrorHandling\notexists.txt' because
it does not exist.
At line:1 char:1
+ gc -Path .\computers.txt,.\notexists.txt,".\computers copy.txt",.\nop ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (C:\Users\drios....g\notexists.txt:String) [Get-Content], ItemNotFoundException
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand
#>
$x
<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\47_AdvancedPSX.AdvancedErrorHandling> $x
gc : Cannot find path 'C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\47_AdvancedPSX.AdvancedErrorHandling\notexists.txt' because
it does not exist.
At line:1 char:1
+ gc -Path .\computers.txt,.\notexists.txt,".\computers copy.txt",.\nop ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (C:\Users\drios....g\notexists.txt:String) [Get-Content], ItemNotFoundException
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand

gc : Cannot find path 'C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\47_AdvancedPSX.AdvancedErrorHandling\nope.txt' because it
does not exist.
At line:1 char:1
+ gc -Path .\computers.txt,.\notexists.txt,".\computers copy.txt",.\nop ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (C:\Users\drios....ndling\nope.txt:String) [Get-Content], ItemNotFoundException
    + FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand
#>

#variable will have them in order of when it occurred. $error will bump error out of the way so index[0] becomes index[1]

$x.count

# 2

# deal with an if construct

foreach ($e in $x) {$e.InvocationInfo}

<#
MyCommand             : Get-Content
BoundParameters       : {}
UnboundArguments      : {}
ScriptLineNumber      : 1
OffsetInLine          : 1
HistoryId             : 44
ScriptName            :
Line                  : gc -Path .\computers.txt,.\notexists.txt,".\computers copy.txt",.\nope.txt -ev x
PositionMessage       : At line:1 char:1
                        + gc -Path .\computers.txt,.\notexists.txt,".\computers copy.txt",.\nop ...
                        + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PSScriptRoot          :
PSCommandPath         :
InvocationName        : gc
PipelineLength        : 0
PipelinePosition      : 0
ExpectingInput        : False
CommandOrigin         : Internal
DisplayScriptPosition :

MyCommand             : Get-Content
BoundParameters       : {}
UnboundArguments      : {}
ScriptLineNumber      : 1
OffsetInLine          : 1
HistoryId             : 44
ScriptName            :
Line                  : gc -Path .\computers.txt,.\notexists.txt,".\computers copy.txt",.\nope.txt -ev x
PositionMessage       : At line:1 char:1
                        + gc -Path .\computers.txt,.\notexists.txt,".\computers copy.txt",.\nop ...
                        + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PSScriptRoot          :
PSCommandPath         :
InvocationName        : gc
PipelineLength        : 0
PipelinePosition      : 0
ExpectingInput        : False
CommandOrigin         : Internal
DisplayScriptPosition :
#>

# If error is terminating.
try {
    do-something -erroraction -stop -errorvariable x
}
catch {
    $_ #Will contain the current error object for a terminating error.
    $error[0] # will both contain same thing.
    #if you plan to use the error from either, you need to copy it out.
    $z = $_
    $z = $error[0]
    #Because there are other things that will hijack $_
    $x # if this was and advance function instead of CMDLET. $x will contain two identical error object for that terror.
    # older versions v2 those error records followed by 2 identical objects called ErrorRuntimeException that contains
    # error record property that will bring you back to $x. It will contain a bunch of wacky stuff.
    # If it was a cmdlet with a terror it will contain an object called a CMDLET Invocation Exception. And will contain
    # error record property.

    $x.ErrorRecord # equiv $_ would expected normally
    # If it was an advance function and you made it throw a terminating error with -EA stop.
    # $x will contain -Ea stop Exception then it will contain two identical error record object.
}
####################!!!!!!!!!!!!!!!!!!!!!!!!!!!!######################################
# advanced function threw a terminating exeption

$x[0]

#cmdledt threw terminating exception

$x[0].ErrorRecord

# advanced function threw non-terminating, but you used -EA stop
$x[0].ErrorRecord

# cmdlet threw non-terminating but you used -EA stop, EV will contain single object EA stop.
$[0].ErrorRecord

# any of these...They can be hijacked
$_
$error[0]
# so keep them
$z = $_
$z = $error[0]

# Figuring out if an error happened. You'll need to know what the situation was.

# start with something that does exist.

gc .\computers.txt

$?
# True - Meaning command completed succesfully otherwise false.
# Some commands won't report false if error.
ping localhost
$?
# true
ping notthing
# $? = false ====in class it was true. Powershell Updates may have changed that. Test all the different cases.
$?




