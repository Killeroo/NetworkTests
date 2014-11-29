# NetDisplay1.0 - Network Statistical Display
# Programmed by Matthew Carney [matthewcarney64@gmail.com]
# Using Powershell Scripting Language (POWERSHELL.PS1)
# © Matthew Carney 29th November 2014
# Feel free to modify, copy or add under the MIT Licence

# begin

$global:scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
IPCONFIG /all | Out-File $global:scriptPath\NetTest.txt
NETSTAT -s -p IP | Out-File $global:scriptPath\NetTest2.txt
PING 8.8.8.8 -n 1 | Out-Null
if ($? -match "True") {$ConnectionError = "False"} else {$ConnectionError = "True"}

Function MenuLayout() {
	Write-Host "NetDisplay                                                         " -foregroundcolor Cyan -nonewline
	Write-Host "Last Refreshed: " -foregroundcolor DarkCyan -nonewline
	Get-Date -format g
	Write-Host "═══════════════════════════════════════════════════════════════════════════════════════════════════" -foregroundcolor DarkRed
}

Function AdapterState() {
	[string]$Networkcard = FIND "Network Card(s):           " $global:scriptPath\Sysinfo.txt
	$SplitNetworkcard = $Networkcard.split(" ")
	Write-Host "Network Card(s): " -foregroundcolor Red -nonewline
	Write-Host $SplitNetworkcard[15] -nonewline
	Write-Host " Network Interface Card(s) Installed" -nonewline
	Write-Host "   Location: " -foregroundcolor DarkCyan -nonewline
	Write-Host $global:scriptPath
	Write-Host "─────────────────────────────────┬─────────────────────────────────────────────────────────────────"
	FIND "Ethernet adapter Local Area Connection" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$EthernetStatus = "ENABLED"} else {$EthernetStatus = "DISABLED"}
	Write-Host "Ethernet Adapter Status: " -nonewline
	if ($EthernetStatus -match "ENABLED") {Write-Host $EthernetStatus -foregroundcolor Green -nonewline} else {Write-Host $EthernetStatus -foregroundcolor Red -nonewline} 
	if ($EthernetStatus -match "ENABLED") {Write-Host " │ " -nonewline} else {Write-Host "│ " -nonewline}
	Write-Host "NetInformation:" -foregroundcolor DarkCyan
	FIND "Wireless LAN adapter Wireless Network Connection" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$WirelessStatus = "ENABLED"} else {$WirelessStatus = "DISABLED"}
	Write-Host "Wireless Adapter Status: " -nonewline
	if ($WirelessStatus -match "ENABLED") {Write-Host $WirelessStatus -foregroundcolor Green -nonewline} else {Write-Host $WirelessStatus -foregroundcolor Red -nonewline}
	if ($WirelessStatus -match "ENABLED") {Write-Host " │ " -nonewline} else {Write-Host "│ " -nonewline}
	FIND "Host Name . . . . . . . . . . . . :" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {
		$HostLine = FIND "Host Name . . . . . . . . . . . . :" $global:scriptPath\NetTest.txt | Select-String -Pattern "Host Name . . . . . . . . . . . . :" 
		$SplitHostLine = $HostLine.tostring().split(":")
		Write-Host "          Host Name" -nonewline
		Write-Host ":" -nonewline
		Write-Host $SplitHostLine[1] -Backgroundcolor DarkGreen -nonewline
		Write-Host " " -Backgroundcolor DarkGreen
	} 
	else {
		Write-Host "          Host Name:" -nonewline
		Write-Host " Unavailable " -Backgroundcolor DarkRed
	}
	FIND "Tunnel adapter" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$TunnelStatus = "ENABLED"} else {$TunnelStatus = "DISABLED"}
	Write-Host "  Tunnel Adapter Status: " -nonewline
	if ($TunnelStatus -match "ENABLED") {Write-Host $TunnelStatus -foregroundcolor Green -nonewline} else {Write-Host $TunnelStatus -foregroundcolor Red -nonewline}
	if ($TunnelStatus -match "ENABLED") {Write-Host " │ " -nonewline} else {Write-Host "│ " -nonewline}
	FIND "IPv4 Address. . . . . . . . . . . :" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {
		$IPv4Line = FIND "IPv4 Address. . . . . . . . . . . :" $global:scriptPath\NetTest.txt | Select-String -Pattern "IPv4 Address. . . . . . . . . . . :" | Select-String -NotMatch "IPv4 Address. . . . . . . . . . . : 25"
		$SplitIPv4Line = $IPv4Line.tostring().split(":")
		Write-Host "       IPv4 Address" -nonewline
		Write-Host ":" -nonewline
		Write-Host $SplitIPv4Line[1] -Backgroundcolor DarkGreen -nonewline
		Write-Host " " -Backgroundcolor DarkGreen
	}
	else {
		Write-Host "       IPv4 Address:" -nonewline
		Write-Host " Unavailable " -Backgroundcolor DarkRed
	}
	FIND "Ethernet adapter Hamachi:" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$HamachiStatus = "ENABLED"} else {$HamachiStatus = "DISABLED"}
	Write-Host "Hamachi Network Adapter: " -nonewline
	if ($HamachiStatus -match "ENABLED") {Write-Host $HamachiStatus -foregroundcolor Green -nonewline} else {Write-Host $HamachiStatus -foregroundcolor Red -nonewline}
	if ($HamachiStatus -match "ENABLED") {Write-Host " │ " -nonewline} else {Write-Host "│ " -nonewline}
	FIND "Default Gateway . . . . . . . . . :" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {
		$GatewayLine = FIND "Default Gateway . . . . . . . . . :" $global:scriptPath\NetTest.txt | Select-String -Pattern "Default Gateway . . . . . . . . . : 1" | Select-String -Pattern "Default Gateway . . . . . . . . . : ::" -NotMatch 
		$SplitGatewayLine = $GatewayLine.tostring().split(":")
		Write-Host "    Default Gateway" -nonewline
		Write-Host ":" -nonewline
		Write-Host $SplitGatewayLine[1] -Backgroundcolor DarkGreen -nonewline
		Write-Host " " -Backgroundcolor DarkGreen
	}
	else {
		Write-Host "    Default Gateway:" -nonewline
		Write-Host " Unavailable " -Backgroundcolor DarkRed
	}
	Write-Host "─────────────────────────────────┤ " -nonewline
	FIND "Subnet Mask . . . . . . . . . . . :" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {
	$SubnetLine = FIND "Subnet Mask . . . . . . . . . . . :" $global:scriptPath\NetTest.txt | Select-String -Pattern "Subnet Mask . . . . . . . . . . . : 255.255"
	$SplitSubnetLine = $SubnetLine.tostring().split(":")
	Write-Host "        Subnet Mask" -nonewline
	Write-Host ":" -nonewline
	Write-Host $SplitSubnetLine[1] -Backgroundcolor DarkGreen -nonewline
	Write-Host " " -Backgroundcolor DarkGreen
	}
	else {
		Write-Host "        Subnet Mask:" -nonewline
		Write-Host " Unavailable " -Backgroundcolor DarkRed
	}
}

