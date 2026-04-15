# POW Org Schema
Generated: 2026-04-15 | Org: protectourwinters.org

## Overview

| Metric | Count |
|--------|-------|
| Custom Objects | 12 (+1 Custom Metadata Type, +1 Platform Event) |
| Custom Fields on Standard Objects | Account: 36, Contact: 169, Opportunity: 39 |
| Installed Packages | 29 |
| Record Types (custom objects) | 1 (Partnership_Deliverables__c) |

## Installed Packages

| Namespace | Package | Purpose |
|-----------|---------|---------|
| npsp | Nonprofit Success Pack | Core donation management |
| npe01 | Contacts & Organizations | NPSP contact/account model |
| npo02 | Households | NPSP household management |
| npe03 | Recurring Donations | NPSP recurring donation processing |
| npe4 | Relationships | NPSP contact relationships |
| npe5 | Affiliations | NPSP org affiliations |
| dlrs | Declarative Lookup Rollup Summaries | Custom rollup fields |
| bt_stripe | Blackthorn Payments (Stripe) | Payment processing |
| bt_base | Blackthorn Base | Blackthorn foundation |
| bt_paylink | Blackthorn Pay Link | Payment links |
| conference360 | Conference360 | Event management |
| classy_npsp | Classy for NPSP | Classy integration |
| stayclassy | StayClassy | Legacy Classy integration |
| GW_Volunteers | Volunteers for Salesforce | Volunteer management |
| kw | KnowWho | Legislator/political data |
| P2A | Phone2Action (CiviClick) | Advocacy/action platform |
| VisualAntidote | Visual Antidote | Form submissions |
| CloudingoAgent | Cloudingo | Duplicate management |
| Field_Trip | Field Trip | Data exploration |
| OIQ | Outreach IQ | Outreach tool |
| SIQCloud | Sales IQ Cloud | Sales intelligence |
| DS360oi | Data Studio 360 | Data analytics |
| dtd | Door to Door | Canvassing |
| pub | Publisher | Content publishing |
| relateiq | RelateIQ | Relationship intelligence |
| rh2 | RollupHelper2 | Rollup helper |
| rhx | RollupHelper Extended | Rollup helper extended |
| sf_chttr_apps | Chatter Apps | Chatter extensions |
| sf_com_apps | Salesforce.com Apps | SF platform apps |

---

## Standard Object Customizations

### Account (37 custom fields)

| API Name | Label | Category |
|----------|-------|----------|
| Affiliated_Accounts__c | Affiliated Accounts | Relationships |
| Bypass_Duplicate_Rules__c | Bypass Duplicate Rules | Admin |
| CEO_Presentation__c | CEO Presentation | Engagement |
| Carbon_Offsets__c | Carbon Offsets | Sustainability |
| Contact_Record_Type__c | Contact Record Type | Admin |
| Context__c | Context | General |
| Contract_Amount__c | Contract Amount | Partnership |
| Contract_Renewal_Date__c | Contract Renewal Date | Partnership |
| Contract_Start_Date__c | Contract Start Date | Partnership |
| Contract__c | Contract | Partnership |
| Divest_From_Fossil_Fuels__c | Divest From Fossil Fuels | Sustainability |
| First_Gift_Amount__c | First Gift Amount | Donation |
| Group_Region__c | Group Region | Alliance |
| Group_Status__c | Group Status | Alliance |
| Last_Activity__c | Last Activity | Engagement |
| Level__c | Level | Partnership |
| OIA_Sustainability__c | OIA Sustainability | Sustainability |
| Outdoor_StateOutdoor_Supporter_Program__c | Outdoor State Supporter Program | Advocacy |
| POW_CTA_Distribution__c | POW CTA Distribution | Engagement |
| POW_Carbon_Neutral__c | POW Carbon Neutral | Sustainability |
| POW_Presentation__c | POW Presentation | Engagement |
| Partner_Level__c | Partner Level | Partnership |
| Portfolio_User__c | Portfolio User | Ownership |
| Previous_Level__c | Previous Level | Partnership |
| Primary_Contact_Email__c | Primary Contact Email | Contact Info |
| Primary_Contact_FirstName__c | Primary Contact First Name | Contact Info |
| Prospect_Status__c | Prospect Status | Pipeline |
| Renewal_Date__c | Renewal Date | Partnership |
| Salesforce_ID__c | Salesforce ID | Admin |
| Social_Post__c | Social Post | Engagement |
| Stage__c | Stage | Pipeline |
| Total_Gifts_117_Days_Ago__c | Total Gifts 117 Days Ago | Donation Analytics |
| Total_Gifts_Three_Years_Ago__c | Total Gifts Three Years Ago | Donation Analytics |
| Total_Gifts_X_Days_Ago__c | Total Gifts X Days Ago | Donation Analytics |
| Website_Presence__c | Website Presence | Digital |
| X10x__c | 10x | Engagement |

