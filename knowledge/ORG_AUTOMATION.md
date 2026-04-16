# POW Org Automation
Generated: 2026-04-15 | Org: protectourwinters.org

## Overview

| Type | Total | Active | Draft | Obsolete |
|------|-------|--------|-------|----------|
| Flows | 49 | 28 | 8 | 13 |
| Workflow Rules | 71 | varies | - | - |
| Apex Classes | 21 | 21 | - | - |
| Apex Triggers | 3 | 3 | - | - |
| Validation Rules | 1 | 1 | - | - |
| DLRS Rollup Configs | 14 | - | - | - |
| NPSP Filter Groups | 13 | - | - | - |
| NPSP Filter Rules | 90+ | - | - | - |

---

## Active Flows (28)

### Record-Triggered: After Save (19 active)

| Name | Object | Description |
|------|--------|-------------|
| Alliance_Registration_Email_Alert | VisualAntidote__Form_Submission__c | Routes registration alerts |
| Call_to_Action_Main_Flow | Call_to_Action__c | CTA processing |
| Campaign_Member_Status | CampaignMemberStatus | Campaign member status updates |
| Campaign_Membership_Type | Campaign | Campaign type processing |
| Case_Category_Automation_8fkiw9 | Case | Assigns Case.OwnerId and sends email alert based on category |
| Contact_Update_State_from_Zip_Code | Zip_Code__c | Zip code → state population |
| Engagement_Attendee | Contact | Determines if attendee is alliance member |
| Engagement_Campaign_Member | Contact | Adds engagement number to Campaign Member |
| Engagement_Record_Creation | Engagement__c | Populates engagement ID on contact |
| Engagment_Emails | Contact | Adds engagement ID to task |
| Event_Main_Flow | Campaign | Event logistics and campaign linking |
| Event_Partner_Main_Flow | conference360__Sponsor__c | Event partner processing |
| GoFundMe_Home_Phone_to_Mobile | Contact | Phone field mapping |
| Grant_Tasks | Task | Close date minus 28 days task creation |
| Membership_Flow_Campaigns_P2A_Opt_In_2 | CampaignMember | Updates POW Action Fund field on contact |
| Membership_Flow_Event_Attendee_2 | conference360__Attendee__c | Event attendee membership processing |
| Membership_Flow_Opportunities_Soft_Credits | Opportunity | Soft credit membership processing |
| One_time_donation_of_500_999_Task | Task | Stewardship task for $500-999 donations |
| Opportunity_Assign_Tasks | Task | Updates POW Action Fund field on contact |
| Recurring_Donor_Cancelled_Close_Future_Opportunities | Contact | Closes future opps when recurring donor cancels |
| Staff_Main_Flow | conference360__Staff__c | Event staff processing |

### Record-Triggered: Before Save (2 active)

| Name | Object | Description |
|------|--------|-------------|
| Account_Update_Billing_State | Zip_Code__c | Optimized before-save flow for fast field updates with duplicate rule workaround |
| Campaign_Flow | Campaign | Campaign pre-save processing |

### Scheduled (7 active)

| Name | Object | Description |
|------|--------|-------------|
| Account_Bypass_Dupe_Rule_Scheduled_Flow | Account | Scheduled duplicate rule bypass |
| Contact_Archive_Scheduled_Flow | Contact | Sets Archived=TRUE per data retention policy |
| Contact_Stages_v2 | Contact | Daily lifecycle segmentation (Current/Lapsed) — today minus 18 months |
| Event_CTA_Main_Flow | CampaignMember | Scheduled CTA event processing |
| Recurring_Donor_Level_Task_30_or_90_Days | Task | Recurring donor stewardship tasks based on days since last task |

### Draft Flows (8)

| Name | Object | Notes |
|------|--------|-------|
| Contact_Assign_Task_Based_on_Donation | Task | First-time donor task (v1) |
| Contact_Assign_Task_Based_on_Donation_v2 | Task | First-time donor task (v2) |
| Data_Retention_Policy_Campaign_Delete | Campaign | Data retention — campaign deletion |
| Data_Retention_Policy_Campaign_Delete_Flow | Campaign | Data retention — campaign deletion (v2) |
| Duplicate_Contact_Deletion | Contact | Duplicate contact cleanup |
| Membership_Flow_Merchandise_Campaign_Member | Opportunity | Merchandise membership processing |
| Membership_Flow_Opportunities_Donations_Merchandise_3 | Contact | InvalidDraft status |
| Speaker_Main_Flow | conference360__Speaker__c | Speaker → Campaign linking |

### Obsolete Flows (13)
Alert_Lindsey_on_Campaign_Member_Add, Create_Job_and_Shift_from_Campaign, Crushit4Climate_Referred_By_Soft_Credit, Delete_Mailchimp_Events_After_30_DAys, Delete_Mailchimp_Events_from_30_Days_Ago, Donor_Level_Tasks_30_and_90_Days, Donor_Level_Tasks_First_Task, Event_Case_Auto_Response, First_Donor_Level_Task, Generate_Membership_Order_from_Opportunity, Membership_Kit_Uncheck_Fields, Order_Fulfillment_Platform_Event, POW_Membership

---

## Apex Classes (12 custom + 9 test = 21 total)

### Custom Classes

| Name | Purpose |
|------|---------|
| ChangePasswordController | Site password change |
| CiviClickWebhookHandler | CiviClick/P2A advocacy webhook processing |
| ForgotPasswordController | Site forgot password |
| GoogleAdsLeadApi | Google Ads lead integration API |
| MyProfilePageController | Site profile page |
| ShopifyOrderWebhook | Shopify e-commerce order webhook |
| SiteLoginController | Site login |
| SiteRegisterController | Site registration |
| UpdateCountryBatch | Batch job to update country fields |

### Test Classes (9)

| Name | Tests |
|------|-------|
| ChangePasswordControllerTest | ChangePasswordController |
| CiviClickWebhookHandlerTest | CiviClickWebhookHandler |
| ForgotPasswordControllerTest | ForgotPasswordController |
| GoogleAdsLeadApiTest | GoogleAdsLeadApi |
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

## Validation Rules (1 total)

| Object | Rule Name | Error Message |
|--------|-----------|---------------|
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

### NPSP Trigger Handlers
NPSP uses TDTM (Table-Driven Trigger Management). Trigger handlers are stored as data records (npsp__Trigger_Handler__c), not metadata. They fire on:
- **Contact** — Address management, household sync, relationships, affiliations, rollups
- **Account** — Household/org account handling, address sync, rollups
- **Opportunity** — Donation processing, payment creation, allocation, rollups
- **Campaign** — Campaign member status management
- **Lead** — Lead conversion handling

**WARNING:** Before adding automation on Contact, Account, Opportunity, or Campaign, be aware that NPSP trigger handlers fire alongside your custom automation. Check for conflicts.

---

## Workflow Rules (71 rules across 8 objects)

> Note: Many of these are legacy. Salesforce recommends migrating workflow rules to Flows.

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
