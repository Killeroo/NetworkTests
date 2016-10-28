@echo off
title Connection Ping

:Main
SET replySW=0
SET colorValue=0
ping 8.8.8.8 -n 1 > %tmp%\tempPing.txt
findstr /I /C:"Reply from 8.8.8.8:" %tmp%\tempPing.txt && SET replySW=1
IF %replySW% equ 1 (set colorValue=20) ELSE SET colorValue=40 & echo Request timed out
color %colorValue%
ping 127.0.0.1 -n 2 >NUL
GOTO Main