**Account Layouts:** Government Office, Household Lightning, Local Alliance, Organization Lightning, POW Partner

### Contact (169 custom fields)

Key field categories:

**Alliance/Athlete Fields (~25 fields)**
| API Name | Label |
|----------|-------|
| Alliance_Group__c | Alliance Group |
| Alliance_Member_Since__c | Alliance Member Since |
| Alliance_Review_Score__c | Alliance Review Score |
| Alliance_Status__c | Alliance Status |
| Alliance_Tier__c | Alliance Tier |
| Alliance_Type__c | Alliance Type |
| Biography__c | Biography |
| Category_Leader__c | Category Leader |
| Connection_to_the_Outdoors__c | Connection to the Outdoors |
| Engagement_Area__c | Engagement Area |
| Headshot__c | Headshot |
| Olympian__c | Olympian |
| Olympic_Results__c | Olympic Results |
| Olympic_Sport_s__c | Olympic Sport(s) |
| Olympic_Years__c | Olympic Years |
| On_Website__c | On Website |
| Profession__c | Profession |
| Scientist_Field_of_Expertise__c | Scientist Field of Expertise |
| Social_Media_Following__c | Social Media Following |
| Sport_Category__c | Sport Category |
| Sport_Interest__c | Sport Interest |
| Talking_Points__c | Talking Points |
| Technique_Area_of_Expertise__c | Technique Area of Expertise |

**Donor/Membership Fields (~40 fields)**
| API Name | Label |
|----------|-------|
| Days_till_1y_to_last_gift_date__c | Days till 1yr to last gift date |
| Donor_Gift_Mailed__c | Donor Gift Mailed |
| Donor_Level2__c | Donor Level 2 |
| Donor_Level__c | Donor Level |
| First_Gift_Amount__c | First Gift Amount |
| First_Merchandise_Amount__c | First Merchandise Amount |
| Last_Gift_Month__c | Last Gift Month |
| Last_Membership_Date_v2__c | Last Membership Date v2 |
| Last_Merchandise_Amount__c | Last Merchandise Amount |
| Last_Merchandise_Date__c | Last Merchandise Date |
| Made_Donation__c | Made Donation |
| Major_Donor_Potential__c | Major Donor Potential |
| Member_Journey__c | Member Journey |
| Member_Since__c | Member Since |
| Member_id__c | Member ID |
| Membership_End_Date_v2__c | Membership End Date v2 |
| Membership_Join_Date_v2__c | Membership Join Date v2 |
| Membership_Opt_Out__c | Membership Opt Out |
| Membership_Status_v2__c | Membership Status v2 |
| Membership_Years__c | Membership Years |
| Previous_Donor_Level__c | Previous Donor Level |
| Received_Membership_Kit__c | Received Membership Kit |
| Send_Membership_Kit__c | Send Membership Kit |
| T_Shirt_Size__c | T-Shirt Size |
| Thank_You_Gift__c | Thank You Gift |
| Total_Gifts_117_Days_Ago__c | Total Gifts 117 Days Ago |
| Total_Gifts_Mem_Merch_Soft_Cred_Amount__c | Total Gifts (Mem+Merch+Soft Credit) |
| Total_Gifts_Past_3_Years__c | Total Gifts Past 3 Years |
| Total_Merchandise_Amount__c | Total Merchandise Amount |

**Voting/Advocacy Fields (~25 fields)**
| API Name | Label |
|----------|-------|
| Ballot_Requested__c | Ballot Requested |
| Ballot_Returned__c | Ballot Returned |
| Ballot_Sent__c | Ballot Sent |
| Battleground_Country__c | Battleground Country |
| Battleground_State__c | Battleground State |
| CiviClick_Advocate_ID__c | CiviClick Advocate ID |
| General_Election_Vote_Propensity_Model__c | General Election Vote Propensity |
| POW_Action_Fund__c | POW Action Fund |
| Political_Party__c | Political Party |
| Taken_Action__c | Taken Action |
| Voter_ID__c | Voter ID |
| Voter_Status__c | Voter Status |
| Voter__c | Voter |
| X2016_PresendElection_Voting_Method__c | 2016 Presidential Election Voting Method |
| X2018_General_Election_Voting_Method__c | 2018 General Election Voting Method |
| X2020_General_Election_Voting_Method__c | 2020 General Election Voting Method |

