@ECHO OFF

:subMain
MODE CON: lines=30 cols=45
CLS & @Powershell.exe -File .\IPRanger.ps1
goto:eof