Get-WmiObject -ComputerName ILCSPSWA -Class win32_bios

Get-Command -Noun cim*

<#
CommandType     Name                                               Version    Source        
-----------     ----                                               -------    ------        
Cmdlet          Get-CimAssociatedInstance                          1.0.0.0    CimCmdlets    
Cmdlet          Get-CimClass                                       1.0.0.0    CimCmdlets    
Cmdlet          Get-CimInstance                                    1.0.0.0    CimCmdlets    
Cmdlet          Get-CimSession                                     1.0.0.0    CimCmdlets    
Cmdlet          Invoke-CimMethod                                   1.0.0.0    CimCmdlets    
Cmdlet          New-CimInstance                                    1.0.0.0    CimCmdlets    
Cmdlet          New-CimSession                                     1.0.0.0    CimCmdlets    
Cmdlet          New-CimSessionOption                               1.0.0.0    CimCmdlets    
Cmdlet          Register-CimIndicationEvent                        1.0.0.0    CimCmdlets     
Cmdlet          Remove-CimInstance                                 1.0.0.0    CimCmdlets     
Cmdlet          Remove-CimSession                                  1.0.0.0    CimCmdlets     
Cmdlet          Set-CimInstance                                    1.0.0.0    CimCmdlets 
#>

$ILCSPSWA = New-CimSession -ComputerName ILCSPSWA.critsol.net

<#
Id           : 1
Name         : CimSession1
InstanceId   : 0b02c392-d90a-447a-bedc-2c3a0cad1664
ComputerName : ILCSPSWA.critsol.net
Protocol     : WSMAN
#>

