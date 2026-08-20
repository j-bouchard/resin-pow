# POW Production Org Query Results — 2026-08-20

Read-only investigation for three support tasks. All data pulled from the POW
production org on 2026-08-20 (UTC) via REST API (v61.0) SOQL, describe calls,
Analytics API, and a Metadata API retrieve. No records or metadata were modified.

- Org: production (instance from `SF_PROD_INSTANCE_URL`), API user `joe@protectourwinters.org` (client-credentials flow)
- Contact total in org: **422,448**
- "Last 30/90 days" = SOQL `LAST_N_DAYS:30/90` relative to 2026-08-20.

---

## A) Email opt-in health (Mailchimp / Salesforce sync)

### A0. Field discovery (Contact describe)

Exact API names found by describing Contact and grepping for POW / mailchimp / sync / opt:

| Field API Name | Type | Label |
|---|---|---|
| `POW__c` | picklist | POW — **this is the opt-in field**. Values: `Yes`, `No` (both active) |
| `POW_Action_Fund__c` | picklist | POW Action Fund. Values: `Yes`, `No` |
| `HasOptedOutOfEmail` | boolean | standard Email Opt Out |
| `MailChimp_Bounce_Data__c` | string(150) | "Data from MailChimp on email deliverability" — **the only Mailchimp-related field on Contact; there is no Mailchimp sync-status/last-synced field** |
| `Team_POW_Email_Communications__c` | boolean | Team POW Email Communications |
| `POW_Data_Sharing_Opt_Out__c` | boolean | POW Data Sharing Opt Out |
| `POW_AF_Data_Sharing_Opt_Out__c` | boolean | POW AF Data Sharing Opt Out |
| `POW_Internal_T__c` | boolean | POW Internal Team |
| `P2A__Phone2Action_Email_Optin__c` | boolean | Capitol Canary Email Optin |
| `P2A__Synced__c` | boolean | Synced with Capitol Canary |
| `stayclassy__opt_in__c` / `stayclassy__Text_Opt_In__c` / `stayclassy__SMS_Opt_In__c` | boolean | Classy opt-ins |

### A1. Contact creation & opt-in counts

| Metric | Last 30 days | Last 90 days |
|---|---:|---:|
| Contacts created (total) | **2,419** | **4,347** |
| … with `POW__c = 'Yes'` | **2,229** (92.1%) | **3,799** (87.4%) |
| … with `HasOptedOutOfEmail = true` | 42 | 174 |
| … `POW__c='Yes'` AND `HasOptedOutOfEmail=false` (**should flow to Mailchimp**) | **2,187** | **3,625** |

New contacts are being created at a healthy rate and the large majority carry
`POW__c = 'Yes'` — the population that should be syncing to Mailchimp is not empty.

### A2. Formstack submission volume

Object counts (`CreatedDate`):

| Object | Last 30d | Last 90d |
|---|---:|---:|
| `VisualAntidote__Form_Submission__c` | 5,867 | 10,145 |
| `VisualAntidote__Submission__c` | 2,934 | 5,077 |

Monthly trend, `GROUP BY CALENDAR_MONTH(CreatedDate)`:

| Month | Form_Submission__c | Submission__c |
|---|---:|---:|
| 2025-07 | 1,513 | — |
| 2025-08 | 1,201 | — |
| 2025-09 | 1,441 | — |
| 2025-10 | 2,124 | — |
| 2025-11 | 2,019 | — |
| 2025-12 | 2,019 | — |
| 2026-01 | 1,735 | 868 |
| 2026-02 | 1,566 | 785 |
| 2026-03 | 1,565 | 782 |
| 2026-04 | 1,802 | 901 |
| 2026-05 | 1,054 | 527 |
| 2026-06 | 867 | 437 |
| 2026-07 | **4,130** | **2,066** |
| 2026-08 (through Aug 20) | **4,872** | **2,436** |

Formstack intake is not stalling — it dipped in May–June and then roughly
tripled in July–August 2026 (likely a campaign/event surge; Coaching Camps and
Stoke Fest registrations line up with this window).

### A3. Cazoomi sync user activity (`sync@protectourwinters.org`)

