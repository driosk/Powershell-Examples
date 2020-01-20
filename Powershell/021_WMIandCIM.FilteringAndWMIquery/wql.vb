Disk.vbs
‘ Sample VBS WMI
‘ Author Guy Thomas https://computerperformance.co.uk/
‘ Version 1.5 – November 2010
‘ ———————————————–‘
Option Explicit
Dim objWMIService, objItem, colItems, strComputer, intDrive

‘ On Error Resume Next
strComputer = "."
intDrive = 0


 
‘ WMI connection to Root CIM
Set objWMIService = GetObject("winmgmts:\\" _
& strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery(_
"Select * from Win32_DiskDrive")

‘ Classic For Next Loop
For Each objItem in colItems
intDrive = intDrive + 1
Wscript.Echo "DiskDrive " & intDrive & vbCr & _
"Caption: " & objItem.Caption & VbCr & _
"Description: " & objItem.Description & VbCr & _
"Manufacturer: " & objItem.Manufacturer & VbCr & _
"Model: " & objItem.Model & VbCr & _
"Name: " & objItem.Name & VbCr & _
"Partitions: " & objItem.Partitions & VbCr & _
"Size: " & objItem.Size & VbCr & _
"Status: " & objItem.Status & VbCr & _
"SystemName: " & objItem.SystemName & VbCr & _
"TotalCylinders: " & objItem.TotalCylinders & VbCr & _
"TotalHeads: " & objItem.TotalHeads & VbCr & _
"TotalSectors: " & objItem.TotalSectors & VbCr & _
"TotalTracks: " & objItem.TotalTracks & VbCr & _
"TracksPerCylinder: " & objItem.TracksPerCylinder
Next
WSCript.Quit

‘ End of Sample Disk VBScript