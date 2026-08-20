# POW OKR Tracking Inventory — Production Org

**Generated:** 2026-08-20 (read-only inventory; no records or metadata were modified)
**Org:** production (`joe@protectourwinters.org`), API v61.0
**Method:** Salesforce REST API (SOQL query endpoint + Analytics API + sObject describe). Every number below lists the exact query or API call that produced it.

---

## A. OKR Reports & Dashboards

### A1. Reports in folder "2025-2029 Objectives and Key Results"

Query: `SELECT Id, Name, DeveloperName FROM Report WHERE FolderName = '2025-2029 Objectives and Key Results'` — **6 reports**. Each was described via `/services/data/v61.0/analytics/reports/<Id>/describe`.

| Report | Id | DeveloperName |
|---|---|---|
| [OKR]_40+EmpowermentGrants | 00ORn00000ChCWsMAN | New_Report_OCI |
| [OKR]_ExpandPOWsreachintonewoutdoorcomm. | 00ORn00000Ch2UKMAZ | New_Contacts_Accounts_Report_rfw |
| [OKR]_Mobilize150+AllianceMembers2026 | 00ORn00000Ch55dMAB | New_Report_Eky |
| [OKR]_TrainingTo150+AllianceMembers2026 | 00ORn00000BZRBtMAP | OKR_TrainingTo150AllianceMembers_WIw |
| [OKR]_TrainingTo150+AllianceMembers2028 | 00ORn00000BZDAYMA5 | OKR_TrainingTo150AllianceMembers2028_b6f |
| Engage 100+ outdoor brands and CEOs | 00ORn00000Cf87aMAB | Engage_100_outdoor_brands_and_CEOs_CQf |

**[OKR]_40+EmpowermentGrants** (`00ORn00000ChCWsMAN`)
- Report type: `Contacts_with_Campaign_History__c` (custom report type), summary format, grouped by Contact Record Type, aggregate = RowCount.
- Filter: `CampaignMember_Campaign.Parent.Name equals "Alliance Empowerment Grants Parent Campaign"`.
- Counts: campaign-member rows for contacts on any child campaign of the Empowerment Grants parent campaign. Row count, not unique contacts (no UNIQUE formula on this one).

**[OKR]_ExpandPOWsreachintonewoutdoorcomm.** (`00ORn00000Ch2UKMAZ`)
- Report type: `ContactList`, summary, grouped by `Contact.Alliance_Group__c` then `Contact.Alliance_Member_Since__c`, aggregate = RowCount.
- Filters: Contact Record Type = `Alliance Member`; `Contact.Alliance_Group__c equals "Run,Water"`; `Contact.Alliance_Member_Since__c >= 2025-01-01`.
- ⚠️ **Likely-broken filter:** the `Alliance_Group__c` picklist contains no values named `Run` or `Water` — actual values are `POW Trail`, `POW Climb`, `POW Water`, `POW Ski`, `POW Snowboard`, `POW Bike`, `Science`, `Creative`, `Other`. As filtered, this report should return 0 rows. It presumably intends `POW Trail` (run) and `POW Water`.

**[OKR]_Mobilize150+AllianceMembers2026** (`00ORn00000Ch55dMAB`)
- Report type: `Contacts_with_Campaign_History__c`, summary, grouped by Contact Name.
- Filters: `CampaignMember_Campaign.Alliance_Mobilization_Type__c != ""` (not equal blank); Contact Record Type = `Alliance Member`; standard date filter on `CampaignMember_Campaign.StartDate` from **2025-01-01 to 2029-12-31** (note: despite the "2026" in the name, the window is the whole 5-year OKR period).
- Counts: unique Alliance Member contacts on any mobilization-typed campaign, via custom summary formula `Contact.Name:UNIQUE` ("Unique Contacts") + RowCount.

