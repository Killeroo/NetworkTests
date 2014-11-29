$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Function IPRanger()
{
$a = (Get-Host).UI.RawUI
$a.WindowTitle = "IP_Ranger"
Remove-Item $scriptPath\IPsuccess.txt -erroraction 'silentlycontinue'
Clear-Host
Write-Host "      IP Range Scanner" -Foregroundcolor Cyan
Write-Host " ────────────────────────────"
Write-Host
Write-Host " Please enter in the first three numbers of your IP Address" 
Write-Host " For Example : 192.168.1"
Write-Host "  » " -nonewline
$IP = Read-Host
Write-Host " Please enter the number of IPs to scan for"
Write-Host " Default : 255"
Write-Host "  » " -nonewline
$target = Read-Host
if ($target -eq "") {$target = "255"}
$global:Success = 0
$global:Fail = 0
For ($count = 0
$count -lt $target
$count++) {
Clear-Host
Write-Host "      IP Range Scanner" -Foregroundcolor Cyan
Write-Host " ────────────────────────────"
Write-Host " Failed : " -nonewline
Write-Host $global:Fail -Foregroundcolor Red -nonewline
Write-Host " Succeed : " -nonewline
Write-Host $global:Success -Foregroundcolor Green -nonewline
Write-Host " [$perComplete% Complete]"
Write-Host " ****************************"
Write-Host "         ACTIVE IPs: "
Get-Content -Path $scriptPath\IPsuccess.txt -erroraction 'silentlycontinue'
Write-Host " ****************************"
if ($count -eq 0)
{
    $perComplete = 0
}
else
{
    $perComplete = $count / $target
    $perComplete = $perComplete * 100
    $perComplete = "{0:N1}" -f $perComplete
    $a.WindowTitle = "IP_Ranger [Search $perComplete% Complete]"
}
Write-Host " Current IP : " -nonewline
Write-Host "$IP.$count" -Foregroundcolor Yellow -Backgroundcolor Black -nonewline
Write-Host "/$IP.$target" -nonewline
$curip = "$IP.$count"
PING $curip -n 1 -l 32 -w 500 | Out-Null
if ($? -match "True") 
{
    [int]$global:Success = $global:Success + 1
    [int]$global:Fail = $global:Fail + 0
    Out-File -FilePath $scriptPath\IPsuccess.txt -Append -InputObject "  -$curip"
}
else
{
    [int]$global:Fail = $global:Fail + 1
    $global:Success = $global:Success + 0
}
}
Clear-Host 
$a.WindowTitle = "IP_Ranger [Search Complete]"
Write-Host "      IP Range Scanner" -Foregroundcolor Cyan
Write-Host " ────────────────────────────"
Write-Host "          ACTIVE IPs: " -Foregroundcolor Green
Write-Host " ****************************"
Get-Content -Path $scriptPath\IPsuccess.txt -erroraction 'silentlycontinue'
Write-Host " ****************************"
Write-Host
Write-Host " $target IPs scanned on network segment $IP"
Write-Host " Attempts Failed"
Write-Host "  » " -nonewline
Write-Host " $global:Fail " -Backgroundcolor Red -Foregroundcolor Black
Write-Host " Attempts Succeeded"
Write-Host "  » " -nonewline
Write-Host " $global:Success " -Backgroundcolor Green -Foregroundcolor Black
Write-Host "Press enter to search again . . ."
$reSearch = Read-Host
if ($reSearch -eq "") {IPRanger} else {exit}
Remove-Item $scriptPath\IPsuccess.txt -erroraction 'silentlycontinue'
}
IPRanger
# USEFUL : http://technet.microsoft.com/en-us/library/hh847831.aspx