**Social/Digital Fields (~10 fields)**
| API Name | Label |
|----------|-------|
| Facebook__c | Facebook |
| Instagram__c | Instagram |
| LinkedIn__c | LinkedIn |
| Twitter__c | Twitter |
| Rival_IQ__c | Rival IQ |

**Admin/System Fields (~15 fields)**
| API Name | Label |
|----------|-------|
| Archived__c | Archived |
| CASE_SAFE_ID__c | Case Safe ID |
| Contact_Created_Date__c | Contact Created Date |
| Data_Privacy_Request__c | Data Privacy Request |
| Email_Marketing_Opt_Out__c | Email Marketing Opt Out |
| New_from_AppFlow__c | New from AppFlow |
| POW_Data_Sharing_Opt_Out__c | POW Data Sharing Opt Out |
| Stage__c | Stage |

**Profile & Demographics (~15 fields)**
| API Name | Label |
|----------|-------|
| Age_Group__c | Age Group |
| Gender__c | Gender |
| Race__c | Race |
| Veteran__c | Veteran |
| City__c | City |
| Postal_Code__c | Postal Code |
| Region__c | Region |
| Regional_Affiliation__c | Regional Affiliation |
| Regional_Area_of_Expertise__c | Regional Area of Expertise |
| Registration_Street__c | Registration Street |
| Registration_City__c | Registration City |
| Registration_State__c | Registration State |
| Registration_Country__c | Registration Country |
| Shipping_address_is_different_from_billi__c | Shipping different from billing |

**Donor/Membership Analytics (~15 fields)**
| API Name | Label |
|----------|-------|
| Last_Membership_or_Donation_Date__c | Last Membership or Donation Date |
| Soft_Credit_Three_Years_Ago__c | Soft Credit Three Years Ago |
| Soft_Credits_Last_18_Months__c | Soft Credits Last 18 Months |
| Total_Gifts_Memb_Soft_Credit_Last_Year__c | Total Gifts (Memb+Soft Credit) Last Year |
| Total_Gifts_Memb_Soft_Credit_This_Year__c | Total Gifts (Memb+Soft Credit) This Year |
| Total_Gifts_Memb_Soft_Last_18_Months__c | Total Gifts (Memb+Soft) Last 18 Months |
| Total_Gifts_Memb_Soft_Three_Years_Ago__c | Total Gifts (Memb+Soft) Three Years Ago |
| Total_Gifts_Memb_Soft_Two_Years_Ago__c | Total Gifts (Memb+Soft) Two Years Ago |
| Total_Gifts_Memb_soft_Credit__c | Total Gifts (Memb+Soft Credit) |
| Total_Gifts_X_Years_Ago__c | Total Gifts X Years Ago |
| Total_Gifts_and_Member_Last_18_Months__c | Total Gifts and Member Last 18 Months |
| Total_Gifts_and_Membership_Last_Year__c | Total Gifts and Membership Last Year |
| Total_Gifts_and_Membership_This_Year__c | Total Gifts and Membership This Year |
| Total_Membership_Three_Years_Ago__c | Total Membership Three Years Ago |
| Total_Membership_Two_Years_Ago__c | Total Membership Two Years Ago |

**Additional Voting/Election Fields (~10 fields)**
| API Name | Label |
|----------|-------|
| X2014_Primary_Election_Party__c | 2014 Primary Election Party |
| X2016_Presidential_Primary_Election_Part__c | 2016 Presidential Primary Party |
| X2016_Primary_Election_Method__c | 2016 Primary Election Method |
| X2016_Primary_Election_Party__c | 2016 Primary Election Party |
| X2016_Primary_Election_Voting_Method__c | 2016 Primary Election Voting Method |
| X2018_Primary_Election_Party__c | 2018 Primary Election Party |
| X2018_Primary_Election_Voting_Method__c | 2018 Primary Election Voting Method |
| X2020_Presidential_Election_Voting_Metho__c | 2020 Presidential Election Voting Method |
| X2020_Primary_Election_Voting_Method__c | 2020 Primary Election Voting Method |
| Ballot_Requested_Date__c | Ballot Requested Date |
| Ballot_Returned_Date__c | Ballot Returned Date |
| Ballot_Sent_Date__c | Ballot Sent Date |
| P2A_Country__c | P2A Country |

