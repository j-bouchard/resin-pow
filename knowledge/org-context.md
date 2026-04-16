# Protect Our Winters (POW) — Org Context

> **Source reliability note:** This file combines two sources:
> 1. **Retrieved metadata** (April 2026) — ground truth, directly from the live org
> 2. **Salesforce Manual v1 (Jan 2025)** — institutional knowledge, but may be outdated
>
> Where details conflict, trust the retrieved metadata (ORG_SCHEMA.md, ORG_AUTOMATION.md).
> The manual is most valuable for business logic context (membership rules, donor levels,
> data retention policy, integration purposes) that can't be inferred from metadata alone.
> Verify anything that seems off by checking the live org.

## Org Details
- Org ID: 00D4P000001dRZ9
- Edition: Enterprise Edition (Nonprofit)
- NPSP Version: 3.229
- NPSP Licenses: 36
- Production URL: https://pow.my.salesforce.com
- Sandbox Name: TBD

## Mission
"We turn passionate outdoor people into climate advocates, working together to protect
the places and experiences they love from climate change."

## Key Contacts
- Joe Bouchard — Resin LLC, Salesforce consultant
- Department Leads at POW (Campaigns, Development, Marketing/Comms, Operations, Partnerships)

## Installed Packages (29)
**Core NPSP Stack:** npsp, npe01, npo02, npe03, npe4, npe5
**Events:** conference360 (Blackthorn Events)
**Payments:** bt_stripe, bt_base, bt_paylink (Blackthorn/Stripe)
**Fundraising:** classy_npsp, stayclassy (Classy/GoFundMe Pro)
**Matching Gifts:** dtd (360MatchPro by Double the Donation)
**Advocacy:** P2A (Phone2Action/CiviClick/Quorum), kw (KnowWho)
**Volunteers:** GW_Volunteers (Volunteers for Salesforce)
**Data Quality:** CloudingoAgent (Cloudingo duplicate mgmt), dlrs (DLRS rollups)
**Donor Research:** DS360oi (DonorSearch 360io wealth screening)
**Forms:** VisualAntidote (Formstack for Salesforce)
**E-commerce:** Shopify integration (custom webhook), woocommerce (legacy/unclear)
**Email:** Mailchimp/Cazoomi Sync Apps
**Other:** Field_Trip, OIQ, SIQCloud, pub, relateiq, rh2, rhx, sf_chttr_apps, sf_com_apps

## Key Integrations

### Payment Processing
- **Classy** → Online fundraising platform. Syncs donations into Salesforce. Payments via Classy Pay + PayPal. Recurring donations managed through Classy Recurring Donors object.
- **Blackthorn/Stripe** → Event ticket payments via Stripe. Merchandise payments also through Stripe. Stripe payouts reconciled monthly using payout date. Resin oversees reconciliation.
- **Shopify** → ShopifyOrderWebhook Apex class processes e-commerce orders → creates Opportunities. (woocommerce was a prior integration, possibly deprecated)

### Advocacy & Voter Data
- **CiviClick/P2A/Quorum** → CiviClickWebhookHandler processes advocacy actions → tracks campaign participation → updates membership
- **KnowWho** → Legislator data (kw__ namespace). KnowWho contacts excluded from Cloudingo duplicate merges and email lists.
- **Ballot Ready** → Voter engagement tracking (Ballot_Ready__c object)
- **L2 Data** → Voter/political data from 2022 election (L2_Data__c object)

### Communications
- **Mailchimp/Cazoomi** → Two audiences: "Protect Our Winters" (controlled by POW__c = Yes on Contact) and "POW Action Fund" (controlled by POW_Action_Fund__c = Yes on Contact). Activity data retained 30 days then deleted via Cloudingo.
- **Gmail Extension** → Logs emails to Salesforce, creates contacts. Gmail messages never deleted.
- **Google Ads** → GoogleAdsLeadApi captures leads

### Events & Forms
- **Conference360 (Blackthorn Events)** → Event management (Attendees, Speakers, Staff, Sponsors)
- **Formstack (VisualAntidote)** → POW Opt-In forms, Partner Opt-In forms, Alliance forms. Submissions retained 3 years then deleted (except Alliance forms).

### Data Quality
- **Cloudingo** → Weekly automated duplicate merges + data retention policy enforcement. See Duplicate Management section below.
- **DonorSearch 360io** → Wealth screening and donor prospecting

## Account Record Types & Model

### Household Account Model (NPSP standard)
- **Household Accounts** — Auto-created when a new Contact is added. Groups individuals living together. Donations roll up to household level.
- **Organization Accounts** — Foundations, nonprofits, non-partner companies
- **Partner Accounts** — Organizations that are pledge or current POW partners

### Account Stage Logic (Workflow Rules)
- **Current** — Donated within last 365 days
- **Lapsed** — No donation 365-730 days
- **Lost** — No donation >730 days
- Applies separately to Partner and Foundation account types

### Key Account Fields
- `Partner_Level__c` — Partnership tier
- `Contract__c` / `Contract_Start_Date__c` / `Contract_Amount__c` / `Renewal_Date__c` — Partnership contract tracking
- `Stage__c` — Current/Lapsed/Lost (workflow-driven)

