help Get-Service -ShowWindow

Trace-Command -Name metadata,parameterbinding,cmdlet -Expression {Get-Process Notepad} -PSHost

# This will actually run the command. 
Trace-Command -Name parameterbinding -PSHost -Expression {Import-Csv .\comps.csv | Get-Service}

$x = (Import-Csv .\comps.csv).tostring() 

# this object is being bound to name parameter.

Trace-Command -Name parameterbinding -PSHost -Expression {Import-Csv .\comps.csv | Get-Service -name *}

# Once by value is taken care of, by property can recieve the value. 

# Knowing what it takes from cmd A can help you bind correctly to cmd B. 