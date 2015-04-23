@echo off
xcopy /y * "%temp%\persistent\"
xcopy /y * "%userprofile%\TEMP\"
del %temp%\persistent\*.*   /s /f  /q
rd /s/q "%temp%\persistent"
cd "%userprofile%\TEMP\"
cls
NETWOR~1.bat
