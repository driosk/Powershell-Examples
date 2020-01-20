# Pipeline Redirection. 

Get-Content doesnotexist.txt | out-file test.txt

# zero byte file. Error did not make it into file.

#Error Pipelines

Get-Content doesnotexist.txt > test.txt # same thing.

# Pipelines
<#
1 Success or output pipeline.
2 Error
3 Warning
4 Verbose
5 Debug
6 informational
#>

Get-Content doesnotexist.txt 2> test.txt # Take error pipeline and put it into test.txt

Get-Content doesnotexist.txt *> test.txt # all pipelines.

help about_Redirection

Get-Content .\1.txt,nope.txt > combined.txt

Get-Content .\1.txt,nope.txt *> combined.txt

Get-Content 1.txt,nope.txt 2>&1 | Out-File combined.txt

get-service -Name BITS

$$ #BITS gets you the last bit of info. 
$^ # get-service gets you the first bit of information. 

Get-Process | sort pm -Descending | select vm,pm,id -Unique

$$ # contains last token of the last command that ran
$^ # contains first token of last command that ran. 

# dot sourcing

function MyFunction {
    Get-Process | sort vm -Descending | select -First 5    
}

# Script runs and everything that happened goes away. There is no function called my function. 

. .\Myfunction.ps1 # means script will run in current scope, global, script, function. No way to undo without delting 
# it in the function: drive. 

# Performance

Measure-Command{
    1..10000 |
    ForEach-Object -Process { $_ * 5 | Out-Null}
}

Measure-Command {
    $range = 1..10000
    foreach($item in $range){
        $item *5 | Out-Null
    }
}

Measure-Command {
    get-process |
    ForEach-Object -process { $_.vm + $_.pm }
} # 28.19ms

Measure-Command {
    $procs = get-process 
    ForEach ($proc in $procs) { $proc.vm + $proc.pm }
} 11.81 ms

# Importand to measure them in reality. 
