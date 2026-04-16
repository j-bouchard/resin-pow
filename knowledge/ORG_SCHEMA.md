# POW Org Schema
Generated: 2026-04-16 | Org: 00D4P000001dRZ9

## Overview

| Metric | Count |
|--------|-------|
| Custom Objects | 12 |
| Custom Fields on Contact | 172 |
| Custom Fields on Account | 36 |
| Custom Fields on Opportunity | 47 |
| Custom Fields on Campaign | 73 |
| Installed Packages | 29 |

---

## Custom Objects (12)

| API Name | Label |
|----------|-------|
| `Alliance_Reviews__c` | Alliance Reviews |
| `Alliance_Surveys__c` | Alliance Surveys |
| `Ballot_Ready__c` | Ballot Ready |
| `Call_to_Action__c` | Call to Action |
| `Campaign_Partners__c` | Campaign Partners |
| `Engagement__c` | Engagement |
| `GL_Account__c` | GL Account |
| `L2_Data__c` | L2 Data |
| `Online_Volunteer_Training__c` | Online Volunteer Training |
| `Partnership_Deliverables__c` | Partnership Deliverables |
| `Shopify_Config__c` | Shopify Config |
| `Zip_Code__c` | Zip Code |

---

## Standard Object Customizations

### Contact (172 custom fields)

