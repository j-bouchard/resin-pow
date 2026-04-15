# Protect Our Winters (POW) — Org Context

## Org Details
- Org ID: TBD (run `sf org display -o production`)
- Edition: Nonprofit Enterprise Edition
- NPSP Version: Current (npsp namespace installed)
- Sandbox Name: TBD
- Production URL: https://pow.my.salesforce.com

## Installed Packages (29)
**Core NPSP Stack:** npsp, npe01, npo02, npe03, npe4, npe5
**Events:** conference360 (Conference360)
**Payments:** bt_stripe, bt_base, bt_paylink (Blackthorn/Stripe)
**Fundraising:** classy_npsp, stayclassy (Classy/GoFundMe Pro)
**Advocacy:** P2A (Phone2Action/CiviClick), kw (KnowWho)
**Volunteers:** GW_Volunteers (Volunteers for Salesforce)
**Data Quality:** CloudingoAgent (Cloudingo duplicate mgmt), dlrs (DLRS rollups)
**E-commerce:** Shopify integration (custom webhook)
**Other:** VisualAntidote (forms), Field_Trip, OIQ, DS360oi, dtd, pub, relateiq, rh2, rhx

## Key Integrations
- **Shopify** → ShopifyOrderWebhook Apex class processes orders → creates Opportunities
- **CiviClick/P2A** → CiviClickWebhookHandler processes advocacy actions
- **Google Ads** → GoogleAdsLeadApi captures leads
- **Classy/GoFundMe Pro** → classy_npsp package syncs donations
- **Blackthorn/Stripe** → bt_stripe handles payment processing
- **Conference360** → Event management (Attendees, Speakers, Staff, Sponsors)
- **Ballot Ready** → Voter engagement tracking (Ballot_Ready__c object)
- **L2 Data** → Voter/political data vendor (L2_Data__c object)
- **KnowWho** → Legislator data (kw__ namespace)
- **Mailchimp** → Email marketing (events tracked, cleanup flows exist)

## Key Contacts
- Joe Bouchard — Resin LLC, Salesforce consultant

## What POW Does
POW is a climate advocacy nonprofit that mobilizes outdoor athletes and the
outdoor recreation community. Their Salesforce org supports:
- **Alliance Program** — managing athlete ambassadors (Alliance Members) with
  reviews, surveys, engagement tracking, and tiered status
- **Fundraising** — donations, memberships, merchandise, grants via NPSP
- **Advocacy** — voter registration, ballot tracking, calls to action, lobbying
- **Events** — Conference360 for events, volunteer management
- **Partnerships** — corporate partner deliverable tracking

## Naming Conventions
- Custom fields: descriptive names with __c suffix, no namespace prefix
- Flows: Object_Action_Description pattern (e.g., Contact_Archive_Scheduled_Flow)
- Apex: controller/handler/webhook pattern, matching test classes (*Test)
- Objects: descriptive names (e.g., Alliance_Reviews__c, Partnership_Deliverables__c)

## Known Constraints & Tech Debt
- **169 custom fields on Contact** — heavily customized, many voting/election fields
  from past integrations (2014-2020 election cycle fields)
- **13 obsolete flows** — should be cleaned up but currently inactive
- **8 draft flows** — some appear to be in-progress iterations (v1/v2 pattern)
- **Membership_Flow_Opportunities_Donations_Merchandise_3** — has InvalidDraft status
- **Multiple membership flow versions** — indicates iteration/complexity in membership logic
- **DLRS triggers on CampaignMember, Task, conference360__Attendee__c** — these fire
  alongside NPSP triggers on these objects
- **Multiple Shopify-related flows are obsolete** — Order_Fulfillment_Platform_Event,
  Generate_Membership_Order_from_Opportunity
- **Old election voting fields** on Contact (X2014_, X2016_, X2018_, X2020_ prefixed)
  may be candidates for archival

## Things That Break
- **Adding automation on Contact** — 169 custom fields + NPSP TDTM handlers +
  DLRS triggers + 10+ active flows = high risk of conflicts. Always check
  ORG_AUTOMATION.md before adding Contact automation.
- **Donation processing** — Multiple flows touch Opportunity/Task for donor level
  assignment. Changing donation-related automation requires understanding the
  full Membership_Flow_* and Donor_Level_* flow chain.
- **NPSP rollup conflicts** — Never update npe01__*, npsp__*, npo02__* rollup fields
  directly. NPSP recalculates these on its own schedule.
- **Engagement tracking** — Engagement__c is master-detail to Contact with DLRS
  rollups. The Engagement_* flows + DLRS triggers form a chain that calculates
  attendance rates and touch points.
