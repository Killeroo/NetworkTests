@echo off

:SubExecute
title SystemShell_Pre_Alpha
mode con: lines=35 cols=125
color 0C
echo ######################################################### WARNING #########################################################
echo / NOT FINISHED / NOT FINISHED / NOT FINISHED / NOT FINISHED / NOT FINISHED / NOT FINISHED / NOT FINISHED / NOT FINISHED / 
echo ###########################################################################################################################
pause
color 07
cls & @Powershell.exe -File .\SystemShell.ps1
pause
goto SubExecute
goto:eof

REM Wanted size mode con: lines=27 cols=125