# Win32_Account class is an abscracted class
# You would use win32_useraccount or Win32_computeraccount.
# Win32_account is the generic basis between them


# An Association is a way of wmi recognizing that relationship.

# in the middle is win32_groupUser (ASSOCIATION CLASS)

<#
class Win32_GroupUser : CIM_Component
{
    Win32_Group   REF GroupComponent;
    Win32_Account REF PartComponent;
};
#>
#Meaning that account lives in that group
# Win32_Group


# Association class

# It will reference the group and it belongs to and the account
# that does the belonging.

# Rather than work with users and groups we'll work with network adapters

######CAUTION######
<#
In domain win32_groups and win32_accounts classes includes all the domain accounts.
Can take a really long time to query things
#>

Get-WmiObject -Class win32_networkadapter

<#
ServiceName      : netvsc
MACAddress       : 00:15:5D:94:B7:0A
AdapterType      : Ethernet 802.3
DeviceID         : 1
Name             : Microsoft Hyper-V Network Adapter
NetworkAddresses :
Speed            : 1000000000
#>

# Couple way to work with assoc, first get a list of classes that refer to this one.
#asking to give me OTHER class definitions.
Get-WmiObject -Query "references of {win32_networkadapter.deviceid=1}"

<#
__GENUS          : 2
__CLASS          : Win32_PnPDevice
__SUPERCLASS     :
__DYNASTY        : Win32_PnPDevice
__RELPATH        : Win32_PnPDevice.SameElement="\\\\CRITHOS\\ROOT\\CIMV2:Win32_NetworkAdapter.DeviceID=\"1\"",SystemElement="\\\\CRITH
                   OS\\root\\cimv2:Win32_PnPEntity.DeviceID=\"VMBUS\\\\{F8615163-DF3E-46C5-913F-F2D2F965ED0E}\\\\{3D91FDD2-043E-4A4C-9
                   96C-488102316BDF}\""
__PROPERTY_COUNT : 2
__DERIVATION     : {}
__SERVER         : CRITHOS
__NAMESPACE      : root\cimv2
__PATH           : \\CRITHOS\root\cimv2:Win32_PnPDevice.SameElement="\\\\CRITHOS\\ROOT\\CIMV2:Win32_NetworkAdapter.DeviceID=\"1\"",Sys
                   temElement="\\\\CRITHOS\\root\\cimv2:Win32_PnPEntity.DeviceID=\"VMBUS\\\\{F8615163-DF3E-46C5-913F-F2D2F965ED0E}\\\\
                   {3D91FDD2-043E-4A4C-996C-488102316BDF}\""
SameElement      : \\CRITHOS\ROOT\CIMV2:Win32_NetworkAdapter.DeviceID="1"
SystemElement    : \\CRITHOS\root\cimv2:Win32_PnPEntity.DeviceID="VMBUS\\{F8615163-DF3E-46C5-913F-F2D2F965ED0E}\\{3D91FDD2-043E-4A4C-9
                   96C-488102316BDF}"
PSComputerName   : CRITHOS

__GENUS          : 2
__CLASS          : Win32_SystemDevices
__SUPERCLASS     : CIM_SystemDevice
__DYNASTY        : CIM_Component
__RELPATH        : Win32_SystemDevices.GroupComponent="\\\\CRITHOS\\root\\cimv2:Win32_ComputerSystem.Name=\"CRITHOS\"",PartComponent="
                   \\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\""
__PROPERTY_COUNT : 2
__DERIVATION     : {CIM_SystemDevice, CIM_SystemComponent, CIM_Component}
__SERVER         : CRITHOS
__NAMESPACE      : root\cimv2
__PATH           : \\CRITHOS\root\cimv2:Win32_SystemDevices.GroupComponent="\\\\CRITHOS\\root\\cimv2:Win32_ComputerSystem.Name=\"CRITH
                   OS\"",PartComponent="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\""
GroupComponent   : \\CRITHOS\root\cimv2:Win32_ComputerSystem.Name="CRITHOS"
PartComponent    : \\CRITHOS\root\cimv2:Win32_NetworkAdapter.DeviceID="1"
PSComputerName   : CRITHOS

__GENUS          : 2
__CLASS          : Win32_NetworkAdapterSetting
__SUPERCLASS     : Win32_DeviceSettings
__DYNASTY        : CIM_ElementSetting
__RELPATH        : Win32_NetworkAdapterSetting.Element="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\"",Setting="\\\\CRI
                   THOS\\root\\cimv2:Win32_NetworkAdapterConfiguration.Index=1"
