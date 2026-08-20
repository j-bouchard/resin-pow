# [POW] Production Deploy Report — 2026-08-20

PR #21 (`b471ebbdf482e8e5b3bfcff982201eccc11de26d`, merged by Joe 2026-08-20 15:32 UTC) · ClickUp task 868kq2mah · Not destructive (no `DESTRUCTIVE:` line in PR body; verified via GitHub API before deploy).

## JOB 1 — Production deploy (validate + quick-deploy)

| Item | Value |
|------|-------|
| Validation ID | `0AfRn000002CpFJKA0` |
| Validation status | **Succeeded** (checkOnly) |
| Quick-deploy ID | `0AfRn000002CpNNKA0` |
| Deploy status | **Succeeded** |
| Components | 2 / 2, 0 errors |
| Tests | 71 / 71 passed (RunLocalTests), 0 failures, ~115 s |
| Org-wide coverage | 92% (963 locations, 71 uncovered) — well above the 75% floor |

Components deployed:

- `Flow: Event_Alliance_Training_Campaign_Sync` (new)
- `CustomField: Campaign.Alliance_Training__c` (already existed in prod — no-op sync, as expected per the PR body)

### ⚠ Flow deployed as INACTIVE — action needed

Post-deploy verification (read-only Tooling API query on `FlowDefinition` /
`FlowDefinitionView`):

- `Event_Alliance_Training_Campaign_Sync` — latest version **1**, status
  **Draft**, active version **none** (`IsActive = false`).

The repo XML ships `<status>Active</status>`, but the production org's
**"Deploy processes and flows as active"** setting (Setup → Process
Automation Settings) is evidently disabled, so the flow landed as version 1
in Draft. **Joe needs to activate the flow in Setup** (Flow → Event -
Alliance Training Campaign Sync → Activate), or enable that org setting
before a future re-deploy. Until activated, tagged Blackthorn events will
NOT check `Alliance Training` on their campaigns.

`Campaign.Alliance_Training__c` verified present in production (Checkbox,
label "Alliance Training").

### Test run notes

Slowest/no failures; suite includes the new Higher Logic classes
(`HigherLogicActivityProcessorTest` et al.), `CiviClickWebhookHandlerTest`,
`ShopifyOrderWebhookTest`, site controllers, DLRS trigger tests, and
`UpdateCountryBatchTest`. Lowest-covered class: `ShopifyOrderWebhook`
(231/270 locations ≈ 86%).

### Operational notes

- Audit events `deploy.start` / `deploy.complete` were emitted, but the
  central audit sink (`j-bouchard/resin-audit`) was unreachable from this
  container (no `gh` auth) — the script warned and continued per its
  failure policy. The events for this deploy exist only in this report.
- The SessionStart SF auth hook was broken at session start; auth was done
  manually with the client-credentials flow (the hook fix subsequently
  landed on main as PR #22 — `2ffd226`).
- The cloud proxy repeatedly killed long-lived Metadata API polling
  connections (`MetadataTransferError: fetch failed`). The validation
  submit succeeded server-side both times; status was confirmed via
  `sf project deploy report --job-id`. Only one validation run was used
  for the quick-deploy.
- ClickUp/Slack updates intentionally NOT posted from this session — the
  parent session handles those.

## JOB 2 — Org snapshot refresh

Full metadata retrieve from production (`package.xml` manifest): **17,532
files**, success. 22 manifest warnings, all pre-existing manifest
limitations (Report/Dashboard wildcards need folder members; Experience
Cloud types not enabled; two matching rules and a few Settings types
unknown) — same class of gaps as the April retrieve, nothing newly broken.

Working tree after retrieve: 234 modified files, ~1,950 new (≈1,740 of the
new files are objectTranslations; 177 are Campaign field definitions now
tracked for the first time via PR #21's Campaign directory).

`knowledge/ORG_SCHEMA.md`, `ORG_AUTOMATION.md`, `ORG_SECURITY.md`,
`ORG_REPORTS.md` regenerated with Generated date 2026-08-20;
`knowledge/org-context.md` integrations table updated (WooCommerce removed
— Shopify replaced it Sept 2025; Quorum → CiviClick Jan 2026; Higher Logic
(POW Connected) and Google Ads lead capture added).

### Drift vs the 2026-04-15 snapshot

**Integrations / Apex**
- **Higher Logic (POW Connected) integration added in-org:** 4 new Apex
  classes (`HigherLogicActivityProcessor(+Test)`,
  `HigherLogicActivityWebhook`, `HigherLogicConfig`), new
  `HL_Webhook_Config__mdt` custom metadata type, new `HL_Integration_Fields`
  permission set, new HL ID fields on Contact/Account/Campaign.
- **`CiviClickWebhookHandler` was hotfixed directly in production** (+54/-11
  lines: savepoint/rollback around DML, referencing a "May 2026 sync gap"
  partial-write incident). The org version is now synced into this repo.
- New installed package: `clientell_sf` (30 packages, was 29).

**Flows**
- Activated since April: `Membership_Flow_Opportunities_Donations_Merchandise_3`
  (was InvalidDraft — membership-critical), `Speaker_Main_Flow`,
  `Alert_Lindsey_on_Campaign_Member_Add` and
  `Donor_Level_Tasks_30_and_90_Days` (both were Obsolete).
- New and active: `Contact_Update_Secondary_Owner_on_Household_Account`,
  `Recurring_Donation_Update_Open_Ended_Status`.
- Deactivated since April: `Engagement_Campaign_Member` (→ Obsolete),
  `Recurring_Donor_Cancelled_Close_Future_Opportunities` (→ Draft).
- Modified in-org while active: `Case_Category_Automation_8fkiw9`.
- Active flow count: 28 → 32 (plus 2 active Blackthorn package flows).

**Schema**
- New fields: Account `DAF_Sponsor__c`, `HL_Community_ID__c`,
  `Secondary_Owner__c`; Contact `HL_Contact_ID__c` (+2); Opportunity
  `Expected_Amount__c`; Campaign `Alliance_Training__c` (today's deploy).
- ⚠ **Reverse drift: `Contact.End_of_Year_Gift__c` (PR #19, merged Dec
  2025) and `Contact.Preferred_Communication_Method__c` are in this repo
  but do NOT exist in production.** PR #19's production deploy apparently
  never landed. Needs follow-up: deploy them or remove from the repo.

**Security / Reports**
- +4 active validation rules (3 on Contact incl. `POW_Cannot_be_Blank`,
  `Require_Reason_Closed_Lost` on Opportunity) — new guardrails that can
  affect integrations doing Contact/Opportunity DML.
- Workflow rules: 71 exist, only 24 active (April doc overstated as "71
  active"); all Campaign/CampaignMember/Opportunity/Case rules are inactive.
- +1 profile (38), +3 custom report types (41); reports now counted: 2,113
  reports / 93 dashboards.

### Follow-ups for Joe
1. **Activate `Event_Alliance_Training_Campaign_Sync`** in production Setup
   (deployed as v1 Draft — see JOB 1).
2. Decide on the PR #19 fields missing from production (End_of_Year_Gift__c).
3. Run the manual Data Loader backfill for the 63 campaigns
   (`data-ops/2026-08-alliance-training-backfill/`) once the flow is active.
4. The audit sink was unreachable from this container — deploy.start /
   deploy.complete events for PR #21 exist only in this report.
