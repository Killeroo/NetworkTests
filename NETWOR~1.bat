REM NetworkTest3.0 - Network Diagnostics
REM Programmed by Matthew Carney [matthewcarney64@gmail.com]
REM Using Command Prompt (CMD.BAT)
REM © Matthew Carney 29th November 2014
REM Feel free to modify, copy and change this program under the MIT Licence

@echo off

:StartUp
echo Initializing StartUp . . .
call :Locater
call :VariableAssign
call :VariableSetUp
call :DirectorySetUp
call :LogGenerator
call :NetworkInfo
echo -StartUp Complete-
ping 127.0.0.1 -n 3 >nul
cls
call :DisplayNetworkInfo
goto SubMainMenu
goto:eof

:Locater
Echo Location Found: %cd%
goto:eof

:VariableAssign
set title=Network Test 3.0
set color=C
set lines=300
set cols=80
set MainMenuPass=0
set VerNo=1.3
set Errorlvl=0
echo Variable Assigning -Done-
goto:eof

:VariableSetUp
title %title%
color %color%
echo Variable Set Up -Done-
goto:eof

:NetworkInfo
echo NetworkInfo Started . . .
ipconfig /all > StartUp.txt
echo StartUp.txt Created. 
findstr /C:"Host Name" %cd%\StartUp.txt > %cd%\IP.txt || echo  Host Name . . . . . . . . . . . . : Unavailable && echo  Host Name . . . . . . . . . . . . : Unavailable > %cd%\IP.txt
findstr /C:"IPv4 Address" %cd%\StartUp.txt >> %cd%\IP.txt || echo  IPv4 Address. . . . . . . . . . . : Unavailable && echo  IPv4 Address. . . . . . . . . . . : Unavailable >> %cd%\IP.txt
findstr /C:"IPv6 Address" %cd%\StartUp.txt >> %cd%\IP.txt || echo  IPv6 Address. . . . . . . . . . . : Unavailable && echo  IPv6 Address. . . . . . . . . . . : Unavailable >> %cd%\IP.txt
findstr /C:"Default Gateway" %cd%\StartUp.txt >> %cd%\IP.txt || echo  Default Gateway . . . . . . . . . : Unavailable && echo  Default Gateway . . . . . . . . . : Unavailable >> %cd%\IP.txt
findstr /C:"DNS Servers" %cd%\StartUp.txt >> %cd%\IP.txt || echo  DNS Servers . . . . . . . . . . . : Unavailable && echo  DNS Servers . . . . . . . . . . . : Unavailable >> %cd%\IP.txt
echo Strings Found.
echo IP.txt Created.
del "StartUp.txt"
echo StartUp.txt Deleted.
goto:eof

:DirectorySetUp
set LogDirChecker=0
set InstallDirChecker=0
set FileDir=%cd%
echo DirectorySetUp Started . . .
cd..
dir | find "<DIR>          NetworkTest" >nul && set InstallDirChecker=1
if %InstallDirChecker% equ 1 ( echo Install Directory Found. ) else mkdir NetworkTest && echo Install Directory Created.
cd NetworkTest
set InstallDir=%cd%
dir | find "Logs" >nul && set LogDirChecker=1
if %LogDirChecker% equ 1 ( echo Log Directory Found. ) else mkdir Logs && echo Log Directory Created.
cd..
if %InstallDirChecker% equ 0 ( copy "%FileDir%\NETWOR~1.bat" "%cd%\NetworkTest\NETWOR~1.bat" ) else cd NetworkTest & echo DirectorySetUp -Done- & goto:eof
echo NETWOR~1.bat Copied.
echo NETWOR~1.bat Deleted.
set OriginalDir=%cd%
call :StartUpCreater
call :ContentExtract
echo DirectorySetUp -Done-
echo :NOTE: Shortcut Created on Desktop 
echo Restart Initialized . . . 
ping 127.0.0.1 -n 8 >nul
ECHO  (^G)
cd %userprofile%\Desktop
start StartNetworkTest.bat 
exit
goto:eof

:ContentExtract
cd %FileDir%
xcopy /y * "%userprofile%\NetworkTest\"
echo ContentExtraction Complete.
cd %OriginalDir%
goto:eof

:StartUpCreater
color 02
set DelTemp=%userprofile%\TEMP
echo @echo off > %userprofile%\Desktop\StartNetworkTest.bat 
echo del %FileDir%\NETWOR~1.bat >> %userprofile%\Desktop\StartNetworkTest.bat
echo rd /s /q "%DelTemp%" >> %userprofile%\Desktop\StartNetworkTest.bat
echo cls >> %userprofile%\Desktop\StartNetworkTest.bat
echo cd %InstallDir% >> %userprofile%\Desktop\StartNetworkTest.bat
echo NETWOR~1.bat >> %userprofile%\Desktop\StartNetworkTest.bat
echo StartUpFile Created.
goto:eof

