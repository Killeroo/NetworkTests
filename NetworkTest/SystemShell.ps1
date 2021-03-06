# begin
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Write-Host "═════════════════════════════════════════════════════" -foregroundcolor Red -nonewline
Write-Host "StartUp Initialised" -foregroundcolor Cyan -nonewline 
Write-Host "═════════════════════════════════════════════════════" -foregroundcolor Red -nonewline
Write-Host "Location Found: " -foregroundcolor DarkGreen -nonewline
Write-Host $scriptpath
Systeminfo | Out-File $scriptpath\Sysinfo.txt
Write-Host "───" -nonewline
Write-Host " Sysinfo.txt Created        " -foregroundcolor DarkCyan -nonewline
Write-Host "───"
Write-Host "───" -nonewline
Write-Host " Loading Computer Resources " -foregroundcolor DarkCyan -nonewline
Write-Host "───"
[string]$global:cmdblock1 = Get-WmiObject win32_computersystem | Find "Name                :"
[string]$global:cmdblock2 = Get-WmiObject win32_computersystem | Find "PrimaryOwnerName    :"
[string]$global:cmdblock3 = Get-WmiObject win32_computersystem | Find "Manufacturer        :"
[string]$global:cmdblock4 = Get-WmiObject win32_computersystem | Find "Model               :"
[string]$global:cmdblock5 = Get-WmiObject win32_computersystem | Find "TotalPhysicalMemory :"
[string]$global:cmdblock6 = Get-WmiObject win32_bios | Find "Name              :"
[string]$global:cmdblock7 = Get-WmiObject win32_bios | Find "Version           :"
[string]$global:cmdblock8 = Get-WmiObject win32_bios | Find "SMBIOSBIOSVersion :"
[string]$global:cmdblock9 = Get-WmiObject win32_baseboard | Find "Manufacturer :"
[string]$global:cmdblock10 = Get-WmiObject win32_baseboard | Find "Product      :"
[string]$global:cmdblock11 = Get-WmiObject win32_processor | Find "AddressWidth                :"
[string]$global:cmdblock12 = Get-WmiObject win32_processor | Find "DataWidth                   :"
[string]$global:cmdblock13 = Get-WmiObject win32_processor | Find "CurrentClockSpeed           :"
[string]$global:cmdblock14 = Get-WmiObject win32_processor | Find "CurrentVoltage              :"
[string]$global:cmdblock15 = Get-WmiObject win32_processor | Find "Description                 :"
[string]$global:cmdblock16 = Get-WmiObject win32_processor | Find "Manufacturer                :"
[string]$global:cmdblock17 = Get-WmiObject win32_processor | Find "MaxClockSpeed               :"
[string]$global:cmdblock18 = Get-WmiObject win32_processor | Find "Name                        :"
[string]$global:cmdblock19 = Get-WmiObject win32_processor | Find "NumberOfCores               :"
[string]$global:cmdblock20 = Get-WmiObject win32_processor | Find "Status                      :"
[string]$global:cmdblock21 = Get-WmiObject win32_logicaldisk | Find "DeviceID     :"
[string]$global:cmdblock22 = Get-WmiObject win32_logicaldisk | ForEach-Object {$_.freespace / 1GB}
[string]$global:cmdblock23 = Get-WmiObject win32_logicaldisk | ForEach-Object {$_.size / 1GB}
[string]$global:cmdblock24 = Get-WmiObject win32_physicalmemory | Find "BankLabel            :"
[string]$global:cmdblock25 = Get-WmiObject win32_physicalmemory | ForEach-Object {$_.capacity / 1GB}
[string]$global:cmdblock26 = Get-WmiObject win32_physicalmemory | Find "DataWidth            :"
[string]$global:cmdblock27 = Get-WmiObject win32_physicalmemory | Find "Tag                  :"
[string]$global:cmdblock28 = Get-WmiObject win32_operatingsystem | Find "SystemDirectory :"
[string]$global:cmdblock29 = Get-WmiObject win32_operatingsystem | Find "RegisteredUser  :"
[string]$global:cmdblock30 = Get-Wmiobject win32_operatingsystem | Find "Version         :"
[string]$global:cmdblock31 = Find "Total Physical Memory:" $scriptpath\Sysinfo.txt | Select-String "Total Physical Memory:"
[string]$global:cmdblock32 = Find "Available Physical Memory:" $scriptpath\Sysinfo.txt | Select-String "Available Physical Memory:"
[string]$global:cmdblock33 = Find "Virtual Memory:" $scriptpath\Sysinfo.txt | Select-String "Max Size:"
[string]$global:cmdblock34 = Find "OS Name:" $scriptpath\Sysinfo.txt | Select-String "OS Name:"
[string]$global:cmdblock35 = Find "Boot Device:" $scriptpath\Sysinfo.txt | Select-String "Boot Device:"
[string]$global:cmdblock36 = Find "System Directory:" $scriptpath\Sysinfo.txt | Select-String "System Directory:"
[string]$global:cmdblock37 = Find "Virtual Memory:" $scriptPath\Sysinfo.txt | Select-String "Available:"
[string]$global:cmdblock38 = Find "Virtual Memory:" $scriptPath\Sysinfo.txt | Select-String "In Use:"
[string]$global:cmdblock39 = Find "System Type:" $scriptPath\Sysinfo.txt | Select-String "System Type:"
[string]$global:cmdblock40 = Get-WmiObject win32_logicaldisk | Find "DriveType    :"
Write-Host "───" -nonewline
Write-Host " Resource Loading Complete  " -foregroundcolor DarkCyan -nonewline
Write-Host "───"
Write-Host "───" -nonewline
Write-Host " Variable Setup Complete    " -foregroundcolor DarkCyan -nonewline
Write-Host "───"
Remove-Item $scriptPath\Sysinfo.txt
Write-Host "───" -nonewline
Write-Host " Sysinfo.txt Deleted        " -foregroundcolor DarkCyan -nonewline
Write-Host "───"
Write-Host "»»»" -foregroundcolor DarkGreen -nonewline
Write-Host "        StartUp Done        " -foregroundcolor Cyan -nonewline
Write-Host "«««" -foregroundcolor DarkGreen -nonewline
PING 127.0.0.1 -n 2 | Out-Null
Function MenuLayout()
 {
 Clear-Host
 Write-Host "SystemShell_Alpha                                 " -foregroundcolor Cyan -nonewline
 Get-Date -format g | Write-Host -foregroundcolor Green -nonewline
 Write-Host " Program Location: " -foregroundcolor DarkCyan -nonewline
 Write-Host "$scriptpath  "
 Write-Host "═════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════" -foregroundcolor Red -nonewline
 }
