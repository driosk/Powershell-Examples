

1..100 | ForEach {notepad.exe}
Measure-Command {
    Get-Process -Name notepad |
    ForEach-Object {$_.Kill()}
}
Measure-Command { 
    $processes = Get-Process -Name notepad
    foreach ($proc in $processes) {
        $proc.Kill()
    }
} # Foreach more effective in scripts

