# Need to find the Class id of the COM Object. 

$fs = New-Object -ComObject "Scripting.FileSystemObject"

$fs.GetSpecialFolder(0)
# asp Active Server Pages = VBScript

# Interop layer can sort of connect to COM OBJECTS> 

$fs.GetSpecialFolder(0).Path
$fs.GetSpecialFolder(1).Path
$fs.GetSpecialFolder(2).Path

$fs.Drives | Select-Object -Property path,drivetype,totalsize

#if you have a typename
$ad = New-Object -ComObject "AdSystemInfo"
 $ad | gm
#vbstript ADsystemInfo in google or bing. 
$ad.GetAnyDCName

 #PS C:\WINDOWS\system32> 
 # $ad.GetAnyDCName()
#ILCSDC0.critsol.net