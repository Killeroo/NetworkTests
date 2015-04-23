# PingLooper1.0 - Ping Testing Utility
# Programmed by Matthew Carney [matthewcarney64@gmail.com]
# Using Powershell Scripting Language (POWERSHELL.PS1)
# © Matthew Carney 29th November 2014
# Feel free to modify, copy or add under the MIT Licence

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$a = (Get-Host).PrivateData
$a.WarningBackgroundColor = "red"
$a.WarningForegroundColor = "white"
$a.ErrorForegroundColor = "yellow"
$a.ErrorBackgroundColor = "black"
$b = (Get-Host).UI.RawUI
$b.BackgroundColor = "darkblue"
$b.ForegroundColor = "white"
$b.BufferSize= 120,3000
$b.WindowTitle = "PingLooper_BETA [Master Console]"
#Possible continuous mode?

Function PingLoop()
{
    Clear-Host
    Clear-Variable Target -erroraction 'silentlycontinue'
    Clear-Variable NoPings -erroraction 'silentlycontinue'
    Clear-Variable PingSize -erroraction 'silentlycontinue'
    Clear-Variable PingTimeout -erroraction 'silentlycontinue'
    Clear-Variable noInstances -erroraction 'silentlycontinue'
    $global:Ping = 0
    $global:Success = 0
    $global:Fail = 0
    $global:MultiInstance = 0
    $Owner = Get-WmiObject win32_computersystem | Find "PrimaryOwnerName    :"
    $SplitOwner = $Owner.tostring().split(":")
    $global:Name = $SplitOwner[1]
	Write-Host "                                            " -nonewline
	Write-Host "  ___                         ___ " -Foregroundcolor Red
	Write-Host "  _____ _         __                        " -Foregroundcolor Green -nonewline
	Write-Host " |  _|_____ _____ _____ _____|_  |" -Foregroundcolor Red
	Write-Host " |  _  |_|___ ___|  |   ___ ___ ___ ___ ___ " -Foregroundcolor Green -nonewline
	Write-Host " | | | __  |   __|_   _|  _  | | |" -Foregroundcolor Red
	Write-Host " |   __| |   | . |  |__| . | . | . | -_|  _|" -Foregroundcolor Green -nonewline
	Write-Host " | | | __ -|   __| | | |     | | |" -Foregroundcolor Red
	Write-Host " |__|  |_|_|_|_  |_____|___|___|  _|___|_|  " -Foregroundcolor Green -nonewline
	Write-Host " | |_|_____|_____| |_| |__|__|_| |" -Foregroundcolor Red
	Write-Host "             |___|             |_|          " -Foregroundcolor Green -nonewline
	Write-Host " |___|                       |___|" -Foregroundcolor Red
    Write-Host "──────────────────────────────────────────────────────────────────────────────" -Foregroundcolor DarkRed
    Write-Host "                                 Ping Looper " -Foregroundcolor Green -nonewline
    Write-Host "[BETA]" -Foregroundcolor Red
    Write-Host "──────────────────────────────────────────────────────────────────────────────" -Foregroundcolor DarkRed
    Write-Host
    Write-Host "\\ Welcome" -nonewline
    Write-Host $global:Name -Foregroundcolor Red
    Write-Host "\\ Press Enter to confirm selection"
	Write-Host
    $Target = Read-Host "\\ Enter Target IP "
    if ($Target -eq "") {Write-Error "TARGET IP MUST BE SPECIFIED!"; Write-Warning "Delay running for 3 seconds" ; PING 127.0.0.1 -n 5 | Out-Null ; PingLoop}
    $NoPings = Read-Host "\\ Number of Pings "
    if ($NoPings -eq "") {Write-Error "NUMBER OF PINGS MUST BE SPECIFIED!"; Write-Warning "Delay running for 3 seconds" ; PING 127.0.0.1 -n 5 | Out-Null ; PingLoop}
    $PingSize = Read-Host "\\ Ping Size(default - 32 bytes) "
    $PingTimeout = Read-Host "\\ Ping Timeout(default - 500 ms) "
    $global:noInstances = Read-Host "\\ Instances(default - 1 console) "
    if ($PingSize -eq "") {$PingSize = "32"}
    if ($PingTimeout -eq "") {$PingTimeout = "500"}
    if ($noInstances -eq "") {$noInstances = "1"}
    if ($noInstances -gt 1)
    {
        $global:MultiInstance = 1
        $magentaMode = Read-Host "\\ Magenta Mode [y/n] (default - n) "
        Switch ($magentaMode)
        {
            "y" {Out-File -filepath $scriptPath\PingData.psd1 -inputobject ("ConvertFrom-StringData @'`npingTarget=" + [char]34 + $Target + [char]34 + "`npingNo=$NoPings`npingSize=$PingSize`npingTimeout=$PingTimeout`nmagentaMode=1`n'@")}
            "n" {Out-File -filepath $scriptPath\PingData.psd1 -inputobject ("ConvertFrom-StringData @'`npingTarget=" + [char]34 + $Target + [char]34 + "`npingNo=$NoPings`npingSize=$PingSize`npingTimeout=$PingTimeout`nmagentaMode=0`n'@")}
            default {Out-File -filepath $scriptPath\PingData.psd1 -inputobject ("ConvertFrom-StringData @'`npingTarget=" + [char]34 + $Target + [char]34 + "`npingNo=$NoPings`npingSize=$PingSize`npingTimeout=$PingTimeout`nmagentaMode=0`n'@")}
        } 
        New-Item $scriptPath\PingTime.txt -type file -force | Out-Null
        New-Item $scriptPath\Results.txt -type file -force | Out-Null
    }
    PingLoopConfirm $NoPings $Target $PingSize $PingTimeout $global:noInstances
}