**[OKR]_TrainingTo150+AllianceMembers2026** (`00ORn00000BZRBtMAP`)
- Report type: `Contacts_with_Attendees__c` (custom report type joining Contact to `conference360__Attendee__c`), summary, grouped by Contact Id.
- Filters: `conference360__Attendee__c.conference360__Attendance_Status__c equals "Attended"`; Contact Record Type = `Alliance Member`; `conference360__Attendee__c.OKR_Alliance_Training_Type__c equals "Training / Summit"`; standard date filter `Contact.CreatedDate >= 2025-01-01` (open end).
- Counts: unique Alliance Member contacts who attended a Training/Summit-typed event, via `Contact.Name:UNIQUE` formula.
- ⚠️ Note: the date filter is on **Contact CreatedDate**, not the event date — a member created before 2025 who attends a 2026 training is excluded, and attendance in any year 2025+ is counted (not just 2026).

**[OKR]_TrainingTo150+AllianceMembers2028** (`00ORn00000BZDAYMA5`)
- Same structure/filters as the 2026 report, but date filter `Contact.CreatedDate` between 2028-01-01 and 2028-12-31, and aggregate is RowCount only (no UNIQUE formula).

**Engage 100+ outdoor brands and CEOs** (`00ORn00000Cf87aMAB`)
- Report type: `AccountCustomEntity$Partnership_Deliverables__c` (Accounts with Partnership Deliverables), summary, grouped by Account Name.
- Filters: `Partnership_Deliverables__c.Completed_Date__c >= 2025-01-01`; `Partnership_Deliverables__c.Partner_Deliverable__c equals "Attended POW Summit, Attended In The Weeds training session"`.
- Counts: unique accounts via `ACCOUNT.NAME:UNIQUE` formula ("Unique Accounts") + RowCount.

### A2. Dashboards in folder "Organizational Health Dashboards"

Query: `SELECT Id, Title, DeveloperName FROM Dashboard WHERE FolderName = 'Organizational Health Dashboards'` — **3 dashboards**. Components pulled via `/analytics/dashboards/<Id>/describe`.

**Dashboard: "2025-2029 Objectives and Key Results"** (`01ZRn000009k2KzMAI`)
| Component (header) | Type | Source report |
|---|---|---|
| Deliver year-round training to 150+ Alliance members annually | Metric | [OKR]_TrainingTo150+AllianceMembers2026 (00ORn00000BZRBtMAP) |
| Engage 100+ outdoor brands and CEOs | Metric | Engage 100+ outdoor brands and CEOs (00ORn00000Cf87aMAB) |
| Expand POW's Reach into Outdoor Comm. | Column | [OKR]_ExpandPOWsreachintonewoutdoorcomm. (00ORn00000Ch2UKMAZ) |
| Double POW's grassroots membership to over 200,000 members | Metric | "Current Members" (00ORn00000Ch50oMAB) — ContactList filtered `Contact.Membership_Status_v2__c = 'Current'`, grouped by that field |
| Mobilize 150+ Alliance Members | Metric | [OKR]_Mobilize150+AllianceMembers2026 (00ORn00000Ch55dMAB) |
| 40+ Empowerment Grants | Metric | [OKR]_40+EmpowermentGrants (00ORn00000ChCWsMAN) |
| (3 RichText components) | RichText | — |

**Dashboard: "Alliance OKRs — Leadership View"** (`01ZRn00000CcWrBMAV`)
| Component | Type | Source report |
|---|---|---|
| Total trainings | Metric | "Alliance — Trainings" (00ORn00000M5ZbbMAF) |
| Alliance members trained | Metric | same report (00ORn00000M5ZbbMAF) |
| Total engagements | Metric | "Alliance — All Engagement 2026" (00ORn00000M5OoHMAV) |
| Alliance members engaged | Metric | same report (00ORn00000M5OoHMAV) |

