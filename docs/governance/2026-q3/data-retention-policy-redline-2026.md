# Protect Our Winters (POW) Data Retention Policy — 2026 Annual Review

**Draft v2 — August 2026** (redline against v1, January 31, 2025)
Prepared by Resin LLC for Data Governance Committee review.

> **What this is:** the policy requires an annual review; the last version is January
> 2025. Everything below marked ✅ **CONFIRM** is unchanged and verified as actually
> running in production — no action needed unless you object. Three small additions are
> marked **[ADD]**. That's the whole review.

## Purpose

✅ **CONFIRM — no change.** Establish clear guidelines for the storage, archiving, and
deletion of data within Salesforce and related systems.

## Data Retention Guidelines

### 1. Contact Records

✅ **CONFIRM — running as written.** Contacts are marked 'Archived' by the weekly
scheduled flow only when **all** conditions are met: no gifts, no affiliations, email
opt-out = true, not an Alliance member, not a Team POW member, no advocacy actions,
never attended an event, created more than three years ago.

**[ADD] Donor protection statement:** "Donors are never archived or deleted regardless
of timeframe. No contact who has given a gift, attended an event, or taken an advocacy
action is ever eligible for archival."
*(This is already how the criteria behave — the line just makes the guarantee explicit.)*

### 2. Campaign Records and Campaign Members

✅ **CONFIRM — running as written.** Campaigns with no contacts and created more than
12 months ago are deleted (365 days after creation). No campaign members are deleted.
Campaign owners remain responsible for cleaning up their own campaigns.

Exclusions:

- Event-related campaigns
- Classy campaigns
- ~~Phone2Action campaigns~~ **[REPLACE WITH]** "Advocacy campaigns (Phone2Action,
  Quorum, and CiviClick)" *(CiviClick replaced Quorum in January 2026; historical
  advocacy campaigns remain protected.)*

### 3. Email Activity

✅ **CONFIRM — running as written.** Mailchimp activity is retained on the contact
record for 30 days, then deleted (applies to all contacts including Alliance members).
Gmail messages are never deleted.

### 4. Form Submissions

✅ **CONFIRM — running as written.** Formstack submissions are deleted after three
years, excluding Alliance forms. Data captured onto the contact record is unaffected —
only the raw submission is deleted.

### **[ADD] 5. L2 Voter Data**

"L2 voter data (2022 election vintage) is static, imported data. The master dataset is
retained in Google Drive external storage; records not linked to active contacts were
removed from Salesforce (completed 2026). No automation writes to L2 data."
*(Formalizes the committee's January 2025 decision, which has been carried out.)*

## Retention of Other Data

✅ **CONFIRM — no change.** All data not specified above is retained indefinitely.

## Enforcement (verified active, August 2026)

| Mechanism | Where it runs | Status |
|---|---|---|
| Contact Archive Scheduled Flow | Salesforce (weekly) | Active |
| Campaign delete filter | Cloudingo | Active |
| Mailchimp activity delete filter | Cloudingo | Active |
| Formstack submission delete filter | Cloudingo | Active |

## Policy Review

✅ **CONFIRM** annual review requirement.
**[ADD]** "Last reviewed: August 2026. Next review due: August 2027."

---

## What we need from you

Reply **"Approved"** or comment on any of the three additions:

1. Donor-protection statement (section 1)
2. CiviClick added to the advocacy campaign exclusions (section 2)
3. New L2 Voter Data section (5)

Everything marked ✅ CONFIRM requires no action unless you object.
