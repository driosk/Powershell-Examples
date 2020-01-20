Enter-PSSession -ComputerName ilcsdc0.critsol.net

# 548      28    49496      64696       0.56   6060   0 wsmprovhost
#exit session
Get-Process -ComputerName ILCSDC0 # wsmprovhost not running

# AdHoc sessions, spun up, used immediately and then shutdown.
# if you plan to use session multiple times:

$dc = New-PSSession -ComputerName ILCSDC0
$servers = New-PSSession -ComputerName ILCSDC0,ILCSDC1,ILCSINFWDS1,CS-WSUS,ILCSRCA,ILCSICA
Get-PSSession

Invoke-Command -Session $servers -ScriptBlock {dir C:\users}

<#
Invoke-Command -Session $servers -ScriptBlock {dir C:\users}

    Directory: C:\users


Mode                LastWriteTime         Length Name                                       PSComputerName
----                -------------         ------ ----                                       --------------
d-----        11/2/2019   2:23 PM                .NET v4.5                                  CS-WSUS
d-----        11/2/2019   2:23 PM                .NET v4.5 Classic                          CS-WSUS
d-----        11/2/2019  12:53 PM                Administrator                              CS-WSUS
d-----        11/2/2019   1:39 PM                driosx                                   CS-WSUS
d-----        11/2/2019   2:23 PM                MSSQL$MICROSOFT##WID                       CS-WSUS
d-r---        11/2/2019  12:53 PM                Public                                     CS-WSUS
d-----        9/18/2018   7:40 PM                .NET v4.5                                  ILCSINFWDS1
d-----        9/18/2018   7:40 PM                .NET v4.5 Classic                          ILCSINFWDS1
d-----        9/16/2018   9:14 PM                Administrator                              ILCSINFWDS1
d-----       11/18/2018   6:02 PM                driosx                                   ILCSINFWDS1
d-----        11/2/2019  11:10 AM                driosx.CRIT                              ILCSINFWDS1
d-----        11/2/2019  11:11 AM                MSSQL$MICROSOFT##WID                       ILCSINFWDS1
d-r---        7/17/2018  10:33 PM                Public                                     ILCSINFWDS1
d-----         4/4/2019  10:45 AM                Administrator                              ILCSDC0
d-----       11/30/2019   7:00 PM                driosx                                   ILCSDC0
d-----       11/30/2019   5:14 PM                drios                                      ILCSDC0
d-r---         4/4/2019  10:45 AM                Public                                     ILCSDC0
d-----         4/5/2019   9:15 AM                .NET v4.5                                  ILCSICA
d-----         4/5/2019   9:15 AM                .NET v4.5 Classic                          ILCSICA
d-----         4/5/2019   8:49 AM                Administrator                              ILCSICA
d-----       11/13/2019   5:29 PM                driosx                                   ILCSICA
d-r---         4/5/2019   8:49 AM                Public                                     ILCSICA
d-----         4/4/2019   1:05 PM                Administrator                              ILCSDC1
d-----       11/18/2019  12:10 PM                driosx                                   ILCSDC1
d-----       11/30/2019   5:14 PM                drios                                      ILCSDC1
d-r---         4/4/2019   1:05 PM                Public                                     ILCSDC1
d-----         4/5/2019  10:35 AM                .NET v4.5                                  ILCSRCA
d-----         4/5/2019  10:35 AM                .NET v4.5 Classic                          ILCSRCA
d-----         4/4/2019  10:37 PM                Administrator                              ILCSRCA
d-----       10/22/2019   8:00 PM                driosx                                   ILCSRCA
d-r---         4/4/2019  10:37 PM                Public                                     ILCSRCA
d-----         4/5/2019   4:03 PM                WSEnrollmentPolicyServer                   ILCSRCA
#>


Remove-PSSession -Session $servers

Invoke-Command -ComputerName ILCSDC0,ILCSDC1,ILCSINFWDS1,CS-WSUS,ILCSRCA,ILCSICA -ScriptBlock {Get-PSSession}

Get-PSSession | Remove-PSSession

New-PSSession -ComputerName ILCSDC0.critsol.net
<#
PS C:\users\DRIOSX\Documents\GitHub\freecodecamp\PowershellRef\11_PersistentRemoting.PSSESSIONS> New-PSSession -ComputerName ILCSDC0.critsol.net
 Id Name            ComputerName    ComputerType    State         ConfigurationName     Availability
 -- ----            ------------    ------------    -----         -----------------     ------------
 21 WinRM21         ILCSDC0.crit... RemoteMachine   Opened        Microsoft.PowerShell     Available
#>

Get-PSSession

Get-PSSession -ComputerName NAMEofSpecifiedComputer

Enter-PSSession -Session (Get-PSSession -ComputerName ILCSDC0.critsol.net | select -First 1)

Get-PSSession | Disconnect-PSSession

Get-PSSession -ComputerName ILCSDC0