- **"Alliance — Trainings"** (00ORn00000M5ZbbMAF): report type `CampaignWithCampaignMembers`; filters `CampaignMember.Contact_Record_Type__c = 'Alliance Member'`, `Campaign.Alliance_Training__c = True`, member status = `Attended`; aggregates: unique `CAMPAIGN_ID` (total trainings), unique `MEMBER_ID` (members trained), RowCount. No date filter in the report itself.
- **"Alliance — All Engagement 2026"** (00ORn00000M5OoHMAV): same report type; filters `CampaignMember.Contact_Record_Type__c = 'Alliance Member'`, `MEMBER_CREATED_DATE = THIS YEAR`, and (`Campaign.Alliance_Training__c = True` **and** `Campaign.Alliance_Mobilization_Type__c != ""` — as stored, both filters are ANDed, no boolean filter recorded, which reads as trainings-that-are-also-mobilizations; likely intended as OR); aggregates: unique campaigns, unique members, RowCount.

**Dashboard: "Organizational Health"** (`01ZRn00000A3iJhMAJ`)
| Component | Type | Source report |
|---|---|---|
| Advocates Engaged by Year | Column | "Advocates Engaged by Year" (00ORn00000ChL77MAF) — CampaignWithCampaignMembers, filters `Campaign.CiviClick_Campaign_ID__c != ""` AND `Campaign.P2A__Synced__c = True`, grouped by member created date, unique-contact formula `CampaignMember.Full_Name__c:UNIQUE` |
| Unique Advocates Engaged All Time | Metric | "Unique Advocates Engaged" (00ORn00000ChMeHMAV) — same filters, grouped by member full name, `Full_Name__c:UNIQUE` formula |
| Giving by Acc Record Type Last 3yrs | Column | "DASH: Giving by Record Type Last Three Y" (00O4P000005w9aZUAQ) — Opportunity report, Won=true, RecordType != Merchandise, `Fund_Designation__c = 'POW'`, close date this + last 2 fiscal years, sum of Amount |
| 2 Year Actuals vs Total Pipeline | Column | 00ORn00000CAnzrMAD — Opportunity, Won, last 2 years + this year, RecordType != Merchandise, Fund POW, sum Amount by fiscal year |
| 2 Year Actuals vs Weighted Pipeline | Column | 00ORn00000CB9M1MAL — same shape as above |

⚠️ The two "Advocates Engaged" reports require **both** `CiviClick_Campaign_ID__c` populated **and** `P2A__Synced__c = True` (Capitol Canary legacy flag). If new CiviClick campaigns don't set `P2A__Synced__c`, they fall out of these dashboard numbers.

---

## B. Fields & Usage

### B1. Contact — Alliance fields

- **Alliance Group** = `Contact.Alliance_Group__c` (picklist). Active values: `POW Trail`, `POW Climb`, `POW Water`, `POW Ski`, `POW Snowboard`, `POW Bike`, `Science`, `Creative`, `Other`. **There is no `Run` value** (see report A1 note; `POW Trail` is the run/trail sport group).
- Alliance Member record type: `RecordType.Name = 'Alliance Member'`, Id `0124P000000hKSWQA2`. Total Alliance Member contacts: **602** (`SELECT COUNT() FROM Contact WHERE RecordType.Name='Alliance Member'`).
- Counts per Alliance Group for Alliance Member record type (`SELECT Alliance_Group__c, COUNT(Id) FROM Contact WHERE RecordType.Name='Alliance Member' GROUP BY Alliance_Group__c`):

| Alliance_Group__c | Count |
|---|---|
| Creative | 146 |
| POW Ski | 121 |
| Science | 70 |
| POW Snowboard | 65 |
| POW Bike | 54 |
| POW Climb | 52 |
| POW Trail | 49 |
| (blank) | 26 |
| POW Water | 15 |
| Other | 4 |

- **Alliance Member Since** = `Contact.Alliance_Member_Since__c` (date). Populated on **368** of 602 Alliance Member contacts (369 org-wide incl. 1 non-Alliance-Member record). Query: `SELECT COUNT() FROM Contact WHERE RecordType.Name='Alliance Member' AND Alliance_Member_Since__c != null`.
- Other Alliance fields present on Contact (for reference): `Alliance_Type__c` (multipicklist), `Alliance_Status__c`, `Alliance_Tier__c`, `Alliance_Review_Score__c`, `alliance_training__c` (multipicklist "Training").

