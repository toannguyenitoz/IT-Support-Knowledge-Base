# 34. Outlook Rules Missing

> Category: Outlook / Exchange Online  
> Difficulty: L1–L2 IT Support / System Administrator  
> Purpose: Rules disappear after profile change, migration, or corruption.

---

## Symptoms

- User reports: **Rules disappear after profile change, migration, or corruption.**
- Issue may affect one user, multiple users, or an entire department.
- Outlook desktop may behave differently from Outlook on the web.
- The issue may be related to profile, network, authentication, permissions, mailbox configuration, or Exchange Online service health.

---

## Quick Triage Checklist

| Check | Action |
|---|---|
| Scope | Confirm whether one user or many users are affected. |
| OWA Test | Ask the user to test Outlook on the web: `https://outlook.office.com/mail/` |
| Network | Confirm internet, VPN, DNS, and proxy status. |
| Account | Check password, MFA, sign-in logs, and license assignment. |
| Client | Test Outlook Safe Mode and a new Outlook profile. |
| Server | Check Exchange Admin Center, Defender, and Microsoft 365 Service Health. |

---

## Common Causes

1. Corrupted Outlook profile or local cache.
2. OST/PST data file issue.
3. Add-in conflict.
4. Microsoft 365 authentication or MFA issue.
5. Mailbox permission or Exchange Online configuration issue.
6. Network, DNS, proxy, VPN, or firewall restriction.
7. Microsoft 365 service incident.
8. Mail flow, spam policy, transport rule, or Defender policy issue.

---

## Step-by-Step Troubleshooting

### 1. Confirm the exact issue

Ask the user:

- When did the issue start?
- Is the issue happening in Outlook desktop, Outlook web, or mobile?
- Is there an error message?
- Is the problem affecting all emails or only some senders/recipients?
- Did anything change recently, such as password reset, MFA setup, device change, migration, or new add-in?

---

### 2. Test Outlook on the web

Open:

```text
https://outlook.office.com/mail/
```

Interpretation:

- If OWA works, the mailbox is likely healthy and the issue is probably local Outlook/client/profile/cache.
- If OWA also fails, investigate account, license, mailbox, service health, or Exchange Online configuration.

---

### 3. Check Outlook connection status

In Outlook desktop:

```text
Ctrl + Right-click Outlook icon in system tray
→ Connection Status
```

Look for:

- Authn errors
- Failed connections
- Repeated reconnects
- Incorrect mailbox/server endpoint
- Latency or proxy-related failures

---

### 4. Start Outlook in Safe Mode

```cmd
outlook.exe /safe
```

If the issue disappears in Safe Mode:

```text
File → Options → Add-ins → COM Add-ins → Go
```

Disable add-ins one by one and test again.

---

### 5. Recreate the Outlook profile

```text
Control Panel
→ Mail
→ Show Profiles
→ Add
```

Recommended approach:

1. Create a new profile.
2. Add the Microsoft 365 mailbox.
3. Set the new profile as default.
4. Test before deleting the old profile.

---

### 6. Rebuild the OST cache

Close Outlook first.

```text
%localappdata%\Microsoft\Outlook
```

Rename the `.ost` file, for example:

```text
outlook-rules-missing-old.ost
```

Restart Outlook and allow the mailbox to resync.

---

### 7. Check mailbox and license status

In Microsoft 365 Admin Center:

```text
Users → Active users → Select user
```

Verify:

- User is active.
- Correct Microsoft 365 license is assigned.
- Exchange Online plan is enabled.
- Sign-in is not blocked.
- MFA or Conditional Access is not blocking access.

---

### 8. Check Exchange Admin Center

```text
Exchange Admin Center
→ Recipients
→ Mailboxes
```

Check:

- Mailbox exists.
- Mailbox is not hidden from address lists unless intended.
- Mailbox quota is not exceeded.
- Email forwarding is not misconfigured.
- Mailbox permissions are correct.

---

## PowerShell Checks

Connect to Exchange Online:

```powershell
Connect-ExchangeOnline
```

Check mailbox:

```powershell
Get-Mailbox -Identity "user@contoso.com" | Format-List DisplayName,PrimarySmtpAddress,RecipientTypeDetails,HiddenFromAddressListsEnabled
```

Check mailbox statistics:

```powershell
Get-MailboxStatistics -Identity "user@contoso.com" | Select DisplayName,TotalItemSize,ItemCount,LastLogonTime
```

Check folder permissions when relevant:

```powershell
Get-MailboxFolderPermission -Identity "user@contoso.com:\Calendar"
```

Check mobile devices when relevant:

```powershell
Get-MobileDeviceStatistics -Mailbox "user@contoso.com"
```

---

## Admin Resolution Options

Depending on the root cause:

- Recreate the Outlook profile.
- Rebuild the OST file.
- Disable or remove problematic add-ins.
- Repair Microsoft 365 Apps.
- Reset password or resolve MFA issue.
- Assign the correct license.
- Correct mailbox permissions.
- Review transport rules or Defender policies.
- Run message trace.
- Escalate if Microsoft 365 Service Health shows an active incident.

---

## End-User Communication Template

```text
Hi [User],

I checked your Outlook issue and verified whether the mailbox works in Outlook on the web. 
I am now isolating whether this is a local Outlook profile/cache issue or an Exchange Online configuration issue.

I will update you once testing is complete.

Regards,
IT Support
```

---

## Escalation Notes

Escalate to Level 2 / Microsoft 365 Administrator if:

- Multiple users are affected.
- Message trace shows failed delivery.
- Service Health shows an incident.
- Conditional Access or Defender policy is involved.
- Mailbox permissions or hybrid Exchange configuration require admin review.

---

## Related Commands

```powershell
Get-Mailbox "user@contoso.com"
Get-MailboxStatistics "user@contoso.com"
Get-CASMailbox "user@contoso.com"
Get-InboxRule -Mailbox "user@contoso.com"
Get-MailboxPermission "user@contoso.com"
```

---

[⬅ Back to Outlook Index](./README.md)

