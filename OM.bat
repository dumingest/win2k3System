:: author:   duming@snda.com
:: create:   2011-2-21
:: modified: 2011-2-21

::Create TEMP Directory

md C:\tmp

::Setup DNS Server

netsh interface ip add dns name="本地连接" 222.73.13.68 index=1
netsh interface ip add dns name="本地连接" 58.215.44.20 index=2
netsh interface ip add dns name="本地连接 2" 222.73.13.68 index=1
netsh interface ip add dns name="本地连接 2" 58.215.44.20 index=2
netsh interface ip add dns name="本地连接 3" 222.73.13.68 index=1
netsh interface ip add dns name="本地连接 3" 58.215.44.20 index=2
netsh interface ip add dns name="本地连接 4" 222.73.13.68 index=1
netsh interface ip add dns name="本地连接 4" 58.215.44.20 index=2
netsh interface ip add dns name="本地连接 5" 222.73.13.68 index=1
netsh interface ip add dns name="本地连接 5" 58.215.44.20 index=2

::Install SNMP&IIS

echo [NetOptionalComponents]>C:\tmp\snmp.txt
echo SNMP = 1>>C:\tmp\snmp.txt
echo [SNMP]>>C:\tmp\snmp.txt
echo Service = Physical,Applications,End-to-End,Internet,Datalink and subnetwork>>C:\tmp\snmp.txt
echo Send_Authentication = Yes>>C:\tmp\snmp.txt
echo Accept_CommunityName = billing:Read_Only>>C:\tmp\snmp.txt
echo Any_Host = Yes>>C:\tmp\snmp.txt
sysocmgr.exe /i:%windir%\inf\sysoc.inf /r /u:C:\tmp\snmp.txt

echo [Components]>C:\tmp\iis.txt
echo iis_common = ON>>C:\tmp\iis.txt
echo iis_www = ON>>C:\tmp\iis.txt
echo iis_asp = ON>>C:\tmp\iis.txt
echo iis_inetmgr = ON>>C:\tmp\iis.txt
echo aspnet= ON>>C:\tmp\iis.txt
sysocmgr.exe /i:%windir%\inf\sysoc.inf /r /u:C:\tmp\iis.txt

::Setup NTP Client

echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers>C:\tmp\ntp.txt
echo 1= 61.172.254.29>>C:\tmp\ntp.txt
regini C:\tmp\ntp.txt
net stop w32Time
net start w32Time
w32tm /resync /nowait /rediscover

::Install Framework 3.5SP1

hotfix\framework35sp1\dotnetfx35.exe /quiet /norestart
C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\aspnet_regiis.exe -i          

::Disable Services

sc config wuauserv start= disabled
sc config dhcp start= disabled
sc config browser start= disabled
sc config messenger start= disabled
sc config spooler start= disabled 
sc config remoteregistry start= disabled
sc config lmhosts start= disabled
sc config wzcsvc start= disabled
sc config w3svc start= disabled
net stop w3svc

::Create Partition

echo select disk 0>C:\tmp\diskpart.txt
echo create partition extended>>C:\tmp\diskpart.txt
echo create partition logical>>C:\tmp\diskpart.txt
echo select volume D>>C:\tmp\diskpart.txt
echo assign letter = H>>C:\tmp\diskpart.txt
echo select volume 2>>C:\tmp\diskpart.txt
echo assign letter = D>>C:\tmp\diskpart.txt
diskpart /s C:\tmp\diskpart.txt

echo HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup>C:\tmp\sourcepath.txt
echo SourcePath = H:I386>>C:\tmp\sourcepath.txt
regini C:\tmp\sourcepath.txt

format D: /FS:NTFS /Q /Y

::Setup Virtual Memory

cscript //H:cscript //s
pagefileconfig /create /i 2048  /m 4096 /vo D:

echo HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management>C:\tmp\vm.txt
echo PagingFiles = REG_MULTI_SZ "D:\pagefile.sys 2048 4096">>C:\tmp\vm.txt
echo HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Control\Session Manager\Memory Management>>C:\tmp\vm.txt
echo PagingFiles = REG_MULTI_SZ "D:\pagefile.sys 2048 4096">>C:\tmp\vm.txt
regini C:\tmp\vm.txt   

::Install Software

software\winrar\wrar-32x-393.exe -s
"%PROGRAMFILES%\winrar\rar.exe" x -y software\cygwin\cygwin.rar C:\
"%PROGRAMFILES%\winrar\rar.exe" x -y software\TotalCMD\TotalCMD.rar D:\
copy C:\Cygwin\cygwin.lnk "%USERPROFILE%\桌面"
copy D:\TotalCMD\TotalCMD.lnk "%USERPROFILE%\桌面"
copy service\服务.lnk "%USERPROFILE%\桌面"

::Create Directory

md D:\websiteslogs
md D:\components
md D:\components\log
md D:\tools
md D:\websites
md D:\webapplog
md D:\iislog
md D:\httperr

::goto IDC.bat
cd %SYSTEMDRIVE%\Prophase\IDC
IDC.bat                                                                                         