__PROPERTY_COUNT : 2
__DERIVATION     : {Win32_DeviceSettings, CIM_ElementSetting}
__SERVER         : CRITHOS
__NAMESPACE      : root\cimv2
__PATH           : \\CRITHOS\root\cimv2:Win32_NetworkAdapterSetting.Element="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"
                   1\"",Setting="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapterConfiguration.Index=1"
Element          : \\CRITHOS\root\cimv2:Win32_NetworkAdapter.DeviceID="1"
Setting          : \\CRITHOS\root\cimv2:Win32_NetworkAdapterConfiguration.Index=1
PSComputerName   : CRITHOS

__GENUS          : 2
__CLASS          : Win32_ProtocolBinding
__SUPERCLASS     :
__DYNASTY        : Win32_ProtocolBinding
__RELPATH        : Win32_ProtocolBinding.Antecedent="\\\\CRITHOS\\root\\cimv2:Win32_NetworkProtocol.Name=\"MSAFD Tcpip
                   [TCP/IP]\"",Device="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\""
__PROPERTY_COUNT : 3
__DERIVATION     : {}
__SERVER         : CRITHOS
__NAMESPACE      : root\cimv2
__PATH           : \\CRITHOS\root\cimv2:Win32_ProtocolBinding.Antecedent="\\\\CRITHOS\\root\\cimv2:Win32_NetworkProtocol.Name=\"MSAFD
                   Tcpip [TCP/IP]\"",Device="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\""
Antecedent       : \\CRITHOS\root\cimv2:Win32_NetworkProtocol.Name="MSAFD Tcpip [TCP/IP]"
Dependent        : \\CRITHOS\root\cimv2:Win32_SystemDriver.Name="netvsc"
Device           : \\CRITHOS\root\cimv2:Win32_NetworkAdapter.DeviceID="1"
PSComputerName   : CRITHOS

__GENUS          : 2
__CLASS          : Win32_ProtocolBinding
__SUPERCLASS     :
__DYNASTY        : Win32_ProtocolBinding
__RELPATH        : Win32_ProtocolBinding.Antecedent="\\\\CRITHOS\\root\\cimv2:Win32_NetworkProtocol.Name=\"MSAFD Tcpip
                   [UDP/IP]\"",Device="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\""
__PROPERTY_COUNT : 3
__DERIVATION     : {}
__SERVER         : CRITHOS
__NAMESPACE      : root\cimv2
__PATH           : \\CRITHOS\root\cimv2:Win32_ProtocolBinding.Antecedent="\\\\CRITHOS\\root\\cimv2:Win32_NetworkProtocol.Name=\"MSAFD
                   Tcpip [UDP/IP]\"",Device="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\""
Antecedent       : \\CRITHOS\root\cimv2:Win32_NetworkProtocol.Name="MSAFD Tcpip [UDP/IP]"
Dependent        : \\CRITHOS\root\cimv2:Win32_SystemDriver.Name="netvsc"
Device           : \\CRITHOS\root\cimv2:Win32_NetworkAdapter.DeviceID="1"
PSComputerName   : CRITHOS

__GENUS          : 2
__CLASS          : Win32_ProtocolBinding
__SUPERCLASS     :
__DYNASTY        : Win32_ProtocolBinding
__RELPATH        : Win32_ProtocolBinding.Antecedent="\\\\CRITHOS\\root\\cimv2:Win32_NetworkProtocol.Name=\"MSAFD Tcpip
                   [TCP/IPv6]\"",Device="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\""
__PROPERTY_COUNT : 3
__DERIVATION     : {}
__SERVER         : CRITHOS
__NAMESPACE      : root\cimv2
__PATH           : \\CRITHOS\root\cimv2:Win32_ProtocolBinding.Antecedent="\\\\CRITHOS\\root\\cimv2:Win32_NetworkProtocol.Name=\"MSAFD
                   Tcpip [TCP/IPv6]\"",Device="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\""
Antecedent       : \\CRITHOS\root\cimv2:Win32_NetworkProtocol.Name="MSAFD Tcpip [TCP/IPv6]"
Dependent        : \\CRITHOS\root\cimv2:Win32_SystemDriver.Name="netvsc"
Device           : \\CRITHOS\root\cimv2:Win32_NetworkAdapter.DeviceID="1"
PSComputerName   : CRITHOS

