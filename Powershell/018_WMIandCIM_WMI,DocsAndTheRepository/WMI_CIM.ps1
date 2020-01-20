# WMI and CIM info are refered to as the Repository.
# Not every computer or OS is the same with the Repository.
# CIM is generic Win32 is more specific.
# ROOT\securitycenter2
# double underscore are system classes __Trustee


winrm get winrm/config

Get-WmiObject -Namespace root\CIMv2 -List
Get-WmiObject -Namespace root\CIMv2 -List | where {$_.name -like '*disk*'}

# Repository vs WMI
# DMTF: Distributed Management Task Force 

Get-HotFix # Uses CIM wrapped in a cmdlet.