:LogGenerator
cd Logs
echo NetworkTest V%VerNo% > %cd%\CompLog.txt
echo %cd%\CompLog:%date%-%time%:txt                     Computer Log File                    %date% %time% >> %cd%\CompLog.txt
echo ============================================================System Information=============================================================== >> %cd%\CompLog.txt
systeminfo >> %cd%\CompLog.txt
echo. >> %cd%\CompLog.txt
echo ============================================================IP Configurations================================================ >> %cd%\CompLog.txt
ipconfig/all >> %cd%\CompLog.txt
echo. >> %cd%\CompLog.txt
echo ============================================================Network Statistics=============================================== >> %cd%\CompLog.txt
echo. >> %cd%\CompLog.txt
echo -------------------------------------------------Active Connections and Destination Ports------------------------------------ >> %cd%\CompLog.txt
netstat -n >> %cd%\CompLog.txt
echo. >> %cd%\CompLog.txt
echo ------------------------------------------------------------General Statistics----------------------------------------------- >> %cd%\CompLog.txt
netstat -s >> %cd%\CompLog.txt
echo. >> %cd%\CompLog.txt
echo ------------------------------------------------------------Ethernet Statistics---------------------------------------------- >> %cd%\CompLog.txt
netstat -e >> %cd%\CompLog.txt
echo. >> %cd%\CompLog.txt
echo ============================================================Driver List====================================================== >> %cd%\CompLog.txt
driverquery >> %cd%\CompLog.txt
FOR /F "TOKENS=1-3 DELIMS=/ " %%I IN ('DATE /T') DO ECHO %%K-%%J-%%I> Date.txt
FOR /F "TOKENS=1-2 DELIMS=: " %%A IN ('TIME /T') DO ECHO %%A-%%B> Time.txt
set /p FormDate=<Date.txt
set /p FormTime=<Time.txt
set LogName=CompLog%FormDate%_%FormTime%
ren CompLog.txt %LogName%.txt
del "Date.txt">nul
del "Time.txt">nul
echo Log File Created: %LogName%.txt
cd..
goto:eof

:DisplayNetworkInfo
echo.
echo                            NetworkTest V%VerNo%
echo.
type IP.txt & del "IP.txt" >nul
echo.
echo    Go to IP Configurations for full information
ping 127.0.0.1 -n 4 >nul 
goto:eof

:SubMainMenu
if %MainMenuPass% equ 0 goto SubMainMenuSetUp
cls
echo Welcome to NetworkTest 3.0                               %date% %time%
echo ===============================================================================
echo For change list type "changelog"                       --Network Stats--
echo Please select an option:                          Internet Status: %DisplayOnlineState%
echo [1] Active Connections                             Network Status: %DisplayConnectVar%
echo [2] IP Configurations                              Gateway Status: %DisplayGatewayState%
echo [3] Test Network Connections                    DNS Server Status: %DisplayDNSState%
echo [4] Network Statistics                               Lease Status: %DisplayLeaseState%
echo [5] Variable Ping                                Ethernet Adapter: %DisplayConnectMeth1%
echo [6] Website Look Up                              Wireless Adapter: %DisplayConnectMeth2%
echo [7] General Overview                              Hamachi Adapter: %DisplayConnectMeth3%
echo [8] Routing Tables                                           IPv4: %DisplayIPv4%
echo [9] Repair                                                   IPv6: %DisplayIPv6%
echo [10] Settings                                                 
echo [11] Logs
echo [12] Exit
echo [netdisplay] Network Statistical Display                            
set MainMenuPass=0
set /p choice1=Option: 
if %choice1% equ 1 goto Opt1Menu
if %choice1% equ 2 goto Opt2Menu
if %choice1% equ 3 goto Opt3Menu
if %choice1% equ 4 goto Opt7Menu
if %choice1% equ 5 goto Opt4Menu
if %choice1% equ 6 goto Opt5
if %choice1% equ 7 goto Opt6Menu
if %choice1% equ 8 goto Opt8
if %choice1% equ 9 goto RepairMenu
if %choice1% equ 10 goto SettingMenu
if %choice1% equ 11 cd Logs & start . & cd.. & goto SubMainMenu
if %choice1% equ 12 exit
if %choice1%==admin goto Admin
if %choice1%==changelog goto ChangeLog
if %choice1%==netdisplay start NETDIS~1.bat & goto SubMainMenu
if %choice1%==hackermode goto HACKERMODZ
if %choice1% gtr 12 set Errorlvl=1 & call :Error & goto SubMainMenu
goto:eof