### B2. Campaign — OKR fields

Campaign describe grep (`okr|megawatt|acre|win|decarb|alliance|civi`) found: `OKR_Type__c`, `OKR_Win_Loss__c`, `Alliance_Mobilization_Type__c`, `Alliance_Training_Type__c`, `Alliance_Training_Category__c`, `Alliance_Training__c` (checkbox), `CiviClick_Campaign_ID__c`, plus legacy Capitol Canary `P2A__*` fields.

**No megawatt, acreage, or decarbonization fields exist on Campaign** (nothing matching `megawatt|acre|decarb`). Those KR metrics are not tracked in Salesforce campaign fields today.

- **`OKR_Type__c`** (picklist): `Recruit`, `Train`, `Mobilize`, `Fundraise`, `Support`, `Validation`. Usage on campaigns with `StartDate >= 2025-01-01` (`SELECT OKR_Type__c, COUNT(Id) FROM Campaign WHERE StartDate >= 2025-01-01 GROUP BY OKR_Type__c`):

| OKR_Type__c | 2025+ campaigns |
|---|---|
| (blank) | 316 |
| Fundraise | 162 |
| Mobilize | 34 |
| Train | 18 |
| Recruit | 8 |
| Support | 6 |
| Validation | 0 |

- **`Alliance_Mobilization_Type__c`** (picklist): `Grants`, `Public Speaking/Events`, `Interview`, `Social Media`, `Fundraiser`, `Opportunistic`, `Educating the Alliance`, `Educating the Outdoor State`, `Advocacy/Policy`. Usage (all-time / 2025+ by StartDate):

| Value | All-time | 2025+ |
|---|---|---|
| Public Speaking/Events | 93 | 64 |
| Interview | 43 | 28 |
| Social Media | 28 | 4 |
| Advocacy/Policy | 21 | 5 |
| Fundraiser | 20 | 5 |
| Opportunistic | 17 | 2 |
| Educating the Outdoor State | 16 | 13 |
| Educating the Alliance | 12 | 8 |
| Grants | 9 | 3 |

- **`OKR_Win_Loss__c`** (picklist): values `Win`, `Loss`. **Barely used: 2 campaigns total**, both `Win`, both pre-OKR-period ("7/6/2021 Infrastructure Bill Parent Campaign", "Joe's Valley Festival Panel" 2022-08-26). No campaign since 2023 has it set. Query: `SELECT Id, Name, StartDate, OKR_Win_Loss__c FROM Campaign WHERE OKR_Win_Loss__c != null`.
- Also relevant: `Alliance_Training_Type__c` (Media, POW 101/Climate Science, Fundraising, Advocacy/Policy, Story Development/Storytelling, Opportunistic, Creative RFP, POW 101, Climate Science) and `Alliance_Training_Category__c` (Summit, Customized Coaching, Semi-Structured Training) — the campaign-side training taxonomy used by the Leadership View dashboard reports.

### B3. Partnership_Deliverables__c

Full field list (custom fields): `Account__c` (lookup), `Completed_Date__c` (date), `Partner_Deliverable__c` (picklist, label "Partner Action Taken"), `POW_Deliverable__c` (picklist), `Deliverable_Status__c` (Complete/Incomplete), `Partner_Level__c` ($150,000+ / $100,000 / $50,000 / $25,000 / $10,000 / $5,000), `Channel__c` (Instagram Static, Instagram Story, Facebook, Twitter, LinkedIn), `Partner_Cycle__c` (text), `Presenter__c` (lookup), `Notes__c`, `POW__c` (checkbox), `Partner__c` (checkbox), `Campaign__c` (text).

