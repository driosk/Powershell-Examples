$DebugPreference = "Inquire"

Function New-Hash {
	param($algorithm,$path)
	$fileStream = [IO.File]::OpenRead((Resolve-Path $path))
	$hasher = [Security.Cryptography.HashAlgorithm]::Create($algorithm)
	$hash = $hasher.ComputeHash($filestream)
	$filestream.close()
	$filestream.dispose()
	return $hash
}
Function New-ChecksumFile {
	param($path)
	$hash = New-Hash -algorithm sha256 -path $path
	$hashStr = [system.bitconverter]::tostring($hash).replace('-','')
	[IO.File]::WriteAllText("$($Path).checksum",$hashStr)
}
 

################################################
################################################
################################################
################################################
################################################
################################################
################################################

If ((Get-ExecutionPolicy) -ne 'Bypass') { Write-Error "Set Exec Pol to Bypass"; break }

Write-Host "http://bit.ly/1hjumbd walks through this" -fore green

#
# Set it up
#
Write-Debug "Set up DSC"
$DebugPreference = 'SilentlyContinue'
\Dsc\InstallPullServerConfig -DSCServiceSetup
$DebugPreference = 'Inquire'


#
# Generate config MOF
#
Write-Debug "Generate pull config MOF"
$DebugPreference = 'SilentlyContinue'
\Dsc\SampleConfig.ps1
$DebugPreference = 'Inquire'


#
# Put the MOF where it needs to be
#
Write-Debug "Relocate MOF to pull folder"
Copy \Dsc\PullDemo\MEMBER2.mof c:\ProgramData\PSDSCPullServer\Configuration\e528dee8-6f0b-4885-98a1-1ee4d8e86d82.mof


#
# Create checksums for .mof configuration files in the PullServer Configuration directory
#
Write-Debug "Checksum MOFs"
Get-ChildItem -Path C:\ProgramData\PSDSCPullServer\Configuration -Filter *.mof |
ForEach-Object { New-ChecksumFile -path $_.FullName }


#
# Check the feature status
#
Write-Debug "See if feature installed"
Get-WindowsFeature -Name Windows-Server-Backup -Computer MEMBER2


#
# Configure pull mode MOF and push it to the server
#
Write-Debug "Configure MOF that sets up pull mode, and push to server via Remoting"
\Dsc\SampleSetPullMode.ps1


#
# Force it
#
Write-Debug "Force check"
Invoke-CimMethod -ComputerName MEMBER2 -Namespace root/microsoft/windows/desiredstateconfiguration `
                 -Class MSFT_DscLocalConfigurationManager -MethodName PerformRequiredConfigurationChecks `
                 -Arguments @{Flags = [uint32]1} -Verbose 



#
# See if it's there
#
Write-Debug "See if the feature is installed"
Get-WindowsFeature -Name Windows-Server-Backup -Computer MEMBER2



#
# The server should now look for it's pull MOF, grab it,
# also grab the resources it uses, and then excecute it all
#
# That should happen every 5 minutes
#
# We can check The Microsoft-Windows-DSC event log for messages.
