Connect-ExchangeOnline
Get-Mailbox -ResultSize Unlimited | Get-MailboxStatistics | Select DisplayName,TotalItemSize,ItemCount,LastLogonTime | Export-Csv .\MailboxSizeReport.csv -NoTypeInformation