| API Name | Label | Type | Description |
|----------|-------|------|-------------|
| `Additional_Comments__c` | Additional Comments | Long Text Area(32768) | Question from "Protect Our Winters Alliance Registration": Additional Comments |
| `Additional_Research_Needed__c` | Additional Research Needed | Checkbox |  |
| `Age_Group__c` | Age Group | Picklist |  |
| `Alliance_Group__c` | Alliance Group | Picklist |  |
| `Alliance_Member_Since__c` | Alliance Member Since | Date |  |
| `Alliance_Review_Score__c` | Alliance Review Score | Number(18, 0) |  |
| `Alliance_Status__c` | Alliance Status | Picklist |  |
| `Alliance_Tier__c` | Alliance Tier | Picklist |  |
| `Alliance_Type__c` | Alliance Type | Picklist (Multi-Select) | Use this field to track alliance contacts. |
| `Archived__c` | Archived | Checkbox |  |
| `Ballot_Requested_Date__c` | Ballot Requested Date | Date |  |
| `Ballot_Requested__c` | Ballot Requested | Picklist |  |
| `Ballot_Returned_Date__c` | Ballot Returned Date | Date |  |
| `Ballot_Returned__c` | Ballot Returned | Picklist |  |
| `Ballot_Sent_Date__c` | Ballot Sent Date | Date |  |
| `Ballot_Sent__c` | Ballot Sent | Picklist |  |
| `Battleground_Country__c` | Battleground Country | Picklist |  |
| `Battleground_State__c` | Battleground State | Picklist (Multi-Select) |  |
| `Best__c` | Best form of communication | Picklist (Multi-Select) |  |
| `Biography__c` | Biography | Long Text Area(2000) |  |
| `Business_Facebook_del__c` | Business Facebook | Checkbox |  |
| `Business_Instagram__c` | Business Instagram | Checkbox |  |
| `CASE_SAFE_ID__c` | CASE SAFE ID | Formula (Text) |  |
| `Campaign__c` | Campaign | Lookup(Campaign) |  |
| `Category_Leader__c` | Category Leader | Checkbox |  |
| `City__c` | City | Text(30) |  |
| `CiviClick_Advocate_ID__c` | CiviClick_Advocate_ID | Text(255) |  |
| `CiviClick_Email__c` | CiviClick Email | Email  (External ID) (Unique) |  |
| `Connection_to_the_Outdoors__c` | Connection to the Outdoors | Text(255) |  |
| `Contact_Created_Date__c` | Contact Created Date | Formula (Date) |  |
| `Context__c` | Context | Long Text Area(32768) |  |
| `Current_Month__c` | Current Month | Formula (Text) |  |
| `Data_Privacy_Request__c` | Data Privacy Request | Picklist (Multi-Select) |  |
| `Days_till_1y_to_last_gift_date__c` | Days till 1y to last gift date | Formula (Number) |  |
| `Donor_Gift_Mailed__c` | Donor Gift Mailed | Date | Enter a date if Donor Gift was mailed to this contact. |
| `Donor_Level2__c` | Donor Level | Lookup(Level) | Ally - 18 Month Giving <$1,000, |
| `Donor_Level__c` | Donor Level | Picklist |  |
| `Email_Marketing_Opt_Out__c` | Email Marketing Opt Out | Checkbox |  |
| `Engagement_Area__c` | Engagement Area | Picklist (Multi-Select) |  |
| `Engagement__c` | Engagement | Lookup(Engagement) |  |
| `Experiences_or_Accomplishments__c` | Experiences Outside of Science | Long Text Area(32768) | Question form "Protect Our Winters Alliance Registration": Describe any experiences or accomplishmen |
| `FB_business__c` | FB Business URL | URL(255) |  |
| `Facebook__c` | Facebook | URL(255) |  |
| `First_Gift_Amount__c` | First Gift Amount | Currency(18, 0) |  |
| `First_Merchandise_Amount__c` | First Merchandise Amount | Currency(18, 0) |  |
| `Gender__c` | Gender | Picklist | This field is configured in NPSP Settings > Relationships > Relationships as the Gender field. Do no |
| `General_Election_Vote_Propensity_Model__c` | 2020 General Election Vote Propensity | Percent(4, 2) | Predicts the likelihood that the record will vote in the 2018 general election. Scale of 0-100. 100  |
| `Headshot__c` | Headshot | Rich Text Area(32768) |  |
| `Initial_Entry_Point__c` | Initial Entry Point | Text(50) |  |
| `Instagram__c` | Instagram | URL(255) |  |
| `Interest_in_joining__c` | Interest in joining the POW Alliance | Long Text Area(32768) | Question form "Protect Our Winters Alliance Registration": In two sentences, why are you interested  |
| `Last_Gift_Month__c` | Last Gift Month | Formula (Text) |  |
| `Last_Membership_Date_v2__c` | Last Membership Date | Date |  |
| `Last_Membership_or_Donation_Date__c` | Last Membership or Gift Date | Date |  |
| `Last_Merchandise_Amount__c` | Last Merchandise Amount | Currency(18, 0) |  |
| `Last_Merchandise_Date__c` | Last Merchandise Date | Date |  |
| `LinkedIn__c` | LinkedIn | URL(255) |  |
| `Made_Donation__c` | Made Donation | Checkbox |  |
| `MailChimp_Bounce_Data__c` | MailChimp Bounce Data | Text(150) |  |
| `Major_Donor_Potential__c` | Major Donor Potential | Checkbox |  |
| `Member_Journey__c` | Member Journey | Picklist |  |
| `Member_Since__c` | Member Since | Date |  |
| `Member_id__c` | Member ID | Formula (Text) |  |
| `Membership_End_Date_v2__c` | Membership End Date | Formula (Date) |  |
| `Membership_Join_Date_v2__c` | Membership Join Date | Date |  |
| `Membership_Opt_Out__c` | Membership Opt Out | Checkbox |  |
| `Membership_Status_del__c` | Membership Status INACTIVE | Formula (Text) |  |
| `Membership_Status_v2__c` | Membership Status | Formula (Text) |  |
| `Membership_Years__c` | Membership Years | Text(255) |  |
| `Mobilization__c` | Mobilization | Picklist (Multi-Select) |  |
| `New_Email__c` | New Email | Email |  |
| `New_Phone__c` | New Phone | Phone |  |
| `New_from_AppFlow__c` | New from AppFlow | Checkbox |  |
| `Number_of_Publications__c` | Number of Publications | Number(18, 0) | Question form "Protect Our Winters Alliance Registration": Number of Publications |
| `Olympian__c` | Olympian | Checkbox |  |
| `Olympic_Results__c` | Olympic Results | Text(255) |  |
| `Olympic_Sport_s__c` | Olympic Sport(s) | Text(255) |  |
| `Olympic_Years__c` | Olympic Years | Text(255) |  |
| `On_Website__c` | On Website | Checkbox |  |
| `Opt_Out_of_Swag__c` | Opt-Out of Swag | Checkbox |  |
| `Other_causes__c` | Other causes or organizations | Long Text Area(32768) | Question form "Protect Our Winters Alliance Registration": If you are involved in other causes or or |
| `P2A_Country__c` | P2A Country | Text(120) |  |
| `POW_AF_Data_Sharing_Opt_Out__c` | POW AF Data Sharing Opt Out | Checkbox |  |
| `POW_Action_Fund__c` | POW Action Fund | Picklist |  |
| `POW_Data_Sharing_Opt_Out__c` | POW Data Sharing Opt Out | Checkbox |  |
| `POW_Internal_T__c` | POW Internal Team | Checkbox | If checked, contact will be added to POW internal communications |
| `POW__c` | POW | Picklist |  |
| `Political_Party__c` | Political Party | Picklist |  |
| `Portfolio_Owner__c` | Portfolio Owner | Lookup(User) |  |
| `Postal_Code__c` | Postal Code | Text(30) |  |
| `Preferred_Communication_Method__c` | Preferred Communication Method | Picklist | Tracks how each constituent prefers to be contacted. Used by staff to personalize outreach. |
| `Previous_Donor_Level__c` | Previous Donor Level | Lookup(Level) | Ally - 18 Month Giving <$1,000, |
| `Profession__c` | Profession | Picklist (Multi-Select) |  |
| `Prospect_Status__c` | Prospect Status | Picklist |  |
| `Race__c` | Race | Picklist |  |
| `Received_Membership_Kit__c` | Received Membership Kit | Checkbox |  |
| `Received_Membership_Kit_and_T_shirt__c` | Received Membership Kit and T-shirt | Checkbox |  |
| `Referred_by__c` | Referred by | Text Area(255) | Question from "Protect Our Winters Alliance Registration": Referred by |
| `Region__c` | Region | Text(30) |  |
| `Regional_Affiliation__c` | Regional Affiliation | Text(255) | Question from "Protect Our Winters Alliance Registration": If you are professionally affiliated with |
| `Regional_Area_of_Expertise__c` | Regional Area of Expertise | Text(255) |  |
| `Registration_City__c` | Registration City | Text(100) |  |
| `Registration_Country__c` | Registration Country | Text(100) |  |
| `Registration_State__c` | Registration State/Province | Text(50) |  |
| `Registration_Street__c` | Registration Street | Text(100) |  |
| `Registration__c` | Registration Zip/Postal Code | Text(10) |  |
| `Research_Contribution_to__c` | Research Contrib. to Climate Solutions | Long Text Area(32768) | Question form "Protect Our Winters Alliance Registration": How does your research contribute to clim |
| `Rival_IQ__c` | Rival IQ | Checkbox |  |
| `Scientist_Field_of_Expertise__c` | Scientist Field of Expertise | Text(100) |  |
| `Send_Membership_Kit__c` | Send Membership Kit | Checkbox |  |
| `Send_Membership_Kit_and_T_shirt__c` | Send Membership Kit and T-shirt | Checkbox |  |
| `Shipping_address_is_different_from_billi__c` | Shipping address is different than billi | Checkbox |  |
| `Social_Media_Following__c` | Social Media Following | Number(18, 0) |  |
| `Soft_Credit_Three_Years_Ago__c` | Soft Credit Three Years Ago | Currency(18, 0) |  |
| `Soft_Credits_Last_18_Months__c` | Soft Credits Last 18 Months | Currency(18, 0) | Total soft credits from the last 18 months |
| `Sport_Category__c` | Sport Category | Picklist |  |
| `Sport_Interest__c` | Sport Interest | Picklist (Multi-Select) |  |
| `Stage__c` | Stage | Picklist | Defining  where donors, foundations and corporate partners reside  in the giving lifecycle will iden |
| `T_Shirt_Size__c` | T-Shirt Size | Picklist |  |
| `Taken_Action__c` | Taken Action | Checkbox |  |
| `Talking_Points__c` | Talking Points | Long Text Area(32768) |  |
| `Team_POW_Email_Communications__c` | Team POW Email Communications | Checkbox |  |
| `Team__c` | Investment Level | Picklist |  |
| `Technique_Area_of_Expertise__c` | Technique Area of Expertise | Text(255) |  |
| `Thank_You_Gift__c` | Thank You Gift | Picklist |  |
| `Total_Gifts_117_Days_Ago__c` | Total Gifts 117 Days Ago | Currency(18, 0) |  |
| `Total_Gifts_Mem_Merch_Soft_Cred_Amount__c` | Total Gifts/Mem/Merch/Soft Cred. Amount | Formula (Currency) |  |
| `Total_Gifts_Memb_Soft_Credit_Last_Year__c` | Total Gifts/Memb/Soft Credit Last Year | Formula (Currency) |  |
| `Total_Gifts_Memb_Soft_Credit_This_Year__c` | Total Gifts/Memb/Soft Credit This Year | Formula (Currency) |  |
| `Total_Gifts_Memb_Soft_Last_18_Months__c` | Total Gifts/Memb/Soft Last 18 Months | Formula (Currency) |  |
| `Total_Gifts_Memb_Soft_Three_Years_Ago__c` | Total Gifts/Memb/Soft Three Years Ago | Formula (Currency) |  |
| `Total_Gifts_Memb_Soft_Two_Years_Ago__c` | Total Gifts/Memb/Soft Two Years Ago | Formula (Currency) |  |
| `Total_Gifts_Memb_soft_Credit__c` | Total Gifts/Memb/Soft Credit Amount | Formula (Currency) |  |
| `Total_Gifts_Past_3_Years__c` | Total Gifts and Membership Past 3 Years | Currency(18, 0) |  |
| `Total_Gifts_Three_Years_Ago__c` | Total Gifts Three Years Ago | Currency(18, 0) |  |
| `Total_Gifts_X_Years_Ago__c` | Total Gifts X Years Ago | Currency(18, 0) |  |
| `Total_Gifts_and_Member_Last_18_Months__c` | Total Gifts and Member. Last 18 Months | Currency(18, 0) | Total gifts and membership in the last 18 months |
| `Total_Gifts_and_Membership_Last_Year__c` | Total Gifts and Membership Last Year | Currency(18, 0) |  |
| `Total_Gifts_and_Membership_This_Year__c` | Total Gifts and Membership This Year | Currency(18, 0) |  |
| `Total_Membership_Three_Years_Ago__c` | Total Membership Three Years Ago | Currency(18, 0) |  |
| `Total_Membership_Two_Years_Ago__c` | Total Membership Two Years Ago | Currency(18, 0) |  |
| `Total_Merchandise_Amount__c` | Total Merchandise Amount | Currency(18, 0) |  |
| `Training__c` | Training | Picklist (Multi-Select) |  |
| `Twitter__c` | Twitter | URL(255) |  |
| `Veteran__c` | Veteran | Checkbox |  |
| `Volunteered__c` | Volunteered | Checkbox |  |
| `Voter_ID__c` | Voter ID | Number(18, 0) |  |
| `Voter_Status__c` | Voter Status | Picklist | Active - Registered Active Voters |
| `Voter__c` | Voter Rating | Picklist | Based off of vote propensity model. 100%-70%- great voter, 69.99%-50% - likely voter, 49.99%-30% - u |
| `W9_Received__c` | W9 Received | Checkbox |  |
| `X10x__c` | 10x | Checkbox |  |
| `X2014_General_Election_Method__c` | 2014 General Election Voting Method | Picklist | Method by which the record cast a vote in the 2014 General election |
| `X2014_Primary_Election_Method__c` | 2014 Primary Election Voting Method | Picklist | Method by which the record cast a vote in a 2014 Primary election |
| `X2014_Primary_Election_Party__c` | 2014 Primary Election Party | Picklist |  |
| `X2016_PresendElection_Voting_Method__c` | 2016 Presidential Election Voting Method | Picklist | Method by which the record cast a vote in the 2016 Presidential election |
| `X2016_Presidential_Primary_Election_Part__c` | 2016 Presidential Primary Election Party | Picklist |  |
| `X2016_Primary_Election_Method__c` | 2016 General Election Voting Method | Picklist | Method by which the record cast a vote in the 2016 General election |
| `X2016_Primary_Election_Party__c` | 2016 Primary Election Party | Picklist |  |
| `X2016_Primary_Election_Voting_Method__c` | 2016 Primary Election Voting Method | Picklist | Method by which the record cast a vote in a 2016 Primary election |
| `X2018_General_Election_Voting_Method__c` | 2018 General Election Voting Method | Picklist | Method by which the record cast a vote in the 2018 General election |
| `X2018_Primary_Election_Party__c` | 2018 Primary Election Party | Picklist |  |
| `X2018_Primary_Election_Voting_Method__c` | 2018 Primary Election Voting Method | Picklist | Method by which the record cast a vote in the 2018 Primary election |
| `X2020_General_Election_Voting_Method__c` | 2020 General Election Voting Method | Picklist |  |
| `X2020_Presidential_Election_Voting_Metho__c` | 2020 Presidential Primary Voting Method | Picklist |  |
| `X2020_Primary_Election_Voting_Method__c` | 2020 Primary Election Voting Method | Picklist |  |
| `X80_20__c` | 8000ers | Checkbox |  |
| `Year_End_Thank_You_Sent__c` | Year End Thank You Sent | Checkbox | Tracks whether the development team has sent a year-end thank-you to this donor. |
| `alliance_training__c` | Training | Picklist (Multi-Select) |  |
| `dtd__company__c` | Company Selected for Matching Gifts | Lookup(Double the Donation Company) | Most recent Double the Donation company selected for matching gifts. |
| `member_entry_points__c` | Member Entry Points | Text(255) |  |
| `most_recent_entry_point__c` | Most Recent Entry Point | Picklist |  |
| `toggle__c` | toggle | Checkbox |  |

