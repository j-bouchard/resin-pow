# POW Org Automation
Generated: 2026-08-20 | Org: protectourwinters.org (00D4P000001dRZ9)

## Overview

| Type | Total | Active | Draft | Obsolete |
|------|-------|--------|-------|----------|
| Flows (unmanaged) | 52 | 32 | 8 | 12 |
| Workflow Rules | 71 | 24 | - | - |
| Apex Classes | 25 | 25 | - | - |
| Apex Triggers | 3 | 3 | - | - |
| Validation Rules (active, custom) | 5 | 5 | - | - |
| DLRS Rollup Configs | 14 | - | - | - |
| NPSP TDTM Handlers (active) | 55 | 55 | - | - |
| NPSP Filter Groups | 13 | - | - | - |

> Changes vs 2026-04-15: +4 Higher Logic Apex classes; +4 validation rules;
> flows: `Membership_Flow_Opportunities_Donations_Merchandise_3` and
> `Speaker_Main_Flow` activated, `Alert_Lindsey_on_Campaign_Member_Add` and
> `Donor_Level_Tasks_30_and_90_Days` reactivated,
> `Contact_Update_Secondary_Owner_on_Household_Account` and
> `Recurring_Donation_Update_Open_Ended_Status` are new-and-active, while
> `Engagement_Campaign_Member` (→ Obsolete) and
> `Recurring_Donor_Cancelled_Close_Future_Opportunities` (→ Draft) were
> deactivated. `Case_Category_Automation_8fkiw9` and
> `CiviClickWebhookHandler` were modified in-org (drift now synced to repo).
> Workflow "71 active" in the April doc was overstated — 71 rules exist,
> 24 are active.

---

## Active Flows (32)

### Record-Triggered: After Save (24 active)

| Name | Object | Description |
|------|--------|-------------|
| Alert_Lindsey_on_Campaign_Member_Add | CampaignMember | Email alert on new campaign member _(reactivated since Apr 2026)_ |
| Alliance_Registration_Email_Alert | VisualAntidote__Form_Submission__c | Routes registration alerts |
| Call_to_Action_Main_Flow | Call_to_Action__c | Copies event details when CTA linked to an Event |
| Campaign_Member_Status | Campaign | Creates campaign member statuses for new Event campaigns |
| Campaign_Membership_Type | Campaign | Sets campaign type on creation |
| Case_Category_Automation_8fkiw9 | Case | Assigns Case.OwnerId and sends email alert based on category _(modified in-org since Apr 2026)_ |
| Contact_Update_Secondary_Owner_on_Household_Account | Contact | Updates Secondary Owner on Household Account _(new since Apr 2026)_ |
| Contact_Update_State_from_Zip_Code | Contact | Fills Mailing/Other State from zip code |
| Engagement_Attendee | conference360__Attendee__c | Links Alliance member event attendance to Engagement |
| Engagement_Record_Creation | Contact | Populates engagement ID on contact |
| Engagment_Emails | Task | Links email Tasks to Engagement record |
| Event_Main_Flow | conference360__Event__c | Ensures related campaign exists; event logistics |
| Event_Partner_Main_Flow | conference360__Sponsor__c | Copies event details to Event Partner |
| GoFundMe_Home_Phone_to_Mobile | Contact | Phone field mapping |
| Grant_Tasks | Opportunity | Grant deadline task creation |
| Membership_Flow_Campaigns_P2A_Opt_In_2 | CampaignMember | Updates POW Action Fund field on contact |
| Membership_Flow_Event_Attendee_2 | conference360__Attendee__c | Event attendee membership processing |
| Membership_Flow_Opportunities_Donations_Merchandise_3 | Contact | Donation/merchandise membership fields _(activated since Apr 2026 — was InvalidDraft)_ |
| Membership_Flow_Opportunities_Soft_Credits | Opportunity | Soft credit membership processing |
| One_time_donation_of_500_999_Task | Opportunity | Stewardship task for $500-999 donations |
| Opportunity_Assign_Tasks | Opportunity | Assigns follow-up tasks, updates related fields |
| Recurring_Donation_Update_Open_Ended_Status | npe03__Recurring_Donation__c | Updates open-ended status _(new since Apr 2026)_ |
| Speaker_Main_Flow | conference360__Speaker__c | Speaker → Campaign linking _(activated since Apr 2026)_ |
| Staff_Main_Flow | conference360__Staff__c | Event staff processing |

