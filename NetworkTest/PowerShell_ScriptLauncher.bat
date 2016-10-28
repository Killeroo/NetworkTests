@echo off
title PowerShell_ScriptLauncher V1.0

:SubMain
cls
dir *.ps1
set /p Launchfile=Select a .ps1 file to run: 
set title=%Launchfile%
goto SubExecute
goto:eof

:SubExecute
title %title%
cls & @Powershell.exe -File .\%Launchfile%
pause
goto SubMain
goto:eof