---

### Account (36 custom fields)

| API Name | Label | Type | Description |
|----------|-------|------|-------------|
| `Affiliated_Accounts__c` | Affiliated Accounts | Lookup(Account) | Relates one account to another |
| `Bypass_Duplicate_Rules__c` | Bypass Duplicate Rules | Checkbox | Hidden checkbox updated through Flow. Used as a workaround manage conflicting duplicate rules and au |
| `Carbon_Offsets__c` | Carbon Offsets | Checkbox |  |
| `CEO_Presentation__c` | CEO Presentation | Checkbox |  |
| `Contact_Record_Type__c` | Contact Record Type | Formula (Text) |  |
| `Context__c` | Context | Long Text Area(32768) | Current "must knows", including connection to POW. |
| `Contract__c` | Contract Needed | Picklist |  |
| `Contract_Amount__c` | Contract Amount | Currency(18, 0) |  |
| `Contract_Renewal_Date__c` | Contract Renewal Date | Formula (Date) |  |
| `Contract_Start_Date__c` | Contract Start Date | Date |  |
| `Divest_From_Fossil_Fuels__c` | Divest From Fossil Fuels | Checkbox |  |
| `First_Gift_Amount__c` | First Gift Amount | Currency(18, 0) |  |
| `Group_Region__c` | Group Region | Picklist |  |
| `Group_Status__c` | Group Status | Picklist |  |
| `Last_Activity__c` | Last Communication Date | Formula (Date) |  |
| `Level__c` | Level | Lookup(Level) | Sample Level field for use with Level feature. May be deleted or edited as needed. |
| `OIA_Sustainability__c` | OIA Sustainability Working Group | Checkbox |  |
| `Outdoor_StateOutdoor_Supporter_Program__c` | Outdoor State Supporter Program | Checkbox |  |
| `Partner_Level__c` | Partner Level | Picklist |  |
| `Portfolio_User__c` | Portfolio Owner | Lookup(User) |  |
| `POW_Carbon_Neutral__c` | POW Carbon Neutral | Checkbox |  |
| `POW_CTA_Distribution__c` | POW CTA Distribution | Checkbox |  |
| `POW_Presentation__c` | POW Presentation | Checkbox |  |
| `Previous_Level__c` | Previous Level | Lookup(Level) | Sample Previous Level field for use with new Level feature. May be edited or deleted as needed. |
| `Primary_Contact_Email__c` | Primary Contact Email | Formula (Text) |  |
| `Primary_Contact_FirstName__c` | Primary Contact FirstName | Formula (Text) |  |
| `Prospect_Status__c` | Prospect Status | Picklist |  |
| `Renewal_Date__c` | Renewal Date | Date |  |
| `Salesforce_ID__c` | Salesforce ID | Formula (Text) |  |
| `Social_Post__c` | Social Post | Checkbox |  |
| `Stage__c` | Stage | Picklist | Defining where donors, foundations and corporate partners reside in the giving lifecycle will identi |
| `Total_Gifts_117_Days_Ago__c` | Total Gifts 117 Days Ago | Currency(18, 0) |  |
| `Total_Gifts_Three_Years_Ago__c` | Total Gifts Three Years Ago | Currency(18, 0) |  |
| `Total_Gifts_X_Days_Ago__c` | Total Gifts X Days Ago | Currency(18, 0) |  |
| `Website_Presence__c` | Website Presence | Checkbox |  |
| `X10x__c` | 10x | Checkbox |  |