Also active in-org from the Blackthorn package family (not in this repo's
FlowDefinition list): `Blackthorn_Events_ERS_Failed` (email on failed Event
Registration Submission), `Blackthorn_Events_WebinarService_Failed` (email
on WebinarService Blackthorn Log errors).

### Record-Triggered: Before Save (2 active)

| Name | Object | Description |
|------|--------|-------------|
| Account_Update_Billing_State | Account | Optimized before-save flow for fast field updates with duplicate rule workaround |
| Campaign_Flow | Campaign | Campaign pre-save processing (tags "Fundraise") |

### Scheduled (6 active)

| Name | Object | Description |
|------|--------|-------------|
| Account_Bypass_Dupe_Rule_Scheduled_Flow | Account | Scheduled duplicate rule bypass |
| Contact_Archive_Scheduled_Flow | Contact | Sets Archived=TRUE per data retention policy |
| Contact_Stages_v2 | Contact | Daily lifecycle segmentation (Current/Lapsed) — today minus 18 months |
| Donor_Level_Tasks_30_and_90_Days | Task | Donor outreach tasks 30/90 days out _(reactivated since Apr 2026)_ |
| Event_CTA_Main_Flow | Call_to_Action__c | Daily CTA count updates per event |
| Recurring_Donor_Level_Task_30_or_90_Days | Task | Recurring donor stewardship tasks based on days since last task |

### Draft Flows (8)