Function ConnectionState() {
	PING 8.8.8.8 -n 3 -w 1000 -l 32 | Out-Null
	if ($? -match "True") {$OnlineStatus = "CONNECTED"} else {$OnlineStatus = "DISCONNECTED"}
	Write-Host "    Internet Status: " -nonewline
	if ($OnlineStatus -eq "CONNECTED") {Write-Host $OnlineStatus -foregroundcolor Green -nonewline} else {Write-Host $OnlineStatus -foregroundcolor Red -nonewline}
	if ($OnlineStatus -eq "CONNECTED") {Write-Host "   │ " -nonewline} else {Write-Host "│ " -nonewline}
	FIND "Lease Obtained. . . . . . . . . . :" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {
		FIND "Lease Obtained. . . . . . . . . . :" $global:scriptPath\NetTest.txt | Out-File $global:scriptPath\Lease.txt
		$LeaseObLine = Get-Content ".\Lease.txt" | Select -First 3 | Select-String -Pattern "Lease Obtained. . . . . . . . . . :"
		$SplitLeaseObLine = $LeaseObLine.tostring().split(":")
		Write-Host "     Lease Obtained" -nonewline
		Write-Host ":" -nonewline
		Write-Host $SplitLeaseObLine[1] -Backgroundcolor DarkGreen -nonewline
		Write-Host ":" -Backgroundcolor DarkGreen -nonewline
		Write-Host $SplitLeaseObLine[2] -Backgroundcolor DarkGreen -nonewline
		Write-Host ":" -Backgroundcolor DarkGreen -nonewline
		Write-Host $SplitLeaseObLine[3] -Backgroundcolor DarkGreen -nonewline
		Write-Host " " -Backgroundcolor DarkGreen
		Out-File $global:scriptPath\Lease.txt
	}
	else {
		Write-Host "     Lease Obtained:" -nonewline
		Write-Host " Unavailable " -Backgroundcolor DarkRed
	}
	FIND "Subnet Mask" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$NetworkStatus = "CONNECTED"} else {$NetworkStatus = "DISCONNECTED"}
	Write-Host "     Network Status: " -nonewline
	if ($NetworkStatus -eq "CONNECTED") {Write-Host $NetworkStatus -foregroundcolor Green -nonewline} else {Write-Host $NetworkStatus -foregroundcolor Red -nonewline}
	if ($NetworkStatus -eq "CONNECTED") {Write-Host "   │ " -nonewline} else {Write-Host "│ " -nonewline}
	FIND "Lease Expires . . . . . . . . . . :" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {
		FIND "Lease Expires . . . . . . . . . . :" $global:scriptPath\NetTest.txt | Out-File $global:scriptPath\Lease.txt
		$LeaseExLine = Get-Content ".\Lease.txt" | Select -First 3 | Select-String -Pattern "Lease Expires . . . . . . . . . . :"
		$SplitLeaseExLine = $LeaseExLine.tostring().split(":")
		Write-Host "      Lease Expires" -nonewline
		Write-Host ":" -nonewline
		Write-Host $SplitLeaseExLine[1] -Backgroundcolor DarkGreen -nonewline
		Write-Host ":" -Backgroundcolor DarkGreen -nonewline
		Write-Host $SplitLeaseExLine[2] -Backgroundcolor DarkGreen -nonewline
		Write-Host ":" -Backgroundcolor DarkGreen -nonewline
		Write-Host $SplitLeaseExLine[3] -Backgroundcolor DarkGreen -nonewline
		Write-Host " " -Backgroundcolor DarkGreen
		Out-File $global:scriptPath\Lease.txt
	}
	else {
		Write-Host "      Lease Expires:" -nonewline
		Write-Host " Unavailable " -Backgroundcolor DarkRed
	}
	FIND "Default Gateway" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$GatewayStatus = "CONNECTED"} else {$GatewayStatus = "DISCONNECTED"}
	Write-Host "     Gateway Status: " -nonewline
	if ($GatewayStatus -eq "CONNECTED") {Write-Host $GatewayStatus -foregroundcolor Green -nonewline} else {Write-Host $GatewayStatus -foregroundcolor Red -nonewline}
	if ($GatewayStatus -eq "CONNECTED") {Write-Host "   │ " -nonewline} else {Write-Host "│ " -nonewline}
	FIND "DNS Servers . . . . . . . . . . . :" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {
		$DNSLine = FIND "DNS Servers . . . . . . . . . . . :" $global:scriptPath\NetTest.txt | Select-String -Pattern "DNS Servers . . . . . . . . . . . :" | Select-String -NotMatch "DNS Servers . . . . . . . . . . . : f" 
		$SplitDNSLine = $DNSLine.tostring().split(":")
		Write-Host "        DNS Servers" -nonewline
		Write-Host ":" -nonewline
		Write-Host $SplitDNSLine[1] -Backgroundcolor DarkGreen -nonewline
		Write-Host " " -Backgroundcolor DarkGreen
	}
	else {
		Write-Host "        DNS Servers:" -nonewline
		Write-Host " Unavailable " -Backgroundcolor DarkRed
	}
	FIND "DNS Server" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$DNSStatus = "CONNECTED"} else {$DNSStatus = "DISCONNECTED"}
	Write-Host "  DNS Server Status: " -nonewline
	if ($DNSStatus -eq "CONNECTED") {Write-Host $DNSStatus -foregroundcolor Green -nonewline} else {Write-Host $DNSStatus -foregroundcolor Red -nonewline}
	if ($DNSStatus -eq "CONNECTED") {Write-Host "   ├" -nonewline} else {Write-Host "├" -nonewline}
	Write-Host "─────────────────────────────────────────────────────────────────"
	FIND "DHCP Server" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$DHCPStatus = "CONNECTED"} else {$DHCPStatus = "DISCONNECTED"}
	Write-Host " DHCP Server Status: " -nonewline
	if ($DHCPStatus -eq "CONNECTED") {Write-Host $DHCPStatus -foregroundcolor Green -nonewline} else {Write-Host $DHCPStatus -foregroundcolor Red -nonewline}
	if ($DHCPStatus -eq "CONNECTED") {Write-Host "   │ " -nonewline} else {Write-Host "│ " -nonewline}
	Write-Host "    Statistics:" -foregroundcolor DarkCyan
	FIND "Lease Obtained" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$LeaseStatus = "OBTAINED"} else {$LeaseStatus = "NOT OBTAINED"}
	Write-Host "       Lease Status: " -nonewline
	if ($LeaseStatus -eq "OBTAINED") {Write-Host $LeaseStatus -foregroundcolor Green -nonewline} else {Write-Host $LeaseStatus -foregroundcolor Red -nonewline}
	if ($LeaseStatus -eq "OBTAINED") {Write-Host "    │ " -nonewline} else {Write-Host "│ " -nonewline}
	FIND "Packets Received                   =" $global:scriptPath\NetTest2.txt | Select-String -Pattern "Packets Received                   =" | Write-Host
	Write-Host "─────────────────────────────────┤ " -nonewline
	FIND "Received Packets Discarded         =" $global:scriptPath\NetTest2.txt | Select-String -Pattern "Received Packets Discarded         =" | Write-Host
}