:SubMainMenuSetUp
set DisplayConnectVar=0
set DisplayConnectMeth1=0
set DisplayConnectMeth2=0
set DisplayConnectMeth3=0
set DisplayOnlineState=0
set DisplayGatewayState=0
set DisplayDNSState=0
set DisplayLeaseState=0
set DisplayIPv4=0
set DisplayIPv6=0
ipconfig /all > %cd%\Connections.txt
findstr "Subnet Mask" %cd%\Connections.txt >nul && set DisplayConnectVar=1
if %DisplayConnectVar% equ 1 (set DisplayConnectVar=CONNECTED) else set DisplayConnectVar=DISCONNECTED
findstr /I /C:"Ethernet adapter Local Area Connection" %cd%\Connections.txt >nul && set DisplayConnectMeth1=1
findstr /I /C:"Wireless LAN Adapter Wireless Network Connection" %cd%\Connections.txt >nul && set DisplayConnectMeth2=1
findstr /I /C:"Hamachi" %cd%\Connections.txt >nul && set DisplayConnectMeth3=1
if %DisplayConnectMeth1% equ 1 (set DisplayConnectMeth1=ENABLED) else set DisplayConnectMeth1=DISABLED
if %DisplayConnectMeth2% equ 1 (set DisplayConnectMeth2=ENABLED) else set DisplayConnectMeth2=DISABLED
if %DisplayConnectMeth3% equ 1 (set DisplayConnectMeth3=ENABLED) else set DisplayConnectMeth3=DISABLED
ping 8.8.8.8 -n 3 -w 1000 -l 32 >nul && set DisplayOnlineState=1
if %DisplayOnlineState% equ 1 (set DisplayOnlineState=ONLINE) else set DisplayOnlineState=OFFLINE
findstr /I /C:"Default Gateway" %cd%\Connections.txt >nul && set DisplayGatewayState=1
if %DisplayGatewayState% equ 1 (set DisplayGatewayState=ACTIVE) else set DisplayGatewayState=INACTIVE
findstr /I /C:"DNS Server" %cd%\Connections.txt >nul && set DisplayDNSState=1
if %DisplayDNSState% equ 1 (set DisplayDNSState=CONNECTED) else set DisplayDNSState=DISCONNECTED
findstr /I /C:"Lease Obtained" %cd%\Connections.txt >nul && set DisplayLeaseState=1
if %DisplayLeaseState% equ 1 (set DisplayLeaseState=OBTAINED) else set DisplayLeaseState=NOT OBTAINED
findstr /I /C:"IPv4 Address" %cd%\Connections.txt >nul && set DisplayIPv4=1
findstr /I /C:"IPv6 Address" %cd%\Connections.txt >nul && set DisplayIPv6=1
if %DisplayIPv4% equ 1 (set DisplayIPv4=ENABLED) else set DisplayIPv4=DISABLED
if %DisplayIPv6% equ 1 (set DisplayIPv6=ENABLED) else set DisplayIPv6=DISABLED
del "Connections.txt"
set MainMenuPass=1 & goto SubMainMenu
goto:eof

:HACKERMODZ
color A
set bandom=      
set wandom=$%**
c:
tree
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%wandom%%random%
echo %wandom%%random%%random%%bandom%%random%%random%%bandom%%random%%random%%bandom%%random%%random%%bandom%%random%%random%%bandom%
echo %random%%bandom%%random%%random%%bandom%%bandom%%random%%random%%bandom%%wandom%%random%%random%%wandom%%bandom%%random%%random%
echo %random%%random%%wandom%%random%%random%%bandom%%wandom%%random%%random%%bandom%%bandom%%random%%random%%bandom%%bandom%%random%
echo %bandom%%bandom%%random%%random%%bandom%%bandom%%random%%random%%bandom%%wandom%%random%%random%%bandom%%bandom%%random%%random%
goto HACKERMODZ
goto:eof

:Admin
cls
echo ADMIN MENU                                               %date% %time%
echo ===============================================================================
echo Type "cls" to clear screen
goto WriteSW
goto:eof

:WriteSW
set /p WriteSW=Write to file[Y/N]?
if %WriteSW%==y (set WriteSW=1)
if %WriteSW%==n (set WriteSW=0)
if %WriteSW% equ 1 (
set /p FileName=File Name: 
goto FileSub )
goto AdminMenu
goto:eof

:FileSub
echo %cd%\%FileName%.txt  NetworkTest Admin File  %date% %time% >> %cd%\%FileName%.txt
systeminfo /fo table >> %cd%\%FileName%.txt
goto AdminMenu
goto:eof

:AdminMenu
echo Please select an option:
echo - DriverQuery
echo - SystemInformation
echo - TaskList
echo - EditMenu
echo - Settings
echo - NetworkConfig
echo - Exit
set /p adminchoice1=Option: 
if %adminchoice1%==driverquery goto DriverQuerySub
if %adminchoice1%==systeminformation goto SystemInfoSub
if %adminchoice1%==tasklist goto TaskListSub
if %adminchoice1%==editmenu goto EditMenu
if %adminchoice1%==settings goto SettingMenu
if %adminchoice1%==networkconfig goto NetworkConfigSub
if %adminchoice1%==cls goto Admin
if %adminchoice1%==exit goto AdminExit
goto:eof

