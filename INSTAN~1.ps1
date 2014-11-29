# PingLooperInstanceTemplate1.0 
# Programmed by Matthew Carney [matthewcarney64@gmail.com]
# Using Powershell Scripting Language (POWERSHELL.PS1)
# © Matthew Carney 29th November 2014
# Feel free to modify, copy or add under the MIT Licence

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$a = (Get-Host).UI.RawUI
$a.WindowTitle = "PingLooper_BETA [Slave Console]"
Function instanceCreate()
{
    Import-LocalizedData -BindingVariable PingData -FileName PingData.psd1
    $global:Target = $PingData.pingTarget
    $global:Count = $PingData.pingNo
    $global:Size = $PingData.pingSize
    $global:Timeout = $PingData.pingTimeout
    For ($global:Ping = 0
    $global:Ping -lt $global:Count
    $global:Ping++) {
    Write-Host "Ping Count : " -nonewline
    Write-Host $global:Ping -Foregroundcolor Red -nonewline
    Write-Host "/$global:Count" -nonewline
    PING $global:Target -n 1 -l $global:Size -w $global:Timeout | Out-Null
    if ($? -match "True") 
    {
        [int]$global:Success = $global:Success + 1
        [int]$global:Fail = $global:Fail + 0
    }
    else
    {
        [int]$global:Fail = $global:Fail + 1
        $global:Success = $global:Success + 0
    }
    Write-Host "  Failed : " -nonewline
    Write-Host $global:Fail -Foregroundcolor Red -nonewline
    Write-Host " Succeed : " -nonewline
    Write-Host $global:Success -Foregroundcolor Green
    }
    Add-Content $scriptPath\Results.txt "`n-Instance Report, Sent:($global:Ping) Successful;($global:Success) Failed@($global:Fail)" -Force
}
Function instanceCreateMagenta()
{
    Import-LocalizedData -BindingVariable PingData -FileName PingData.psd1
    $global:Target = $PingData.pingTarget
    $global:Count = $PingData.pingNo
    $global:Size = $PingData.pingSize
    $global:Timeout = $PingData.pingTimeout
    For ($global:Ping = 0
    $global:Ping -lt $global:Count
    $global:Ping++) {
    Write-Host "Ping Count : " -Foregroundcolor Magenta -nonewline
    Write-Host $global:Ping -Foregroundcolor Red -nonewline
    Write-Host "/$global:Count" -Foregroundcolor Magenta -nonewline
    PING $global:Target -n 1 -l $global:Size -w $global:Timeout | Out-Null
    if ($? -match "True") 
    {
        [int]$global:Success = $global:Success + 1
        [int]$global:Fail = $global:Fail + 0
    }
    else
    {
        [int]$global:Fail = $global:Fail + 1
        $global:Success = $global:Success + 0
    }
    Write-Host "  Failed : " -Foregroundcolor Magenta -nonewline
    Write-Host $global:Fail -Foregroundcolor Red -nonewline
    Write-Host " Succeed : " -Foregroundcolor Magenta -nonewline
    Write-Host $global:Success -Foregroundcolor Green
    }
    Add-Content $scriptPath\Results.txt "`n-Instance Report, Sent:($global:Ping) Successful;($global:Success) Failed@($global:Fail)" -Force
}

Import-LocalizedData -BindingVariable modeFinder -FileName PingData.psd1
$magentaMode = $modeFinder.magentaMode
if ($magentaMode -eq 1)
{
    $instanceTime = Measure-Command -Expression {instanceCreateMagenta}
    [double]$instanceTime = $instanceTime.totalseconds
    [int]$pingPersec = $global:ping / $instanceTime
    Add-Content $scriptPath\PingTime.txt "`n-$pingPersec" -Force
} 
else
{
    $instanceTime = Measure-Command -Expression {instanceCreate}
    [double]$instanceTime = $instanceTime.totalseconds
    [int]$pingPersec = $global:ping / $instanceTime
    Add-Content $scriptPath\PingTime.txt "`n-$pingPersec" -Force
}