| Name | Object | Notes |
|------|--------|-------|
| Contact_Assign_Task_Based_on_Donation | Task | First-time donor task (v1) |
| Contact_Assign_Task_Based_on_Donation_v2 | Task | First-time donor task (v2) |
| Data_Retention_Policy_Campaign_Delete | Campaign | Data retention — campaign deletion |
| Data_Retention_Policy_Campaign_Delete_Flow | Campaign | Data retention — campaign deletion (v2) |
| Duplicate_Contact_Deletion | Contact | Duplicate contact cleanup |
| Event_Alliance_Training_Campaign_Sync | conference360__Event__c | ⚠ Deployed 2026-08-20 (PR #21) as v1 Draft — org's "deploy flows as active" setting is off; **needs manual activation by Joe** |
| Membership_Flow_Merchandise_Campaign_Member | Opportunity | Merchandise membership processing |
| Recurring_Donor_Cancelled_Close_Future_Opportunities | Contact | ⚠ Was ACTIVE in Apr 2026 — deactivated in-org since |

### Obsolete Flows (12)
Create_Job_and_Shift_from_Campaign, Crushit4Climate_Referred_By_Soft_Credit, Delete_Mailchimp_Events_After_30_DAys, Delete_Mailchimp_Events_from_30_Days_Ago, Donor_Level_Tasks_First_Task, Engagement_Campaign_Member _(was active in Apr 2026)_, Event_Case_Auto_Response, First_Donor_Level_Task, Generate_Membership_Order_from_Opportunity, Membership_Kit_Uncheck_Fields, Order_Fulfillment_Platform_Event, POW_Membership

---

## Apex Classes (12 custom + 10 test + 3 DLRS test = 25 total)

### Custom Classes

| Name | Purpose |
|------|---------|
| ChangePasswordController | Site password change |
| CiviClickWebhookHandler | CiviClick/P2A advocacy webhook processing _(modified in-org since Apr 2026: savepoint/rollback added after the May 2026 partial-write sync gap)_ |
| ForgotPasswordController | Site forgot password |
| GoogleAdsLeadApi | Google Ads lead integration API |
| HigherLogicActivityProcessor | Processes Higher Logic (POW Connected) community activity into SF records _(new since Apr 2026)_ |
| HigherLogicActivityWebhook | REST endpoint receiving Higher Logic activity webhooks _(new since Apr 2026)_ |
| HigherLogicConfig | Higher Logic integration configuration (reads `HL_Webhook_Config__mdt`) _(new since Apr 2026)_ |
| MyProfilePageController | Site profile page |
| ShopifyOrderWebhook | Shopify e-commerce order webhook |
| SiteLoginController | Site login |
| SiteRegisterController | Site registration |
| UpdateCountryBatch | Batch job to update country fields |

### Test Classes (10)

| Name | Tests |
|------|-------|
| ChangePasswordControllerTest | ChangePasswordController |
| CiviClickWebhookHandlerTest | CiviClickWebhookHandler |
| ForgotPasswordControllerTest | ForgotPasswordController |
| GoogleAdsLeadApiTest | GoogleAdsLeadApi |
| HigherLogicActivityProcessorTest | HigherLogicActivityProcessor + webhook _(new since Apr 2026)_ |
| MyProfilePageControllerTest | MyProfilePageController |
| ShopifyOrderWebhookTest | ShopifyOrderWebhook |
| SiteLoginControllerTest | SiteLoginController |
| SiteRegisterControllerTest | SiteRegisterController |
| UpdateCountryBatchTest | UpdateCountryBatch |

### DLRS Test Classes (3)

| Name | Tests |
|------|-------|
| dlrs_CampaignMemberTest | DLRS CampaignMember trigger |
| dlrs_TaskTest | DLRS Task trigger |
| dlrs_conference360_AttendeeTest | DLRS conference360 Attendee trigger |

---

## Apex Triggers (3 total)

All triggers are DLRS-generated for rollup calculations:

| Name | Object | Purpose |
|------|--------|---------|
| dlrs_CampaignMemberTrigger | CampaignMember | DLRS rollups on campaign members |
| dlrs_TaskTrigger | Task | DLRS rollups on tasks |
| dlrs_conference360_AttendeeTrigger | conference360__Attendee__c | DLRS rollups on event attendees |

---

## DLRS Rollup Configurations (14)

Rollups on Engagement__c tracking attendance and participation:

| Rollup Name | Purpose |
|-------------|---------|
| Attended_Campaign | Count campaigns attended |
| Attended_Event | Count events attended |
| Attended_Mobilize_Campaign | Count Mobilize campaigns attended |
| Attended_Train_Summit_Event | Count training/summit events attended |
| Invited_Campaign | Count campaign invitations |
| Invited_Event | Count event invitations |
| Invited_Mobilize_Campaign | Count Mobilize invitations |
| Invited_Train_Summit_Event | Count training/summit invitations |
| Invited_to_Post_2023 | Count post invitations (2023) |
| Mobilize_Invited | Count Mobilize invitations |
| Mobilize_Posted | Count Mobilize posts |
| Posted_2023 | Count posts (2023) |
| Touch_Points | Count total touch points |
| Validation_Campaign | Count validation campaigns |

---

## Validation Rules (5 active, custom)

| Object | Rule Name | Notes |
|--------|-----------|-------|
| Contact | POW_Cannot_be_Blank | _(new since Apr 2026)_ |
| Contact | Contact_Preferred_Email | _(new since Apr 2026)_ |
| Contact | Contact_Preferred_Phone | _(new since Apr 2026)_ |
| Opportunity | Require_Reason_Closed_Lost | _(new since Apr 2026)_ |
| Partnership_Deliverables__c | Partner_Action_OR_POW_Deliverable | A value needs to be added to either POW Deliverable or Partner Action. Values cannot exist in both fields. |

---

## NPSP Automation (Managed Package)

### NPSP Filter Groups (13)
These control NPSP rollup calculations:
- MerchOppsWonHCExclRecTypes — Merchandise opps, hard credit, excluding certain record types
- NPSP_Allocations_Filter — Allocation rollups
- NPSP_ClosedWon_Memberships — Closed/Won membership opps
- NPSP_ClosedWon_Opps_HC — Closed/Won opps, hard credit
- NPSP_ClosedWon_Opps_No_RT_Exclusions — Closed/Won opps, no record type exclusions
- NPSP_ClosedWon_Opps_SC — Closed/Won opps, soft credit
- NPSP_Open_Opportunties — Open opportunities
- NPSP_Paid_Payments — Paid payments
- NPSP_WrittenOff_Payments — Written-off payments
- OppsWonHCExclRecTypesClone — Clone of exclusion filter
- OppsWonHCGiftsandMembership (x2) — Gifts + membership combined
- OppsWonHCMemberandDonations — Members + donations combined

### NPSP Trigger Handlers (55 active)
NPSP uses TDTM (Table-Driven Trigger Management). Trigger handlers are stored as data records (npsp__Trigger_Handler__c), not metadata. Active handler counts by object (2026-08-20):

| Object | Handlers | | Object | Handlers |
|--------|----------|-|--------|----------|
| Opportunity | 12 | | npe01__OppPayment__c | 4 |
| Contact | 8 | | Task / Campaign / Allocation__c / Address__c | 2 each |
| Account | 5 | | npo02__Household__c, npe4/npe5, User, CampaignMember, Level__c, GAU, Engagement Plan objects, DataImport objects, soft-credit objects | 1 each |
| npe03__Recurring_Donation__c | 4 | | | |

**WARNING:** Before adding automation on Contact, Account, Opportunity, or Campaign, be aware that NPSP trigger handlers fire alongside your custom automation. Check for conflicts.

---

## Workflow Rules (71 rules across 8 objects — 24 active)

> Note: Many of these are legacy. Salesforce recommends migrating workflow
> rules to Flows. Active counts (2026-08-20): Account 6/16, Contact 16/42,
> Alliance_Reviews__c 1/1, Lead 1/1; Campaign 0/4, CampaignMember 0/2,
> Opportunity 0/5, Case 0 are all inactive. The April doc's "71 active" was
> the total rule count, not the active count.

### Account (16 rules)
- Account Foundation Stage — Current / Lapsed / Lost (based on donation recency)
- Account Partner Stage — Current / Lapsed / Lost (based on donation recency)
- Partner Contract Expiring — Task to account owner when renewal <30 days
- KnowWho rules (8) — Auto-set KnowWho record types (kw__ namespace, managed)

### Contact (42 rules)
- **Alliance Prospect workflows (~20 rules)** — Track prospect status across sport categories (Bike, Climb, Creative, Ski, Snowboard, Trail, Science). Stages: Scouting → Facebook → Slack Sign Up → Event Activation → Survey → Training/Summit → Onboarding Complete
- **Name capitalization** — Auto-capitalize first and last name
- **Contact Stage** — Current / Lapsed / Lost based on donation recency
- **Country/State updates (~10 rules)** — Normalize country and state values
- **Voter Rating** — Assign Great Voter / Likely Voter / Nonvoter / Blank
- **POW/POW AF email list** — Set POW__c and POW_Action_Fund__c to No for specific criteria
- **Membership** — Update_Member_Donation
- **Volunteers** — GW_Volunteers signup notification and thank you emails

### Campaign (4 rules)
- Campaign-related workflow rules

### CampaignMember (2 rules)
- Campaign member status workflows with email alerts

### Case (15 actions: 5 alerts + 10 field updates)
- Case routing by category: Media, Memberships, Partnerships, Events/Fundraising, POW International, Merchandise, Donor Relations, Other
- Each rule assigns case owner + sends email alert

### Alliance_Reviews__c (1 rule)
- Alliance review field update

### Lead (1 rule)
- Lead workflow with alerts and tasks

### Opportunity (5 rules)
- Opportunity workflows with alerts, field updates, and tasks

---

## Key Integration Webhooks

| Endpoint | Class | Integration |
|----------|-------|-------------|
| ShopifyOrderWebhook | ShopifyOrderWebhook | Shopify e-commerce orders → Opportunity |
| CiviClick Webhook | CiviClickWebhookHandler | CiviClick/P2A advocacy actions |
| Google Ads | GoogleAdsLeadApi | Google Ads lead capture |