:DriverQuerySub
if %WriteSW% equ 1 (echo Please Wait As Files Are Written. . . 
echo Driver List >> %cd%\%FileName%.txt & driverquery >> %cd%\%FileName%.txt )
if %WriteSW% equ 0 driverquery
pause
goto AdminMenu
goto:eof

:SystemInfoSub
if %WriteSW% equ 1 (echo Please Wait As Files Are Written. . . 
echo System Information >> %cd%\%FileName%.txt & systeminfo >> %cd%\%FileName%.txt )
if %WriteSW% equ 0 systeminfo
pause
goto AdminMenu
goto:eof

:TaskListSub
if %WriteSW% equ 1 (echo Please Wait As Files Are Written. . . 
echo Task List >> %cd%\%FileName%.txt & tasklist >> %cd%\%FileName%.txt
pause & goto AdminMenu )
if %WriteSW% equ 0 tasklist
echo Type "exit" to return to menu
set /p TaskKill=Kill Task: 
if %TaskKill%==exit (goto AdminMenu) else (
taskkill /im %Taskkill%)
pause
goto TaskListSub
goto:eof

:NetworkConfigSub
if %WriteSW% equ 1 (echo Please Wait As Files Are Written. . .
echo Network Configurations >> %cd%\%Filename%.txt & ipconfig /all >> %cd%\%FileName%.txt
pause & goto AdminMenu )
if %WriteSW% equ 0 ipconfig
pause
goto AdminMenu
goto:eof

:EditMenu
cls 
echo Edit Menu                                                %date% %time%
echo ===============================================================================
dir
set /p editchoice=Please type the filename you would like to edit: 
edit %editchoice%.bat
set /p editmenu=Return to Edit Menu[Y/N]?
if %editmenu%==y goto EditMenu
if %editmenu%==n goto Admin
goto:eof

:AdminExit
echo Return to menu[Y/N]?
set /p adminchoice2=
if %adminchoice2%==y goto SubMainMenu
if %adminchoice2%==n goto Admin
set Errorlvl=2 & call :Error
goto AdminExit
goto:eof

:ChangeLog
cls
echo NetworkTest3.0                                           %date% %time%
echo ===============================================================================
echo Programmed by Matthew Carney
echo [iluvekittykat@gmail.com]
echo V 3.0
echo  NetworkTest now comes in 2 versions:
echo  *NetworkTest3.0 - Full self extracting executable (.EXE) designed for install-
echo                    ation on a PC
echo  *NetworkTest3.0Portable - Portable version of NetworkTest3.0 containing all 
echo                            the same components of the PC version of NetworkTest
echo                            designed for use on a USB device comes as a ZIP File
echo  +Added complete and improved version of NetDisplay
echo  +Added HACKERMODZ (type hackmode while on the Main Menu)
echo V 1.3
echo  We are a fucking .exe (kinda)
echo  -NetworkTest now comes in the form of a Self Extraction Directive
echo   this means the file now comes in .exe format and will install the
echo   the program in the location: C:\Users\-UserName-\NetworkTest
echo  -The program will also create a shortcut called StartNetworkTest.bat
echo   which will be placed on installation on the users desktop, this shortcut
echo   can be placed anywhere on the computer and will always run NetworkTest
echo  +Added NetDisplay - This is Powershell script (.ps1) that will display
echo   network statistics and information in a nicer and better format than
echo   the version present on the main menu (and in pretty colours :3)
echo  -Changed processes in the installation process
echo V 1.2
echo  The 'Devil Update'
echo  Alpha tester: Matthew Kerins
echo -*Change file structure and layout*
echo -*Program now creates log text files containing computer
echo  information and IP configurations each time the program is started*
echo -Improved Start Up process
echo -Replaced () brackets with [] Brackets on user inputs
echo -Improved menu layout
echo -Improved Error system
echo +*Added installation process*
echo +*Added main menu status bar*
echo +New start up screen
echo +Added Statistcs Menu
echo   +Ethernet statistics
echo   +Complete list of network statistics
echo +Added Routing Tables 
echo +Added computer network list
echo +Added Renew Adapters option in Repair Menu
echo +Added network tables for TCP and UDP
echo +Added list of processes and active network connections
echo  tables
echo +Added Logs pop out menu
echo V 1.11
echo -Remade AdminMenu
echo +Added Repair menu
echo V 1.1
echo -Compiled all program batch files into one file
echo -Edited Menu Layouts
echo +Added Changelog
echo +Added Website Look Up
echo +Added DNS Cache Contents List
echo +Added General Overview
echo +Added Settings Menu
echo +Added Colour Menu
echo V 1.0
echo +Basic program structure
echo +Added Active Connection Tests
echo +Added IP Configuration Tests
echo +Added Network Connection Tests
echo +Added Variable Ping Test
pause & goto SubMainMenu
goto:eof

