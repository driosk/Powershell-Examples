ps | select -First 1 | fl *

<#
Name                       : ApplicationFrameHost
Id                         : 8460
PriorityClass              : Normal
FileVersion                : 10.0.18362.1 (WinBuild.160101.0800)
HandleCount                : 340
WorkingSet                 : 16965632
PagedMemorySize            : 10342400
PrivateMemorySize          : 10342400
VirtualMemorySize          : 247181312
TotalProcessorTime         : 00:00:00.5312500
SI                         : 2
Handles                    : 340
VM                         : 2203565404160
WS                         : 16965632
PM                         : 10342400
NPM                        : 20528
Path                       : C:\WINDOWS\system32\ApplicationFrameHost.exe
Company                    : Microsoft Corporation
CPU                        : 0.53125
ProductVersion             : 10.0.18362.1
Description                : Application Frame Host
Product                    : Microsoft® Windows® Operating System
__NounName                 : Process
BasePriority               : 8
ExitCode                   :
HasExited                  : False
ExitTime                   :
Handle                     : 3232
SafeHandle                 : Microsoft.Win32.SafeHandles.SafeProcessHandle
MachineName                : .
MainWindowHandle           : 66330
MainWindowTitle            : Microsoft Edge
MainModule                 : System.Diagnostics.ProcessModule (ApplicationFrameHost.exe)
MaxWorkingSet              : 1413120
MinWorkingSet              : 204800
Modules                    : {System.Diagnostics.ProcessModule (ApplicationFrameHost.exe), System.Diagnostics.ProcessModule (ntdll.dll),
                             System.Diagnostics.ProcessModule (KERNEL32.DLL), System.Diagnostics.ProcessModule (KERNELBASE.dll)...}
NonpagedSystemMemorySize   : 20528
NonpagedSystemMemorySize64 : 20528
PagedMemorySize64          : 10342400
PagedSystemMemorySize      : 335768
PagedSystemMemorySize64    : 335768
PeakPagedMemorySize        : 20180992
PeakPagedMemorySize64      : 20180992
PeakWorkingSet             : 39870464
PeakWorkingSet64           : 39870464
PeakVirtualMemorySize      : 261562368
PeakVirtualMemorySize64    : 2203579785216
PriorityBoostEnabled       : True
PrivateMemorySize64        : 10342400
PrivilegedProcessorTime    : 00:00:00.4375000
ProcessName                : ApplicationFrameHost
ProcessorAffinity          : 255
Responding                 : True
SessionId                  : 2
StartInfo                  : System.Diagnostics.ProcessStartInfo
StartTime                  : 12/5/2019 7:17:36 PM
SynchronizingObject        :
Threads                    : {8464, 8584}
UserProcessorTime          : 00:00:00.0937500
VirtualMemorySize64        : 2203565404160
EnableRaisingEvents        : False
StandardInput              :
StandardOutput             :
StandardError              :
WorkingSet64               : 16965632
Site                       :
Container                  :
#> # In bytes and properties are not named the same as in object property. 

cd $PSHOME

<#
PS C:\Windows\System32\WindowsPowerShell\v1.0> dir -Filter *format*


    Directory: C:\Windows\System32\WindowsPowerShell\v1.0


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        3/18/2019  11:46 PM          12825 Certificate.format.ps1xml
-a----        3/18/2019  11:46 PM           5074 Diagnostics.Format.ps1xml
-a----        3/18/2019  11:46 PM         138223 DotNetTypes.format.ps1xml
-a----        3/18/2019  11:46 PM          10144 Event.Format.ps1xml
-a----        3/18/2019  11:46 PM          25526 FileSystem.format.ps1xml
-a----        3/18/2019  11:46 PM          91655 Help.format.ps1xml
-a----        3/18/2019  11:46 PM         138625 HelpV3.format.ps1xml
-a----        3/18/2019  11:46 PM         206468 PowerShellCore.format.ps1xml
-a----        3/18/2019  11:46 PM           4097 PowerShellTrace.format.ps1xml
-a----        3/18/2019  11:46 PM           8458 Registry.format.ps1xml
-a----        3/18/2019  11:46 PM          16598 WSMan.Format.ps1xml
#>

notepad .\DotNetTypes.format.ps1xml

# Look for type name

#  TypeName: System.Diagnostics.Process

# <TableColumnHeader /> last header

<#
<TableRowEntries>
                    <TableRowEntry>
                        <TableColumnItems>
                            <TableColumnItem>
                                <PropertyName>HandleCount</PropertyName>
                            </TableColumnItem>
                            <TableColumnItem>
                                <ScriptBlock>[long]($_.NPM / 1024)</ScriptBlock>
                            </TableColumnItem>
                            <TableColumnItem>
                                <ScriptBlock>[long]($_.PM / 1024)</ScriptBlock>
                            </TableColumnItem>
                            <TableColumnItem>
                                <ScriptBlock>[long]($_.WS / 1024)</ScriptBlock>
                            </TableColumnItem>
                            <TableColumnItem>
                                <ScriptBlock>[long]($_.VM / 1048576)</ScriptBlock>
                            </TableColumnItem>
                            <TableColumnItem>
                                <ScriptBlock>
if ($_.CPU -ne $()) 
{ 
    $_.CPU.ToString("N") 
}
				</ScriptBlock>
                            </TableColumnItem>
                            <TableColumnItem>
                                <PropertyName>Id</PropertyName>
                            </TableColumnItem>
                            <TableColumnItem>
                                <PropertyName>SI</PropertyName>
                            </TableColumnItem>
                            <TableColumnItem>
                                <PropertyName>ProcessName</PropertyName>
                            </TableColumnItem>
                        </TableColumnItems>#>