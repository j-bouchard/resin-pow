# [POW] Salesforce Update + Two Decisions — Q3 2026 (sent as email)

**To:** Data Governance Committee (Lindsey, Maddy, Graham, Waverley, Patrick, Stacie; Hannah cc'd as executive sponsor)
**From:** Joe Bouchard (Resin LLC)
**Responses due Thursday, August 27.** No meeting required.

Reframed 8/20 per Joe: this is an *update* on recent Salesforce changes (all reflected
in the completed User Manual v2) plus the two decisions that still need the committee —
Quorum-stack retirement and the retention policy annual review. Membership structure
item removed (committee already aware); manual approval item removed (manual completed
directly). This file mirrors the Gmail draft.

## What's new in Salesforce (FYI section)

- **User Manual v2 complete** — all chapters written ([Drive doc](https://docs.google.com/document/d/1geY_FfQHJQWnoRG68U37zWQKAl_ps7R5-PjlImn10WQ/edit))
- **CiviClick advocacy integration live** — 12 campaigns, ~3,900 unique advocates in 2026
- **Higher Logic community sync live**
- **Shopify order sync live**
- **Alliance training tracking automated** — event tag → campaign checkbox → dashboard (71 members trained across 15 events in 2026)
- **OKR tracking reference** published ([Drive doc](https://docs.google.com/document/d/1FbmQHcQ0cF3gV9eZS7-vXR8Nj1Vad__2jmH20Ika784/edit))
- **Data health snapshot** (read-only) ([Drive doc](https://docs.google.com/document/d/15xm8G6BiGnfuBuf4YRzBncIIj-u4k20hKhqBVFvimwQ/edit))

## Decision 1 — Retire the Quorum stack (KnowWho + Phone2Action packages)

CiviClick fully replaced Quorum in January; the retired stack is still installed and the
KnowWho sync is still growing (30,904 records). **Resin recommendation: REMOVE**, per
Salesforce best practice on retired managed packages (storage, security surface, upgrade
risk, schema clutter). Staged plan: dependency audit → deactivate syncs → full data
archive to Google Drive → uninstall. Historical advocacy campaign history is preserved
(standard objects). Ask: **REMOVE (recommended) or KEEP** (with who uses it).

*(Supersedes the narrower KnowWho keep/archive/drop question — expanded to the whole
retired stack per Joe, 8/20. The dependency audit already has one known item: the active
`Contact_Address` matching rule keys on `kw__Zip_Code__c` and will be re-pointed to
`MailingPostalCode` as part of removal.)*

## Decision 2 — Data Retention Policy annual review

Short review doc: confirms everything running (4 enforcement mechanisms verified active)
plus three small additions — donor-protection statement, CiviClick in the advocacy
campaign exclusions, L2 voter data section (completed action, now recorded in policy).
Ask: **"Approved"** or comments in the doc.
([Drive doc](https://docs.google.com/document/d/1TuLw4DmYBu9fofut8T7mDHIPpXKdNmtHOA92Qq4vYak/edit))

*(Simplified 8/20 per Joe: implementation/oversight section removed; activity-records
section removed — storage remediation is a Resin operational item for September, not a
committee policy question.)*

## Housekeeping — code access

POW's Salesforce configuration + custom integrations are version-controlled in GitHub
(Resin-maintained). Offer: POW names a technical point of contact for **read access** —
continuity and transparency best practice.

## Summary of asks

| Item | Action | Who |
|------|--------|-----|
| 1. Quorum/KnowWho retirement | REMOVE / KEEP | Anyone using it; else Hannah |
| 2. Retention policy | "Approved" or doc comments | All |
| 3. GitHub read access | Name a contact (optional) | Hannah / Erin |
| Manual, OKR ref, snapshot | FYI only | All |