- **`Partner_Deliverable__c` values** (the field the "Engage 100+" OKR report keys on): `Attended Lobby Day`, **`Attended POW Summit`**, `Launched collab product`, `Donated in-kind product`, `Hosted custom education/training`, `Hosted activation/program/event`, `Reshared POW social content`, `Posted original social content featuring POW`, `Signed sign-on letter`, `Wrote op-ed`, `Featured POW in internal or external email comms`, **`Attended In The Weeds training session`**, `Promoted Team POW`, `Other`.
- **`POW_Deliverable__c` values**: Supported collab product, Provided custom education/training, Provided activation/program/event support, Posted/reshared/featured on social, Invited to POW Summit, Invited to Lobby Day, Included in email newsletter, Alliance product seeding, Other.
- Record counts: **576 all-time**; **289 created 2025+** (`CreatedDate >= 2025-01-01T00:00:00Z`); **171 with `Completed_Date__c >= 2025-01-01`**.
- 2025+ completed, by Partner_Deliverable__c: Posted original social content featuring POW 30; Attended POW Summit 30; (blank) 27; Attended In The Weeds training session 27; Donated in-kind product 12; Featured POW in email comms 10; Hosted activation/program/event 10; Launched collab product 10; Reshared POW social content 8; Promoted Team POW 2; Other 2; Hosted custom education/training 1; Wrote op-ed 1; Signed sign-on letter 1.
- For the "Engage 100+" metric specifically: `Attended POW Summit` = 30 records / **29 distinct accounts**; `Attended In The Weeds training session` = 27 records / **25 distinct accounts** (COUNT_DISTINCT(Account__c), Completed_Date__c >= 2025-01-01).

### B4. Grant / Empowerment / Advocacy-Adventure campaigns (2024+)

Query: `SELECT Id, Name, StartDate, NumberOfContacts, NumberOfLeads, Parent.Name FROM Campaign WHERE (Name LIKE '%Empower%Grant%' OR Name LIKE '%Advocacy%Adventure%' OR Name LIKE '%Grant%') AND (StartDate >= 2024-01-01 OR CreatedDate >= 2024-01-01T00:00:00Z)`

| Campaign | Id | StartDate | Members | Parent |
|---|---|---|---|---|
| 2024 - Empowerment Grants | 701Rn00000CSfB0IAL | 2024-01-01 | 24 | 2024 Alliance Mobilizations |
| 2024 - Rapid Response Grant | 701Rn00000Jy1fwIAB | 2024-01-01 | 3 | 2024 Alliance Mobilizations |
| Alliance Empowerment Grants Parent Campaign | 701Rn00000xwpszIAA | 2025-01-01 | 0 (parent shell) | — |
| Alliance Empowerment Grants 2025 | 701Rn00000xwkGdIAI | 2025-01-01 | 29 | Alliance Empowerment Grants Parent Campaign |
| Alliance Empowerment Grants 2026 | 701Rn00000xwqPFIAY | 2026-01-01 | 4 | Alliance Empowerment Grants Parent Campaign |
| Alliance Lunch n' Learn: AAA Grants 2026 | 701Rn00000v7hIpIAI | 2026-02-05 | 35 | — |
| POW Alliance Lunch n' Learn - AAA Grants | 701Rn00001HoxH9IAJ | 2026-02-05 | 17 | 2026 Alliance Engagment |
| The Drew Peterson Podcast (AAA Grant Project) | 701Rn00001IJWZDIA5 | 2026-02-09 | 2 | 2026 Alliance Engagment |
| AAA Grant applications | 701Rn00001IJyKAIA1 | 2026-02-25 | 24 | 2026 Alliance Engagment |

- **No campaign matches `%Advocacy%Adventure%`** — that program appears in the org only under the abbreviation "AAA Grants" (three 2026 campaigns above).
- Distinct contacts across Empowerment Grants parent's children (the [OKR]_40+ report population): **32** (`SELECT COUNT_DISTINCT(ContactId) FROM CampaignMember WHERE Campaign.Parent.Name = 'Alliance Empowerment Grants Parent Campaign'`).

### B5. CiviClick campaigns