:SettingMenu
cls
echo Settings                                                 %date% %time%
echo ===============================================================================
echo Please select an option:
echo [1] Color Menu
echo [2] Main Menu
echo [3] Exit
set /p SettingChoice=Option: 
if %SettingChoice% equ 1 goto ColorMenu
if %SettingChoice% equ 2 goto SubMainMenu
if %SettingChoice% equ 3 exit
if %SettingChoice% gtr 3 set Errorlvl=1 & call :Error & goto SettingMenu
goto:eof

:ColorMenu
cls
echo Color Menu                                               %date% %time%
echo ===============================================================================
echo Please select a background and foreground colour from the list:
echo (Default is Black background and Light Red foreground)
echo Type 'exit' to return to Settings Menu
echo -Black				-Gray
echo -Blue				-Light Blue (lblue)
echo -Green				-Light Green (lgreen)
echo -Red				-Light Red (lred)
echo -Purple				-Light Purple (lpurple)
echo -Yellow				-Light Yellow (lyellow)
echo -White				-Bright White (bwhite)
set /p Background=Please select a background colour: 
if %Background%==black (set Background=0)
if %Background%==blue (set Background=1)
if %Background%==green (set Background=2)
if %Background%==aqua (set Background=3)
if %Background%==red (set Background=4)
if %Background%==purple (set Background=5)
if %Background%==yellow (set Background=6)
if %Background%==white (set Background=7)
if %Background%==gray (set Background=8)
if %Background%==lblue (set Background=9)
if %Background%==lgreen (set Background=A)
if %Background%==laqua (set Background=B)
if %Background%==lred (set Background=C)
if %Background%==lpurple (set Background=D)
if %Background%==lyellow (set Background=E)
if %Background%==bwhite (set Background=F)
if %Background%==exit (goto SettingMenu) 
set /p Foreground=Please select a foreground colour: 
if %Foreground%==black (set Foreground=0)
if %Foreground%==blue (set Foreground=1)
if %Foreground%==green (set Foreground=2)
if %Foreground%==aqua (set Foreground=3)
if %Foreground%==red (set Foreground=4)
if %Foreground%==purple (set Foreground=5)
if %Foreground%==yellow (set Foreground=6)
if %Foreground%==white (set Foreground=7)
if %Foreground%==gray (set Foreground=8)
if %Foreground%==lblue (set Foreground=9)
if %Foreground%==lgreen (set Foreground=A)
if %Foreground%==laqua (set Foreground=B)
if %Foreground%==lred (set Foreground=C)
if %Foreground%==lpurple (set Foreground=D)
if %Foreground%==lyellow (set Foreground=E)
if %Foreground%==bwhite (set Foreground=F)
if %Foreground%==exit (goto SettingMenu) 
color %Background%%Foreground%
set /p ColorOpt1=Do you wish to keep the current setting[Y/N]: 
if %ColorOpt1%==y goto SettingMenu
if %ColorOpt1%==n color %color% & goto ColorMenu
if %ColorOpt1%==exit goto SettingMenu
set Errorlvl=2 & call :Error
goto ColorMenu
goto:eof

:RepairMenu
cls
echo Repair Menu                                              %date% %time%
echo ===============================================================================
echo Please select an option:
echo [1] DNS Flush
echo [2] Renew Adapters
echo [3] Main Menu
echo [4] Exit
set /p RepairMenuChoice1=Option: 
if %RepairMenuChoice1% equ 1 goto DNSFlushStart
if %RepairMenuChoice1% equ 2 goto RenewSub
if %RepairMenuChoice1% equ 3 goto SubMainMenu
if %RepairMenuChoice1% equ 4 exit
if %RepairMenuChoice1% gtr 4 set Errorlvl=1 & call :Error & goto RepairMenu
goto:eof

:DNSFlushStart
set SucessSW=0
set PassCNT=0
goto DNSFlushTitleSub
goto:eof

:DNSFlushTitleSub
cls
echo DNS Flush                                                %date% %time%
echo ===============================================================================
if %PassCNT% equ 1 goto DNSFlush
if %PassCNT% equ 0 goto DNSFlushSub
goto:eof

:DNSFlushSub
echo - A Domain Name Sever (DNS) flush will clear the DNS cache on your computer
echo   clearing older outdated DNS data so that more up to date DNS information 
echo   from your Internet Service Provider (ISP) can be received
set /p DNSFlushSubOpt1=Continue[Y/N]?
if %DNSFlushSubOpt1%==y set PassCNT=1 & goto DNSFlushTitleSub
if %DNSFlushSubOpt1%==n goto RepairMenu
set Errorlvl=2 & call :Error
goto DNSFlushStart
goto:eof

