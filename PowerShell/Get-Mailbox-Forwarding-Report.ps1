# Report mailbox forwarding settings
Connect-ExchangeOnline
Get-Mailbox -ResultSize Unlimited | Select DisplayName,PrimarySmtpAddress,ForwardingAddress,ForwardingSmtpAddress,DeliverToMailboxAndForward | Export-Csv .\MailboxForwardingReport.csv -NoTypeInformation