Function IPState() {
	FIND "IPv4 Address" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$IPv4State = "ENABLED"} else {$IPv4State = "DISABLED"}
	Write-Host "IPv4: " -nonewline
	if ($IPv4State -eq "ENABLED") {Write-Host $IPv4State -foregroundcolor Green -nonewline} else {Write-Host $IPv4State -foregroundcolor Red -nonewline}
	if ($IPv4State -eq "ENABLED") {Write-Host "                    │ " -nonewline} else {Write-Host "                   │ " -nonewline}
	FIND "Received Packets Delivered         =" $global:scriptPath\NetTest2.txt | Select-String -Pattern "Received Packets Delivered         =" | Write-Host
	FIND "IPv6 Address" $global:scriptPath\NetTest.txt | Out-Null
	if ($? -match "True") {$IPv6State = "ENABLED"} else {$IPv6State = "DISABLED"}
	Write-Host "IPv6: " -nonewline
	if ($IPv6State -eq "ENABLED") {Write-Host $IPv6State -foregroundcolor Green -nonewline} else {Write-Host $IPv6State -foregroundcolor Red -nonewline}
	if ($IPv6State -eq "ENABLED") {Write-Host "                    │ " -nonewline} else {Write-Host "                   │ " -nonewline}
	FIND "Output Requests                    =" $global:scriptPath\NetTest2.txt| Select-String -Pattern "Output Requests                    =" | Write-Host
	Write-Host "─────────────────────────────────┤ " -nonewline
	FIND "Discarded Output Packets           =" $global:scriptPath\NetTest2.txt | Select-String -Pattern "Discarded Output Packets           =" | Write-Host
}