$ILCSWS007 = New-CimSession -ComputerName ILCSWS007.critsol.net `
-SessionOption (New-CimSessionOption -Protocol Dcom) # Session option object fed to session option parameter. 

<#
Id Name        InstanceId                           ComputerName          Protocol
-- ----        ----------                           ------------          --------
 1 CimSession1 0b02c392-d90a-447a-bedc-2c3a0cad1664 ILCSPSWA.critsol.net  WSMAN
 2 CimSession2 e4c97108-26ee-44c5-ac67-0411ff7d38b2 ILCSWS007.critsol.net DCOM
#>

Get-CimInstance -ClassName Win32_OperatingSystem -CimSession $ILCSPSWA,$ILCSWS007 |
select PScomputername,version,BuildNumber,ServicePackMajorVersion,OSArchitecture | ft

<#
PSComputerName        version    BuildNumber ServicePackMajorVersion OSArchitecture
--------------        -------    ----------- ----------------------- --------------
ILCSWS007.critsol.net 6.1.7601   7601                              1 32-bit
ILCSPSWA.critsol.net  10.0.14393 14393                             0 64-bit
#>

Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $ILCSPSWA,$ILCSWS007

<#
Name             PrimaryOwnerNam Domain          TotalPhysicalMe Model          Manufacturer   PSComputerName
                 e                               mory
----             --------------- ------          --------------- -----          ------------   --------------
ILCSWS007        drios           critsol.net     4160282624      Virtual Mac... Microsoft C... ILCSWS007.c...
ILCSPSWA         Windows User    critsol.net     4291686400      Standard PC... QEMU           ILCSPSWA.cr...
#>

Get-CimInstance -ClassName win32_bios -CimSession $ILCSPSWA,$ILCSWS007

<#
SMBIOSBIOSVersion : 090008
Manufacturer      : American Megatrends Inc.
Name              : BIOS Date: 12/07/18 15:46:29  Ver: 09.00.08
SerialNumber      : 6603-6794-8308-4334-1109-7146-08
Version           : VRTUAL - 12001807
PSComputerName    : ILCSWS007.critsol.net

SMBIOSBIOSVersion : 0.0.0
Manufacturer      : EFI Development Kit II / OVMF
Name              : 0.0.0
SerialNumber      :
Version           : BOCHS  - 1
PSComputerName    : ILCSPSWA.critsol.net
#>

Get-CimSession | Remove-CimSession

# only way to get dcom to work with cim commands is to manually create a session first. 

Get-CimInstance -ClassName Win32_LogicalDisk -CimSession $ILCSWS007

PS C:\> Get-CimInstance -ClassName Win32_LogicalDisk -CimSession $ILCSWS007
<#
DeviceID DriveType ProviderName VolumeName        Size        FreeSpace   PSComputerName
-------- --------- ------------ ----------        ----        ---------   --------------
A:       2                                                                ILCSWS007.critsol.net
C:       3                                        42842714112 18470440960 ILCSWS007.critsol.net
D:       5                      GRMCULFRER_EN_DVD 2501894144  0           ILCSWS007.critsol.net
#>


help New-CimSession

<#
SYNTAX
    New-CimSession [[-ComputerName] <String[]>] [[-Credential] <PSCredential>] [-Authentication {Default | Digest | Negotiate | Basic  
    | Kerberos | NtlmDomain | CredSsp}] [-Name <String>] [-OperationTimeoutSec <UInt32>] [-Port <UInt32>] [-SessionOption
    <CimSessionOptions>] [-SkipTestConnection] [<CommonParameters>]

    New-CimSession [[-ComputerName] <String[]>] [-CertificateThumbprint <String>] [-Name <String>] [-OperationTimeoutSec <UInt32>]     
    [-Port <UInt32>] [-SessionOption <CimSessionOptions>] [-SkipTestConnection] [<CommonParameters>]
#>

$wsman = New-CimSession -ComputerName ILCSWS008.critsol.net,ILCSICA.critsol.net,ILCSPSWA.critsol.net

<#
Id           : 3
Name         : CimSession3
InstanceId   : 462e9eb5-5320-4118-8d63-be49f2ac7b6f
ComputerName : ILCSPSWA.critsol.net
Protocol     : WSMAN

Id           : 4
Name         : CimSession4
InstanceId   : 3749911a-65ae-4bf1-8424-ed73fa2c5b3d
ComputerName : ILCSICA.critsol.net
Protocol     : WSMAN

Id           : 5
Name         : CimSession5
InstanceId   : 45eb328f-2a19-4667-8ebc-55bea065c7b4
ComputerName : ILCSWS008.critsol.net
Protocol     : WSMAN
#>

$dcom = New-CimSession -ComputerName ILCSWS007.critsol.net -SessionOption (New-CimSessionOption -Protocol Dcom)

<#
Id           : 6
Name         : CimSession6
InstanceId   : 67aa1c05-a044-45d2-b2bc-74557a18c08d
ComputerName : ILCSWS007.critsol.net
Protocol     : DCOM
#>
Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $wsman,$dcom

<#
PS C:\> Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $wsman

Name             PrimaryOwnerNam Domain          TotalPhysicalMe Model          Manufacturer   PSComputerName
                 e                               mory
----             --------------- ------          --------------- -----          ------------   --------------
ILCSPSWA         Windows User    critsol.net     4291686400      Standard PC... QEMU           ILCSPSWA.cr...
ILCSICA          Windows User    critsol.net     2144333824      Standard PC... QEMU           ILCSICA.cri...
ILCSWS008        dougrios@gma... critsol.net     4291686400      Standard PC... QEMU           ILCSWS008.c...


PS C:\> Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $dcom

Name             PrimaryOwnerNam Domain          TotalPhysicalMe Model          Manufacturer   PSComputerName
                 e                               mory
----             --------------- ------          --------------- -----          ------------   --------------
ILCSWS007        drios           critsol.net     4160282624      Virtual Mac... Microsoft C... ILCSWS007.c...
#>

$wsman += $dcom #combine sessions


$wsman

<#
Id           : 3
Name         : CimSession3
InstanceId   : 462e9eb5-5320-4118-8d63-be49f2ac7b6f
ComputerName : ILCSPSWA.critsol.net
Protocol     : WSMAN

Id           : 4
Name         : CimSession4
InstanceId   : 3749911a-65ae-4bf1-8424-ed73fa2c5b3d
ComputerName : ILCSICA.critsol.net
Protocol     : WSMAN

Id           : 5
Name         : CimSession5
InstanceId   : 45eb328f-2a19-4667-8ebc-55bea065c7b4
ComputerName : ILCSWS008.critsol.net
Protocol     : WSMAN

Id           : 6
Name         : CimSession6
InstanceId   : 67aa1c05-a044-45d2-b2bc-74557a18c08d
ComputerName : ILCSWS007.critsol.net
Protocol     : DCOM
#>

Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $wsman

<#
PS C:\> Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $wsman

Name             PrimaryOwnerNam Domain          TotalPhysicalMe Model          Manufacturer   PSComputerName
                 e                               mory
----             --------------- ------          --------------- -----          ------------   --------------
ILCSWS007        drios           critsol.net     4160282624      Virtual Mac... Microsoft C... ILCSWS007.c...
ILCSICA          Windows User    critsol.net     2144333824      Standard PC... QEMU           ILCSICA.cri...
ILCSWS008        dougrios@gma... critsol.net     4291686400      Standard PC... QEMU           ILCSWS008.c...
ILCSPSWA         Windows User    critsol.net     4291686400      Standard PC... QEMU           ILCSPSWA.cr...
#>
# TypeName: Microsoft.Management.Infrastructure.CimInstance#root/cimv2/Win32_ComputerSystem