__GENUS          : 2
__CLASS          : Win32_ProtocolBinding
__SUPERCLASS     :
__DYNASTY        : Win32_ProtocolBinding
__RELPATH        : Win32_ProtocolBinding.Antecedent="\\\\CRITHOS\\root\\cimv2:Win32_NetworkProtocol.Name=\"MSAFD Tcpip
                   [UDP/IPv6]\"",Device="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\""
__PROPERTY_COUNT : 3
__DERIVATION     : {}
__SERVER         : CRITHOS
__NAMESPACE      : root\cimv2
__PATH           : \\CRITHOS\root\cimv2:Win32_ProtocolBinding.Antecedent="\\\\CRITHOS\\root\\cimv2:Win32_NetworkProtocol.Name=\"MSAFD
                   Tcpip [UDP/IPv6]\"",Device="\\\\CRITHOS\\root\\cimv2:Win32_NetworkAdapter.DeviceID=\"1\""
Antecedent       : \\CRITHOS\root\cimv2:Win32_NetworkProtocol.Name="MSAFD Tcpip [UDP/IPv6]"
Dependent        : \\CRITHOS\root\cimv2:Win32_SystemDriver.Name="netvsc"
Device           : \\CRITHOS\root\cimv2:Win32_NetworkAdapter.DeviceID="1"
PSComputerName   : CRITHOS
#> #Lots of info to go through

Get-WmiObject -Query "references of {win32_networkadapter.deviceid=1}" | select __CLASS

<#
_CLASS
-------
Win32_PnPDevice
Win32_SystemDevices
Win32_NetworkAdapterSetting
Win32_ProtocolBinding
Win32_ProtocolBinding
Win32_ProtocolBinding
Win32_ProtocolBinding
#>

# There is a where clause that you can use to narrow down.

Get-WmiObject -Query "references of {win32_networkadapter.deviceid=1} WHERE classdefsonly"

<#
   NameSpace: ROOT\cimv2

Name                                Methods              Properties
----                                -------              ----------
Win32_PnPDevice                     {}                   {SameElement, SystemElement}
Win32_SystemDevices                 {}                   {GroupComponent, PartComponent} # Associator Class
Win32_NetworkAdapterSetting         {}                   {Element, Setting}
Win32_ProtocolBinding               {}                   {Antecedent, Dependent, Device}
#>

# Associator Class = GROUP + PART

Get-WmiObject -Query `
"associators of {win32_networkadapter.deviceid=1} WHERE resultclass= win32_networkadapterconfiguration"
<#
PS C:\Users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\19_WMI Commands to Query Data> Get-WmiObject -Query `
>> "associators of {### This space here messed it up!!! ### win32_networkadapter.deviceid=1} WHERE resultclass= win32_networkadapterconfiguration"
Get-WmiObject : Invalid object path
At line:1 char:1
+ Get-WmiObject -Query `
+ ~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (:) [Get-WmiObject], ManagementException
    + FullyQualifiedErrorId : GetWMIManagementException,Microsoft.PowerShell.Commands.GetWmiObjectCommand
#>
<#
DHCPEnabled      : True
IPAddress        : {10.11.10.35, fe80::ad36:8259:65e0:381a, fd75:17af:1d1f:cb0e:e99b:f03f:a10b:a39f,
                   fd75:17af:1d1f:cb0e:4d69:e8e:9889:a1e3...}
DefaultIPGateway : {10.11.10.1, fe80::5054:ff:fe9c:5ab}
DNSDomain        : critsol.net
ServiceName      : netvsc
Description      : Microsoft Hyper-V Network Adapter
Index            : 1
#>
Get-WmiObject -Query `
"associators of {win32_networkadapter.deviceid=1} WHERE resultclass= win32_networkadapterconfiguration" |
select -ExpandProperty IPAddress

