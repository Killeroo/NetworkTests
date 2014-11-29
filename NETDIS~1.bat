@echo off

:SubMain
echo NOTE: Set Execution Policy to RemoteSigned in Powershell first before
echo       attempting to start NetDisplay
echo       Type: "Set-ExecutionPolicy RemoteSigned" (usually has to be done
echo       in Administration Mode in Powershell: type "powershell" into the
echo       Windows start menu and right click "Run As Administrator")
systeminfo > %cd%\SysInfo.txt
pause & goto SubExecute
goto:eof

:SubExecute
title NetDisplay
mode con: lines=24 cols=100
cls
@Powershell.exe -File .\NETDIS~1.ps1
goto SubExecute
goto:eof