---

### Opportunity (47 custom fields)

| API Name | Label | Type | Description |
|----------|-------|------|-------------|
| `Cancel_Reason__c` | Cancel Reason | Text Area(255) |  |
| `Cancelled__c` | Cancelled | Checkbox |  |
| `Cancelled_At__c` | Cancelled At | Date/Time |  |
| `Captured_Charge_Count__c` | Captured Charge Count | Number(10, 0) |  |
| `Captured_Charges__c` | Captured Charges | Currency(16, 2) |  |
| `Captured_Transfer_Count__c` | Captured Transfer Count | Number(10, 0) |  |
| `Captured_Transfers__c` | Captured Transfers | Currency(16, 2) |  |
| `Completed_Payout_Count__c` | Completed Payouts Count | Number(10, 0) |  |
| `Completed_Payouts__c` | Completed Payouts | Currency(16, 2) |  |
| `Discount_Code__c` | Discount Code | Text(50) |  |
| `dtd__company__c` | Company Selected for Matching Gifts | Lookup(Double the Donation Company) | Double the Donation company selected for matching gifts |
| `Final_Report_Deadline__c` | Final Report Deadline | Date |  |
| `Flow_Update__c` | Flow Update | Checkbox |  |
| `Fund_Designation__c` | Fund Designation | Picklist |  |
| `Grant_Application_Deadline__c` | Grant Application Deadline | Date |  |
| `Member_T_shirt_Size__c` | Member T-shirt Size | Text(10) |  |
| `Open_Charge_Count__c` | Open Charge Count | Number(10, 0) |  |
| `Open_Charges__c` | Open Charges | Currency(16, 2) |  |
| `Open_Payout_Count__c` | Open Payout Count | Number(10, 0) |  |
| `Open_Payouts__c` | Open Payouts | Currency(16, 2) |  |
| `Open_Transfer_Count__c` | Open Transfer Count | Number(10, 0) |  |
| `Open_Transfers__c` | Open Transfers | Currency(16, 2) |  |
| `Order_ID__c` | Order ID | Text(10) | Woocommerce Order ID |
| `Order_Type__c` | Order Type | Text(50) |  |
| `Payment__c` | Payment Vehicle | Picklist |  |
| `Payment_Method__c` | Payment Methods | Picklist |  |
| `Primary_Contact_Created_Date__c` | Primary Contact Created Date | Formula (Date/Time) | create date from primary contact record |
| `Progress_Report_Deadline__c` | Progress Report Deadline | Date |  |
| `Record_Type__c` | Record Type | Formula (Text) |  |
| `Refunded_Charge_Count__c` | Refunded Charge Count | Number(10, 0) |  |
| `Refunded_Charges__c` | Refunded Charges | Currency(16, 2) |  |
| `Restricted__c` | Restricted | Long Text Area(32768) | To write out the restriction on certain gifts |
| `Retained_Charge_Count__c` | Retained Charge Count | Number(10, 0) |  |
| `Retained_Charges__c` | Retained Charges | Currency(16, 2) |  |
| `Retained_Transfer_Count__c` | Retained Transfer Count | Number(10, 0) |  |
| `Retained_Transfers__c` | Retained Transfers | Currency(16, 2) |  |
| `Reversed_Transfer_Count__c` | Reversed Transfer Count | Number(10, 0) |  |
| `Reversed_Transfers__c` | Reversed Transfers | Currency(16, 2) |  |
| `Shipping_is_different_than_billing__c` | Shipping is different than billing | Checkbox |  |
| `Shopify_Order_Id__c` | Shopify Order Id | Text(50)  (External ID) (Unique Case Sensitive) |  |
| `stayclassy__cc_address2__c` | Billing Address 2 | Text(100) |  |
| `stayclassy__cc_address__c` | Billing Address | Text(100) |  |
| `stayclassy__cc_city__c` | Billing City | Text(100) |  |
| `stayclassy__cc_country__c` | Billing Country | Text(100) |  |
| `stayclassy__cc_state__c` | Billing State | Text(50) |  |
| `stayclassy__cc_zip__c` | Billing Postal Code | Text(100) |  |
| `stayclassy__check_number__c` | Check Number | Text(32) |  |

