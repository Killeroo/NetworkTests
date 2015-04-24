@ECHO OFF

:SubMain
echo NOTE: Set Execution Policy to RemoteSigned in Powershell first before
echo       attempting to start NetDisplay
echo       Type: "Set-ExecutionPolicy RemoteSigned" (usually has to be done
echo       in Administration Mode in Powershell: type "powershell" into the
echo       Windows start menu and right click "Run As Administrator")
pause & goto SubExecute
goto:eof

:subExecute
MODE CON: lines= cols=50
CLS & @Powershell.exe -File .\PINGLO~1.ps1
goto:eof
