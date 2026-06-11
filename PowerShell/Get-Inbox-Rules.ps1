# Check inbox rules for a mailbox
param(
    [Parameter(Mandatory=$true)]
    [string]$Mailbox
)
Connect-ExchangeOnline
Get-InboxRule -Mailbox $Mailbox | Select Name,Enabled,Priority,Description