---

### Campaign (73 custom fields)

| API Name | Label | Type | Description |
|----------|-------|------|-------------|
| `Activation_Type__c` | Activation Type | Picklist |  |
| `Actual_Reach__c` | Actual Reach | Number(18, 0) |  |
| `Advocacy_Effort__c` | Advocacy Effort | Picklist |  |
| `Alliance_Mobilization_Type__c` | Alliance Mobilization Type | Picklist |  |
| `Alliance_Training_Category__c` | Alliance Training Category | Picklist |  |
| `Alliance_Training_Type__c` | Alliance Training Type | Picklist |  |
| `Anything_else__c` | Additional Information | Text Area(255) |  |
| `ask_to_take_action__c` | Willing to share a call to action? | Picklist |  |
| `Asset_Attached__c` | Asset Attached | Checkbox |  |
| `Attended__c` | Attended | Number(18, 0) | # of attendees for this event |
| `AV_Requirements__c` | AV Requirements? | Picklist |  |
| `Campaign_ID__c` | Campaign ID | Auto Number  (External ID) |  |
| `Campaign_Type__c` | Campaign Type | Picklist |  |
| `CiviClick_Campaign_ID__c` | CiviClick Campaign ID | Text(255)  (External ID) (Unique Case Insensitive) |  |
| `COI_Requests__c` | COI Requests | Picklist |  |
| `Communications_Tier__c` | Communications Tier | Picklist |  |
| `Conversion__c` | Conversion | Number(18, 0) |  |
| `CTA_Details__c` | CTA Details | Text(50) |  |
| `Department__c` | Department | Picklist |  |
| `Digital_Platform__c` | Digital Platform | Text Area(255) |  |
| `Equipment__c` | Equipment | Picklist (Multi-Select) |  |
| `Event_Audience__c` | Event Audience | Picklist | Who is the event targeted towards? |
| `Event_Category__c` | Event Category | Picklist |  |
| `Event_Components__c` | Event Components | Picklist (Multi-Select) |  |
| `Event_End_Date_and_Time__c` | Event End Date and Time | Date/Time |  |
| `Event_Start_Date_and_Time__c` | Event Start Date and Time | Date/Time |  |
| `Free_Event__c` | Free Event | Checkbox | Pulled from Blackthorn Events to indicate the event is free |
| `Fundraising_Type__c` | Fundraising Type | Picklist |  |
| `General_Equipment__c` | General Equipment | Picklist (Multi-Select) |  |
| `Giveaways__c` | Giveaways | Picklist (Multi-Select) |  |
| `Host__c` | Host Category | Picklist |  |
| `Host_Email__c` | Host Email | Email |  |
| `How_many_people_attended__c` | How many people attended? | Number(18, 0) |  |
| `How_many_people_took_action__c` | How many people took action? | Number(18, 0) |  |
| `Liquor_License_Requested__c` | Liquor License Requested | Picklist |  |
| `Lodging_Needed__c` | Lodging Needed? | Checkbox |  |
| `Marketing_Materials__c` | Marketing Materials | Picklist (Multi-Select) |  |
| `Membership_Campaign_Type__c` | Membership Campaign Type | Picklist |  |
| `of_CTA_s_Taken__c` | # of CTA's Taken | Number(18, 0) |  |
| `OKR_Type__c` | OKR Type | Picklist |  |
| `OKR_Win_Loss__c` | OKR Win/Loss | Picklist |  |
| `Onsite_Contact__c` | Host Contact | Lookup(Contact) |  |
| `Priority__c` | Priority | Picklist |  |
| `Raffle_Items_Requested__c` | Raffle Items Requested | Picklist (Multi-Select) |  |
| `Registered__c` | Registered | Number(18, 0) | # of people registered for this event |
| `Related_Account_2__c` | Related Account #2 | Lookup(Account) |  |
| `Related_Account_3__c` | Related Account #3 | Lookup(Account) |  |
| `Related_Account__c` | Related Account | Lookup(Account) |  |
| `Set_Up_Date_and_Time__c` | Set-Up Date and Time | Date/Time |  |
| `Speaker_2__c` | Speaker #2 | Lookup(Contact) |  |
| `Speaker_3__c` | Speaker #3 | Lookup(Contact) |  |
| `Speaker_4__c` | Speaker #4 | Lookup(Contact) |  |
| `Speaker__c` | Speaker | Lookup(Contact) |  |
| `Speaker_Audio_Equipment_Needed__c` | Speaker/Audio Equipment Needed? | Picklist |  |
| `Speakers_Needed__c` | Speakers Needed? | Picklist |  |
| `Special_Requests__c` | Special Requests | Long Text Area(32768) |  |
| `stayclassy__campaign_url__c` | Campaign URL | Formula (Text) |  |
| `stayclassy__city__c` | City | Text(100) |  |
| `stayclassy__country__c` | Country | Text(50) |  |
| `Subtype__c` | Subtype | Picklist |  |
| `Table_Fee_Registration__c` | Table Fee/Registration | Picklist |  |
| `Target__c` | Target | Picklist |  |
| `Target_Conversion__c` | Target Conversion | Number(18, 0) |  |
| `Target_Reach__c` | Target Reach | Number(18, 0) |  |
| `Type_of_Event__c` | Type of Event | Picklist |  |
| `Venue_City__c` | Venue City | Text(255) |  |
| `Venue_Country__c` | Venue Country | Text(255) |  |
| `Venue_Postal_Code__c` | Venue Postal Code | Text(255) |  |
| `Venue_State_Province__c` | Venue State/Province | Text(255) |  |
| `Venue_Street__c` | Venue Street | Text(255) |  |
| `Volunteers_Needed__c` | Volunteers Needed? | Picklist |  |
| `What_can_we_do_better__c` | What can we do better? | Text Area(255) |  |
| `What_went_well__c` | What went well? | Text Area(255) |  |

---

## Record Types (Active)

| Object | Developer Name | Label |
|--------|---------------|-------|
| Partnership_Deliverables__c | Partnership_Deliverables | Partnership Deliverables |
| npe5__Affiliation__c | Board_Member | Board Member |
| npe5__Affiliation__c | Default | Default |
| Account | HH_Account | Household Account |
| Account | Local_Alliance | Local Alliance |
| Account | Organization | Organization |
| Account | Partner | Partner |
| Campaign | Default | Default |
| Campaign | Event | Event |
| Campaign | Classy | GoFundMe Pro |
| Campaign | Parent | Parent |
| Case | Alliance_Request | Alliance Request |
| Case | Default | Default |
| Case | Event_Request | Event Request |
| Contact | Alliance_Member | Alliance Member |
| Contact | Contact | Contact |
| Opportunity | Donation | Donation |
| Opportunity | Event_Ticket | Event Ticket |
| Opportunity | stayclassy | GoFundMe Pro |
| Opportunity | Grant | Grant |
| Opportunity | InKindGift | In-Kind Gift |
| Opportunity | MatchingGift | Matching Gift |
| Opportunity | Merchandise | Merchandise |
| Opportunity | Partner_Commitment | Partner Commitment |