**Email/Communication Fields (~10 fields)**
| API Name | Label |
|----------|-------|
| CiviClick_Email__c | CiviClick Email |
| Business_Facebook_del__c | Business Facebook (deprecated) |
| Business_Instagram__c | Business Instagram |
| FB_business__c | FB Business |
| New_Email__c | New Email |
| New_Phone__c | New Phone |
| MailChimp_Bounce_Data__c | MailChimp Bounce Data |
| POW_Internal_T__c | POW Internal Team |
| Team_POW_Email_Communications__c | Team POW Email Communications |

**Membership/Entry Point Fields (~10 fields)**
| API Name | Label |
|----------|-------|
| Initial_Entry_Point__c | Initial Entry Point |
| most_recent_entry_point__c | Most Recent Entry Point |
| member_entry_points__c | Member Entry Points |
| Membership_Status_del__c | Membership Status (deprecated) |
| Received_Membership_Kit_and_T_shirt__c | Received Membership Kit and T-shirt |
| Send_Membership_Kit_and_T_shirt__c | Send Membership Kit and T-shirt |
| Opt_Out_of_Swag__c | Opt Out of Swag |

**Research & Alliance (~10 fields)**
| API Name | Label |
|----------|-------|
| Research_Contribution_to__c | Research Contribution |
| Number_of_Publications__c | Number of Publications |
| Experiences_or_Accomplishments__c | Experiences or Accomplishments |
| Additional_Comments__c | Additional Comments |
| Additional_Research_Needed__c | Additional Research Needed |
| Interest_in_joining__c | Interest in Joining |
| alliance_training__c | Alliance Training |
| W9_Received__c | W9 Received |

**Other/Admin Fields**
| API Name | Label |
|----------|-------|
| Engagement__c | Engagement (lookup) |
| Campaign__c | Campaign |
| Context__c | Context |
| POW__c | POW (Mailchimp audience flag) |
| POW_AF_Data_Sharing_Opt_Out__c | POW AF Data Sharing Opt Out |
| Portfolio_Owner__c | Portfolio Owner |
| Prospect_Status__c | Prospect Status |
| Referred_by__c | Referred by |
| Team__c | Team |
| Current_Month__c | Current Month |
| Data_Privacy_Request__c | Data Privacy Request |
| Mobilization__c | Mobilization |
| Training__c | Training |
| Volunteered__c | Volunteered |
| Other_causes__c | Other Causes |
| Best__c | Best |
| toggle__c | Toggle |
| X10x__c | 10x |
| X80_20__c | 80/20 (8000ers) |

**Contact Layouts:** Alliance Member, Alliance Member - Captains, Contact Lightning, Legislators, POW Contact, Volunteers Contact

### Opportunity (39 custom fields)

| API Name | Label | Category |
|----------|-------|----------|
| Cancel_Reason__c | Cancel Reason | Subscription |
| Cancelled_At__c | Cancelled At | Subscription |
| Cancelled__c | Cancelled | Subscription |
| Captured_Charge_Count__c | Captured Charge Count | Stripe/Payments |
| Captured_Charges__c | Captured Charges | Stripe/Payments |
| Captured_Transfer_Count__c | Captured Transfer Count | Stripe/Payments |
| Captured_Transfers__c | Captured Transfers | Stripe/Payments |
| Completed_Payout_Count__c | Completed Payout Count | Stripe/Payments |
| Completed_Payouts__c | Completed Payouts | Stripe/Payments |
| Discount_Code__c | Discount Code | E-commerce |
| Final_Report_Deadline__c | Final Report Deadline | Grants |
| Flow_Update__c | Flow Update | Admin |
| Fund_Designation__c | Fund Designation | Finance |
| Grant_Application_Deadline__c | Grant Application Deadline | Grants |
| Member_T_shirt_Size__c | Member T-shirt Size | Membership |
| Open_Charge_Count__c | Open Charge Count | Stripe/Payments |
| Open_Charges__c | Open Charges | Stripe/Payments |
| Open_Payout_Count__c | Open Payout Count | Stripe/Payments |
| Open_Payouts__c | Open Payouts | Stripe/Payments |
| Open_Transfer_Count__c | Open Transfer Count | Stripe/Payments |
| Open_Transfers__c | Open Transfers | Stripe/Payments |
| Order_ID__c | Order ID | E-commerce |
| Order_Type__c | Order Type | E-commerce |
| Payment_Method__c | Payment Method | Payments |
| Payment__c | Payment | Payments |
| Primary_Contact_Created_Date__c | Primary Contact Created Date | Admin |
| Progress_Report_Deadline__c | Progress Report Deadline | Grants |
| Record_Type__c | Record Type | Admin |
| Refunded_Charge_Count__c | Refunded Charge Count | Stripe/Payments |
| Refunded_Charges__c | Refunded Charges | Stripe/Payments |
| Restricted__c | Restricted | Finance |
| Retained_Charge_Count__c | Retained Charge Count | Stripe/Payments |
| Retained_Charges__c | Retained Charges | Stripe/Payments |
| Retained_Transfer_Count__c | Retained Transfer Count | Stripe/Payments |
| Retained_Transfers__c | Retained Transfers | Stripe/Payments |
| Reversed_Transfer_Count__c | Reversed Transfer Count | Stripe/Payments |
| Reversed_Transfers__c | Reversed Transfers | Stripe/Payments |
| Shipping_is_different_than_billing__c | Shipping different than billing | E-commerce |
| Shopify_Order_Id__c | Shopify Order ID | E-commerce |

