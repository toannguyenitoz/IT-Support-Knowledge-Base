param([Parameter(Mandatory=$true)][string]$Mailbox)
Connect-ExchangeOnline
Get-MailboxPermission -Identity $Mailbox | Where-Object {$_.User -notlike 'NT AUTHORITY\SELF'} | Select User,AccessRights,IsInherited,Deny