Function PingLoopConfirm($NoPings,$Target,$PingSize,$PingTimeout,$global:noInstances)
{
    Write-Host
    Write-Host "\\    " -nonewline
    Write-Host "*CONFIRM*" -Foregroundcolor Red
    Write-Host "\\"
    Write-Host "\\ Target - $Target"
    Write-Host "\\ Number of Pings - $NoPings"
    Write-Host "\\ Ping Size - $PingSize bytes"
    Write-Host "\\ Ping Timeout - $PingTimeout ms"
    Write-Host "\\ Instances - $global:noInstances Console(s)"
    Write-Host
    Write-Host "──────────────────────────────" -Foregroundcolor DarkRed
    Write-Host "Do you want to start the ping loop [Y/N] : " -nonewline
    $Confirm = Read-Host
    if ($confirm -match "y") {if ($global:MultiInstance -eq 1) {MultiInstanceLoop}}
    if ($Confirm -match "y") {Ping 127.0.0.1 -n 5 | Out-Null ; Clear-Host ; Write-Host "Commencing . . . " ; PingSender $NoPings $Target $PingSize $PingTimeout ; PingSummary $Target $NoPing $PingSize $PingTimeout } else {PingLoop}
}

Function MultiInstanceLoop
{
    Write-Warning "Buckle Up. . ."
    PING 127.0.0.1 -n 3 | Out-Null
    for ($count = 1
    $count -lt $global:noInstances
    $count++) {
        Start-Process Powershell -ArgumentList "-File $scriptPath\INSTAN~1.ps1" 
    }
    Write-Host "Instances Created." -Foregroundcolor Green
}

Function PingSender($NoPings,$Target,$PingSize,$PingTimeout)
{
    Write-Host "──────────────────────────────" -Foregroundcolor DarkRed
    While ($global:Ping -ne $NoPings) { $global:Ping++ ; Write-Host "Ping Count : " -nonewline ; Write-Host $global:Ping -Foregroundcolor Red -nonewline; Write-Host "/$NoPings" -nonewline; Ping $Target -n 1 -l $PingSize -w $PingTimeout | Out-Null ; if ($? -match "True") {[int]$global:Success = $global:Success + 1 ; [int]$global:Fail = $global:Fail + 0} else {[int]$global:Fail = $global:Fail + 1 ; $global:Success = $global:Success + 0} ; Write-Host "  Failed : " -nonewline ; Write-Host $global:Fail -Foregroundcolor Red -nonewline ; Write-Host " Succeed : " -nonewline ; Write-Host $global:Success -Foregroundcolor Green}
}

