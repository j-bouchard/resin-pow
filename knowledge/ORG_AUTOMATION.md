# POW Org Automation
Generated: 2026-04-16 | Org: 00D4P000001dRZ9

## Overview

| Type | Total |
|------|-------|
| Active Flows | 34 |
| NPSP Trigger Handlers (active) | 55 |
| Apex Classes (unmanaged) | 21 |
| Apex Triggers (unmanaged) | 3 |
| Active Validation Rules | 1 |

---

## Active Flows (34)

> All flows use AutoLaunchedFlow process type unless noted.

| Developer Name | Notes |
|----------------|-------|
| `Account_Bypass_Dupe_Rule_Scheduled_Flow` | Scheduled |
| `Account_Update_Billing_State` | Before Save |
| `Alliance_Registration_Email_Alert` |  |
| `Blackthorn_Events_ERS_Failed` |  |
| `Blackthorn_Events_WebinarService_Failed` |  |
| `Call_to_Action_Main_Flow` |  |
| `Campaign_Flow` |  |
| `Campaign_Member_Status` |  |
| `Campaign_Membership_Type` | Membership processing |
| `Case_Category_Automation_8fkiw9` |  |
| `Contact_Archive_Scheduled_Flow` | Scheduled |
| `Contact_Stages_v2` | Scheduled |
| `Contact_Update_State_from_Zip_Code` |  |
| `DS_data_transfer_from_Leads_to_Accounts_and_Contacts_after_conversion` | Process Builder (legacy) |
| `Donor_Level_Tasks_30_and_90_Days` |  |
| `Engagement_Attendee` |  |
| `Engagement_Campaign_Member` |  |
| `Engagement_Record_Creation` |  |
| `Engagment_Emails` |  |
| `Event_CTA_Main_Flow` | Scheduled |
| `Event_Main_Flow` |  |
| `Event_Partner_Main_Flow` |  |
| `GoFundMe_Home_Phone_to_Mobile` |  |
| `Grant_Tasks` |  |
| `Membership_Flow_Campaigns_P2A_Opt_In_2` | Membership processing |
| `Membership_Flow_Event_Attendee_2` | Membership processing |
| `Membership_Flow_Opportunities_Donations_Merchandise_3` | Membership processing |
| `Membership_Flow_Opportunities_Soft_Credits` | Membership processing |
| `One_time_donation_of_500_999_Task` |  |
| `Opportunity_Assign_Tasks` |  |
| `Recurring_Donor_Cancelled_Close_Future_Opportunities` |  |
| `Recurring_Donor_Level_Task_30_or_90_Days` |  |
| `Speaker_Main_Flow` |  |
| `Staff_Main_Flow` |  |

---

## NPSP Trigger Handlers (TDTM) — Active (55)

| Object | Handler Class | Load Order | Async |
|--------|--------------|-----------|-------|
| Account | `ACCT_CascadeDeleteLookups_TDTM` | 1 | False |
| Account | `ADDR_Account_TDTM` | 1 | False |
| Account | `ACCT_AccountMerge_TDTM` | 1 | False |
| Account | `ACCT_Accounts_TDTM` | 1 | False |
| Account | `AFFL_Affiliations_TDTM` | 2 | False |
| Account_Soft_Credit__c | `OPP_AccountSoftCredit_TDTM` | 1 | False |
| Address__c | `ADDR_Validator_TDTM` | 1 | False |
| Address__c | `ADDR_Addresses_TDTM` | 1 | False |
| Allocation__c | `ALLO_Allocations_TDTM` | 1 | False |
| Allocation__c | `ALLO_PaymentSync_TDTM` | 4 | False |
| Campaign | `ALLO_Multicurrency_TDTM` | 1 | False |
| Campaign | `CAM_CascadeDeleteLookups_TDTM` | 1 | False |
| CampaignMember | `REL_Relationships_Cm_TDTM` | 1 | False |
| Contact | `HH_Households_TDTM` | 0 | False |
| Contact | `ACCT_IndividualAccounts_TDTM` | 1 | False |
| Contact | `AFFL_Affiliations_TDTM` | 1 | False |
| Contact | `CON_CascadeDeleteLookups_TDTM` | 1 | False |
| Contact | `CON_DoNotContact_TDTM` | 2 | False |
| Contact | `ADDR_Contact_TDTM` | 2 | False |
| Contact | `REL_Relationships_Con_TDTM` | 2 | False |
| Contact | `CON_ContactMerge_TDTM` | 3 | False |
| DataImport__c | `BDI_DataImportBatchStatus_TDTM` | 1 | False |
| DataImportBatch__c | `BDI_DataImportBatch_TDTM` | 1 | False |
| Engagement_Plan__c | `EP_EngagementPlans_TDTM` | 0 | False |
| Engagement_Plan_Task__c | `EP_EngagementPlanTaskValidation_TDTM` | 1 | False |
| Form_Template__c | `BGE_FormTemplate_TDTM` | 1 | False |
| General_Accounting_Unit__c | `GAU_TDTM` | 1 | False |
| Level__c | `LVL_Level_TDTM` | 1 | False |
| npe01__OppPayment__c | `PMT_Payment_TDTM` | 0 | False |
| npe01__OppPayment__c | `ALLO_Allocations_TDTM` | 1 | False |
| npe01__OppPayment__c | `PMT_CascadeDeleteLookups_TDTM` | 1 | False |
| npe01__OppPayment__c | `CRLP_Rollup_TDTM` | 2 | False |
| npe03__Recurring_Donation__c | `RD_CascadeDeleteLookups_TDTM` | 1 | False |
| npe03__Recurring_Donation__c | `ALLO_Multicurrency_TDTM` | 1 | False |
| npe03__Recurring_Donation__c | `RD_RecurringDonations_TDTM` | 1 | False |
| npe03__Recurring_Donation__c | `RD2_RecurringDonations_TDTM` | 2 | False |
| npe4__Relationship__c | `REL_Relationships_TDTM` | 1 | False |
| npe5__Affiliation__c | `AFFL_Affiliations_TDTM` | 1 | False |
| npo02__Household__c | `HH_HHObject_TDTM` | 1 | False |
| Opportunity | `OPP_OpportunityContactRoles_TDTM` | 0 | False |
| Opportunity | `OPP_CascadeDeleteLookups_TDTM` | 1 | False |
| Opportunity | `MTCH_Opportunity_TDTM` | 1 | False |
| Opportunity | `PMT_Payment_TDTM` | 1 | False |
| Opportunity | `RD_RecurringDonations_Opp_TDTM` | 1 | False |
| Opportunity | `HH_OppContactRoles_TDTM` | 1 | False |
| Opportunity | `RLLP_OppRollup_TDTM` | 1 | False |
| Opportunity | `ALLO_Allocations_TDTM` | 2 | False |
| Opportunity | `RD2_RecurringDonationsOpp_TDTM` | 2 | False |
| Opportunity | `OPP_CampaignMember_TDTM` | 3 | False |
| Opportunity | `CRLP_Rollup_TDTM` | 4 | False |
| Opportunity | `PSC_Opportunity_TDTM` | 4 | False |
| Partial_Soft_Credit__c | `PSC_PartialSoftCredit_TDTM` | 1 | False |
| Task | `EP_TaskRollup_TDTM` | 0 | False |
| Task | `EP_TaskDependency_TDTM` | 1 | False |
| User | `USER_InActiveUser_TDTM` | 0 | False |