Function TopMenuBar()
 {
 $SplitSysLoc = $global:cmdblock36.tostring().split("\")
 $SysInfo1 = $SplitSysLoc[1]
 $SysInfo2 = $SplitSysLoc[2]
 $SysInfo3 = $SplitSysLoc[3]
 $SplitBootLoc = $global:cmdblock35.tostring().split("\")
 $BootLoc1 = $SplitBootLoc[1]
 $BootLoc2 = $SplitBootLoc[2]
 $BootLoc3 = $SplitBootLoc[3]
 Write-Host "System Location: " -foregroundcolor DarkGreen -nonewline
 Write-Host "C:\$Sysinfo1\$SysInfo2\$SysInfo3" -nonewline
 Write-Host "     Boot Sector: " -foregroundcolor DarkGreen -nonewline
 Write-Host "\$BootLoc1\$BootLoc2\$BootLoc3"
 }
 Function MiddleBar()
 {
 $SplitSysName = $global:cmdblock1.tostring().split(":")
 $SysName = $SplitSysName[1]
 $SplitSysOwner = $global:cmdblock2.tostring().split(":")
 $SysOwner = $SplitSysOwner[1]
 $SplitManufacturer = $global:cmdblock3.tostring().split(":")
 $Manufacturer = $SplitManufacturer[1]
 $SplitSysModel = $global:cmdblock4.tostring().split(":")
 $SysModel = $SplitSysModel[1]
 
 Write-Host "═════════════════════════════════════════════════════════════════╦═══════════════════════════════════════════════════════════" -nonewline
 Write-Host " Random Access Memory (RAM) Information:" -foregroundcolor DarkCyan -nonewline
 Write-Host "                         ║" -nonewline
 Write-Host " Computer Information:            " -foregroundcolor DarkCyan
 $SplitTagLine = $global:cmdblock27.tostring().split(" ")
 Write-Host "        Memory Tag: " -nonewline
 Write-Host $SplitTagLine[19] -nonewline
 Write-Host " " -nonewline
 Write-Host $SplitTagLine[20] -nonewline
 Write-Host " " -nonewline
 Write-Host $SplitTagLine[21] -nonewline
 Write-Host "    " -nonewline
 Write-Host $SplitTagLine[41] -nonewline
 Write-Host " " -nonewline
 Write-Host $SplitTagLine[42] -nonewline
 Write-Host " " -nonewline
 Write-Host $SplitTagLine[43] -nonewline
 Write-Host "       ║ System Name   : $SysName"
 $SplitBankLabel = $global:cmdblock24.tostring().split(" ")
 Write-Host " Memory Bank Label:      " -nonewline
 Write-Host $SplitBankLabel[13] -nonewline
 Write-Host " " -nonewline
 Write-Host $SplitBankLabel[14] -nonewline
 Write-Host "               " -nonewline
 Write-Host $SplitBankLabel[28] -nonewline
 Write-Host " " -nonewline
 Write-Host $SplitBankLabel[29] -nonewline
 Write-Host "             ║ Computer Owner: $SysOwner"
 $SplitMemoryAmount = $global:cmdblock25.tostring().split(" ")
 Write-Host "   Memory Capacity:        " -nonewline
 Write-Host $SplitMemoryAmount[0] -nonewline
 Write-Host "Gb                  " -nonewline
 Write-Host $SplitMemoryAmount[1] -nonewline
 Write-Host "Gb" -nonewline
 Write-Host "              ║ Manufacturer  : $Manufacturer"
 $SplitMemoryWidth = $global:cmdblock26.tostring().split(" ")
 Write-Host "        Data Width:        x" -nonewline
 Write-Host $SplitMemoryWidth[13] -nonewline
 Write-Host "                  x" -nonewline
 Write-Host $SplitMemoryWidth[27] -nonewline
 Write-Host "              ║ Model         : $SysModel"
 $SplitTotalMemory = $global:cmdblock5.tostring().split(":")
 Write-Host "  " -nonewline    
 Write-Host "Total RAM Amount: " -nonewline
 $PhyMemoryGB = $SplitTotalMemory[1] / 1GB 
 $TotalPhyMemoryGB = "{0:N1}" -f $PhyMemoryGB
 Write-Host $TotalPhyMemoryGB -Foregroundcolor Green -nonewline
 Write-Host " GB" -Foregroundcolor Green -nonewline
 $TotPhyMemGbLength = $TotalPhyMemoryGB.length
 if ($TotPhyMemGbLength -match 3) {$TotPhyMemGbGap = "                                       ║"} else {$TotPhyMemGbGap = "                                      ║"}
 Write-Host $TotPhyMemGbGap -nonewline
 Write-Host " Architecture  :  " -nonewline
 $SplitSysType = $global:cmdblock39.tostring().split(" ")
 $SplitSystemType = $SplitSysType[16].tostring().split("-")
 Write-Host $SplitSystemType[0]
 Write-Host "    " -nonewline    
 Write-Host "Total Physical Memory:" -Backgroundcolor DarkGreen -nonewline
 Write-Host " MB : " -nonewline  
 $PhyMemoryMB = $SplitTotalMemory[1] / 1MB
 $TotalPhyMemoryMB = "{0:N0}" -f $PhyMemoryMB
 Write-Host $TotalPhyMemoryMB -Foregroundcolor Yellow -nonewline
 $TotalPhyMemoryMBLength = $TotalPhyMemoryMB.length
 if ($TotalPhyMemoryMBLength -match 5) {$TotPhyMemGap = "                            ╠"} else {$TotPhyMemGap = "                           ╠"}
 Write-Host $TotPhyMemGap -nonewline
 Write-Host "═══════════════════════════════════════════════════════════" -nonewline 
 Write-Host "         " -nonewline
 Write-Host "Available Memory:" -Backgroundcolor DarkGreen -nonewline
 $SplitAvaPhyMemory = $global:cmdblock32.tostring().split(" ")
 Write-Host " MB : " -nonewline
 Write-Host $SplitAvaPhyMemory[3] -Foregroundcolor Green -nonewline
 $AvaPhyMemLength = $SplitAvaPhyMemory[3].length
 if ($AvaPhyMemLength -match 5) {$AvaPhyMemGap = "  "} else {$AvaPhyMemGap = " "}
 Write-Host $AvaPhyMemGap -nonewline
 Write-Host "In Use Memory:" -Backgroundcolor DarkGreen -nonewline
 Write-Host " MB : " -nonewline
 $TotPhyMem = $SplitTotalMemory[1] / 1MB
 $SplitTotPhyMem = $TotPhyMem.tostring().split(".")
 $TotPhyMemory = $SplitTotPhyMem[0]
 $AvaPhyMem = $SplitAvaPhyMemory[3]
 $SplitAvaPhyMem = $AvaPhyMem.tostring().split(",")
 $AvaPhyMem1 = $SplitAvaPhyMem[0]
 $AvaPhyMem2 = $SplitAvaPhyMem[1]
 $AvaPhyMemory = ($AvaPhyMem1 + $AvaPhyMem2)
 $PhyMemoryInUse = $TotPhyMemory - $AvaPhyMemory
 $PhyMemoryInUseMB = "{0:N0}" -f $PhyMemoryInUse
 Write-Host $PhyMemoryInUseMB -Foregroundcolor Red -nonewline
 $PhyMemInUseLength = $PhyMemoryInUseMB.length
 if ($PhyMemInUseLength -match 5) {$PhyMemInUseGap = " ║"} else {$PhyMemInUseGap = "║"}
 Write-Host " ║" -nonewline
 Write-Host " Software Information: " -Foregroundcolor DarkCyan 
 Write-Host "     " -nonewline
 Write-Host "Total Virtual Memory:" -Backgroundcolor DarkRed -nonewline
 Write-Host " MB : " -nonewline
 $SplitVirMemoryAva = $global:cmdblock33.tostring().split(" ")
 Write-Host $SplitVirMemoryAva[5] -Foregroundcolor Yellow -nonewline
 $VirMemAvaLength = $SplitVirMemoryAva[5].length
 if ($VirMemAvaLength -match 5) {$VirMemAvaGap = "                            ║"} else {$VirMemAvaGap = "                           ║"}
 Write-Host $VirMemAvaGap -nonewline
 Write-Host "  Operating System: " -Foregroundcolor DarkCyan
 Write-Host "         " -nonewline
 Write-Host "Available Memory:" -Backgroundcolor DarkRed -nonewline
 Write-Host " MB : " -nonewline
 $SplitVirMemoryAva = $global:cmdblock37.tostring().split(" ")
 Write-Host $SplitVirMemoryAva[3] -Foregroundcolor Green -nonewline
 $VirMemAvaLength = $SplitVirMemoryAva[3].length
 if ($VirMemAvaLength -match 5) {$VirMemAvaGap ="  "} else {$VirMemAvaGap = " "}
 Write-Host $VirMemAvaGap -nonewline
 Write-Host "In Use Memory:" -Backgroundcolor DarkRed -nonewline
 Write-Host " MB : " -nonewline
 $SplitVirMemoryInUse = $global:cmdblock38.tostring().split(" ")
 Write-Host $SplitVirMemoryInUse[7] -Foregroundcolor Red -nonewline
 $VirMemInUseLength = $SplitVirMemoryInUse[7].length
 if ($VirMemInUseLength -match 5) {$VirMemInUseGap = " ║"} else {$VirMemInUseGap = "║"}
 Write-Host $VirMemInUseGap -nonewline
 Write-Host "   Windows Version : " -nonewline
 $SplitOSVersion = $global:cmdblock30.tostring().split(":")
 Write-Host $SplitOSVersion[1]
 Write-Host "═════════════════════════════════════════════════════════════════╣  " -nonewline
 Write-Host " Registered User : " -nonewline
 $SplitOSUser = $global:cmdblock29.tostring().split(":")
 Write-Host $SplitOSUser[1]
 Write-Host "                                                                 ║  " -nonewline
 Write-Host "BIOS:" -Foregroundcolor DarkCyan
 Write-Host "                                                                 ║  " -nonewline
 Write-Host " BIOS Name                      : " -nonewline
 $SplitBIOSName = $global:cmdblock6.tostring().split(":")
 Write-Host $SplitBIOSName[1]
 Write-Host "                                                                 ║  " -nonewline
 Write-Host " BIOS Version                   : " -nonewline
 $SplitBIOSVersion = $global:cmdblock7.tostring().split(":")
 Write-Host $SplitBIOSVersion[1]
 Write-Host "                                                                 ║  " -nonewline
 Write-Host " System Management BIOS Version : " -nonewline
 $SplitSMBIOSVersion = $global:cmdblock8.tostring().split(":")
 Write-Host $SplitSMBIOSVersion[1]
 Write-Host "                                                                 " -nonewline
 Write-Host "╚═══════════════════════════════════════════════════════════" -nonewline
 }
 Function BottomBar()
 {
 Write-Host "Drive and Device Information:" -Foregroundcolor Darkcyan
 $SplitDeviceID = $global:cmdblock21.tostring().split(":")
 Write-Host " DeviceID     :" -Foregroundcolor Cyan -nonewline
 Write-Host "    " -nonewline
 Write-Host $SplitDeviceID[1] -nonewline
 $DeviceIDLength1 = $SplitDeviceID[1].length
 if ($DeviceIDLength1 -match 2) {Write-Host ": Drive    " -nonewline} else {Write-Host "" -nonewline}
 Write-Host "    " -nonewline
 Write-Host $SplitDeviceID[3] -nonewline
 $DeviceIDLength2 = $SplitDeviceID[3].length
 if ($DeviceIDLength2 -match 2) {Write-Host ": Drive    " -nonewline} else {Write-Host "" -nonewline}
 Write-Host "    " -nonewline
 Write-Host $SplitDeviceID[5] -nonewline
 $DeviceIDLength3 = $SplitDeviceID[5].length
 if ($DeviceIDLength3 -match 2) {Write-Host ": Drive    " -nonewline} else {Write-Host "" -nonewline}
 Write-Host "    " -nonewline
 Write-Host $SplitDeviceID[7] -nonewline
 $DeviceIDLength4 = $SplitDeviceID[7].length
 if ($DeviceIDLength4 -match 2) {Write-Host ": Drive    " -nonewline} else {Write-Host "" -nonewline}
 Write-Host "    " -nonewline
 Write-Host $SplitDeviceID[9] -nonewline
 $DeviceIDLength5 = $SplitDeviceID[9].length
 if ($DeviceIDLength5 -match 2) {Write-Host ": Drive    " -nonewline} else {Write-Host "" -nonewline}
 Write-Host "    " -nonewline
 Write-Host $SplitDeviceID[11] -nonewline
 $DeviceIDLength6 = $SplitDeviceID[11].length
 if ($DeviceIDLength6 -match 2) {Write-Host ": Drive    "} else {Write-Host "" -nonewline}
 $SplitDriveTypeTest = $global:cmdblock40.tostring().split(":")
 $DriveType1 = $SplitDriveTypeTest[1]
 $DriveTypeLength1 = $DriveType1.length
 if ($DriveTypeLength1 -gt 2) 
 {
 $NewDriveType1 = $DriveType1.tostring().split(" ")
 $DriveType1 = $NewDriveType1[1]
 }
 else 
 {
 Write-Host "=^-^= : Kitty disaproves of your bad coding"
 }
 $DriveType2 = $SplitDriveTypeTest[2]
 $DriveTypeLength2 = $DriveType2.length
 if ($DriveTypeLength2 -gt 2) 
 {
 $NewDriveType2 = $DriveType2.tostring().split(" ")
 $DriveType2 = $NewDriveType2[1]
 }
 else 
 {
 Write-Host " " -nonewline
 }
 $DriveType3 = $SplitDriveTypeTest[3]
 $DriveTypeLength3 = $DriveType3.length
 if ($DriveTypeLength3 -gt 2) 
 {
 $NewDriveType3 = $DriveType3.tostring().split(" ")
 $DriveType3 = $NewDriveType3[1]
 }
 else 
 {
 Write-Host " " -nonewline
 }
 $DriveType4 = $SplitDriveTypeTest[4]
 $DriveTypeLength4 = $DriveType4.length
 if ($DriveTypeLength4 -gt 2) 
 {
 $NewDriveType4 = $DriveType4.tostring().split(" ")
 $DriveType4 = $NewDriveType4[1]
 }
 else 
 {
 Write-Host " " -nonewline
 }
 $DriveType5 = $SplitDriveTypeTest[5]
 $DriveTypeLength5 = $DriveType5.length
 if ($DriveTypeLength5 -gt 2) 
 {
 $NewDriveType5 = $DriveType5.tostring().split(" ")
 $DriveType5 = $NewDriveType5[1]
 }
 else 
 {
 Write-Host " " -nonewline
 }
 $DriveType6 = $SplitDriveTypeTest[6]
 $DriveTypeLength6 = $DriveType6.length
 if ($DriveTypeLength6 -gt 2) 
 {
 $NewDriveType6 = $DriveType6.tostring().split(" ")
 $DriveType6 = $NewDriveType6[1]
 }
 else 
 {
 Write-Host " "
 }
 Write-Host " Drive Type   :" -Foregroundcolor Cyan -nonewline
 if ($DriveType1 -match 1)
 {
 $DriveType1 = " Unknown"
 $DriveTypeGap1 = "         "
 Write-Host $DriveType1 -nonewline
 Write-Host $DriveTypeGap1 -nonewline
 }
 else
 {
 if ($DriveType1 -match 2)
 {
 $DriveType1 = " Removable Storage"
 $DriveTypeGap1 = ""
 Write-Host $DriveType1 -nonewline
 Write-Host $DriveTypeGap1 -nonewline
 }
 else
 {
 if ($DriveType1 -match 3)
 {
 $DriveType1 = " HardDisk Drive"
 $DriveTypeGap1 = "  "
 Write-Host $DriveType1 -nonewline
 Write-Host $DriveTypeGap1 -nonewline
 }
 else
 {
 if ($DriveType1 -match 4)
 {
 $DriveType1 = " Unknown"
 $DriveTypeGap1 = "         "
 Write-Host $DriveType1 -nonewline
 Write-Host $DriveTypeGap1 -nonewline
 }
 else
 {
 if ($DriveType1 -match 5)
 {
 $DriveType1 = " Disk Drive"
 $DriveTypeGap1 = "      "
 Write-Host $DriveType1 -nonewline
 Write-Host $DriveTypeGap1 -nonewline
 }
 else
 {
 Write-Host " " -nonewline
 }
 }
 }
 }
 }
 if ($DriveType2 -match 1)
 {
 $DriveType2 = " Unknown"
 $DriveTypeGap2 = "         "
 Write-Host $DriveType2 -nonewline
 Write-Host $DriveTypeGap2 -nonewline
 }
 else
 {
 if ($DriveType2 -match 2)
 {
 $DriveType2 = " Removable Storage"
 $DriveTypeGap2 = ""
 Write-Host $DriveType2 -nonewline
 Write-Host $DriveTypeGap2 -nonewline
 }
 else
 {
 if ($DriveType2 -match 3)
 {
 $DriveType2 = " HardDisk Drive"
 $DriveTypeGap2 = "  "
 Write-Host $DriveType2 -nonewline
 Write-Host $DriveTypeGap2 -nonewline
 }
 else
 {
 if ($DriveType2 -match 4)
 {
 $DriveType2 = " Unknown"
 $DriveTypeGap2 = "         "
 Write-Host $DriveType2 -nonewline
 Write-Host $DriveTypeGap2 -nonewline
 }
 else
 {
 if ($DriveType2 -match 5)
 {
 $DriveType2 = " Disk Drive"
 $DriveTypeGap2 = "      "
 Write-Host $DriveType2 -nonewline
 Write-Host $DriveTypeGap2 -nonewline
 }
 else
 {
 Write-Host " " -nonewline
 }
 }
 }
 }
 }
 if ($DriveType3 -match 1)
 {
 $DriveType3 = " Unknown"
 $DriveTypeGap3 = "         "
 Write-Host $DriveType3 -nonewline
 Write-Host $DriveTypeGap3 -nonewline
 }
 else
 {
 if ($DriveType3 -match 2)
 {
 $DriveType3 = " Removable Storage"
 $DriveTypeGap3 = ""
 Write-Host $DriveType3 -nonewline
 Write-Host $DriveTypeGap3 -nonewline
 }
 else
 {
 if ($DriveType3 -match 3)
 {
 $DriveType3 = " HardDisk Drive"
 $DriveTypeGap3 = "  "
 Write-Host $DriveType3 -nonewline
 Write-Host $DriveTypeGap3 -nonewline
 }
 else
 {
 if ($DriveType3 -match 4)
 {
 $DriveType3 = " Unknown"
 $DriveTypeGap3 = "         "
 Write-Host $DriveType3 -nonewline
 Write-Host $DriveTypeGap3 -nonewline
 }
 else
 {
 if ($DriveType3 -match 5)
 {
 $DriveType3 = " Disk Drive"
 $DriveTypeGap3 = "      "
 Write-Host $DriveType3 -nonewline
 Write-Host $DriveTypeGap3 -nonewline
 }
 else
 {
 Write-Host " " -nonewline
 }
 }
 }
 }
 }
 if ($DriveType4 -match 1)
 {
 $DriveType4 = " Unknown"
 $DriveTypeGap4 = "         "
 Write-Host $DriveType4 -nonewline
 Write-Host $DriveTypeGap4 -nonewline
 }
 else
 {
 if ($DriveType4 -match 2)
 {
 $DriveType4 = " Removable Storage"
 $DriveTypeGap4 = ""
 Write-Host $DriveType4 -nonewline
 Write-Host $DriveTypeGap4 -nonewline
 }
 else
 {
 if ($DriveType4 -match 3)
 {
 $DriveType4 = " HardDisk Drive"
 $DriveTypeGap4 = "  "
 Write-Host $DriveType4 -nonewline
 Write-Host $DriveTypeGap4 -nonewline
 }
 else
 {
 if ($DriveType4 -match 4)
 {
 $DriveType4 = " Unknown"
 $DriveTypeGap4 = "         "
 Write-Host $DriveType4 -nonewline
 Write-Host $DriveTypeGap4 -nonewline
 }
 else
 {
 if ($DriveType4 -match 5)
 {
 $DriveType4 = " Disk Drive"
 $DriveTypeGap4 = "      "
 Write-Host $DriveType4 -nonewline
 Write-Host $DriveTypeGap4 -nonewline
 }
 else
 {
 Write-Host " " -nonewline
 }
 }
 }
 }
 }
 if ($DriveType5 -match 1)
 {
 $DriveType5 = " Unknown"
 $DriveTypeGap5 = "         "
 Write-Host $DriveType5 -nonewline
 Write-Host $DriveTypeGap5 -nonewline
 }
 else
 {
 if ($DriveType5 -match 2)
 {
 $DriveType5 = " Removable Storage"
 $DriveTypeGap5 = ""
 Write-Host $DriveType5 -nonewline
 Write-Host $DriveTypeGap5 -nonewline
 }
 else
 {
 if ($DriveType5 -match 3)
 {
 $DriveType5 = " HardDisk Drive"
 $DriveTypeGap = "  "
 Write-Host $DriveType5 -nonewline
 Write-Host $DriveTypeGap5 -nonewline
 }
 else
 {
 if ($DriveType5 -match 4)
 {
 $DriveType5 = " Unknown"
 $DriveTypeGap5 = "         "
 Write-Host $DriveType5 -nonewline
 Write-Host $DriveTypeGap5 -nonewline
 }
 else
 {
 if ($DriveType5 -match 5)
 {
 $DriveType5 = " Disk Drive"
 $DriveTypeGap5 = "      "
 Write-Host $DriveType5 -nonewline
 Write-Host $DriveTypeGap5 -nonewline
 }
 else
 {
 Write-Host " " -nonewline
 }
 }
 }
 }
 }
 if ($DriveType6 -match 1)
 {
 $DriveType6 = " Unknown"
 $DriveTypeGap6 = "         "
 Write-Host $DriveType6 -nonewline
 Write-Host $DriveTypeGap6 -nonewline
 }
 else
 {
 if ($DriveType6 -match 2)
 {
 $DriveType6 = " Removable Storage"
 $DriveTypeGap6 = ""
 Write-Host $DriveType6 -nonewline
 Write-Host $DriveTypeGap6 -nonewline
 }
 else
 {
 if ($DriveType6 -match 3)
 {
 $DriveType6 = " HardDisk Drive"
 $DriveTypeGap = "  "
 Write-Host $DriveType6 -nonewline
 Write-Host $DriveTypeGap6 -nonewline
 }
 else
 {
 if ($DriveType6 -match 4)
 {
 $DriveType6 = " Unknown"
 $DriveTypeGap6 = "         "
 Write-Host $DriveType6 -nonewline
 Write-Host $DriveTypeGap6 -nonewline
 }
 else
 {
 if ($DriveType6 -match 5)
 {
 $DriveType6 = " Disk Drive"
 $DriveTypeGap6 = "      "
 Write-Host $DriveType6 -nonewline
 Write-Host $DriveTypeGap6 -nonewline
 }
 else
 {
 Write-Host " "
 }
 }
 }
 }
 }
 $SplitAvaDeviceMemory = $global:cmdblock22.tostring().split(" ")
 Write-Host " Avaliable Memory: "
 $AvaMem1 = $SplitAvaDeviceMemory[0] / 1GB
 $DeviceAvaMem1 = "{0:N3}" -f $AvaMem1
 Write-Host $DeviceAvaMem1
 Write-Host $SplitAvaDeviceMemory[1]
 Write-Host $SplitAvaDeviceMemory[2]
 Write-Host $SplitAvaDeviceMemory[3]
 Write-Host $SplitAvaDeviceMemory[4]
 "{0:N1}" -f $SplitAvaDeviceMemory[5]
 Write-Host $DeviceAvaMem6
 Write-Host $global:cmdblock22
 Write-Host $global:cmdblock23
 }
 MenuLayout
 TopMenuBar
 MiddleBar
 BottomBar