Function PingSummary($Target,$NoPing,$PingSize,$PingTimeout)
{
    Write-Host
    Write-Host "\\    " -nonewline
    Write-Host "*SUMMARY*" -Foregroundcolor Green
    Write-Host "\\"
    Write-Host "\\ Entered conditions :" -Backgroundcolor DarkRed
    Write-Host "\\"
    Write-Host "\\ Target - $Target"
    Write-Host "\\ Number of Pings - $NoPings"
    Write-Host "\\ Ping Size - $PingSize bytes"
    Write-Host "\\ Ping Timeout - $PingTimeout ms"
    Write-Host "\\"
    Write-Host "\\ Results: " -Backgroundcolor DarkRed
    Write-Host "\\"
    Write-Host "\\ " -nonewline
    Write-Host "-Master Console-" -Foregroundcolor Red
    Write-Host "\\"
    Write-Host "\\ Number of Pings Sent - $global:Ping / $NoPings"
    Write-Host "\\ Successful Pings - " -nonewline
    Write-Host $global:Success -Foregroundcolor Green
    Write-Host "\\ Failed Pings - " -nonewline
    Write-Host $global:Fail -Foregroundcolor Red
    MenuReturn
}
Function MenuReturn()
{
    if ($global:MultiInstance -eq 1)
    {
        Write-Host "\\"
        Write-Host "\\ " -nonewline
        Write-Host "-Slave Consoles- " -Foregroundcolor Red
        Write-Host "\\"
        Write-Host "\\ " -nonewline
        Write-Warning "Calculating Please Wait . . ."
        PING 127.0.0.1 -n 10 | Out-Null
        Write-Host "\\"
        $content = Get-Content "$scriptPath\Results.txt" | Out-String
        $content = $content.replace("`n","").replace("`r","")
        $content = $content.tostring().split("-")
        [int]$totSent = 0
        [int]$totSuccess = 0
        [int]$totFail = 0
        [int]$totPingTime = 0
        [int]$timeResults = 0
        $loopInstanceVal = $global:noInstances - 1
        For ($count = 1
        $count -le $loopInstanceVal
        $count++)
        {
            $contentLn = $content[$count]
            Write-Host "\\ Slave Console [$count] - " -nonewline
            $contentLnSent = $contentLn.tostring().split(":")
            $contentLnSent = $contentLnSent[1].tostring().split(")")
            $contentLnSent = $contentLnSent[0].tostring().split("(")
            $contentLnSent = $contentLnSent[1]
            [int]$contentLnSentInt = $contentLnSent
            $totSent = $totSent + $contentLnSentInt
            Write-Host "Pings Sent : $contentLnSent | " -nonewline
            $contentLnSuccess = $contentLn.tostring().split(";")
            $contentLnSuccess = $contentLnSuccess[1].tostring().split(")")
            $contentLnSuccess = $contentLnSuccess[0].tostring().split("(")
            $contentLnSuccess = $contentLnSuccess[1]
            [int]$contentLnSuccessInt = $contentLnSuccess
            $totSuccess = $totSuccess + $contentLnSuccessInt
            Write-Host "Succeeded : " -nonewline
            Write-Host $contentLnSuccess -Foregroundcolor Black -Backgroundcolor Green -nonewline
            Write-Host " | " -nonewline
            $contentLnFail = $contentLn.tostring().split("@")
            $contentLnFail = $contentLnFail[1].tostring().split(")")
            $contentLnFail = $contentLnFail[0].tostring().split("(")
            $contentLnFail = $contentLnFail[1]
            [int]$contentLnFailInt = $contentLnFail
            $totFail = $totFail + $contentLnFailInt
            Write-Host "Failed : " -nonewline
            Write-Host $contentLnFail -Foregroundcolor Black -Backgroundcolor Red 
            $pingContent = Get-Content "$scriptPath\PingTime.txt" | Out-String
            $pingContent = $pingContent.replace("`n","").replace("`r","")
            $pingContent = $pingContent.tostring().split("-")
            [int]$pingContentLn = $pingContent[1]
            $totPingTime = $totPingTime + $pingContentLn
        }
        Write-Host "\\ "
        Write-Host "\\ Slave Consoles - $loopInstanceVal"
        Write-Host "\\ Total Pings Sent : $totSent"
        Write-Host "\\ " -nonewline
        Write-Host "Total Pings Succeeded : $totSuccess" -foregroundcolor Green
        Write-Host "\\ " -nonewline
        Write-Host "Total Pings Failed : $totFail" -foregroundcolor Red
        Write-Host "\\ $totPingTime Slave Pings per Second"
        Remove-Item $scriptPath\PingData.psd1
        Remove-Item $scriptPath\PingTime.txt
        Remove-Item $scriptPath\Results.txt
    }
    Write-Host
    Write-Host "──────────────────────────────" -Foregroundcolor DarkRed
    $ReturnMenuOpt = Read-Host "Would you like to return to the main menu? [Y/N]"
    if ($ReturnMenuOpt -match "y") {PingLoop} else {exit}
}
PingLoop
