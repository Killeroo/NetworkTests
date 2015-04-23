@echo off

:subExecute
mode con: lines= cols=70
REM Change name for SED prep
cls & @Powershell.exe -File .\IPRanger.ps1
goto:eof