:DNSFlush
echo Please Wait . . .
ipconfig /flushdns > %cd%\DNSFlush.txt 
find "Successfully" %cd%\DNSFlush.txt >nul && set SucessSW=1
if %SucessSW% equ 1 (goto DNSFlushSucess) else goto DNSFlushFail
goto:eof

:DNSFlushFail
set Errorlvl=3 & call :Error
type DNSFlush.txt
echo -This error may be due to restricted user or network rights on the computer 
echo  you are using
goto DNSFlushCleanUp
goto:eof

:DNSFlushSucess
echo -SUCCESS-
type DNSFlush.txt
goto DNSFlushCleanUp
goto:eof

:DNSFlushCleanUp
del "DNSFlush.txt"
pause
goto RepairMenu
goto:eof

:RenewSub
cls
echo Renew Adapters                                           %date% %time%
echo ===============================================================================
echo - Renewing a computers adapters will allow for new lease data to be obtainted
echo   by network adapters to allow for new IP address and more secure Domain Name 
echo   Server(DNS) and Internet Service Provider(ISP) data
set /p RenewSubChoice1=Continue[Y/N]?
if %RenewSubChoice1%==y goto RenewAdapters
if %RenewSubChoice1%==n goto RepairMenu
set Errorlvl=2 & call :Error & goto RenewSub
goto:eof

:RenewAdapters
cls
ipconfig /renew > %cd%\RenewAdapters.txt
findstr /C:"No operation can be performed" %cd%\RenewAdapters.txt && set ErrorFound=1
if %ErrorFound% equ 1 ( goto RenewFail ) else goto RenewSuccess
goto:eof

:RenewSuccess
cls
type RenewAdapters.txt
echo.
echo -SUCCESS-
echo.
del "RenewAdapters.txt">nul
set /p RenewSubChoice2=Return to menu[Y/N]?
if %RenewSubChoice2%==y goto RepairMenu
if %RenewSubChoice2%==n exit
goto:eof

:RenewFail
cls
echo - Error maybe due to Firewall being present or windows components are damaged
set Errorlvl=3 & call :Error
del "RenewAdapters.txt" >nul
pause & goto RepairMenu
got:eof

:Opt1Menu
cls
echo Active Connections                                       %date% %time%
echo ===============================================================================
echo Please select an option:
echo [1] List local and foreign Addresses
echo [2] List local active executables 
echo [3] List connections with process ID
echo [4] List computer network connections
echo [5] List all active routes
echo [6] List DNS Cache Contents
echo [7] Active TCP connections
echo [8] Active UDP connections
echo [9] General Connections Table
echo [10] Main menu
echo [11] Exit
set /p choice2=Option: 
if %choice2% equ 1 goto Opt1Sub1
if %choice2% equ 2 goto Opt1Sub2
if %choice2% equ 3 goto Opt1Sub7
if %choice2% equ 4 goto Opt1Sub6
if %choice2% equ 5 goto Opt1Sub3
if %choice2% equ 6 goto Opt1Sub4
if %choice2% equ 7 goto Opt1Sub8
if %choice2% equ 8 goto Opt1Sub9
if %choice2% equ 9 goto Opt1Sub5
if %choice2% equ 10 goto SubMainMenu
if %choice2% equ 11 exit
if %choice2% gtr 11 set Errorlvl=1 & call :Error & goto Opt1Menu
goto:eof

:Opt1Sub1
cls
echo Local And Foreign Addresses                              %date% %time%
echo ===============================================================================
netstat -n
echo.
echo Return to menu[Y/N]?
set /p Opt1SubChoice1=
if %Opt1SubChoice1%==y goto Opt1Menu
if %Opt1SubChoice1%==n exit
set Errorlvl=2 & call :Error & goto Opt1Sub1
goto:eof

:Opt1Sub2
cls
echo Local Active Exectutables                                %date% %time%
echo ===============================================================================
netstat -b
echo.
echo Return to menu[Y/N]?
set /p Opt1SubChoice2=
if %Opt1SubChoice2%==y goto Opt1Menu
if %Opt1SubChoice2%==n exit
set Errorlvl=2 & call :Error & goto Opt1Sub2
goto:eof

:Opt1Sub3
cls
echo Active Routes                                            %date% %time%
echo ===============================================================================
netstat -a
echo.
echo Return to menu[Y/N]?
set /p Opt1SubChoice3=
if %Opt1SubChoice3%==y goto Opt1Menu
if %Opt1SubChoice3%==n exit
set Errorlvl=2 & call :Error & goto Opt1Sub3
goto:eof

:Opt1Sub4
cls
echo DNS Cache Contents                                       %date% %time%
echo ===============================================================================
ipconfig /displaydns
echo.
echo Return to menu[Y/N]?
set /p Opt1SubChoice4=
if %Opt1SubChoice4%==y goto Opt1Menu
if %Opt1SubChoice4%==n exit
set Errorlvl=2 & call :Error & goto Opt1Sub4
goto:eof

