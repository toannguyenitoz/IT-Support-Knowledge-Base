<a id="top"></a>

# 29. Teams Meeting Button Missing

**Category:** Teams integration  
**Audience:** IT Support, Service Desk, Desktop Support, Junior System Administrator  
**Scenario:** Teams Meeting add-in is missing from Outlook.

---

## Overview

This article documents a practical troubleshooting approach for **Teams Meeting Button Missing** in an Outlook / Exchange Online / Microsoft 365 environment.

The goal is to identify whether the issue is caused by local Outlook configuration, corrupted profile/cache, add-in conflicts, authentication/MFA, Microsoft 365 licensing, Exchange Online configuration, mail flow policies, network connectivity or service health.

---

## Symptoms

Users may report one or more of the following:

- Teams Meeting add-in is missing from Outlook.
- Outlook desktop behaves differently from Outlook on the web.
- Issue occurs after password change, MFA enrolment, Microsoft 365 migration, Windows update or profile rebuild.
- Mailbox may work on mobile but not desktop, or the reverse.
- The issue may affect one user, a shared mailbox, a department or multiple users.

---

## First Response Questions

1. When did the issue start?
2. Is it happening in Outlook desktop, Outlook on the web or mobile?
3. Is there an error message?
4. Is it affecting one mailbox, a shared mailbox or multiple users?
5. Did anything change recently, such as password, MFA, new device, migration, VPN, add-in or Windows update?
6. Can the user access Outlook on the web?

---

## Quick Triage Checklist

| Check | Action |
|---|---|
| Scope | Confirm whether one user or multiple users are affected. |
| OWA Test | Test Outlook on the web: `https://outlook.office.com/mail/` |
| Network | Confirm internet, VPN, proxy and DNS status. |
| Account | Check password, MFA, sign-in status and Microsoft 365 license. |
| Client | Test Outlook Safe Mode and a new Outlook profile. |
| Cache | Rebuild the OST file if local cache corruption is suspected. |
| Service | Check Microsoft 365 Service Health for active incidents. |
| Admin | Use Exchange Admin Center and PowerShell checks where required. |

---

## Troubleshooting Steps

### 1. Test Outlook on the web

```text
https://outlook.office.com/mail/
```

- If Outlook on the web works, the mailbox is likely healthy and the issue is probably local Outlook, cache, add-in, profile or device related.
- If Outlook on the web also fails, investigate account status, license, MFA, mailbox, permissions, Defender, mail flow or service health.

### 2. Check Outlook connection status

```text
Ctrl + Right-click Outlook icon in the system tray
→ Connection Status
```

Look for authentication failures, repeated reconnects, failed connections, incorrect endpoint, high latency, proxy or VPN-related failures.

### 3. Start Outlook in Safe Mode

```cmd
outlook.exe /safe
```

If the problem disappears in Safe Mode:

```text
File → Options → Add-ins → COM Add-ins → Go
```

Disable add-ins one by one and test Outlook again.

### 4. Create a new Outlook profile

```text
Control Panel
→ Mail
→ Show Profiles
→ Add
```

Create a new profile, add the Microsoft 365 mailbox, set it as default and test Outlook before deleting the old profile.

### 5. Rebuild the OST cache

Close Outlook first.

```text
%localappdata%\Microsoft\Outlook
```

Rename the `.ost` file and restart Outlook to allow the mailbox to resync.

### 6. Check Microsoft 365 account and license

In Microsoft 365 Admin Center, verify the user is active, sign-in is not blocked, correct license is assigned, Exchange Online plan is enabled and MFA/Conditional Access is not blocking access.

### 7. Check Exchange Admin Center

```text
Exchange Admin Center
→ Recipients
→ Mailboxes
```

Check mailbox existence, GAL visibility, quota, forwarding, shared mailbox permissions and calendar permissions where relevant.

---

## PowerShell Checks

```powershell
Connect-ExchangeOnline

Get-Mailbox -Identity "user@domain.com" |
Format-List DisplayName,PrimarySmtpAddress,RecipientTypeDetails,HiddenFromAddressListsEnabled

Get-MailboxStatistics -Identity "user@domain.com" |
Select DisplayName,TotalItemSize,ItemCount,LastLogonTime

Get-MailboxPermission -Identity "user@domain.com"

Get-InboxRule -Mailbox "user@domain.com" |
Select Name,Enabled,Priority,Description

Get-MailboxFolderPermission -Identity "user@domain.com:\Calendar"
```

---

## Resolution Options

- Disable problematic Outlook add-ins.
- Recreate the Outlook profile.
- Rebuild the OST file.
- Repair Microsoft 365 Apps.
- Reset password or resolve MFA issue.
- Assign or correct Microsoft 365 license.
- Correct mailbox or calendar permissions.
- Review Defender quarantine.
- Run message trace for mail delivery issues.
- Review mail flow rules.
- Escalate to Microsoft 365 Administrator if a tenant-wide or policy issue is found.

---

## User Communication Template

```text
Hi [User],

I am investigating your Outlook issue and checking whether it is related to the local Outlook application, mailbox configuration, authentication or Microsoft 365 service health.

I will test Outlook on the web, review the Outlook profile/cache and verify the mailbox configuration where required.

I will update you once I confirm the root cause or the next troubleshooting step.

Regards,
IT Support
```

---

## Escalation Notes

Escalate to Level 2 / Microsoft 365 Administrator if multiple users are affected, Outlook on the web also fails, message trace shows delivery failure, Defender quarantine or mail flow rules are involved, Conditional Access/MFA policy requires admin review, Service Health shows an active Microsoft 365 incident or hybrid Exchange is involved.

---

## Related Articles

[Outlook Index](./README.md) | [Previous: Delegate Access Issues](./28-delegate-access-issues.md) | [Next: Zoom Meeting Button Missing](./30-zoom-meeting-button-missing.md)

---

[Back to top](#top)
