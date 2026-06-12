param([Parameter(Mandatory=$true)][string]$Mailbox)
Connect-ExchangeOnline
Get-MailboxFolderPermission -Identity "$Mailbox:\Calendar"
