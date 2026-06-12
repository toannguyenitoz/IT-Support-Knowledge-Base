ipconfig /all
Write-Host '--- DNS Test ---'
nslookup microsoft.com
Write-Host '--- Internet Test ---'
Test-NetConnection microsoft.com -Port 443
