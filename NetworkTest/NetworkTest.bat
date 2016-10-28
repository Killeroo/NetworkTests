@ECHO off

REM NetworkTest3.1 EXPERIMENTAL - Network Diagnostics
REM Programmed by Matthew Carney [matthewcarney64@gmail.com]
REM Using Command Prompt (CMD.BAT)

REM CHANGES:
REM edited 5/11/2015 to run ping color (found in startup code) and allow to run additional powershell scripts from menu
REM Add warning before EXITING?
REM Uninstall feature?
REM look at symbols used within :NetworkInfo and search for logical operators
REM make all revert colour changes use global variable for colour
REM Add choice logic to settings and active connections
REM Capitalise title for submainmenus maybe add a varibale system for main bar for readbility
REM Website look up needs choice logic
REM Add a run function to run string commands from main menu to get to admin and hackers [BACKDOOR?]
REM ADD TEMP DIR FUNCTIONALITY FOR TEMP FILES USING %tmp%

:StartUp
ECHO Initializing StartUp . . .
CALL :Locater
CALL :VariableAssign
CALL :VariableSetUp
CALL :DirectorySetUp
CALL :LogGenerator
CALL :ConnectionPing
CALL :NetworkInfo
ECHO -StartUp Complete-
ping 127.0.0.1 -n 3 >nul
CLS
CALL :DisplayNetworkInfo
GOTO SubMainMenu
GOTO:eof

:Locater
ECHO Location Found: %CD%
GOTO:eof

:VariableAssign
SET title=Network Test 3.1 [Experimental]
SET color=C
SET lines=300
SET cols=80
SET MainMenuPass=0
SET MainMenuOptionView=0
SET VerNo=1.3.1
SET Errorlvl=0
ECHO Variable Assigning -Done-
GOTO:eof

:VariableSetUp
title %title%
color %color%
ECHO Variable Set Up -Done-
GOTO:eof

:ConnectionPing
start ConnectionPing.bat
ECHO Connection Console Started.
GOTO:eof

:NetworkInfo
ECHO NetworkInfo Started . . .
ipconfig /all > StartUp.txt
ECHO StartUp.txt Created. 
findstr /C:"Host Name" %CD%\StartUp.txt > %CD%\IP.txt || ECHO  Host Name . . . . . . . . . . . . : Unavailable && ECHO    Host Name . . . . . . . . . . . . : Unavailable > %CD%\IP.txt
findstr /C:"IPv4 Address" %CD%\StartUp.txt >> %CD%\IP.txt || ECHO  IPv4 Address. . . . . . . . . . . : Unavailable && ECHO    IPv4 Address. . . . . . . . . . . : Unavailable >> %CD%\IP.txt
findstr /C:"IPv6 Address" %CD%\StartUp.txt >> %CD%\IP.txt || ECHO  IPv6 Address. . . . . . . . . . . : Unavailable && ECHO    IPv6 Address. . . . . . . . . . . : Unavailable >> %CD%\IP.txt
findstr /C:"Default Gateway" %CD%\StartUp.txt >> %CD%\IP.txt || ECHO  Default Gateway . . . . . . . . . : Unavailable && ECHO    Default Gateway . . . . . . . . . : Unavailable >> %CD%\IP.txt
findstr /C:"DNS Servers" %CD%\StartUp.txt >> %CD%\IP.txt || ECHO  DNS Servers . . . . . . . . . . . : Unavailable && ECHO    DNS Servers . . . . . . . . . . . : Unavailable >> %CD%\IP.txt
ECHO Strings Found.
ECHO IP.txt Created.
DEL "StartUp.txt"
ECHO StartUp.txt Deleted.
GOTO:eof

:DirectorySetUp
SET LogDirChecker=0
SET InstallDirChecker=0
SET FileDir=%CD%
ECHO DirectorySetUp Started . . .
CD..
DIR | find "<DIR>          NetworkTest" >nul && SET InstallDirChecker=1
IF %InstallDirChecker% EQU 1 ( ECHO Install Directory Found. ) ELSE mkdir NetworkTest && ECHO Install Directory Created.
CD NetworkTest
DIR | find "Logs" >nul && SET LogDirChecker=1
IF %LogDirChecker% EQU 1 ( ECHO Log Directory Found. ) ELSE mkdir Logs && ECHO Log Directory Created.
CD..
IF %InstallDirChecker% EQU 0 ( copy "%FileDir%\NetworkTest.bat" "%CD%\NetworkTest\NetworkTest.bat" ) ELSE CD NetworkTest & ECHO DirectorySetUp -Done- & GOTO:eof
ECHO NetworkTest.bat Copied.
ECHO NetworkTest.bat Deleted.
CALL :StartUpCreater
ECHO DirectorySetUp -Done-
ECHO Restart Initialized . . . 
ping 127.0.0.1 -n 3 >nul
start StartNetworkTest.bat
exit
GOTO:eof

:StartUpCreater
color 02
ECHO @ECHO off > %CD%\StartNetworkTest.bat 
ECHO DEL %FileDir%\NetworkTest.bat >> %CD%\StartNetworkTest.bat
ECHO CLS >> %CD%\StartNetworkTest.bat
ECHO CD NetworkTest >> %CD%\StartNetworkTest.bat
ECHO NetworkTest.bat >> %CD%\StartNetworkTest.bat
ECHO StartUpFile Created.
GOTO:eof

:LogGenerator
CD Logs
ECHO NetworkTest V%VerNo% > %CD%\CompLog.txt
ECHO %CD%\CompLog:%date%-%time%:txt                     Computer Log File                    %date% %time% >> %CD%\CompLog.txt
ECHO ============================================================System Information=============================================================== >> %CD%\CompLog.txt
systeminfo >> %CD%\CompLog.txt
ECHO. >> %CD%\CompLog.txt
ECHO ============================================================IP Configurations================================================ >> %CD%\CompLog.txt
ipconfig/all >> %CD%\CompLog.txt
ECHO. >> %CD%\CompLog.txt
ECHO ============================================================Network Statistics=============================================== >> %CD%\CompLog.txt
ECHO. >> %CD%\CompLog.txt
ECHO -------------------------------------------------Active Connections and Destination Ports------------------------------------ >> %CD%\CompLog.txt
netstat -n >> %CD%\CompLog.txt
ECHO. >> %CD%\CompLog.txt
ECHO ------------------------------------------------------------General Statistics----------------------------------------------- >> %CD%\CompLog.txt
netstat -s >> %CD%\CompLog.txt
ECHO. >> %CD%\CompLog.txt
ECHO ------------------------------------------------------------Ethernet Statistics---------------------------------------------- >> %CD%\CompLog.txt
netstat -e >> %CD%\CompLog.txt
ECHO. >> %CD%\CompLog.txt
ECHO ============================================================Driver List====================================================== >> %CD%\CompLog.txt
driverquery >> %CD%\CompLog.txt
FOR /F "TOKENS=1-3 DELIMS=/ " %%I IN ('DATE /T') DO ECHO %%K-%%J-%%I> Date.txt
FOR /F "TOKENS=1-2 DELIMS=: " %%A IN ('TIME /T') DO ECHO %%A-%%B> Time.txt
SET /p FormDate=<Date.txt
SET /p FormTime=<Time.txt
SET LogName=CompLog%FormDate%_%FormTime%
ren CompLog.txt %LogName%.txt
DEL "Date.txt">nul
DEL "Time.txt">nul
ECHO Log File Created: %LogName%.txt
CD..
GOTO:eof