- Identification: **`Campaign.CiviClick_Campaign_ID__c != null`** (string field holding the CiviClick campaign id). This matches how the org's own "Advocates Engaged" reports identify them (those additionally require `P2A__Synced__c = true`).
- **12 CiviClick campaigns exist, all created in 2026** (2026-01-26 → 2026-07-07). ⚠️ **Only 1 of the 12 has `StartDate` populated** — a `StartDate >= 2026-01-01` filter catches just that one ("3/9/2026: Grand Staircase-Escalante Video"), so date-scoping CiviClick campaigns must use `CreatedDate`. "2026" and "all-time" are currently the same population.
- Campaign list with per-campaign member counts (`NumberOfContacts`): Defend The Vote Sign On 2026 — 2,347; 1/30/26 Protect Grand Staircase Escalante — 1,308; 5/4/26 Arctic Refuge Lease Sales — 776; GOTV — 97; 3/2/2026 Oppose Steve Pearce BLM Nomination — 56; 2/13/2026 Aoki Write to Your Commissioners — 20; 3/9/2026 Grand Staircase-Escalante Video — 14; Support Montezuma Support Solar — 8; Endangerment Finding Petition — 5; Routt Support Clean Energy — 5; test Salesforce campaign #2 — 1; 2/11/2026 Trego Write to Your Commissioners — 0.
- Totals: **4,637 campaign-member rows**, **3,856 distinct contacts** (`SELECT COUNT() / COUNT_DISTINCT(ContactId) FROM CampaignMember WHERE Campaign.CiviClick_Campaign_ID__c != null`).

### B6. Higher Logic (POW Connected)

Global describe grep (`HL_|Higher|Chapter|Community|Connected`):
- **No custom objects** from the integration. `HL_Webhook_Config__mdt` (Custom Metadata Type, "Higher Logic Webhook Config") is the only HL component at object level — 1 record, `Default`. (`Community`/`ConnectedApplication` are standard; `bt_stripe__Connected_Account*` is the Stripe package, unrelated.)
- **Fields:** `Contact.HL_Contact_ID__c` (text) — populated on **185 contacts**. `Campaign.HL_Event_ID__c` (text) — populated on **66 campaigns**. `Campaign.HL_Event_Type__c` (picklist: `Chapter Meeting`, `Community Event`, `Webinar`) — all 66 HL-synced campaigns are `Chapter Meeting`; `Community Event` and `Webinar` are unused so far.

---

## C. Live KR Numbers (as of 2026-08-20)

### C1. KR 1.1 — Alliance members trained (2026)

Field mechanics: `conference360__Event__c.OKR_Alliance_Training_Type__c` is the source picklist (values: **`Training / Summit`**, **`Semi-Structured Training`**); `conference360__Attendee__c.OKR_Alliance_Training_Type__c` is a formula = `TEXT(conference360__Event__r.OKR_Alliance_Training_Type__c)`.

Query:
```sql
SELECT COUNT_DISTINCT(conference360__Contact__c)
FROM conference360__Attendee__c
WHERE conference360__Attendance_Status__c = 'Attended'
  AND conference360__Contact__r.RecordType.Name = 'Alliance Member'
  AND conference360__Event__r.OKR_Alliance_Training_Type__c != null
  AND conference360__Event__r.conference360__Event_Start_Date__c >= 2026-01-01
  AND conference360__Event__r.conference360__Event_Start_Date__c <= 2026-12-31
```

- **Total distinct Alliance Members trained in 2026: 71**
- Split: **Training / Summit: 71** · **Semi-Structured: 0** — no 2026 event carries the `Semi-Structured Training` value. Of 31 events with a 2026 start date, 15 are tagged `Training / Summit` and 16 have no OKR type.

### C2. KR 1.2 — Alliance members mobilized (2026)

Query: `SELECT COUNT_DISTINCT(ContactId) FROM CampaignMember WHERE Campaign.OKR_Type__c = 'Mobilize' AND Campaign.StartDate >= 2026-01-01 AND Campaign.StartDate <= 2026-12-31 AND Contact.RecordType.Name = 'Alliance Member'`

- **Distinct Alliance Members in 2026 `OKR_Type__c = 'Mobilize'` campaigns (any status): 36** across 17 such campaigns.
- By member status (only two statuses in use here): `Attended` **32**, `Sent` **4**. No `Responded` status rows exist on these campaigns.