- User: `0054P00000AKolIQAT`, Name "Protect Our Winters", **IsActive = true**, LastLoginDate **2026-08-20T14:30:45Z** (today).
- Most recent Contact modifications by this user: 2026-08-20T13:52:49Z, 13:36:25Z, 13:10:16Z — **the sync was writing to Contacts within hours of this snapshot**.

Contacts **modified** by the sync user per day (last 14 days):

| Day | Modified | | Day | Modified |
|---|---:|---|---|---:|
| 2026-08-06 | 298 | | 2026-08-14 | **81,332** |
| 2026-08-07 | 287 | | 2026-08-15 | 9 |
| 2026-08-08 | 13 | | 2026-08-16 | 17 |
| 2026-08-09 | 14 | | 2026-08-17 | 637 |
| 2026-08-10 | 59 | | 2026-08-18 | 2,412 |
| 2026-08-11 | 451 | | 2026-08-19 | 1,499 |
| 2026-08-12 | 531 | | 2026-08-20 (partial) | **41,564** |
| 2026-08-13 | 320 | | | |

Contacts **created** by the sync user per day (last 14 days): 1–20/day
(8/06: 2, 8/07: 18, 8/08: 1, 8/09: 2, 8/10: 13, 8/11: 6, 8/12: 3, 8/13: 2,
8/14: 12, 8/15: 1, 8/16: 0, 8/17: 16, 8/18: 2, 8/19: 20).

### A4. Read on "is opt-in working?"

- The sync user is alive and actively writing (including two very large bulk
  passes on 8/14 and today 8/20 — 81k and 41k contact updates, which look like
  full-list resyncs rather than incremental syncs).
- New opt-ins exist in volume (2,187 mailable `POW__c='Yes'` contacts created in
  the last 30 days), and Formstack volume is up, not down.
- **Caveat:** Salesforce has no per-contact Mailchimp sync-status/timestamp
  field, so from the Salesforce side alone we can confirm the sync user is
  writing *into* Salesforce but cannot confirm contacts are arriving *in
  Mailchimp*. If the complaint is "new subscribers not appearing in Mailchimp,"
  the next check is on the Cazoomi/Mailchimp side (audience growth vs. the
  2,187/30d number above), not in Salesforce.

---

## B) Blackthorn trainings rollup (coaching camps + summit → Trainings)

### B1. Field discovery (exact API names + picklist values)

**On `conference360__Event__c` (Blackthorn Event):**

| Field | Type | Values |
|---|---|---|
| `OKR_Alliance_Training_Type__c` | picklist | `Training / Summit`, `Semi-Structured Training` (both active) |
| `Alliance_Training_Summit__c` | checkbox | label "Alliance Training/Summit", no help text |
| `conference360__Event_Start_Date__c` | date | the usable start-date field (`conference360__Event_Start_Date_Time_GMT__c` is labeled "do not use") |

**On `conference360__Attendee__c`:**

| Field | Type | Detail |
|---|---|---|
| `OKR_Alliance_Training_Type__c` | formula (text) | `TEXT(conference360__Event__r.OKR_Alliance_Training_Type__c)` — mirrors the Event picklist down to the attendee for reporting |

**On `Campaign`:**

| Field | Type | Values |
|---|---|---|
| `Alliance_Training__c` | checkbox | label "Alliance Training" |
| `Alliance_Training_Type__c` | picklist | `Media`, `POW 101/Climate Science`, `Fundraising`, `Advocacy/Policy`, `Story Development/Storytelling`, `Opportunistic`, `Creative RFP`, `POW 101`, `Climate Science` |
| `Alliance_Training_Category__c` | picklist | `Summit`, `Customized Coaching`, `Semi-Structured Training` |
| `OKR_Type__c` | picklist | `Recruit`, `Train`, `Mobilize`, `Fundraise`, `Support`, `Validation` |
| `OKR_Win_Loss__c`, `Alliance_Mobilization_Type__c` | picklists | (not training-specific) |

### B2. 2025–2026 events (`conference360__Event_Start_Date__c >= 2025-01-01`, 58 events)

Columns: Start date · `OKR_Alliance_Training_Type__c` · `Alliance_Training_Summit__c` · Name.
Flags: 🏕 = coaching camp, 🏔 = summit, per name.

