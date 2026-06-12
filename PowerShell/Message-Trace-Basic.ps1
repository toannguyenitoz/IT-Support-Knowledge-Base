param([Parameter(Mandatory=$true)][string]$Sender)
Connect-ExchangeOnline
Get-MessageTrace -SenderAddress $Sender -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date)
