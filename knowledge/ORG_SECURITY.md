# POW Org Security
Generated: 2026-04-16 | Org: 00D4P000001dRZ9

## Overview

| Type | Count |
|------|-------|
| Custom Permission Sets (POW-managed) | 12 |
| Total Profiles | 37 |

---

## POW-Managed Permission Sets (12)

| API Name | Label | Description |
|----------|-------|-------------|
| `Alliance_Record_Type_Access` | Alliance Record Type Access | Grants Alliance Member record type visibility. Contact: ViewAll/ModifyAll. |
| `Alliance_Record_Type_Prevention_of_Change` | Alliance Record Type - Prevention of Change | Prevents users from changing the Alliance record type. |
| `Batch_Gift_Entry` | Batch Gift Entry | NPSP Batch Gift Entry access for creating and processing batches. |
| `Case_Full_Access` | Case Full Access | Full case management access. Assign to case managers. |
| `Edit_Donations` | View and Edit Donations | Create/edit donations and recurring donations. |
| `Edit_Donations_and_Payments` | View and Edit Donations & Payments | Full donation + payment access including delete. |
| `Integration_User_Standard_Objects` | Integration User - Standard Objects | Full access for integration user on standard objects. |
| `MFA` | MFA | Multi-factor authentication enforcement. |
| `No_MFA` | No MFA | MFA bypass for service/integration users. |
| `Preferred_Communication_Method_Access` | Preferred Communication Method Access | Read/write access to Preferred_Communication_Method__c on Contact. |
| `View_Donations` | View Donations | Read-only access to donation information. |
| `Year_End_Thank_You_Access` | Year End Thank You Access | Read/write access to Year_End_Thank_You_Sent__c on Contact. Assign to development/fundraising staff. |

> Third-party managed package permission sets (Blackthorn, Classy, Formstack, DLRS, etc.) are excluded above.

---

## Profiles (37)

### Staff Profiles (Key)

| Profile | Purpose |
|---------|---------|
| POW System Admin | Full admin with POW-specific config |
| System Admin - Advocacy | Admin access for advocacy team |
| Fundraising and Development | Development team — main staff profile for donation management |
| Comms and Marketing | Communications team |
| Program Staff | Program team |
| Advocacy | Advocacy team |
| Partnerships | Partnerships team |
| Executive Management | Executive-level access |
| Alliance Captains | Alliance team captains |

### All Profiles (37 total)

- Advocacy
- Alliance Captain - Science
- Alliance Captains
- Analytics Cloud Integration User
- Analytics Cloud Security User
- Anypoint Integration
- Chatter External User
- Chatter Free User
- Chatter Moderator User
- CiviClick Webhook Profile
- Comms and Marketing
- Contract Manager
- Executive Management
- Fundraising and Development
- Guest License User
- Identity User
- Marketing User
- Minimum Access - API Only Integrations
- Minimum Access - Salesforce
- POW System Admin
- Partnerships
- Program Staff
- Read Only
- Sales Insights Integration User
- Salesforce API Only System Integrations
- SalesforceIQ Integration User
- ShopifyIntegration Profile
- Solution Manager
- Standard Guest
- Standard Platform User
- Standard User
- System Admin - Advocacy
- System Admin - Training
- System Administrator
- System Administrator - Sync
- Volunteer
- Volunteer Profile

---

## FLS Notes

- **Year_End_Thank_You_Sent__c** — Editable/readable via `Year_End_Thank_You_Access` permission set. Assign to Fundraising and Development users.
- **Preferred_Communication_Method__c** — Editable/readable via `Preferred_Communication_Method_Access` permission set. Assign to all staff.
- **Donation fields** — Controlled via `View_Donations`, `Edit_Donations`, `Edit_Donations_and_Payments` tiers.
- **KnowWho fields** — Managed via `KnowWho_Data_Update_Access` and `KnowWho_User_Read_Access`.
- **Alliance record type** — Controlled via `Alliance_Record_Type_Access` (enable) and `Alliance_Record_Type_Prevention_of_Change` (lock).