| Start | OKR Training Type | Chk | Event (Id) |
|---|---|---|---|
| 2025-02-13 | — | ☐ | 2025 Girl Winter Virtual Film Tour (a4YRn0000004sUrMAI) |
| 2025-02-20 | — | ☐ | 2025 POWering The Transition (a4YRn0000004eA9MAI) |
| 2025-02-25 | — | ☐ | POW Inside Track (a4YRn0000004uwTMAQ) |
| 2025-03-13 | Training / Summit | ☐ | 2025 Brand Alliance Roundtable - Climate Finance (a4YRn0000005c9VMAQ) |
| 2025-04-13 | — | ☐ | Glacier Art Panel with Protect Our Winters (a4YRn0000005rEzMAI) |
| 2025-04-14 | — | ☐ | 2025 All Staff (a4YRn0000006JMXMA2) |
| 2025-04-23 | — | ☐ | 2025 SF Climate Week: Inspiring Action with POW & Patagonia (a4YRn0000004v1JMAQ) |
| 2025-04-30 | — | ☐ | 2025 POW Book Club: Surviving Autocracy (a4YRn0000005rDNMAY) |
| 2025-05-01 | — | ☐ | 🏔 2025 POW CEO Summit (a4YRn0000005bRxMAI) |
| 2025-06-05 | Semi-Structured Training | ☐ | POW In The Weeds: Budget Reconciliation Q&A (a4YRn0000006YWrMAM) |
| 2025-06-24 | Training / Summit | ☐ | 2025 Brand Alliance Roundtable - Public Lands (a4YRn0000006XvlMAE) |
| 2025-06-25 | Semi-Structured Training | ☐ | POW's Clean Energy Campaign (a4YRn0000006b89MAA) |
| 2025-07-09 | — | ☐ | 2025 POW Book Club: A Children's Bible (a4YRn0000005sRBMAY) |
| 2025-07-13 | Semi-Structured Training | ☐ | 2025 POW Alliance Gathering: Durango, CO (a4YRn0000006mjVMAQ) |
| 2025-07-30 | Semi-Structured Training | ☐ | 2025 POW Alliance Gathering: Missoula, MT (a4YRn0000006lp3MAA) |
| 2025-08-06 | Semi-Structured Training | ☐ | 2025 POW Alliance Gathering: Basalt, CO (a4YRn00000076tVMAQ) |
| 2025-08-12 | Training / Summit | ☐ | 🏕 2025 POW Training Camp (a4YRn0000006YVFMA2) |
| 2025-08-27 | — | ☐ | 2025 POW Book Club: What if we Get it Right (a4YRn0000005sSnMAI) |
| 2025-09-18 | — | ☐ | 2025 POW Alliance Gathering: Bend, OR (a4YRn0000006nndMAA) — *note: untagged unlike other 2025 Gatherings* |
| 2025-09-23 | — | ☐ | Ridge to Reef: Introducing the POW Water Alliance (a4YRn000000774nMAA) |
| 2025-09-24 | — | ☐ | Before the Crux: A Community Reception (a4YRn0000008KmLMAU) |
| 2025-10-07 | Semi-Structured Training | ☐ | 2025 POW Alliance Gathering: Rumney, NH (a4YRn0000006omvMAA) |
| 2025-10-10 | Semi-Structured Training | ☐ | 2025 POW Alliance Gathering: Salt Lake City, UT (a4YRn0000007KWfMAM) |
| 2025-10-15 | — | ☐ | 2025 Brand Alliance Roundtable - Clean Energy (a4YRn0000009QmTMAU) — *note: untagged unlike the other two 2025 Roundtables* |
| 2025-10-17 | Semi-Structured Training | ☐ | 2025 POW Alliance Gathering: Boulder, CO (a4YRn0000007KYHMA2) |
| 2025-10-21 | Training / Summit | ☐ | 2025 POW Impact Academy (a4YRn0000008a37MAA) |
| 2025-11-05 | Training / Summit | ☐ | 🏔 2025 POW Brand Alliance Summit (a4YRn00000063T3MAI) |
| 2026-01-09 | — | ☐ | 2026 POW x 11th Hour Racing Park City Gathering (a4YRn000000Adg1MAC) |
| 2026-02-05 | Training / Summit | ☐ | Alliance Lunch n' Learn: AAA Grants 2026 (a4YRn000000BQlZMAW) |
| 2026-02-12 | — | ☐ | 2026 Girl Winter Virtual Film Tour (a4YRn000000AtzJMAS) |
| 2026-02-19 | Training / Summit | ☐ | Creative Summit Pre-Event Connect (a4YRn000000BdyvMAC) |
| 2026-02-24 | — | ☐ | POW Inside Track (a4YRn000000CHOTMA4) |
| 2026-02-25 | Training / Summit | ☐ | 🏔 2026 POW Creative Summit (a4YRn000000AuNVMA0) |
| 2026-02-25 | — | ☐ | Climbers for Clean Energy (a4YRn000000Csr3MAC) |
| 2026-03-13 | — | ☐ | Flathead Electric Panel (a4YRn000000DCg5MAG) |
| 2026-03-26 | Training / Summit | ☐ | Q1 Brand Alliance Roundtable (a4YRn000000DxFBMA0) |
| 2026-03-29 | — | ☐ | Spring Stoke: Summit County Apres with POW Action Fund (a4YRn000000DyUbMAK) |
| 2026-04-22 | — | ☐ | Celebrating Earth Day with POW x Patagonia (a4YRn000000EYRdMAO) |
| 2026-05-18 | Training / Summit | ☐ | 🏔 2026 POW Leadership Summit (a4YRn000000AisbMAC) |
| 2026-06-05 | Training / Summit | ☐ | 🏕 2026 POW Alliance Coaching Camp - Truckee, CA (a4YRn000000GOMXMA4) |
| 2026-06-10 | Training / Summit | ☐ | Stoke the Vote - POW Brand Alliance Q2 Roundtable (a4YRn000000Jc9dMAC) |
| 2026-06-11 | Training / Summit | ☐ | 🏕 2026 POW Alliance Coaching Camp - Durango, CO (a4YRn000000GOO9MAO) |
| 2026-06-11 | Training / Summit | ☐ | 🏕 2026 POW Alliance Coaching Camp - Boulder, CO (a4YRn000000GOPlMAO) |
| 2026-06-18 | Training / Summit | ☐ | 🏕 2026 POW Alliance Coaching Camp - Willow, AK (a4YRn000000GORNMA4) |
| 2026-06-20 | Training / Summit | ☐ | 🏕 2026 POW Alliance Coaching Camp - Park City, UT (a4YRn000000GOUbMAO) |
| 2026-07-14 | Training / Summit | ☐ | 🏕 2026 POW Alliance Coaching Camp - Bozeman, MT (a4YRn000000GOSzMAO) |
| 2026-07-16 | Training / Summit | ☐ | 🏕 2026 POW Alliance Coaching Camp - Bend, OR (a4YRn000000GOWDMA4) |
| 2026-07-24 | Training / Summit | ☐ | 🏕 2026 POW Alliance Coaching Camp - Basalt, CO (a4YRn000000GOXpMAO) |
| 2026-08-27 | Training / Summit | ☐ | 🏕 2026 POW Alliance Coaching Camp - Conway, NH (a4YRn000000MjkrMAC) |
| 2026-09-18…09-30 | — | ☐ | 2026 POW Stoke Fest ×9: Portsmouth NH (a4YRn000000Pde5MAC), Tahoe City CA (a4YRn000000PqQ1MAK), Whitefish MT (a4YRn000000PqRdMAK), Reno CA (a4YRn000000SGLBMA4), Denver CO (a4YRn000000PqTFMA0), Durango CO (a4YRn000000PqUrMAK), Bozeman MT (a4YRn000000SGMnMAO), Burlington VT (a4YRn000000QsUbMAK), Steamboat Springs CO (a4YRn000000SGOPMA4) |

