# Protect Our Winters (POW) Data Retention Policy — 2026 Annual Review Redline

**Draft v2 — August 2026** (redline against v1, January 31, 2025)
Prepared by Resin LLC for Data Governance Committee async review. **Responses due within one week of send.**

> **How to read this redline:** ~~struck text~~ is proposed for removal, **[ADD]** marks
> proposed additions, ✅ **CONFIRM** marks language that is unchanged and verified as
> actually running in production. This review is mostly confirmation — the policy has
> been enforced continuously since January 2025 and it is working: storage went from
> 142% of allocation (November 2024) to 87% (January 2026). Note that as of August 2026
> storage is back over allocation (116.5%), driven by **activity records the policy does
> not cover** (Tasks and system relation records) — see the new section 7. That is a
> gap to close next, not a failure of what's here.

---

## Purpose

✅ **CONFIRM — no change.** Establish clear guidelines for the storage, archiving, and
deletion of data within Salesforce and related systems.

## Data Retention Guidelines

### 1. Contact Records

✅ **CONFIRM — running as written.** Contacts are marked 'Archived' by the weekly
scheduled flow (`Data Retention Policy - Contact Archive Scheduled Flow`) only when
**all** conditions are met: no gifts, no affiliations, email opt-out = true, not an
Alliance member, not a Team POW member, no advocacy actions, never attended an event,
created more than three years ago.

**[ADD] Donor protection statement (formalizes the committee's January 2025 direction):**
"Donors are never archived or deleted regardless of timeframe. No contact who has given
a gift, attended an event, or taken an advocacy action is ever eligible for archival."
*(This is already how the criteria behave — this line just makes the guarantee explicit
in the policy document.)*

**[ADD] KnowWho records:** "KnowWho legislator contact records (~26,000) are governed by
the committee's KnowWho decision (Q3 2026 async packet, item 1). If the decision is
'drop,' KnowWho records will be deleted in a one-time, documented operation and this
policy will not apply to them. If 'keep' or 'archive,' KnowWho records remain excluded
from archival criteria and from Cloudingo merges."
*(Placeholder pending your KnowWho vote — the policy will be updated to match the decision.)*

### 2. Campaign Records and Campaign Members

✅ **CONFIRM — running as written.** Campaigns with no contacts and created more than
12 months ago are deleted via the Cloudingo filter `Data Retention Policy - Campaigns`
(deletion occurs 365 days after creation date). No campaign members are deleted.

Exclusions — proposed update to reflect the Quorum → CiviClick migration:

- Event-related campaigns
- Classy campaigns
- ~~Phone2Action campaigns~~ **[REPLACE WITH]** "Advocacy campaigns (Phone2Action,
  Quorum, and CiviClick)" *(CiviClick replaced Quorum in January 2026; historical
  Phone2Action and Quorum campaigns remain protected.)*

✅ **CONFIRM** Campaign owners remain responsible for reviewing and cleaning up their
own campaigns.

### 3. Email Activity

✅ **CONFIRM — running as written.**

- Mailchimp activity retained on the contact record for 30 days; older activity deleted
  via Cloudingo filter `Data Retention Policy - Mailchimp Activity Delete`. Applies to
  all contacts **including Alliance members** (per the committee's January 2025 decision).
- Gmail messages are never deleted.

### 4. Form Submissions

✅ **CONFIRM — running as written.** Formstack submissions deleted after three years via
Cloudingo filter `Data Retention Policy - Formstack Submissions`, excluding Alliance
forms. Contact-record data captured from forms is unaffected — only the raw submission
is deleted.

### **[ADD] 5. L2 Voter Data**

**Proposed new section** (formalizes the committee's January 2025 action item, which
has been **completed**): "L2 voter data (2022 election vintage) is static, imported
data. The master dataset is retained in Google Drive external storage; records not
linked to active contacts were removed from Salesforce (438,645 → 9,599 remaining
linked records as of August 2026). No automation writes to L2 data."

### **[ADD] 6. Integration-Owned Data (CiviClick, Higher Logic)**

**Proposed new section:** "Data synced from CiviClick (advocacy actions) and Higher Logic
(community engagement) follows the retention rules of its record type above (campaign
members, contacts, activities). Any integration-specific retention needs will be brought
to the committee before new deletion rules are created."
*(New integrations went live after the January 2025 policy; this closes the gap without
changing behavior.)*

### **[ADD] 7. Activity Records (Tasks) — flagged for next review, no change proposed now**

**Proposed new informational section:** "Activity records (Tasks and their
system-generated relation records) are not currently covered by this policy and are
retained indefinitely. As of August 2026 they are the largest data storage consumer
(3.4M Tasks / 9.1M relation records) and the primary driver of storage returning to
116% of allocation. Resin will present retention options for activity records at the
next policy review; any change will require committee approval."
*(This makes the gap visible in the policy itself without deciding anything today.)*

## Retention of Other Data

✅ **CONFIRM — no change.** All data not specified above is retained indefinitely.

## Processes for Maintaining Guidelines

✅ **CONFIRM — all four enforcement mechanisms verified active:**

| Mechanism | Where it runs | Status |
|---|---|---|
| Contact Archive Scheduled Flow | Salesforce (weekly) | Active |
| `Data Retention Policy - Campaigns` delete filter | Cloudingo | Active |
| `Data Retention Policy - Mailchimp Activity Delete` filter | Cloudingo | Active |
| `Data Retention Policy - Formstack Submissions` filter | Cloudingo | Active |

## Implementation and Oversight

- ~~Conduct quarterly data reviews~~ **[REPLACE WITH]** "Conduct data reviews on the
  committee's meeting cadence, with a written data health snapshot circulated at least
  quarterly (async acceptable)." *(Matches how oversight actually works in 2026 —
  quarterly in-person reviews have not been happening; async snapshots keep the
  oversight commitment honest without requiring a meeting.)*
- ✅ **CONFIRM** annual review of archived data.
- ✅ **CONFIRM** storage solutions guidance (Salesforce for active data; Drive/external
  storage for archives).
- ✅ **CONFIRM** stakeholder involvement via the Data Governance Committee.

## Policy Review

✅ **CONFIRM** annual review requirement.
**[ADD]** "Last reviewed: August 2026 (async committee review). Next review due:
August 2027."

---

## What we need from the committee

Reply within one week with either **"Approved as redlined"** or specific comments on:

1. The donor-protection statement (1)
2. The CiviClick campaign exclusion update (2)
3. The new L2 Data section (5)
4. The new integration-owned data section (6)
5. The new activity-records informational section (7)
6. The oversight cadence language change

Everything marked ✅ CONFIRM requires no action unless you object.
