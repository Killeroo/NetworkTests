NetworkTests
============

A small, mainly Batch written, network utility for windows that provides a basic suit of network tests from Command Prompt as well as some more complicated interesting Powershell scripts for network probing and analysis.

NetworkTests comes in a windows created Self Extracting Directory [SED] which will install NetworkTests on a local windows machine. However a copy of main directory will still work and when executed on its own the main NetworkTest batch file will create its own directory in its current location.

NetworkTests consists of 4 many programs and scripts:
- [CMD.BAT] NetworkTest - Core and underlying Batch script, all other scripts are initiated from here
- [POWERSHELL.PS1] NetDisplay - A powershell script that displays, in a simple colourful format, the statuses of a computers network components and connections
- [POWERSHELL.PS1] NetRanger - A small script built using core components from PingLooper, it is designed to scan for IP address on a specified network segment
- [POWERSHELL.PS1] NetLooper - A script designed to test the connection between computers and servers by using accelerated ping sending from multiple console instances

[NOTE : Each Powershell script has a corresponding batchh file that sets the appropriate window size and executes the script. It is crucial for the powershell scripts to be initiated using  these files otherwise some of the scrips may suffer majoy formating and positioning errors]


