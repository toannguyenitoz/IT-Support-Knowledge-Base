# Review mobile devices
param([Parameter(Mandatory=$true)][string]$Mailbox)
Connect-ExchangeOnline
Get-MobileDeviceStatistics -Mailbox $Mailbox