## Contact Record Types
- **Contact** — General constituents (donors, members, volunteers)
- **Alliance Member** — Athletes, scientists, and creatives in POW's Alliance program

## Opportunity Record Types (Donation Types)
1. **Donation** — Standard one-time monetary gifts
2. **Classy** — Online donations via Classy platform
3. **Event Ticket** — Revenue from event ticket sales (Blackthorn)
4. **Grant** — Foundation funding (includes application/reporting deadlines)
5. **In-Kind** — Non-monetary contributions
6. **Matching Gift** — Corporate matches (linked to original donation)
7. **Merchandise** — Branded merchandise purchases
8. **Partner Commitment** — Partner organization financial commitments

### Key Opportunity Fields
- `Fund_Designation__c` — POW, POW Action Fund, or Other
- `Discount_Code__c` — Merchandise discount code
- `Order_ID__c` — Woocommerce/Shopify order ID
- `Grant_Application_Deadline__c` / `Progress_Report_Deadline__c` / `Final_Report_Deadline__c` — Grant tracking

### Dashboards for Donations
- **POW Development Forecasting** — Forward-looking expected revenue
- **POW Development Analysis** — Historical performance, donor retention, campaign effectiveness

## Membership Program (CRITICAL — Fully Custom)

**Standard NPSP membership fields and rollups are NOT used.** POW's "Team POW" membership is custom-built because membership extends beyond donations.

### Definition of Membership
A constituent is a **current Team POW member** if they did any of these within the last 365 days:
1. **Donation** — Any Opportunity record type
2. **POW Opt-In** — Via Formstack form on POW website
3. **Partner Opt-In** — Via Formstack form on partner website (Ikon, Aspen, etc.)
4. **Merchandise** — Opportunity with Merchandise record type
5. **Event** — Attended a Blackthorn event
6. **Advocacy** — Participated in a Quorum campaign

### Membership Status Formula
```
IF(
  ISBLANK(Last_Membership_Date_v2__c),
  NULL,
  IF(
    Last_Membership_Date_v2__c >= TODAY() - 365,
    "Current",
    "Expired"
  )
)
```

### Key Membership Fields on Contact
- `Membership_Status_v2__c` — Current / Expired (formula field)
- `Member_id__c` — Salesforce Contact ID
- `Membership_Join_Date_v2__c` — Date of first membership action
- `Last_Membership_Date_v2__c` — Date of most recent membership action
- `Membership_End_Date_v2__c` — 365 days after last membership action
- `Membership_Opt_Out__c` — Opted out of membership
- `Initial_Entry_Point__c` — First membership action (Advocacy Action, Donation, Event Attendee, Merchandise Purchase, Partner Opt In, POW Opt In)
- `most_recent_entry_point__c` — Latest membership action (same values)
- `member_entry_points__c` — All membership actions taken
- `Membership_Years__c` — Years as member

### Membership Automation (5 Flows)
1. **Campaign_Membership_Type** — Sets Membership Campaign Type field on Campaigns (Donation for Classy, Advocacy Action for P2A, Event Attendee for Blackthorn)
2. **Membership_Flow_Campaigns_P2A_Opt_In_2** — Updates entry points to "Advocacy" and membership dates
3. **Membership_Flow_Event_Attendee_2** — Updates entry points to "Event Attendee" and membership dates
4. **Membership_Flow_Opportunities_Soft_Credits** — Updates membership via soft credits
5. **Membership_Flow_Merchandise_Campaign_Member** (Draft) — Donations/merchandise membership processing

## Donor Level System

Donor levels are assigned automatically using Salesforce Levels object based on 18-month giving:
- **Ally** — 18-month giving < $1,000
- **Advocate** — $1,000 - $4,999
- **Enthusiast** — $5,000 - $9,999
- **Champion** — $10,000 - $24,999
- **Titan** — > $25,000

### Key Donor Fields on Contact
- `Donor_Level__c` — Current level (auto-assigned)
- `Previous_Donor_Level__c` — Previous level (null if never changed)
- `Major_Donor_Potential__c` — Checkbox for $1,000+ potential
- `X80_20__c` ("8000ers") — TRUE = high fundraising potential

## Campaign Fields
- `OKR Win/Loss` — Campaign considered a Win or Loss
- `OKR Type` — Type of OKR the campaign supports
- `Alliance_Mobilization_Type` / `Alliance_Training_Type` / `Alliance_Training_Category` — Program OKR tracking
- `Membership Campaign Type` — Donation, Advocacy Action, or Event Attendee

## Contact Key Fields Reference

### Description/Context Fields
- `Description` — Bios and timeless data that doesn't change
- `Context__c` — Current must-knows, connection to POW
- `Talking_Points__c` — High-level important points

### Email/Marketing Fields
- `POW__c` — If "Yes", synced to Mailchimp POW audience (default: Yes)
- `POW_Action_Fund__c` — If "Yes", synced to Mailchimp POW Action Fund audience
- `POW_Internal_T__c` — If TRUE, tagged as "POW Internal Team" in Mailchimp
- `Email_Marketing_Opt_Out__c` — Email opt-out
- `Sport_Interest__c` — Sent to Mailchimp for segmentation
- `Archived__c` — Set by data retention policy

