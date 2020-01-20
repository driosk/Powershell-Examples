$ComputerNames = 'localhost','ILCSDC0','ILCSDC1'

$ComputerNames | Get-DiskDetails | Save-ReportData