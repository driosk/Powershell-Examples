gwmi win32_logicaldisk -Filter "drivetype='3'" | select @{name='Computername';expression={$_.__SERVER}}, `
@{name='Drive';expression={$_.deviceid}},@{name='Freespace(GB)';expression={$_.Freespace / 1GB -as [int]}}, `
@{name='Size(GB)';expression={$_.Size / 1GB -as [int]}}

$cred = Get-Credential
gwmi win32_logicaldisk -Filter "drivetype='3'" -Credential $cred | select @{name='Computername';expression={$_.__SERVER}}, `
@{name='Drive';expression={$_.deviceid}},@{name='Freespace(GB)';expression={$_.Freespace / 1GB -as [int]}}, `
@{name='Size(GB)';expression={$_.Size / 1GB -as [int]}}