Key observations:
- **All 9 of the 2026 Alliance Coaching Camps and all 2026 summits are already
  tagged `OKR_Alliance_Training_Type__c = 'Training / Summit'`.**
- **The `Alliance_Training_Summit__c` checkbox is FALSE on every 2025–2026
  event.** It was last used in 2021–2022 (11 events, all of which *also* have
  the picklist populated — see B3).

### B3. Field usage: picklist vs. checkbox

`conference360__Event__c`, all time (187 events):

| `OKR_Alliance_Training_Type__c` | Count |
|---|---:|
| (null) | 107 |
| `Training / Summit` | 60 |
| `Semi-Structured Training` | 20 |

| `Alliance_Training_Summit__c` | Count |
|---|---:|
| true | 11 |
| false | 176 |

All 11 checkbox=true events are 2021–2022 (e.g. 2021 POW Leadership Summit,
POW Alliance 101 Trainings, 2022 Creative Summit) and every one of them also
has the picklist set — the checkbox is a legacy field that adds no information.

Campaign-side usage (2,208 campaigns): `Alliance_Training__c` checkbox true on
only **5** campaigns; `Alliance_Training_Category__c` populated on 163
(Customized Coaching 84, Summit 44, Semi-Structured Training 35).

### B4. Alliance metrics dashboards/reports and what the training tiles filter on