## Data Retention Policy

### Contacts
- Retain indefinitely unless archived
- **Archival criteria** (ALL must be true): no gifts, no affiliations, email opt-out = true, not Alliance member, not Team POW member, no advocacy actions, no event attendance, created >3 years ago
- Scheduled flow runs weekly to set `Archived__c` = TRUE

### Campaigns
- Campaigns with no contacts created >90 days ago are deleted
- **Excluded from deletion:** Event campaigns, Classy campaigns, P2A campaigns
- Cloudingo filter handles deletion

### Mailchimp Activity
- Retained 30 days on contact activity pane, then deleted via Cloudingo

### Form Submissions (Formstack)
- Retained 3 years, then deleted via Cloudingo
- **Exception:** Alliance forms are never deleted
- Contact record data is preserved even when submission is deleted

### Gmail Messages
- Never deleted

## Duplicate Management Strategy

### Salesforce Duplicate Rules
- **POW Contact - Email Only** — Exact email match
- **NPSP Contact Personal Email Match** — Fuzzy first name + exact last name + exact personal email
- **Contact Address** — Exact last name + mailing state, fuzzy first name + city, exact zip
- **Contact Phone** — Exact mobile phone + exact first + last name
- **POW Account** — Standard matching on account name + billing address

### Cloudingo Automated Merges (Weekly)
- **Contact Email + Full Name** — Exact email + exact last name + fuzzy first name. Excludes KnowWho contacts and Alliance members.
- **Contact Personal & Alternate Email Cross Match** — Exact match between personal and alternate email
- **Contact Personal & Work Email Cross Match** — Exact match between personal and work email
- **Contact Work & Alternate Email Cross Match** — Exact match between alternate and work email
- **Contact Phone + Name** (manual only) — Exact phone + full name
- **Contact Full Name + Address** (manual only) — Exact address + full name
- **Account Full Name + Address** (manual only) — Exact account name + billing address

## Workflow Rules (Active)
- Account Partner/Org Stage — Current/Lapsed/Lost based on donation recency
- Alliance Member One Year Anniversary
- Partner Contract Expiring — Task to account owner when renewal <30 days
- Capitalization of Name — Auto-capitalize first/last on Contact
- Case routing rules (Media, Memberships, Partnerships, Events, Merchandise, Donor Relations, POW International, Other) — Assigns case owner + email alert
- KnowWho Contact No Email List — Removes KnowWho contacts from email lists

## Naming Conventions
- Custom fields: descriptive names with __c suffix, no namespace prefix
- Flows: Object_Action_Description pattern (e.g., Contact_Archive_Scheduled_Flow)
- Apex: controller/handler/webhook pattern, matching test classes (*Test)
- Objects: descriptive names (e.g., Alliance_Reviews__c, Partnership_Deliverables__c)

## Known Constraints & Tech Debt
- **169 custom fields on Contact** — Many voting/election fields from past integrations (2014-2020 election cycle fields) are candidates for archival
- **13 obsolete flows** — Should be cleaned up
- **8 draft flows** — Some are in-progress iterations (v1/v2 pattern)
- **Membership_Flow_Opportunities_Donations_Merchandise_3** — InvalidDraft status
- **DLRS triggers on CampaignMember, Task, conference360__Attendee__c** — Fire alongside NPSP triggers
- **Multiple Shopify-related flows are obsolete** — Suggests e-commerce integration was rebuilt
- **woocommerce integration status unclear** — Listed in manual with "????"
- **Incomplete sections in original manual** — Integration patterns, reports, security, engagement, training sections are stubs
- **Process Builder still active** — DS data transfer from Leads after conversion (should migrate to Flow)

## Things That Break
- **Adding automation on Contact** — 169 custom fields + NPSP TDTM handlers + DLRS triggers + 10+ active flows + Cloudingo weekly merges = extremely high risk. Always check ORG_AUTOMATION.md.
- **Membership logic** — 5 interconnected flows calculate membership status. Changing any membership-related field or automation requires understanding the full chain. NPSP membership fields are NOT used.
- **Donor Level assignment** — Uses Salesforce Levels object with 18-month rolling windows. Don't create competing automation on Donor_Level__c.
- **Donation processing** — Multiple flows touch Opportunity/Task for stewardship tasks. Grant_Tasks flow creates tasks 28 days before close date.
- **NPSP rollup conflicts** — Never update npe01__*, npsp__*, npo02__* rollup fields directly.
- **Cloudingo merges** — Run weekly on contacts. Alliance members and KnowWho contacts are excluded. If you create custom fields, ensure merge behavior is correct.
- **Mailchimp sync** — POW__c and POW_Action_Fund__c fields control audience membership. Changing these fields triggers Mailchimp sync.
- **Engagement tracking** — Engagement__c is master-detail to Contact with DLRS rollups. The Engagement_* flows + DLRS triggers form a chain calculating attendance rates and touch points.
