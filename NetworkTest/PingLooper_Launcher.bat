@ECHO OFF

:subMain
MODE CON: lines= cols=50
CLS & @Powershell.exe -File .\PINGLO~1.ps1
goto:eof