Dashboards matching Alliance/Training (9): the primary one is
**`Alliance OKRs — Leadership View`** (Id `01ZRn00000CcWrBMAV`, folder
"Organizational Health Dashboards"). Others: Alliance Dashboard, Alliance
Engagement OKRs, Alliance User Journey, Alliance Graduates, Alliance Deeper/
Further/Higher, Alliance Areas of Climate Interest (folder "Programs"),
Alliance Support Dashboard ("Zimmerman"), Training Example ("Private Dashboards").

**`Alliance OKRs — Leadership View` components (Analytics API describe):**

| Tile | Source report |
|---|---|
| Total trainings | `Alliance — Trainings` (00ORn00000M5ZbbMAF, folder "Resin") |
| Alliance members trained | `Alliance — Trainings` (same report) |
| Total engagements | `Alliance — All Engagement 2026` (00ORn00000M5OoHMAV) |
| Alliance members engaged | `Alliance — All Engagement 2026` (same) |

**Report filter metadata (the load-bearing findings):**

- `Alliance — Trainings` (00ORn00000M5ZbbMAF) — report type
  `CampaignWithCampaignMembers`; filters:
  `CampaignMember.Contact_Record_Type__c = 'Alliance Member'` AND
  **`Campaign.Alliance_Training__c = True`** AND `MEMBER_STATUS = 'Attended'`.
  → **The Leadership View training tiles count via the Campaign checkbox,
  which only 5 campaigns have checked.** This is the rollup that will
  undercount coaching camps/summit unless their campaigns get the checkbox
  (or the report is re-pointed at the Event picklist / Campaign category field).
- `[OKR]_TrainingTo150+AllianceMembers2026` (00ORn00000BZRBtMAP, folder
  "2025-2029 Objectives and Key Results") — report type
  `Contacts_with_Attendees__c`; filters:
  `conference360__Attendee__c.conference360__Attendance_Status__c = 'Attended'`
  AND `Contact.RecordType = 'Alliance Member'` AND
  **`conference360__Attendee__c.OKR_Alliance_Training_Type__c = 'Training / Summit'`**,
  date scope `Contact.CreatedDate >= 2025-01-01`.
  → The OKR report counts via the **Event picklist** (through the Attendee
  formula field). Same for the 2028 variant (00ORn00000BZDAYMA5, not described
  but named identically).
- `Events by OKR Alliance Training Type` (00O4P000006nQtMUAU) — filters
  `conference360__Event__c.OKR_Alliance_Training_Type__c != ''`.
- `Alliance Training Campaigns` (00O4P000006IPLxUAO, "Alliance User Journey"
  folder) — filters `Campaign.Alliance_Training_Category__c IN
  (Customized Coaching, Semi-Structured Training, Summit)` AND
  `Campaign.OKR_Type__c = 'Train'` — a third pattern, via the Campaign
  category picklist.

Full report list (name / folder / Id) for anything containing "Alliance" or
"Training": 178 reports found; the ones most relevant to the trainings rollup
besides those above are the 11 per-camp reports in folder
"2026 POW Alliance Coaching Camps" (00ORn00000Ey26vMAB … 00ORn00000ExyphMAB),
`Alliance Attendees Trainings/Summits` (00O4P000003sjkRUAQ, Blackthorn Event
Standard Reports), and `Alliance Training Campaigns`/`Alliance Training Type`
(Alliance User Journey folder).