<#
10.11.10.35
fe80::ad36:8259:65e0:381a
fd75:17af:1d1f:cb0e:e99b:f03f:a10b:a39f
fd75:17af:1d1f:cb0e:4d69:e8e:9889:a1e3
fd75:17af:1d1f:cb0e:f8e7:fea5:45f7:3f97
fd75:17af:1d1f:cb0e:ad36:8259:65e0:381a
#>
Get-WmiObject -Query `
"associators of {win32_networkadapter.deviceid=1} WHERE resultclass= win32_networkadapterconfiguration" |
gm

<#
TypeName: System.Management.ManagementObject#root\cimv2\Win32_NetworkAdapterConfiguration

Name                         MemberType    Definition
----                         ----------    ----------
PSComputerName               AliasProperty PSComputerName = __SERVER
DisableIPSec                 Method        System.Management.ManagementBaseObject DisableIPSec()
EnableDHCP                   Method        System.Management.ManagementBaseObject EnableDHCP()
EnableIPSec                  Method        System.Management.ManagementBaseObject EnableIPSec(System.String[] IPSecPermitTCPPorts, ...
EnableStatic                 Method        System.Management.ManagementBaseObject EnableStatic(System.String[] IPAddress, System.St...
ReleaseDHCPLease             Method        System.Management.ManagementBaseObject ReleaseDHCPLease()
RenewDHCPLease               Method        System.Management.ManagementBaseObject RenewDHCPLease()
SetDNSDomain                 Method        System.Management.ManagementBaseObject SetDNSDomain(System.String DNSDomain)
SetDNSServerSearchOrder      Method        System.Management.ManagementBaseObject SetDNSServerSearchOrder(System.String[] DNSServer...
SetDynamicDNSRegistration    Method        System.Management.ManagementBaseObject SetDynamicDNSRegistration(System.Boolean FullDNSR...
SetGateways                  Method        System.Management.ManagementBaseObject SetGateways(System.String[] DefaultIPGateway, Sys...
SetIPConnectionMetric        Method        System.Management.ManagementBaseObject SetIPConnectionMetric(System.UInt32 IPConnectionM...
SetIPXFrameTypeNetworkPairs  Method        System.Management.ManagementBaseObject SetIPXFrameTypeNetworkPairs(System.String[] IPXNe...
SetTcpipNetbios              Method        System.Management.ManagementBaseObject SetTcpipNetbios(System.UInt32 TcpipNetbiosOptions)
SetWINSServer                Method        System.Management.ManagementBaseObject SetWINSServer(System.String WINSPrimaryServer, Sy...
ArpAlwaysSourceRoute         Property      bool ArpAlwaysSourceRoute {get;set;}
ArpUseEtherSNAP              Property      bool ArpUseEtherSNAP {get;set;}
Caption                      Property      string Caption {get;set;}
DatabasePath                 Property      string DatabasePath {get;set;}
DeadGWDetectEnabled          Property      bool DeadGWDetectEnabled {get;set;}
DefaultIPGateway             Property      string[] DefaultIPGateway {get;set;}
DefaultTOS                   Property      byte DefaultTOS {get;set;}
DefaultTTL                   Property      byte DefaultTTL {get;set;}
Description                  Property      string Description {get;set;}
DHCPEnabled                  Property      bool DHCPEnabled {get;set;}
DHCPLeaseExpires             Property      string DHCPLeaseExpires {get;set;}
DHCPLeaseObtained            Property      string DHCPLeaseObtained {get;set;}
DHCPServer                   Property      string DHCPServer {get;set;}
DNSDomain                    Property      string DNSDomain {get;set;}
DNSDomainSuffixSearchOrder   Property      string[] DNSDomainSuffixSearchOrder {get;set;}
DNSEnabledForWINSResolution  Property      bool DNSEnabledForWINSResolution {get;set;}
DNSHostName                  Property      string DNSHostName {get;set;}
DNSServerSearchOrder         Property      string[] DNSServerSearchOrder {get;set;}
DomainDNSRegistrationEnabled Property      bool DomainDNSRegistrationEnabled {get;set;}
ForwardBufferMemory          Property      uint32 ForwardBufferMemory {get;set;}
FullDNSRegistrationEnabled   Property      bool FullDNSRegistrationEnabled {get;set;}
GatewayCostMetric            Property      uint16[] GatewayCostMetric {get;set;}
IGMPLevel                    Property      byte IGMPLevel {get;set;}
Index                        Property      uint32 Index {get;set;}
InterfaceIndex               Property      uint32 InterfaceIndex {get;set;}
IPAddress                    Property      string[] IPAddress {get;set;}
IPConnectionMetric           Property      uint32 IPConnectionMetric {get;set;}
IPEnabled                    Property      bool IPEnabled {get;set;}
IPFilterSecurityEnabled      Property      bool IPFilterSecurityEnabled {get;set;}
IPPortSecurityEnabled        Property      bool IPPortSecurityEnabled {get;set;}
IPSecPermitIPProtocols       Property      string[] IPSecPermitIPProtocols {get;set;}
IPSecPermitTCPPorts          Property      string[] IPSecPermitTCPPorts {get;set;}
IPSecPermitUDPPorts          Property      string[] IPSecPermitUDPPorts {get;set;}
IPSubnet                     Property      string[] IPSubnet {get;set;}
IPUseZeroBroadcast           Property      bool IPUseZeroBroadcast {get;set;}
IPXAddress                   Property      string IPXAddress {get;set;}
IPXEnabled                   Property      bool IPXEnabled {get;set;}
IPXFrameType                 Property      uint32[] IPXFrameType {get;set;}
IPXMediaType                 Property      uint32 IPXMediaType {get;set;}
IPXNetworkNumber             Property      string[] IPXNetworkNumber {get;set;}
IPXVirtualNetNumber          Property      string IPXVirtualNetNumber {get;set;}
KeepAliveInterval            Property      uint32 KeepAliveInterval {get;set;}
KeepAliveTime                Property      uint32 KeepAliveTime {get;set;}
MACAddress                   Property      string MACAddress {get;set;}
MTU                          Property      uint32 MTU {get;set;}
NumForwardPackets            Property      uint32 NumForwardPackets {get;set;}
PMTUBHDetectEnabled          Property      bool PMTUBHDetectEnabled {get;set;}
PMTUDiscoveryEnabled         Property      bool PMTUDiscoveryEnabled {get;set;}
ServiceName                  Property      string ServiceName {get;set;}
SettingID                    Property      string SettingID {get;set;}
TcpipNetbiosOptions          Property      uint32 TcpipNetbiosOptions {get;set;}
TcpMaxConnectRetransmissions Property      uint32 TcpMaxConnectRetransmissions {get;set;}
TcpMaxDataRetransmissions    Property      uint32 TcpMaxDataRetransmissions {get;set;}
TcpNumConnections            Property      uint32 TcpNumConnections {get;set;}
TcpUseRFC1122UrgentPointer   Property      bool TcpUseRFC1122UrgentPointer {get;set;}
TcpWindowSize                Property      uint16 TcpWindowSize {get;set;}
WINSEnableLMHostsLookup      Property      bool WINSEnableLMHostsLookup {get;set;}
WINSHostLookupFile           Property      string WINSHostLookupFile {get;set;}
WINSPrimaryServer            Property      string WINSPrimaryServer {get;set;}
WINSScopeID                  Property      string WINSScopeID {get;set;}
WINSSecondaryServer          Property      string WINSSecondaryServer {get;set;}
__CLASS                      Property      string __CLASS {get;set;}
__DERIVATION                 Property      string[] __DERIVATION {get;set;}
__DYNASTY                    Property      string __DYNASTY {get;set;}
__GENUS                      Property      int __GENUS {get;set;}
__NAMESPACE                  Property      string __NAMESPACE {get;set;}
__PATH                       Property      string __PATH {get;set;}
__PROPERTY_COUNT             Property      int __PROPERTY_COUNT {get;set;}
__RELPATH                    Property      string __RELPATH {get;set;}
__SERVER                     Property      string __SERVER {get;set;}
__SUPERCLASS                 Property      string __SUPERCLASS {get;set;}
DHCP                         PropertySet   DHCP {Description, DHCPEnabled, DHCPLeaseExpires, DHCPLeaseObtained, DHCPServer, Index}
DNS                          PropertySet   DNS {Description, DNSDomain, DNSDomainSuffixSearchOrder, DNSEnabledForWINSResolution, DN...
IP                           PropertySet   IP {Description, Index, IPAddress, IPConnectionMetric, IPEnabled, IPFilterSecurityEnabled}
PSStatus                     PropertySet   PSStatus {DHCPLeaseExpires, Index, Description}
WINS                         PropertySet   WINS {Description, Index, WINSEnableLMHostsLookup, WINSHostLookupFile, WINSPrimaryServer...
ConvertFromDateTime          ScriptMethod  System.Object ConvertFromDateTime();
ConvertToDateTime            ScriptMethod  System.Object ConvertToDateTime();
#>

# The output is a type of : TypeName: System.Management.ManagementObject#root\cimv2\Win32_NetworkAdapterConfiguration
# just as a specific instance of it via association.

# Specific instance associated with deviceID.1 instance of networkadapter

