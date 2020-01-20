gsv | fl *

gsv winmgmt | select -ExpandProperty requiredservices
<#
Status   Name               DisplayName
------   ----               -----------
Running  RPCSS              Remote Procedure Call (RPC)
#>
gsv RpcSs | select -ExpandProperty requiredservices

<#
Status   Name               DisplayName
------   ----               -----------
Running  DcomLaunch         DCOM Server Process Launcher
Running  RpcEptMapper       RPC Endpoint Mapper
#>

get-service | Export-Csv services.csv # this would be a flat file. Can't nest objects. 

# Better approach would be to use XML

Get-Service | Export-Clixml services.XML

Get-Service WManSvc | Format-Custom

<#
class ServiceController
{
  Status = Stopped
  Name = WManSvc
  DisplayName = Windows Management Service
}
#>

Get-Service WManSvc | Format-Custom -Property Name,Status,RequiredServices

<#
class ServiceController
{
  Name = WManSvc
  Status = Stopped
  RequiredServices =
    [
      class ServiceController
      {
        Status = Running
        Name = rpcss
        DisplayName = Remote Procedure Call (RPC)
      }
    ]

}
#>

help Format-Custom

<#
SYNTAX
    Format-Custom [[-Property] <Object[]>] [-Depth <Int32>] [-DisplayError] [-Expand {CoreOnly | EnumOnly | Both}] [-Force] [-GroupBy  
    <Object>] [-InputObject <PSObject>] [-ShowError] [-View <String>] [<CommonParameters>]
#>


<#
PS C:\> Get-SysDiskDetails -ComputerName localhost | Format-Custom

class SysDiskDetails
{
  Manufacturer = Microsoft Corporation
  ComputerName = CRITHOS
  Model = Virtual Machine
  OSVersion = 10.0.18363
  Disks =
    [
      class PSCustomObject
      {
        DriveLetter = C:
        DriveType = 3
        Size = 135219716096
      }
      class PSCustomObject
      {
        DriveLetter = D:
        DriveType = 5
        Size = 1298604032
      }
    ]

  BIOSSerial = 2296-6916-3248-0804-6177-1356-99
  OSBuild = 18363
  SPVersion = 0
}

#>