### B5. Field-vs-checkbox recommendation input (summary)

- Event picklist `OKR_Alliance_Training_Type__c`: actively used (80 events all
  time, all 2026 camps/summits tagged), feeds the OKR reports via the Attendee
  formula field. **This is the live convention.**
- Event checkbox `Alliance_Training_Summit__c`: dormant since 2022, fully
  redundant with the picklist on the 11 records that use it. Candidate for
  deprecation.
- Campaign checkbox `Alliance_Training__c`: only 5 campaigns, but it is what
  the **Leadership View "Total trainings" / "Alliance members trained" tiles
  filter on today** — either the camps' campaigns need the checkbox checked, or
  the `Alliance — Trainings` report should be re-based on the Event/Attendee
  picklist or `Alliance_Training_Category__c`.

---

## C) Salesforce-side duplicate rules (Cloudingo review context)

Retrieved via SOQL (`DuplicateRule`, `MatchingRule`, `MatchingRuleItem`) plus a
Metadata API retrieve (`DuplicateRule`, `MatchingRules:Contact/Account/Lead`).
Custom-field IDs in matching rule items were resolved via Tooling API.

### C1. Duplicate rules

| Object | Rule (DeveloperName) | Active | Matching rule used | Actions (insert / update) | Conditions / exclusions |
|---|---|---|---|---|---|
| Contact | `NPSP_Contact_Personal_Email_Match` | ✅ | `NPSP_Contact_Personal_Email_Match` | Allow+Alert+Report / Allow+Alert+Report | none |
| Contact | `POW_Contact_Email_Only` | ✅ | `POW_Contact` (Email exact) | Allow+Alert+Report / Allow+Alert+Report | none |
| Contact | `Contact_Address` | ✅ | `Contact_Address` | Allow+Alert+Report / Allow+Alert | none |
| Contact | `Contact_Phone` | ✅ | `Contact_Phone` | Allow+Alert+Report / Allow+Alert | none |
| Contact | `Standard_Rule_for_Contacts_with_Duplicate_Leads` | ❌ inactive | `Standard_Lead_Match_Rule_v1_0` (cross-object → Lead) | — | none |
| Account | `POW_Account` | ✅ | `Standard_Account_Match_Rule_v1_0` | Allow+Alert+Report / Allow+Alert+Report | **only filter in the org: `Account.Bypass_Duplicate_Rules__c = false`** |
| Account | `Account_Billing_Address` | ❌ inactive | `Account_Address3` | — | none |
| Lead | `Standard_Rule_for_Leads_with_Duplicate_Contacts` | ❌ inactive | `Standard_Contact_Match_Rule_v1_1` (cross-object → Contact) | — | none |
| conference360__Attendee__c | `BT_Event_Attendee_Duplicate_Rule` | ✅ | `BT_Events_Attendee_Matching_Rule` | (packaged — XML not retrievable unpackaged) | — |
| bt_stripe__Stripe_Customer__c | `Payment_Gateway_Customer_Dup_Rule` | ✅ | `Payment_Gateway_Customer_Matching_Rule` | (packaged) | — |

**There are NO KnowWho or Alliance record-type exclusions on any duplicate
rule.** The only condition anywhere is the `Bypass_Duplicate_Rules__c = false`
filter on the Account rule. All active rules are Allow+Alert (none block), and
all enforce sharing rules (`securityOption: EnforceSharingRules`). Note for the
Cloudingo review: the KnowWho connection shows up in matching criteria instead —
the active `Contact_Address` matching rule matches on the KnowWho field
`kw__Zip_Code__c` (see C2).

### C2. Matching rules and their criteria

Contact rules (from Metadata API XML; field IDs resolved):