:Opt1Sub5
cls
echo General Connections Table                                %date% %time%
echo ===============================================================================
netstat
echo.
echo Return to menu[Y/N]?
set /p Opt1SubChoice5=
if %Opt1SubChoice5%==y goto Opt1Menu
if %Opt1SubChoice5%==n exit
set Errorlvl=2 & call :Error & goto Opt1Sub5
goto:eof

:Opt1Sub6
cls
echo Computer Network Connections                             %date% %time%
echo ===============================================================================
netstat -a
echo.
echo Return to menu[Y/N]?
set /p Opt1SubChoice6=
if %Opt1SubChoice6%==y goto Opt1Menu
if %Opt1SubChoice6%==n exit
set Errorlvl=2 & call :Error & goto Opt1Sub6
goto:eof

:Opt1Sub7
cls
echo List connections with process ID                         %date% %time%
echo ===============================================================================
netstat -o
echo.
echo Return to menu[Y/N]?
set /p Opt1SubChoice7=
if %Opt1SubChoice7%==y goto Opt1Menu
if %Opt1SubChoice7%==n exit
set Errorlvl=2 & call :Error & goto Opt1Sub7
goto:eof

:Opt1Sub8
cls
echo Active TCP connections                                   %date% %time%
echo ===============================================================================
netstat -p tcp
echo.
echo Return to menu[Y/N]?
set /p Opt1SubChoice8=
if %Opt1SubChoice8%==y goto Opt1Menu
if %Opt1SubChoice8%==n exit
set Errorlvl=2 & call :Error & goto Opt1Sub8
goto:eof

:Opt1Sub9
cls
echo Active UDP connections                                   %date% %time%
echo ===============================================================================
netstat -p udp
echo.
echo Return to menu[Y/N]?
set /p Opt1SubChoice9=
if %Opt1SubChoice9%==y goto Opt1Menu
if %Opt1SubChoice9%==n exit
set Errorlvl=2 & call :Error & goto Opt1Sub9
goto:eof

:Opt2Menu
cls
echo IP Configurations                                        %date% %time%
echo ===============================================================================
echo Please select an option:
echo [1] General Configurations
echo [2] All Configurations
echo [3] Main Menu
echo [4] Exit
set /p choice3=Option: 
if %choice3% equ 1 goto Opt2Sub1
if %choice3% equ 2 goto Opt2Sub2
if %choice3% equ 3 goto SubMainMenu
if %choice3% equ 4 exit
if %choice3% gtr 4 set Errorlvl=1 & call :Error & goto Opt2Menu
goto:eof

:Opt2Sub1
cls
echo General Configurations                                   %date% %time%
echo ===============================================================================
ipconfig
echo Return to menu[Y/N]?
set /p Opt2SubChoice1=
if %Opt2SubChoice1%==y goto Opt2Menu
if %Opt2SubChoice1%==n exit
set Errorlvl=2 & call :Error & goto Opt2Sub1
goto:eof

:Opt2Sub2
cls
echo All Configurations                                       %date% %time%
echo ===============================================================================
ipconfig /all
echo Return to menu[Y/N]?
set /p Opt2SubChoice2=
if %Opt2SubChoice2%==y goto Opt2Menu
if %Opt2SubChoice2%==n exit
set Errorlvl=2 & call :Error & goto Opt2Sub2
goto:eof


:Opt3Menu
cls
echo Test Network Connections                                 %date% %time%
echo ===============================================================================
echo Please select an option:
echo [1] Ping to local adapter
echo [2] Ping test
echo [3] PathPing test
echo [4] Trace route
echo [5] Main Menu
echo [6] Exit
set /p choice4=Option: 
if %choice4% equ 1 goto Opt3Sub1
if %choice4% equ 2 goto Opt3Sub2
if %choice4% equ 3 goto Opt3Sub3
if %choice4% equ 4 goto Opt3Sub4
if %choice4% equ 5 goto SubMainMenu
if %choice4% equ 6 exit
if %choice4% gtr 6 set Errorlvl=1 & call :Error & goto Opt3Menu
goto:eof

:Opt3Sub1
cls
echo Local Adapter                                            %date% %time%
echo ===============================================================================
set /p PingNo1=Enter No of pings: 
Ping 127.0.0.1 -n %PingNo1%
echo Return to menu[Y/N]?
set /p Opt3SubChoice1=
if %Opt3SubChoice1%==y goto Opt3Menu
if %Opt3SubChoice1%==n exit
set Errorlvl=2 & call :Error & goto Opt3Sub1
goto:eof