### C3. KR 1.4 — New-community Alliance growth

Alliance Member contacts with `Alliance_Member_Since__c >= 2025-01-01`, per `Alliance_Group__c` (`SELECT Alliance_Group__c, COUNT(Id) FROM Contact WHERE RecordType.Name='Alliance Member' AND Alliance_Member_Since__c >= 2025-01-01 GROUP BY Alliance_Group__c`):

| Group | 2025+ new members |
|---|---|
| Creative | 27 |
| POW Ski | 15 |
| **POW Water** | **9** |
| POW Bike | 9 |
| Science | 7 |
| **POW Trail** (run) | **4** |
| POW Climb | 3 |
| POW Snowboard | 1 |
| Other | 1 |

Reminder: no `Run` picklist value exists; `POW Trail` is the running-adjacent group, and the folder report that tracks this KR filters on nonexistent values `Run,Water` (see A1).

### C4. KR 2.2 — Current grassroots members

- Exact field: **`Contact.Membership_Status_v2__c`** — formula (text): `IF(ISBLANK(Last_Membership_Date_v2__c), NULL, IF(Last_Membership_Date_v2__c >= TODAY() - 365, "Current", "Expired"))`. Confirmed: driven by `Last_Membership_Date_v2__c`, as suspected.
- **Contacts with Membership_Status_v2__c = 'Current': 19,390** (`SELECT COUNT() FROM Contact WHERE Membership_Status_v2__c = 'Current'`).
- Cross-check `SELECT COUNT() FROM Contact WHERE Last_Membership_Date_v2__c = LAST_N_DAYS:365` → 19,352 (small boundary difference: LAST_N_DAYS excludes today; the formula window includes it).
- This matches the dashboard's "Double membership to 200,000" metric source report ("Current Members", 00ORn00000Ch50oMAB), which filters the same field. Current progress vs the 200,000 goal: ~9.7%.

### C5. Movement health — CiviClick advocacy

From the CampaignMember pull in B5 (all rows on campaigns with `CiviClick_Campaign_ID__c != null`, aggregated locally):

- Distinct contacts, all-time: **3,856**
- Distinct contacts, 2026: **3,856** (identical — all 12 CiviClick campaigns were created in 2026; see B5 StartDate caveat)
- Distinct contacts in **≥2** CiviClick campaigns: **611**

Note the org's own "Unique Advocates Engaged" dashboard reports add `P2A__Synced__c = true` to this filter, so their numbers can diverge from the raw CiviClick-ID-based counts above.

---

## Gaps & anomalies worth flagging

1. **[OKR]_ExpandPOWsreachintonewoutdoorcomm.** filters `Alliance_Group__c = "Run,Water"` — neither value exists in the picklist (should presumably be `POW Trail` / `POW Water`). The report almost certainly renders 0.
2. **`OKR_Win_Loss__c` is effectively unused** (2 records, both pre-2023). If win/loss is a 2026 KR, nothing is feeding it.
3. **No megawatt / acreage / decarbonization fields** exist on Campaign — those KR quantities are not tracked in Salesforce.
4. **CiviClick campaigns lack `StartDate`** (11 of 12 null), so date-scoped reporting on them must use `CreatedDate`.
5. **No `Semi-Structured Training` events in 2026** — the event-side split for KR 1.1 currently has only `Training / Summit`; the campaign side does have an `Alliance_Training_Category__c = 'Semi-Structured Training'` value, so training is tracked in two parallel taxonomies (conference360 events vs. campaigns) that don't reconcile automatically.
6. **Training OKR report dates key off Contact CreatedDate**, not event dates (see A1) — the 2026 dashboard training metric is not actually a 2026-activity number (live 2026-activity number is 71, per C1).
7. **No campaign named like "Advocacy Adventure"** — that program lives under the "AAA Grants" name.
8. `OKR_Type__c` is blank on 316 of 544 campaigns started 2025+ — mostly fundraise-adjacent record types, but coverage is partial.