| Rule | Status | Engine | Criteria (in order) |
|---|---|---|---|
| `POW_Contact` | Active | Exact | `Email` Exact |
| `NPSP_Contact_Personal_Email_Match` (org copy) | Active | Fuzzy | `FirstName` FirstName, `LastName` Exact, `npe01__HomeEmail__c` Exact |
| `npsp__NPSP_Contact_Personal_Email_Match` (packaged) | Inactive | Fuzzy | same three fields |
| `Contact_Address` | Active | Fuzzy | `LastName` Exact, `FirstName` FirstName, `MailingState` Exact, **`kw__Zip_Code__c` Exact (KnowWho zip field)**, `MailingCity` City |
| `Contact_Phone` | Active | Exact | `MobilePhone` Exact, `FirstName` Exact, `LastName` Exact |
| `POW_Contact_Exact2` | Active | Fuzzy | `FirstName` Exact, `LastName` Exact, `MailingCity` City — *active but not referenced by any duplicate rule* |
| `Address` | Inactive | Fuzzy | `LastName` Exact, `FirstName` FirstName, `MailingStateCode` Exact, `kw__Zip_Code__c` Exact, `MailingCity` Exact |
| `Standard_Contact_Match_Rule_v1_1` | Inactive | Fuzzy | standard |

All items are `blankValueBehavior: NullNotAllowed` (blank never matches blank).

Account:

| Rule | Status | Criteria |
|---|---|---|
| `Standard_Account_Match_Rule_v1_0` | Active | standard fuzzy account match (used by the active POW Account rule) |
| `Account_Address3` | Active | `BillingStreet` Street, `BillingCity` Exact, `BillingPostalCode` Zip — referenced only by the inactive Account rule |
| `Account_Name` | **ActivationFailed** | `Name` CompanyName |

Lead: `Standard_Lead_Match_Rule_v1_0` Active (standard).

Packaged/other objects (from SOQL; XML not retrieved unpackaged):

- `BT_Events_Attendee_Matching_Rule` (Active, Fuzzy, BooleanFilter `1 AND 2 AND 3 AND 4`): `conference360__Event__c` Exact, `conference360__Email2__c` Exact, `conference360__First_Name2__c` FirstName, `conference360__Last_Name2__c` LastName. A second variant `BT_Events_Attendee_Matching_Rule2` (also Active) swaps item 1 for `conference360__Event_ID__c` Exact.
- `Payment_Gateway_Customer_Matching_Rule` (Active, Exact): `bt_stripe__Email__c`, `bt_stripe__Billing_City__c`, `bt_stripe__Billing_State__c`, `bt_stripe__Billing_Postal_Code__c`; the inactive `…Rule2` adds `bt_stripe__Payment_Gateway__c`.

### C3. Notes for the Cloudingo review

- Four active Contact duplicate rules run on every insert/update (email-only,
  NPSP name+home-email, name+address, mobile+name) — all alert-only, none block,
  so Salesforce-side rules will not stop Cloudingo (or any integration) writes.
- No record-type conditions anywhere: Alliance Member contacts and
  KnowWho-sourced records go through the same rules as everyone else.
- `kw__Zip_Code__c` (KnowWho) inside the active `Contact_Address` matching rule
  means address-based duplicate detection depends on a KnowWho-maintained field
  being populated (NullNotAllowed: contacts without it can never address-match).
- Loose ends: `POW_Contact_Exact2` is active but unused by any duplicate rule;
  `Account_Name` matching rule is in `ActivationFailed` state; the two standard
  cross-object Lead↔Contact rules are inactive (Leads are effectively
  un-deduplicated against Contacts except via the standard Lead rule, which no
  active duplicate rule references either — the only Lead duplicate rule is
  inactive).

---

## Failures / gaps

- The `sf` CLI's default Node shim + SessionStart auth hook are still broken;
  used the documented workaround (Node 22 + client-credentials token via curl,
  `SF_ACCESS_TOKEN`/`sf org login access-token --no-prompt`). All queries ran.
- Tooling API does not expose `MatchingRule` (INVALID_TYPE) — used the regular
  REST API and Metadata API instead; no data lost.
- Packaged duplicate-rule XML (`bt_stripe`, `conference360`) is not retrievable
  in an unpackaged retrieve; their criteria were reconstructed from
  `MatchingRuleItem` SOQL (complete) but their alert/block actions were not
  confirmed (SOQL shows both rules IsActive=true).
- No per-contact Mailchimp sync-status field exists in Salesforce, so
  Mailchimp-side arrival of the 2,187 recent opt-ins could not be verified from
  the org (see A4 caveat).