---

## Apex Classes (21 unmanaged)

| Class | Status | Lines (no comments) |
|-------|--------|-------------------|
| `ChangePasswordController` | Active | 376 |
| `ChangePasswordControllerTest` | Active | 480 |
| `CiviClickWebhookHandler` | Active | 11843 |
| `CiviClickWebhookHandlerTest` | Active | 11971 |
| `dlrs_CampaignMemberTest` | Active | 174 |
| `dlrs_conference360_AttendeeTest` | Active | 194 |
| `dlrs_TaskTest` | Active | 154 |
| `ForgotPasswordController` | Active | 379 |
| `ForgotPasswordControllerTest` | Active | 346 |
| `GoogleAdsLeadApi` | Active | 3936 |
| `GoogleAdsLeadApiTest` | Active | 5670 |
| `MyProfilePageController` | Active | 1403 |
| `MyProfilePageControllerTest` | Active | 2507 |
| `ShopifyOrderWebhook` | Active | 15956 |
| `ShopifyOrderWebhookTest` | Active | 10672 |
| `SiteLoginController` | Active | 352 |
| `SiteLoginControllerTest` | Active | 393 |
| `SiteRegisterController` | Active | 1524 |
| `SiteRegisterControllerTest` | Active | 559 |
| `UpdateCountryBatch` | Active | 665 |
| `UpdateCountryBatchTest` | Active | 868 |

---

## Apex Triggers (3 unmanaged — all DLRS)

| Trigger | Object | Status |
|---------|--------|--------|
| `dlrs_CampaignMemberTrigger` | `CampaignMember` | Active |
| `dlrs_conference360_AttendeeTrigger` | `conference360__Attendee__c` | Active |
| `dlrs_TaskTrigger` | `Task` | Active |

---

## Active Validation Rules (1)

| Full Name | Notes |
|-----------|-------|
| `Opportunity.Classy_Opportunity_Close_Date` | Classy opportunities must have a close date |

---

## DLRS Rollup Configs (14)

DLRS rollups are configured on CampaignMember, Task, and conference360__Attendee__c.
Triggers: `dlrs_CampaignMemberTrigger`, `dlrs_TaskTrigger`, `dlrs_conference360_AttendeeTrigger`.

---

## Things That Break

- **Adding automation on Contact** — 177 custom fields + NPSP TDTM (10 handlers on Contact) + DLRS triggers + 10+ active Contact flows = extremely high risk. Always review ORG_AUTOMATION.md before touching Contact.
- **Membership logic** — 5 interconnected flows. Changing membership fields or automation requires understanding the full chain.
- **NPSP rollup conflicts** — Never update `npe01__*`, `npsp__*`, `npo02__*` rollup fields directly.
- **Cloudingo weekly merges** — Alliance members and KnowWho contacts excluded. New fields need merge behavior verified.