:Opt3Sub2
cls
echo Ping Test                                                %date% %time%
echo ===============================================================================
set /p PingNo2=Enter No of pings: 
ping 8.8.8.8 -n %PingNo2% 
echo Return to menu[Y/N]?
set /p Opt3SubChoice2=
if %Opt3SubChoice2%==y goto Opt3Menu
if %Opt3SubChoice2%==n exit
set Errorlvl=2 & call :Error & goto Opt3Sub2
goto:eof

:Opt3Sub3
cls
echo Pathping Test                                            %date% %time%
echo ===============================================================================
pathping 8.8.8.8
echo Return to menu[Y/N]?
set /p Opt3SubChoice3=
if %Opt3SubChoice3%==y goto Opt3Menu
if %Opt3SubChoice3%==n exit
set Errorlvl=2 & call :Error & goto Opt3Sub3
goto:eof

:Opt3Sub4
cls
echo Trace Route                                              %date% %time%
echo ===============================================================================
tracert 8.8.8.8
echo Return to menu[Y/N]?
set /p Opt3SubChoice4=
if %Opt3SubChoice4%==y goto Opt3Menu
if %Opt3SubChoice4%==n exit
set Errorlvl=2 & call :Error & goto Opt3Sub4
goto:eof


:Opt4Menu
cls
echo Variable Ping                                            %date% %time%
echo ===============================================================================
set /p PingDest=Destination: 
set /p PingSize=Size(Bytes): 
set /p PingCnt=Number of Pings: 
set /p PingTime=Timeout(Milliseconds): 
pause
goto PingTest
goto:eof 

:PingTest
cls
ping %PingDest% -n %PingCnt% -l %PingSize% -w %PingTime%
echo Return to menu[Y/N]?
set /p Opt4SubChoice1=
if %Opt4SubChoice1%==y goto SubMainMenu
if %Opt4SubChoice1%==n exit
set Errorlvl=2 & call :Error & goto PingTest
goto:eof


:Opt5
cls
echo Website Look Up                                          %date% %time%
echo ===============================================================================
echo Type "exit" to return to menu
goto Opt5Sub1
goto:eof

:Opt5Sub1
set /p Website=Website:
if %Website%==exit (goto Opt5Sub2) else nslookup %Website%
goto Opt5Sub1
goto:eof

:Opt5Sub2
echo Return to menu[Y/N]?
set /p Opt5SubChoice1=
if %Opt5SubChoice1%==y goto SubMainMenu
if %Opt5SubChoice1%==n exit
set Errorlvl=2 & call :Error & goto Opt5Sub2
goto:eof


:Opt6Menu
cls
echo General Overview                                         %date% %time%
echo ===============================================================================
ipconfig && netstat
echo Return to menu[Y/N]?
set /p Opt6SubChoice1=
if %Opt6SubChoice1%==y goto SubMainMenu
if %Opt6SubChoice1%==n exit
set Errorlvl=2 & call :Error & goto Opt6Menu
goto:eof

:Opt7Menu
cls
echo Network Statistics                                       %date% %time%
echo ===============================================================================
echo Please select an option:
echo [1] Ethernet Statistics
echo [2] All Network Statistics
echo [3] Main Menu
echo [4] Exit
set /p Opt7Choice1=Option: 
if %Opt7Choice1% equ 1 goto Opt7Sub1
if %Opt7Choice1% equ 2 goto Opt7Sub2
if %Opt7Choice1% equ 3 goto SubMainMenu
if %Opt7Choice1% equ 4 exit
if %Opt7Choice1% gtr 4 set Errorlvl=1 & call :Error & goto Opt7Menu
goto:eof

:Opt7Sub1
cls
echo Ethernet Statistics                                      %date% %time%
echo ===============================================================================
netstat -e
echo Return to menu[Y/N]?
set /p Opt7Choice2=
if %Opt7Choice2%==y goto Opt7Menu
if %Opt7Choice2%==n exit
set Errorlvl=2 & call :Error
goto Opt7Sub1
goto:eof

:Opt7Sub2
cls
echo All Network Statistics                                   %date% %time%
echo ===============================================================================
netstat -s
echo Return to menu[Y/N]?
set /p Opt7Choice3=
if %Opt7Choice3%==y goto Opt7Menu
if %Opt7Choice3%==n exit
set Errorlvl=2 & call :Error & goto Opt7Sub2
goto:eof

:Opt8
cls
echo Routing Tables                                           %date% %time%
echo ===============================================================================
echo.
netstat -r
echo Return to menu[Y/N]
set /p Opt8Choice=
if %Opt8Choice%==y goto SubMainMenu
if %Opt8Choice%==n exit
set Errorlvl=2 & call :Error & goto Opt8
goto:eof

:Error
if %Errorlvl% equ 1 echo -INPUT ERROR: Please select again-
if %Errorlvl% equ 2 echo -OPTION ERROR: Please use apropriate characters-
if %Errorlvl% equ 3 echo -COMMAND FAILURE: Error in execution of command-
set Errorlvl=o
pause
goto:eof