:DisplayNetworkInfo
ECHO.
ECHO                            NetworkTest V%VerNo%
ECHO.
TYPE IP.txt & DEL "IP.txt" >nul
ECHO.
ECHO    Go to IP Configurations for full information
ping 127.0.0.1 -n 4 >nul 
GOTO:eof

:SubMainMenu
IF %MainMenuPass% EQU 0 GOTO SubMainMenuSetUp
CLS
ECHO Welcome to NetworkTest 3.1Port                       %date% %time%
ECHO ===============================================================================
IF %MainMenuOptionView% EQU 1 CALL :SubMainMenu_OptionsTemplate_Main
IF %MainMenuOptionView% EQU 2 CALL :SubMainMenu_OptionsTemplate_NetStats
IF %MainMenuOptionView% EQU 3 CALL :SubMainMenu_OptionsTemplate_NetTests
IF %MainMenuOptionView% EQU 4 CALL :SubMainMenu_OptionsTemplate_PowerShellScripts
GOTO:eof

:SubMainMenu_OptionsTemplate_Main
SET MainMenuPass=0
ECHO Please select an option:                   -----------Network Stats-----------
ECHO [1] NETWORK STATISTICS ^& INFO              [   Internet Status: %DisplayOnlineState_Pre_Buffer%%DisplayOnlineState%%DisplayOnlineState_Post_Buffer%]
ECHO [2] TESTS ^& QUERIES                        [    Network Status: %DisplayNetworkState_Pre_Buffer%%DisplayNetworkState%%DisplayNetworkState_Post_Buffer%]
ECHO [3] POWERSHELL SCRIPTS                     [    Gateway Status: %DisplayGatewayState_Pre_Buffer%%DisplayGatewayState%%DisplayGatewayState_Post_Buffer%]
ECHO                                            [ DNS Server Status: %DisplayDNSState_Pre_Buffer%%DisplayDNSState%%DisplayDNSState_Post_Buffer%]
ECHO [4] GENERAL OVERVIEW                       -----------------------------------
ECHO                                            [      Lease Status: %DisplayLeaseState_Pre_Buffer%%DisplayLeaseState%%DisplayLeaseState_Post_Buffer%]
ECHO [5] REPAIR                                 -----------------------------------
ECHO [6] SETTINGS                               [  Ethernet Adapter: %DisplayConnectMeth1_Pre_Buffer%%DisplayConnectMeth1%%DisplayConnectMeth1_Post_Buffer%]
ECHO [7] CHANGELOG                              [  Wireless Adapter: %DisplayConnectMeth2_Pre_Buffer%%DisplayConnectMeth2%%DisplayConnectMeth2_Post_Buffer%]
ECHO [8] LOGS                                   [   Hamachi Adapter: %DisplayConnectMeth3_Pre_Buffer%%DisplayConnectMeth3%%DisplayConnectMeth3_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO [E] EXIT                                   [              IPv4: %DisplayIPv4_Pre_Buffer%%DisplayIPv4%%DisplayIPv4_Post_Buffer%]
ECHO                                            [              IPv6: %DisplayIPv6_Pre_Buffer%%DisplayIPv6%%DisplayIPv4_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO.
CHOICE /C 12345678E /N /M "Option:"
IF %errorlevel% EQU 1 SET MainMenuOptionView=2 & SET MainMenuPass=1 & GOTO SubMainMenu
IF %errorlevel% EQU 2 SET MainMenuOptionView=3 & SET MainMenuPass=1 & GOTO SubMainMenu
IF %errorlevel% EQU 3 SET MainMenuOptionView=4 & SET MainMenuPass=1 & GOTO SubMainMenu
IF %errorlevel% EQU 4 GOTO Opt6Menu REM RENAME
IF %errorlevel% EQU 5 GOTO RepairMenu REM RENAME
IF %errorlevel% EQU 6 GOTO SettingMenu REM RENAME
IF %errorlevel% EQU 7 GOTO ChangeLog
IF %errorlevel% EQU 8 CD Logs & start . & CD.. & GOTO SubMainMenu
IF %errorlevel% EQU 9 exit
GOTO:eof

:SubMainMenu_OptionsTemplate_NetStats
SET MainMenuPass=0
ECHO Please select an option:                   -----------Network Stats-----------
ECHO Network Statistics ^& Info:                 [   Internet Status: %DisplayOnlineState_Pre_Buffer%%DisplayOnlineState%%DisplayOnlineState_Post_Buffer%]
ECHO [1] Active Connections                     [    Network Status: %DisplayNetworkState_Pre_Buffer%%DisplayNetworkState%%DisplayNetworkState_Post_Buffer%]
ECHO [2] IP Configurations                      [    Gateway Status: %DisplayGatewayState_Pre_Buffer%%DisplayGatewayState%%DisplayGatewayState_Post_Buffer%]
ECHO [3] Network Statistics                     [ DNS Server Status: %DisplayDNSState_Pre_Buffer%%DisplayDNSState%%DisplayDNSState_Post_Buffer%]
ECHO [4] General Overview                       -----------------------------------
ECHO [5] Routing Table                          [      Lease Status: %DisplayLeaseState_Pre_Buffer%%DisplayLeaseState%%DisplayLeaseState_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO [B] Back to menu                           [  Ethernet Adapter: %DisplayConnectMeth1_Pre_Buffer%%DisplayConnectMeth1%%DisplayConnectMeth1_Post_Buffer%]
ECHO [E] Exit                                   [  Wireless Adapter: %DisplayConnectMeth2_Pre_Buffer%%DisplayConnectMeth2%%DisplayConnectMeth2_Post_Buffer%]
ECHO                                            [   Hamachi Adapter: %DisplayConnectMeth3_Pre_Buffer%%DisplayConnectMeth3%%DisplayConnectMeth3_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO                                            [              IPv4: %DisplayIPv4_Pre_Buffer%%DisplayIPv4%%DisplayIPv4_Post_Buffer%]
ECHO                                            [              IPv6: %DisplayIPv6_Pre_Buffer%%DisplayIPv6%%DisplayIPv4_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO.
CHOICE /C 12345BE /N /M "Option:"
IF %errorlevel% EQU 1 GOTO Opt1Menu REM Rename
IF %errorlevel% EQU 2 GOTO Opt2Menu REM Rename
IF %errorlevel% EQU 3 GOTO Opt7Menu REM Rename
IF %errorlevel% EQU 4 GOTO Opt6Menu REM Rename
IF %errorlevel% EQU 5 GOTO Opt8 REM Rename
IF %errorlevel% EQU 6 SET MainMenuOptionView=1 & SET MainMenuPass=1 & GOTO SubMainMenu
IF %errorlevel% EQU 7 exit
GOTO:eof

:SubMainMenu_OptionsTemplate_NetTests
SET MainMenuPass=0
ECHO Please select an option:                   -----------Network Stats-----------
ECHO Tests ^& Queries:                           [   Internet Status: %DisplayOnlineState_Pre_Buffer%%DisplayOnlineState%%DisplayOnlineState_Post_Buffer%]
ECHO [1] Test Network Connections               [    Network Status: %DisplayNetworkState_Pre_Buffer%%DisplayNetworkState%%DisplayNetworkState_Post_Buffer%]
ECHO [2] Variable Ping                          [    Gateway Status: %DisplayGatewayState_Pre_Buffer%%DisplayGatewayState%%DisplayGatewayState_Post_Buffer%]
ECHO [3] Website Look Up                        [ DNS Server Status: %DisplayDNSState_Pre_Buffer%%DisplayDNSState%%DisplayDNSState_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO [B] Back to menu                           [      Lease Status: %DisplayLeaseState_Pre_Buffer%%DisplayLeaseState%%DisplayLeaseState_Post_Buffer%]
ECHO [E] Exit                                   -----------------------------------
ECHO                                            [  Ethernet Adapter: %DisplayConnectMeth1_Pre_Buffer%%DisplayConnectMeth1%%DisplayConnectMeth1_Post_Buffer%]
ECHO                                            [  Wireless Adapter: %DisplayConnectMeth2_Pre_Buffer%%DisplayConnectMeth2%%DisplayConnectMeth2_Post_Buffer%]
ECHO                                            [   Hamachi Adapter: %DisplayConnectMeth3_Pre_Buffer%%DisplayConnectMeth3%%DisplayConnectMeth3_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO                                            [              IPv4: %DisplayIPv4_Pre_Buffer%%DisplayIPv4%%DisplayIPv4_Post_Buffer%]
ECHO                                            [              IPv6: %DisplayIPv6_Pre_Buffer%%DisplayIPv6%%DisplayIPv4_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO.
CHOICE /C 123BE /N /M "Option:"
IF %errorlevel% EQU 1 GOTO Opt3Menu REM Rename
IF %errorlevel% EQU 2 GOTO Opt4Menu REM Rename
IF %errorlevel% EQU 3 GOTO Opt5 REM Rename
IF %errorlevel% EQU 4 SET MainMenuOptionView=1 & SET MainMenuPass=1 & GOTO SubMainMenu
IF %errorlevel% EQU 5 exit
GOTO:eof

:SubMainMenu_OptionsTemplate_PowerShellScripts
SET MainMenuPass=0
ECHO Please select an option:                   -----------Network Stats-----------
ECHO PowerShell Scripts:                        [   Internet Status: %DisplayOnlineState_Pre_Buffer%%DisplayOnlineState%%DisplayOnlineState_Post_Buffer%]
ECHO [1] NetDisplay - Network Stat Display      [    Network Status: %DisplayNetworkState_Pre_Buffer%%DisplayNetworkState%%DisplayNetworkState_Post_Buffer%]
ECHO [2] IPRanger - Ping Scanning Utility       [    Gateway Status: %DisplayGatewayState_Pre_Buffer%%DisplayGatewayState%%DisplayGatewayState_Post_Buffer%]
ECHO [3] PingLooper - Speed Ping Sender         [ DNS Server Status: %DisplayDNSState_Pre_Buffer%%DisplayDNSState%%DisplayDNSState_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO [B] Back to menu                           [      Lease Status: %DisplayLeaseState_Pre_Buffer%%DisplayLeaseState%%DisplayLeaseState_Post_Buffer%]
ECHO [E] Exit                                   -----------------------------------
ECHO                                            [  Ethernet Adapter: %DisplayConnectMeth1_Pre_Buffer%%DisplayConnectMeth1%%DisplayConnectMeth1_Post_Buffer%]
ECHO                                            [  Wireless Adapter: %DisplayConnectMeth2_Pre_Buffer%%DisplayConnectMeth2%%DisplayConnectMeth2_Post_Buffer%]
ECHO                                            [   Hamachi Adapter: %DisplayConnectMeth3_Pre_Buffer%%DisplayConnectMeth3%%DisplayConnectMeth3_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO                                            [              IPv4: %DisplayIPv4_Pre_Buffer%%DisplayIPv4%%DisplayIPv4_Post_Buffer%]
ECHO                                            [              IPv6: %DisplayIPv6_Pre_Buffer%%DisplayIPv6%%DisplayIPv4_Post_Buffer%]
ECHO                                            -----------------------------------
ECHO.
CHOICE /C 123BE /N /M "Option:"
IF %errorlevel% EQU 1 start NetDisplayStart.bat & SET MainMenuOptionView=4 & SET MainMenuPass=1 & GOTO SubMainMenu
IF %errorlevel% EQU 2 start IPRanger_Launcher.bat & SET MainMenuOptionView=4 & SET MainMenuPass=1 & GOTO SubMainMenu
IF %errorlevel% EQU 3 start PingLooper_Launcher.bat & SET MainMenuOptionView=4 & SET MainMenuPass=1 & GOTO SubMainMenu 
IF %errorlevel% EQU 4 SET MainMenuOptionView=1 &  SET MainMenuPass=1 & GOTO SubMainMenu
IF %errorlevel% EQU 5 exit
GOTO:eof

:SubMainMenuSetUp
SET DisplayNetworkState=0
SET DisplayConnectMeth1=0
SET DisplayConnectMeth2=0
SET DisplayConnectMeth3=0
SET DisplayOnlineState=0
SET DisplayGatewayState=0
SET DisplayDNSState=0
SET DisplayLeaseState=0
SET DisplayIPv4=0
SET DisplayIPv6=0
ipconfig /all > %CD%\Connections.txt
ping 8.8.8.8 -n 3 -w 1000 -l 32 > %CD%\tempPing.txt 
findstr /I /C:"Reply from 8.8.8.8:" %CD%\tempPing.txt >nul && SET DisplayOnlineState=1
findstr "Subnet Mask" %CD%\Connections.txt >nul && SET DisplayNetworkState=1
findstr /I /C:"Ethernet adapter Local Area Connection" %CD%\Connections.txt >nul && SET DisplayConnectMeth1=1
findstr /I /C:"Wireless LAN Adapter Wireless Network Connection" %CD%\Connections.txt >nul && SET DisplayConnectMeth2=1
findstr /I /C:"Hamachi" %CD%\Connections.txt >nul && SET DisplayConnectMeth3=1
findstr /I /C:"Default Gateway" %CD%\Connections.txt >nul && SET DisplayGatewayState=1
findstr /I /C:"DNS Server" %CD%\Connections.txt >nul && SET DisplayDNSState=1
findstr /I /C:"Lease Obtained" %CD%\Connections.txt >nul && SET DisplayLeaseState=1
findstr /I /C:"IPv4 Address" %CD%\Connections.txt >nul && SET DisplayIPv4=1
findstr /I /C:"IPv6 Address" %CD%\Connections.txt >nul && SET DisplayIPv6=1
IF %DisplayOnlineState% EQU 1 (
SET DisplayOnlineState=ONLINE
SET DisplayOnlineState_Pre_Buffer=    
SET DisplayOnlineState_Post_Buffer=   
) ELSE (
SET DisplayOnlineState=OFFLINE
SET DisplayOnlineState_Pre_Buffer=   
SET DisplayOnlineState_Post_Buffer=   
)
IF %DisplayNetworkState% EQU 1 (
SET DisplayNetworkState=ONLINE
SET DisplayNetworkState_Pre_Buffer=    
SET DisplayNetworkState_Post_Buffer=   
) ELSE (
SET DisplayNetworkState=OFFLINE
SET DisplayNetworkState_Pre_Buffer=   
SET DisplayNetworkState_Post_Buffer=   
)
IF %DisplayGatewayState% EQU 1 (
SET DisplayGatewayState=ONLINE
SET DisplayGatewayState_Pre_Buffer=    
SET DisplayGatewayState_Post_Buffer=   
) ELSE (
SET DisplayGatewayState=OFFLINE
SET DisplayGatewayState_Pre_Buffer=   
SET DisplayGatewayState_Post_Buffer=   
)
IF %DisplayDNSState% EQU 1 (
SET DisplayDNSState=ONLINE
SET DisplayDNSSTate_Pre_Buffer=    
SET DisplayDNSState_Post_Buffer=   
) ELSE (
SET DisplayDNSState=OFFLINE
SET DisplayDNSSTate_Pre_Buffer=   
SET DisplayDNSState_Post_Buffer=   
)
IF %DisplayLeaseState% EQU 1 (
SET DisplayLeaseState=VALID
SET DisplayLeaseState_Pre_Buffer=    
SET DisplayLeaseState_Post_Buffer=    
) ELSE (
SET DisplayLeaseState=INVALID
SET DisplayLeaseState_Pre_Buffer=   
SET DisplayLeaseState_Post_Buffer=   
)
IF %DisplayConnectMeth1% EQU 1 (
SET DisplayConnectMeth1=ENABLED
SET DisplayConnectMeth1_Pre_Buffer=   
SET DisplayConnectMeth1_Post_Buffer=   
) ELSE (
SET DisplayConnectMeth1=DISABLED
SET DisplayConnectMeth1_Pre_Buffer=   
SET DisplayConnectMeth1_Post_Buffer=  
)
IF %DisplayConnectMeth2% EQU 1 (
SET DisplayConnectMeth2=ENABLED
SET DisplayConnectMeth2_Pre_Buffer=   
SET DisplayConnectMeth2_Post_Buffer=   
) ELSE (
SET DisplayConnectMeth2=DISABLED
SET DisplayConnectMeth2_Pre_Buffer=   
SET DisplayConnectMeth2_Post_Buffer=  
)
IF %DisplayConnectMeth3% EQU 1 (
SET DisplayConnectMeth3=ENABLED
SET DisplayConnectMeth3_Pre_Buffer=   
SET DisplayConnectMeth3_Post_Buffer=   
) ELSE (
SET DisplayConnectMeth3=DISABLED
SET DisplayConnectMeth3_Pre_Buffer=   
SET DisplayConnectMeth3_Post_Buffer=  
)
IF %DisplayIPv4% EQU 1 (
SET DisplayIPv4=ENABLED
SET DisplayIPv4_Pre_Buffer=   
SET DisplayIPv4_Post_Buffer=   
) ELSE (
SET DisplayIPv4=DISABLED
SET DisplayIPv4_Pre_Buffer=   
SET DisplayIPv4_Post_Buffer=  
)
IF %DisplayIPv6% EQU 1 (
SET DisplayIPv6=ENABLED
SET DisplayIPv6_Pre_Buffer=   
SET DisplayIPv6_Post_Buffer=   
) ELSE (
SET DisplayIPv6=DISABLED
SET DisplayIPv6_Pre_Buffer=   
SET DisplayIPv6_Post_Buffer=  
)
DEL "Connections.txt"
DEL "tempPing.txt"
SET MainMenuPass=1 & SET MainMenuOptionView=1 & GOTO SubMainMenu
GOTO:eof

:HACKERMODZ
color A
SET bandom=      
SET wandom=$%**
c: & CD\
tree
ECHO %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%wandom%%random%
ECHO %wandom%%random%%random%%bandom%%random%%random%%bandom%%random%%random%%bandom%%random%%random%%bandom%%random%%random%%bandom%
ECHO %random%%bandom%%random%%random%%bandom%%bandom%%random%%random%%bandom%%wandom%%random%%random%%wandom%%bandom%%random%%random%
ECHO %random%%random%%wandom%%random%%random%%bandom%%wandom%%random%%random%%bandom%%bandom%%random%%random%%bandom%%bandom%%random%
ECHO %bandom%%bandom%%random%%random%%bandom%%bandom%%random%%random%%bandom%%wandom%%random%%random%%bandom%%bandom%%random%%random%
GOTO HACKERMODZ
GOTO:eof

:Admin
CLS
ECHO ADMIN MENU                                           %date% %time%
ECHO ===============================================================================
ECHO TYPE "CLS" to clear screen
GOTO WriteSW
GOTO:eof

:WriteSW
CHOICE /C YN /M "Write to file"
IF %errorlevel% EQU 1 (
SET /p FileName=File Name: 
SET WriteSW=1 
GOTO FileSub
)
IF %errorlevel% EQU 2 (
SET WriteSW=0
GOTO AdminMenu
)
GOTO:eof

:FileSub
ECHO %CD%\%FileName%.txt  NetworkTest Admin File  %date% %time% >> %CD%\%FileName%.txt
systeminfo /fo table >> %CD%\%FileName%.txt
GOTO AdminMenu
GOTO:eof

:AdminMenu
ECHO Please select an option:
ECHO - DriverQuery
ECHO - SystemInformation
ECHO - TaskList
ECHO - EditMenu [XP ONLY]
ECHO - Settings
ECHO - NetworkConfig
ECHO - Exit
SET /p adminchoice1=Option: 
IF %adminchoice1%==driverquery GOTO DriverQuerySub
IF %adminchoice1%==systeminformation GOTO SystemInfoSub
IF %adminchoice1%==tasklist GOTO TaskListSub
IF %adminchoice1%==editmenu GOTO EditMenu
IF %adminchoice1%==settings GOTO SettingMenu
IF %adminchoice1%==networkconfig GOTO NetworkConfigSub
IF %adminchoice1%==cls GOTO Admin
IF %adminchoice1%==exit GOTO AdminExit
SET Errorlvl=1 & CALL :Error & GOTO AdminMenu
GOTO:eof

:DriverQuerySub
IF %WriteSW% EQU 1 (ECHO Please Wait As Files Are Written. . . 
ECHO Driver List >> %CD%\%FileName%.txt & driverquery >> %CD%\%FileName%.txt )
IF %WriteSW% EQU 0 driverquery
PAUSE
GOTO AdminMenu
GOTO:eof

:SystemInfoSub
IF %WriteSW% EQU 1 (ECHO Please Wait As Files Are Written. . . 
ECHO System Information >> %CD%\%FileName%.txt & systeminfo >> %CD%\%FileName%.txt )
IF %WriteSW% EQU 0 systeminfo
PAUSE
GOTO AdminMenu
GOTO:eof

:TaskListSub
IF %WriteSW% EQU 1 (ECHO Please Wait As Files Are Written. . . 
ECHO Task List >> %CD%\%FileName%.txt & tasklist >> %CD%\%FileName%.txt
PAUSE & GOTO AdminMenu )
IF %WriteSW% EQU 0 tasklist
ECHO TYPE "exit" to return to menu
SET /p TaskKill=Kill Task: 
IF %TaskKill%==exit (GOTO AdminMenu) ELSE (
taskkill /im %Taskkill%)
PAUSE
GOTO TaskListSub
GOTO:eof

:NetworkConfigSub
IF %WriteSW% EQU 1 (ECHO Please Wait As Files Are Written. . .
ECHO Network Configurations >> %CD%\%Filename%.txt & ipconfig /all >> %CD%\%FileName%.txt
PAUSE & GOTO AdminMenu )
IF %WriteSW% EQU 0 ipconfig
PAUSE
GOTO AdminMenu
GOTO:eof

:EditMenu
CLS 
ECHO Edit Menu                                            %date% %time%
ECHO ===============================================================================
DIR
SET /p editchoice=Please TYPE the filename you would like to edit: 
edit %editchoice%.bat 
SET /p editmenu=Return to Edit Menu[Y/N]?
IF %editmenu%==y GOTO EditMenu
IF %editmenu%==n GOTO Admin
GOTO:eof

:AdminExit
CHOICE /C YN /M "Return to menu"
IF %errorlevel% EQU 1 (
ECHO Loading Please Wait . . .
GOTO SubMainMenu
)
IF %errorlevel% EQU 2 GOTO Admin
GOTO:eof

:ChangeLog
CLS
ECHO NetworkTest3.0Port                                   %date% %time%
ECHO ===============================================================================
ECHO Programmed by Matthew Carney
ECHO [matthewcarney64@gmail.com]
ECHO V 3.1
ECHO  Usability Release
ECHO  -*Reworked menus and tests to be easier to navigate and use*
ECHO  -*Program now starts up a constant Ping Connection console that sends a ping
ECHO   connection request to the Google DNS servers to see IF the an internet is
ECHO   establised. Green means that a reply has been recieved, red means a request
ECHO   has timed out.*
ECHO  +*Changed the almost every menu for single key press selection allowing for
ECHO    faster navigation*
ECHO  +*Total overhaul of the logic and interface of the main menu and sub menus*
ECHO  +Added IPRanger Powershell Script
ECHO  +Added PingLooper Powershell Script
ECHO  +Added Connection Console to start up process
ECHO  +Added Window Resize option to settings menu
ECHO  +Added Failure and Pass states to tests in Test Network Connections
ECHO  +Added Colorized option for Variable Ping
ECHO  -Fixed menu layouts to stop unintended console cropping
ECHO  -Fixed handling of invalid input in admin menu
ECHO  -Fixed offline string misalignment in start up process
ECHO  -Edited syntax layout of code to be more readable
ECHO  -Edited admin menu selection logic to use choice command for faster response
ECHO  -Edited each of menu option to pause instead of prompting for menu return
ECHO   or exit
ECHO  -Updated all menus to use choice logic for faster navigation
ECHO  -Updated Ping Test logical
ECHO  -Updated Variable Ping code 
ECHO V 3.0
ECHO  NetworkTest now comes in 2 versions:
ECHO  *NetworkTest3.0 - Full self extracting executable (.EXE) designed for install-
ECHO                    ation on a PC
ECHO  *NetworkTest3.0Portable - Portable version of NetworkTest3.0 containing all 
ECHO                            the same components of the PC version of NetworkTest
ECHO                            designed for use on a USB device comes as a ZIP File
ECHO  +Added complete and improved version of NetDisplay
ECHO  +Added HACKERMODZ (TYPE hackmode while on the Main Menu) 
ECHO V 1.3
ECHO  We are a fucking .exe (kinda)
ECHO  -NetworkTest now comes in the form of a Self Extraction Directive
ECHO   this means the file now comes in .exe format and will install the
ECHO   the program in the location: C:\Users\-UserName-\NetworkTest
ECHO  -The program will also create a shortcut called StartNetworkTest.bat
ECHO   which will be placed on installation on the users desktop, this shortcut
ECHO   can be placed anywhere on the computer and will always run NetworkTest
ECHO  +Added NetDisplay - This is Powershell script (.ps1) that will display
ECHO   network statistics and information in a nicer and better format than
ECHO   the version present on the main menu (and in pretty colours :3)
ECHO  -Changed processes in the installation process
ECHO V 1.2
ECHO  The 'Devil Update'
ECHO  Alpha tester: Matthew Kerins
ECHO -*Change file structure and layout*
ECHO -*Program now creates log text files containing computer
ECHO  information and IP configurations each time the program is started*
ECHO -Improved Start Up process
ECHO -Replaced () brackets with [] Brackets on user inputs
ECHO -Improved menu layout
ECHO -Improved Error system
ECHO +*Added installation process*
ECHO +*Added main menu status bar*
ECHO +New start up screen
ECHO +Added Statistcs Menu
ECHO   +Ethernet statistics
ECHO   +Complete list of network statistics
ECHO +Added Routing Tables 
ECHO +Added computer network list
ECHO +Added Renew Adapters option in Repair Menu
ECHO +Added network tables for TCP and UDP
ECHO +Added list of processes and active network connections
ECHO  tables
ECHO +Added Logs pop out menu
ECHO V 1.11
ECHO -Remade AdminMenu
ECHO +Added Repair menu
ECHO V 1.1
ECHO -Compiled all program batch files into one file
ECHO -Edited Menu Layouts
ECHO +Added Changelog
ECHO +Added Website Look Up
ECHO +Added DNS Cache Contents List
ECHO +Added General Overview
ECHO +Added Settings Menu
ECHO +Added Colour Menu
ECHO V 1.0
ECHO +Basic program structure
ECHO +Added Active Connection Tests
ECHO +Added IP Configuration Tests
ECHO +Added Network Connection Tests
ECHO +Added Variable Ping Test
PAUSE & GOTO SubMainMenu
GOTO:eof

:SettingMenu
CLS
ECHO Settings                                             %date% %time%
ECHO ===============================================================================
ECHO Please select an option:
ECHO [1] Color Menu
ECHO [2] Size Menu
ECHO [3] Main Menu
ECHO [4] Exit
SET /p SettingChoice=Option: 
IF %SettingChoice% EQU 1 GOTO ColorMenu
IF %SettingChoice% EQU 2 GOTO SizeMenu
IF %SettingChoice% EQU 3 GOTO SubMainMenu
IF %SettingChoice% EQU 4 exit
IF %SettingChoice% GTR 4 SET Errorlvl=1 & CALL :Error & GOTO SettingMenu
GOTO:eof

:ColorMenu
CLS
ECHO Color Menu                                           %date% %time%
ECHO ===============================================================================
ECHO Please select a background and foreground colour from the list:
ECHO (Default is Black background and Light Red foreground)
ECHO Type 'exit' to return to Settings Menu
ECHO -Black				-Gray
ECHO -Blue				-Light Blue (lblue)
ECHO -Green				-Light Green (lgreen)
ECHO -Red				-Light Red (lred)
ECHO -Purple				-Light Purple (lpurple)
ECHO -Yellow				-Light Yellow (lyellow)
ECHO -White				-Bright White (bwhite)
SET /p Background=Please select a background colour: 
IF %Background%==black (SET Background=0)
IF %Background%==blue (SET Background=1)
IF %Background%==green (SET Background=2)
IF %Background%==aqua (SET Background=3)
IF %Background%==red (SET Background=4)
IF %Background%==purple (SET Background=5)
IF %Background%==yellow (SET Background=6)
IF %Background%==white (SET Background=7)
IF %Background%==gray (SET Background=8)
IF %Background%==lblue (SET Background=9)
IF %Background%==lgreen (SET Background=A)
IF %Background%==laqua (SET Background=B)
IF %Background%==lred (SET Background=C)
IF %Background%==lpurple (SET Background=D)
IF %Background%==lyellow (SET Background=E)
IF %Background%==bwhite (SET Background=F)
IF %Background%==exit (GOTO SettingMenu) 
SET /p Foreground=Please select a foreground colour: 
IF %Foreground%==black (SET Foreground=0)
IF %Foreground%==blue (SET Foreground=1)
IF %Foreground%==green (SET Foreground=2)
IF %Foreground%==aqua (SET Foreground=3)
IF %Foreground%==red (SET Foreground=4)
IF %Foreground%==purple (SET Foreground=5)
IF %Foreground%==yellow (SET Foreground=6)
IF %Foreground%==white (SET Foreground=7)
IF %Foreground%==gray (SET Foreground=8)
IF %Foreground%==lblue (SET Foreground=9)
IF %Foreground%==lgreen (SET Foreground=A)
IF %Foreground%==laqua (SET Foreground=B)
IF %Foreground%==lred (SET Foreground=C)
IF %Foreground%==lpurple (SET Foreground=D)
IF %Foreground%==lyellow (SET Foreground=E)
IF %Foreground%==bwhite (SET Foreground=F)
IF %Foreground%==exit (GOTO SettingMenu) 
color %Background%%Foreground%
SET /p ColorOpt1=Do you wish to keep the current setting[Y/N]: 
IF %ColorOpt1%==y GOTO SettingMenu
IF %ColorOpt1%==n color %color% & GOTO ColorMenu
IF %ColorOpt1%==exit GOTO SettingMenu
SET Errorlvl=2 & CALL :Error
GOTO ColorMenu
GOTO:eof

:SizeMenu
CLS
ECHO Size Menu                                           %date% %time%
ECHO ===============================================================================
FOR /F "usebackq tokens=2* delims=: " %%I IN (`MODE CON ^| findstr Columns`) DO SET Console_Width=%%I
FOR /F "usebackq tokens=2* delims=: " %%I IN (`MODE CON ^| findstr Lines`) DO SET Console_Height=%%I
ECHO Current console width %Console_Width% Characters
ECHO Current console height %Console_Height% Lines
ECHO Type 'exit' to return to Settings Menu
ECHO.
SET /p SizeOptionWidth=Please Enter New Width: 
IF %SizeOptionWidth%==exit GOTO SettingMenu
SET /p SizeOptionHeight=Please Enter New Height: 
IF %SizeOptionHeight%==exit GOTO SettingMenu
MODE CON: lines=%SizeOptionHeight% cols=%SizeOptionWidth%
CHOICE /C YN /M "Would you like to keep the current screen size?"
IF %errorlevel% EQU 1 GOTO SettingMenu
IF %errorlevel% EQU 2 MODE CON: lines=%Console_Height% cols=%Console_Width% & GOTO SizeMenu 
GOTO:eof

:RepairMenu
CLS
ECHO Repair Menu                                          %date% %time%
ECHO ===============================================================================
ECHO Please select an option:
ECHO [1] DNS Flush
ECHO [2] Renew Adapters
ECHO [3] Main Menu
ECHO [4] Exit
SET /p RepairMenuChoice1=Option: 
IF %RepairMenuChoice1% EQU 1 GOTO DNSFlushStart
IF %RepairMenuChoice1% EQU 2 GOTO RenewSub
IF %RepairMenuChoice1% EQU 3 GOTO SubMainMenu
IF %RepairMenuChoice1% EQU 4 exit
IF %RepairMenuChoice1% GTR 4 SET Errorlvl=1 & CALL :Error & GOTO RepairMenu
GOTO:eof

:DNSFlushStart
SET SucessSW=0
SET PassCNT=0
GOTO DNSFlushTitleSub
GOTO:eof

:DNSFlushTitleSub
CLS
ECHO DNS Flush                                            %date% %time%
ECHO ===============================================================================
IF %PassCNT% EQU 1 GOTO DNSFlush
IF %PassCNT% EQU 0 GOTO DNSFlushSub
GOTO:eof

:DNSFlushSub
ECHO - A Domain Name Sever (DNS) flush will clear the DNS cache on your computer
ECHO   clearing older outdated DNS data so that more up to date DNS information 
ECHO   from your Internet Service Provider (ISP) can be received
SET /p DNSFlushSubOpt1=Continue[Y/N]?
IF %DNSFlushSubOpt1%==y SET PassCNT=1 & GOTO DNSFlushTitleSub
IF %DNSFlushSubOpt1%==n GOTO RepairMenu
SET Errorlvl=2 & CALL :Error
GOTO DNSFlushStart
GOTO:eof

:DNSFlush
ECHO Please Wait . . .
ipconfig /flushdns > %CD%\DNSFlush.txt 
find "Successfully" %CD%\DNSFlush.txt >nul && SET SucessSW=1
IF %SucessSW% EQU 1 (GOTO DNSFlushSucess) ELSE GOTO DNSFlushFail
GOTO:eof

:DNSFlushFail
SET Errorlvl=3 & CALL :Error
TYPE DNSFlush.txt
ECHO -This error may be due to restricted user or network rights on the computer 
ECHO  you are using
GOTO DNSFlushCleanUp
GOTO:eof

:DNSFlushSucess
ECHO -SUCCESS-
TYPE DNSFlush.txt
GOTO DNSFlushCleanUp
GOTO:eof

:DNSFlushCleanUp
DEL "DNSFlush.txt"
PAUSE
GOTO RepairMenu
GOTO:eof

:RenewSub
CLS
ECHO Renew Adapters                                       %date% %time%
ECHO ===============================================================================
ECHO - Renewing a computers adapters will allow for new lease data to be obtainted
ECHO   by network adapters to allow for new IP address and more secure Domain Name 
ECHO   Server(DNS) and Internet Service Provider(ISP) data
SET /p RenewSubChoice1=Continue[Y/N]?
IF %RenewSubChoice1%==y GOTO RenewAdapters
IF %RenewSubChoice1%==n GOTO RepairMenu
SET Errorlvl=2 & CALL :Error & GOTO RenewSub
GOTO:eof

:RenewAdapters
CLS
ipconfig /renew > %CD%\RenewAdapters.txt
findstr /C:"No operation can be performed" %CD%\RenewAdapters.txt && SET ErrorFound=1
IF %ErrorFound% EQU 1 ( GOTO RenewFail ) ELSE GOTO RenewSuccess
GOTO:eof

:RenewSuccess
CLS
TYPE RenewAdapters.txt
ECHO.
ECHO -SUCCESS-
ECHO.
DEL "RenewAdapters.txt">nul
SET /p RenewSubChoice2=Return to menu[Y/N]?
IF %RenewSubChoice2%==y GOTO RepairMenu
IF %RenewSubChoice2%==n exit
GOTO:eof

:RenewFail
CLS
ECHO - Error maybe due to Firewall being present or windows components are damaged
SET Errorlvl=3 & CALL :Error
DEL "RenewAdapters.txt" >nul
PAUSE & GOTO RepairMenu
got:eof

:Opt1Menu
CLS
ECHO Active Connections                                   %date% %time%
ECHO ===============================================================================
ECHO Please select an option:
ECHO [1] List local and foreign Addresses
ECHO [2] List local active executables 
ECHO [3] List connections with process ID
ECHO [4] List computer network connections
ECHO [5] List all active routes
ECHO [6] List DNS Cache Contents
ECHO [7] Active TCP connections
ECHO [8] Active UDP connections
ECHO [9] General Connections Table
ECHO [10] Main menu
ECHO [11] Exit
SET /p choice2=Option: 
IF %choice2% EQU 1 GOTO Opt1Sub1
IF %choice2% EQU 2 GOTO Opt1Sub2
IF %choice2% EQU 3 GOTO Opt1Sub7
IF %choice2% EQU 4 GOTO Opt1Sub6
IF %choice2% EQU 5 GOTO Opt1Sub3
IF %choice2% EQU 6 GOTO Opt1Sub4
IF %choice2% EQU 7 GOTO Opt1Sub8
IF %choice2% EQU 8 GOTO Opt1Sub9
IF %choice2% EQU 9 GOTO Opt1Sub5
IF %choice2% EQU 10 GOTO SubMainMenu
IF %choice2% EQU 11 exit
IF %choice2% GTR 11 SET Errorlvl=1 & CALL :Error & GOTO Opt1Menu
GOTO:eof

:Opt1Sub1
CLS
ECHO Local And Foreign Addresses                          %date% %time%
ECHO ===============================================================================
netstat -n
ECHO.
ECHO Return to menu[Y/N]?
SET /p Opt1SubChoice1=
IF %Opt1SubChoice1%==y GOTO Opt1Menu
IF %Opt1SubChoice1%==n exit
SET Errorlvl=2 & CALL :Error & GOTO Opt1Sub1
GOTO:eof

:Opt1Sub2
CLS
ECHO Local Active Exectutables                            %date% %time%
ECHO ===============================================================================
netstat -b
ECHO.
ECHO Return to menu[Y/N]?
SET /p Opt1SubChoice2=
IF %Opt1SubChoice2%==y GOTO Opt1Menu
IF %Opt1SubChoice2%==n exit
SET Errorlvl=2 & CALL :Error & GOTO Opt1Sub2
GOTO:eof

:Opt1Sub3
CLS
ECHO Active Routes                                        %date% %time%
ECHO ===============================================================================
netstat -a
ECHO.
ECHO Return to menu[Y/N]?
SET /p Opt1SubChoice3=
IF %Opt1SubChoice3%==y GOTO Opt1Menu
IF %Opt1SubChoice3%==n exit
SET Errorlvl=2 & CALL :Error & GOTO Opt1Sub3
GOTO:eof

:Opt1Sub4
CLS
ECHO DNS Cache Contents                                   %date% %time%
ECHO ===============================================================================
ipconfig /displaydns
ECHO.
ECHO Return to menu[Y/N]?
SET /p Opt1SubChoice4=
IF %Opt1SubChoice4%==y GOTO Opt1Menu
IF %Opt1SubChoice4%==n exit
SET Errorlvl=2 & CALL :Error & GOTO Opt1Sub4
GOTO:eof

:Opt1Sub5
CLS
ECHO General Connections Table                            %date% %time%
ECHO ===============================================================================
netstat
ECHO.
ECHO Return to menu[Y/N]?
SET /p Opt1SubChoice5=
IF %Opt1SubChoice5%==y GOTO Opt1Menu
IF %Opt1SubChoice5%==n exit
SET Errorlvl=2 & CALL :Error & GOTO Opt1Sub5
GOTO:eof

:Opt1Sub6
CLS
ECHO Computer Network Connections                         %date% %time%
ECHO ===============================================================================
netstat -a
ECHO.
ECHO Return to menu[Y/N]?
SET /p Opt1SubChoice6=
IF %Opt1SubChoice6%==y GOTO Opt1Menu
IF %Opt1SubChoice6%==n exit
SET Errorlvl=2 & CALL :Error & GOTO Opt1Sub6
GOTO:eof

:Opt1Sub7
CLS
ECHO List connections with process ID                     %date% %time%
ECHO ===============================================================================
netstat -o
ECHO.
ECHO Return to menu[Y/N]?
SET /p Opt1SubChoice7=
IF %Opt1SubChoice7%==y GOTO Opt1Menu
IF %Opt1SubChoice7%==n exit
SET Errorlvl=2 & CALL :Error & GOTO Opt1Sub7
GOTO:eof

:Opt1Sub8
CLS
ECHO Active TCP connections                               %date% %time%
ECHO ===============================================================================
netstat -p tcp
ECHO.
ECHO Return to menu[Y/N]?
SET /p Opt1SubChoice8=
IF %Opt1SubChoice8%==y GOTO Opt1Menu
IF %Opt1SubChoice8%==n exit
SET Errorlvl=2 & CALL :Error & GOTO Opt1Sub8
GOTO:eof

:Opt1Sub9
CLS
ECHO Active UDP connections                               %date% %time%
ECHO ===============================================================================
netstat -p udp
ECHO.
ECHO Return to menu[Y/N]?
SET /p Opt1SubChoice9=
IF %Opt1SubChoice9%==y GOTO Opt1Menu
IF %Opt1SubChoice9%==n exit
SET Errorlvl=2 & CALL :Error & GOTO Opt1Sub9
GOTO:eof

:Opt2Menu
CLS
ECHO IP Configurations                                    %date% %time%
ECHO ===============================================================================
ECHO Please select an option:
ECHO [1] General Configurations
ECHO [2] All Configurations
ECHO [3] Main Menu
ECHO [4] Exit
CHOICE /C 1234 /N /M "Option: "
IF %errorlevel% EQU 1 GOTO Opt2Sub1
IF %errorlevel% EQU 2 GOTO Opt2Sub2
IF %errorlevel% EQU 3 ECHO Loading Please Wait . . . & GOTO SubMainMenu
IF %errorlevel% EQU 4 exit
GOTO:eof

:Opt2Sub1
CLS
ECHO General Configurations                               %date% %time%
ECHO ===============================================================================
ipconfig
PAUSE & GOTO Opt2Menu
GOTO:eof

:Opt2Sub2
CLS
ECHO All Configurations                                   %date% %time%
ECHO ===============================================================================
ipconfig /all
PAUSE & GOTO Opt2Menu
GOTO:eof


:Opt3Menu
CLS
ECHO Test Network Connections                             %date% %time%
ECHO ===============================================================================
ECHO Please select an option:
ECHO [1] Ping to local adapter
ECHO [2] Ping test
ECHO [3] PathPing test
ECHO [4] Trace route
ECHO [5] Main Menu
ECHO [6] Exit
CHOICE /C 123456 /N /M "Option: "
IF %errorlevel% EQU 1 GOTO Opt3Sub1
IF %errorlevel% EQU 2 GOTO Opt3Sub2
IF %errorlevel% EQU 3 GOTO Opt3Sub3
IF %errorlevel% EQU 4 GOTO Opt3Sub4
IF %errorlevel% EQU 5 ECHO Loading Please Wait . . . & GOTO SubMainMenu
IF %errorlevel% EQU 6 exit
GOTO:eof

:Opt3Sub1
CLS
ECHO Local Adapter                                        %date% %time%
ECHO ===============================================================================
SET /p PingNo1=Enter No of pings: 
ECHO. 
ECHO Sending pings to local adapter [127.0.0.1]
Ping 127.0.0.1 -n %PingNo1% && SET replySW=1
IF %replySW% EQU 1 (
color 20
ECHO.
ECHO         		  #####################
ECHO         		  #    TEST PASSED    #
ECHO         		  #####################
ECHO.
) ELSE (
color 40
ECHO.
ECHO         		  *********************
ECHO         		  *    TEST FAILED    *
ECHO         		  *********************
ECHO.
)
SET replySW=0
PAUSE & color C & GOTO Opt3Menu
GOTO:eof

:Opt3Sub2
CLS
SET count=0
SET replied=0
SET failed=0
ECHO Ping Test                                            %date% %time%
ECHO ===============================================================================
SET /p PingNo2=Enter No of pings: 
ECHO.
ECHO Sending [%PingNo2%] pings to google-public-dns-a.com [8.8.8.8]
SET /A passmark=%PingNo2%/2
ECHO.
CALL :Opt3Sub2_Loop
IF %replied% GTR %passmark% (
color 20
ECHO.
ECHO         		    #####################
ECHO         		    #    TEST PASSED    #
ECHO         		    #####################
ECHO.
) ELSE (
color 40
ECHO.
ECHO         		    *********************
ECHO         		    *    TEST FAILED    *
ECHO         		    *********************
ECHO.
)
ECHO.
ECHO =========RESULTS=========
ECHO Pings Sent: [%count%]
ECHO Recieved: [%replied%]
ECHO Failed: [%failed%]
ECHO Test Passmark: [%passmark%] out of [%PingNo2%]
ECHO Test Result: [%replied%] out of [%PingNo2%]
ECHO.
PAUSE & color C & GOTO Opt3Menu
GOTO:eof

:Opt3Sub2_Loop
SET /A count=%count%+1 
ping 8.8.8.8 -n 1 > tempPing.txt
findstr /I /C:"Reply from 8.8.8.8:" %cd%\tempPing.txt && SET replySW=1
IF %replySW% EQU 1 (
SET /A replied=%replied%+1
SET replySW=0
) ELSE (
SET /A failed=%failed%+1
ECHO Request timed out.
)
IF %count% EQU %PingNo2%  DEL %CD%\tempPing.txt & SET replySW=0 & GOTO:EOF
GOTO Opt3Sub2_Loop
GOTO:eof

:Opt3Sub3
CLS
ECHO Pathping Test                                        %date% %time%
ECHO ===============================================================================
pathping 8.8.8.8 && SET replySW=1
IF %replySW% EQU 1 (
color 20
ECHO.
ECHO         		    #####################
ECHO         		    #    TEST PASSED    #
ECHO         		    #####################
ECHO.
) ELSE (
color 40
ECHO.
ECHO         		    *********************
ECHO         		    *    TEST FAILED    *
ECHO         		    *********************
ECHO.
)
SET replySW=0
PAUSE & color C & GOTO Opt3Menu
GOTO:eof

:Opt3Sub4
CLS
ECHO Trace Route                                          %date% %time%
ECHO ===============================================================================
tracert 8.8.8.8 && SET replySW=1
IF %replySW% EQU 1 (
color 20
ECHO.
ECHO         		    #####################
ECHO         		    #    TEST PASSED    #
ECHO         		    #####################
ECHO.
) ELSE (
color 40
ECHO.
ECHO         		    *********************
ECHO         		    *    TEST FAILED    *
ECHO         		    *********************
ECHO.
)
SET replySW=0
PAUSE & color C & GOTO Opt3Menu
GOTO:eof

:Opt7Menu
CLS
ECHO Network Statistics                                   %date% %time%
ECHO ===============================================================================
ECHO Please select an option:
ECHO [1] Ethernet Statistics
ECHO [2] All Network Statistics
ECHO [3] Main Menu
ECHO [4] Exit
CHOICE /C 1234 /N /M "Option:"
IF %errorlevel% EQU 1 GOTO Opt7Sub1 
IF %errorlevel% EQU 2 GOTO Opt7Sub2
IF %errorlevel% EQU 3 ECHO Loading Please Wait . . . & GOTO SubMainMenu
IF %errorlevel% EQU 4 exit
GOTO:eof

:Opt7Sub1
CLS
ECHO Ethernet Statistics                                  %date% %time%
ECHO ===============================================================================
netstat -e
PAUSE & GOTO Opt7Menu
GOTO:eof

:Opt7Sub2
CLS
ECHO All Network Statistics                               %date% %time%
ECHO ===============================================================================
netstat -s
PAUSE & GOTO Opt7Menu
GOTO:eof

:Opt4Menu
CLS
SET count=0
ECHO Variable Ping                                        %date% %time%
ECHO ===============================================================================
CHOICE /C NC /M "Use [N] Normal or [C] Colorized Ping"
IF %errorlevel% EQU 1 SET PingType=1 
IF %errorlevel% EQU 2 SET PingType=2 
GOTO PingTest_UserInput
GOTO:eof 

:PingTest_UserInput
SET /p PingDest=Destination: 
SET /p PingSize=Size(Bytes): 
SET /p PingCnt=Number of Pings: 
SET /p PingTime=Timeout(Milliseconds): 
IF %PingType% EQU 1 ( 
GOTO PingTest_Normal 
) ELSE (
CLS
ECHO.
ECHO Pinging %PingDest% with %PingSize% bytes of data:
GOTO PingTest_Colorized 
)
GOTO:eof

:PingTest_Normal
CLS
ping %PingDest% -n %PingCnt% -l %PingSize% -w %PingTime%
GOTO PingTest_Exit
GOTO:eof

:PingTest_Colorized
SET /A count=%count%+1 
SET replySW=0
SET colorValue=0
ping %PingDest% -n 1 -l %PingSize% -w %PingTime% > tempPing.txt
findstr /I /C:"Reply from" %cd%\tempPing.txt && SET replySW=1
IF %replySW% equ 1 (set colorValue=20) ELSE SET colorValue=40 & echo Request timed out
color %colorValue%
ping 127.0.0.1 -n 2 >NUL
IF %count% EQU %PingCnt%  DEL %CD%\tempPing.txt & SET replySW=0 & GOTO PingTest_Exit
GOTO PingTest_Colorized
GOTO:eof

:PingTest_Exit
ECHO.
CHOICE /C YN /M "Resend ping"
IF %errorlevel% EQU 1 GOTO Opt4Menu
IF %errorlevel% EQU 2 ECHO Loading Please Wait . . . & color C  & GOTO SubMainMenu 
GOTO:eof

:Opt5
CLS
ECHO Website Look Up                                       %date% %time%
ECHO ===============================================================================
ECHO Type "exit" to return to menu
GOTO Opt5Sub1
GOTO:eof

:Opt5Sub1
SET /p Website=Website:
IF %Website%==exit (GOTO Opt5Sub2) ELSE nslookup %Website%
GOTO Opt5Sub1
GOTO:eof

:Opt5Sub2
ECHO Return to menu[Y/N]?
SET /p Opt5SubChoice1=
IF %Opt5SubChoice1%==y GOTO SubMainMenu
IF %Opt5SubChoice1%==n exit
SET Errorlvl=2 & CALL :Error & GOTO Opt5Sub2
GOTO:eof


:Opt6Menu
CLS
ECHO General Overview                                     %date% %time%
ECHO ===============================================================================
ipconfig && netstat
ECHO.
CHOICE /C RM /M "Would you like to [R] Refresh or go to [M] Main Menu"
IF %errorlevel% EQU 1 GOTO Opt6Menu
IF %errorlevel% EQU 2 ECHO Loading Please Wait . . . & GOTO SubMainMenu
GOTO:eof

:Opt8
CLS
ECHO Routing Tables                                       %date% %time%
ECHO ===============================================================================
ECHO.
netstat -r
PAUSE & ECHO Loading Please Wait . . . & GOTO SubMainMenu
GOTO:eof

:Error
IF %Errorlvl% EQU 1 ECHO -INPUT ERROR: Please select again-
IF %Errorlvl% EQU 2 ECHO -OPTION ERROR: Please use apropriate characters-
IF %Errorlvl% EQU 3 ECHO -COMMAND FAILURE: Error in execution of command-
SET Errorlvl=o
PAUSE
GOTO:eof