**Opportunity Layouts:** Event Ticket, Merchandise, POW Partner

---

## Custom Objects

### Alliance_Reviews__c (44 fields)
**Purpose:** Tracks performance of Alliance Members in engagement areas (speaking, social media, lobbying, etc.)
**Sharing:** ControlledByParent (master-detail to Contact)
**Key relationships:** Contact__c (MasterDetail), Campaign__c (Lookup)

### Alliance_Surveys__c (28 fields)
**Purpose:** Collects survey data from Alliance members about interests, skills, and background
**Sharing:** ReadWrite
**Key relationships:** Contact__c (Lookup)

### Ballot_Ready__c (29 fields)
**Purpose:** Voter engagement tracking from Ballot Ready integration
**Sharing:** ReadWrite
**Key relationships:** Contact_br__c (Lookup to Contact)

### Call_to_Action__c (4 fields)
**Purpose:** Tracks calls to action linked to events and campaigns
**Name field:** AutoNumber (CTA-{0000})
**Key relationships:** Event__c (Lookup), Related_CTA_Campaign__c (Lookup), Related_Event_Campaign__c (Lookup)

### Campaign_Partners__c (3 fields)
**Purpose:** Links partner accounts to campaigns
**Name field:** AutoNumber (CP-{000})
**Key relationships:** Account__c (Lookup), Campaign__c (Lookup)

### Engagement__c (24 fields)
**Purpose:** Tracks engagement metrics per contact (attendance rates, invitations, posts)
**Sharing:** ControlledByParent (master-detail to Contact)
**Name field:** AutoNumber (E-{0000})
**Key relationships:** Contact__c (MasterDetail)

### GL_Account__c (1 field)
**Purpose:** General Ledger accounts for financial tracking
**Required fields:** GL_Account_Number__c

### L2_Data__c (46 fields)
**Purpose:** Voter/political data from L2 data vendor
**Key relationships:** Contact_l2__c (Lookup), Lead_L2__c (Lookup)

### Online_Volunteer_Training__c (14 fields)
**Purpose:** Tracks volunteer training quiz responses
**Key relationships:** Contact__c (Lookup)

### Order_Fulfillment__e (2 fields)
**Purpose:** Platform Event for order fulfillment processing (Shopify integration)
**Type:** Platform Event (HighVolume)
**Fields:** Order_ID__c, Reference_ID__c

### Partnership_Deliverables__c (13 fields)
**Purpose:** Tracks partner deliverables (POW deliverables and partner actions)
**Sharing:** ControlledByParent (master-detail to Account)
**Record Types:** Partnership_Deliverables
**Validation Rules:** Partner_Action_OR_POW_Deliverable (ensures mutual exclusivity)
**Key relationships:** Account__c (MasterDetail), Presenter__c (Lookup to Contact)

### Zip_Code__c (3 fields)
**Purpose:** Zip code lookup table to auto-populate state on Account
**Required fields:** Zip_Code__c

### Shopify_Config__c (1 field)
**Purpose:** Configuration for Shopify e-commerce integration
**Fields:** Webhook_Secret__c (stores Shopify webhook secret for order processing)

### Testing__mdt
**Type:** Custom Metadata Type (no fields deployed)