Function LocalAdapterState() {
	PING 127.0.0.1 -n 3 -w 100 -l 32 | Out-Null
	if ($? -match "True") {$LocalState = "ACTIVE"} else {$LocalState = "INACTIVE"}
	Write-Host "Local Network Adapter: " -nonewline
	if ($LocalState -eq "ACTIVE") {Write-Host $LocalState -foregroundcolor Green -nonewline} else {Write-Host $LocalState -foregroundcolor Red -nonewline}
	if ($LocalState -eq "ACTIVE") {Write-Host "    │ " -nonewline} else {Write-Host "  │ " -nonewline}
	FIND "Unknown Protocols Received         =" $global:scriptPath\NetTest2.txt | Select-String -Pattern "Unknown Protocols Received         =" | Write-Host
	Write-Host "─────────────────────────────────┴─────────────────────────────────────────────────────────────────"
}

Function EndWindow() {
	Remove-Item $global:scriptPath\Lease.txt -erroraction 'silentlycontinue'
	Remove-Item $global:scriptPath\NetTest.txt
	Remove-Item $global:scriptPath\NetTest2.txt
	if ($ConnectionError -match "True") {Write-Warning "Connection Error : Internet Connection Failed"} else {Write-Host}
	Write-Host "═══════════════════════════════════" -foregroundcolor DarkRed -nonewline
	Write-Host "Press Enter To Refresh Display" -nonewline
	Write-Host "══════════════════════════════════" -foregroundcolor DarkRed
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown,AllowCtrlC")
}

MenuLayout
AdapterState
ConnectionState
IPState
LocalAdapterState
EndWindow
 
 # end
 
 # NOTE : For anyone who cares the program uses the IP configurations of the current Hamachi adapter (June 2013)
 #        to differentiate between the addresses given by the Hamachi adapters and those given by the actual PC
 #        adapters (the addresses we want to display). The program may have an issue with this differentiation
 #        if Hamachi updates its IP layout the program won't display the correct information if the Hamachi
 #        adapter is enabled so if the problem ever occurs you might need to change the IF statements that are
 #        used for this.
