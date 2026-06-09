---
client: Protect Our Winters
generated: 2026-06-09T19:18:07Z
generated_from: bd36d09
pipeline_version: pipeline-v1.2.5
---

# Protect Our Winters — Salesforce Manual

*A living guide to how your Salesforce works. Regenerated automatically
whenever your system changes, so it is never out of date.*

---

## 1. About Your Salesforce

Salesforce is POW's central record of every relationship that advances the
mission — donors, Team POW members, Alliance athletes and scientists,
partner brands, volunteers, advocates, and event attendees. It runs on
**Enterprise Edition** with the **Nonprofit Success Pack (NPSP)**, the
nonprofit standard for managing donations and households.

**Who maintains it:** Resin LLC (Joe Bouchard). Changes are made through a
managed process: every change is specified, built and tested in a sandbox
(a safe copy of your system), reviewed, and only then deployed to your live
system — with a full history of what changed, when, and why. This manual is
regenerated after every deployment.

---

## 2. Your Data Model

The objects your team touches daily, in plain terms:

### Contacts — people
Every person POW interacts with. Two record types change how a contact
behaves:

- **Contact** — donors, members, volunteers, advocates, the general
  community.
- **Alliance Member** — athletes, scientists, and creatives in POW's
  Alliance. Alliance members are handled specially across the system: they
  are excluded from duplicate-record cleanup, from data archiving, and have
  their own page layouts, fields (bio, sport category, social following,
  Olympic history), and captain review process. **Don't change a contact's
  record type** — there's a safeguard preventing this for good reason.

Fields staff use most:
- **Description / Context / Talking Points** — bio and timeless notes vs.
  current must-knows vs. high-level points for conversations.
- **Donor Level** (Ally → Advocate → Enthusiast → Champion → Titan) —
  assigned automatically from 18-month giving totals. See §3.
- **Membership Status** (Current/Expired) — calculated automatically.
  See §3. Editing membership dates by hand will be overwritten.
- **Major Donor Potential** — checked when a contact has $1,000+ giving
  potential; set by staff.
- **POW / POW Action Fund** — these two fields control which Mailchimp
  email audiences the contact belongss to. POW defaults to Yes.
- **Archived** — set automatically by the data retention policy (§5).

Contacts also carry voter-engagement data (districts, voting history,
registration status) imported from the L2 voter file. This data is
historical and static — it is not maintained day-to-day.

### Accounts — households and organizations
- **Household** — created automatically when you add a contact; rolls up
  the household's combined giving.
- **Organization** — foundations, nonprofits, non-partner companies.
- **Partner** — brands in POW's partner program, carrying contract fields
  (level, start date, amount, renewal date). Partner and foundation
  accounts get a **Stage** (Current / Lapsed / Lost) updated automatically
  from donation recency: lapsed after 1 year without giving, lost after 2.
  An automatic task alerts the account owner 30 days before a partner
  contract renewal.

### Opportunities — money and merchandise
Every donation, grant, ticket sale, and merch order. The record type tells
you what kind of revenue it is: **Donation**, **Classy** (online),
**Event Ticket**, **Grant** (with application/report deadline fields),
**In-Kind**, **Matching Gift**, **Merchandise**, **Partner Commitment**.
Note: an "Opportunity" is not just a donation here — merchandise and event
tickets flow through the same object.

### Campaigns — events, appeals, and advocacy
Fundraising appeals, events (via Blackthorn), email campaigns, and advocacy
actions, with parent campaigns for hierarchies. Campaign records carry OKR
tracking fields (Win/Loss, OKR Type) and a Membership Campaign Type set
automatically based on the campaign's source platform.

### Cases — inbound requests
Inquiries from the website's Contact Us form, routed automatically by
category (Media, Memberships, Partnerships, Events & Fundraising,
International, Merchandise, Donor Relations, Other) to the right owner
with an email alert. The Communications queue receives membership email.

### Supporting objects
- **Engagement** — per-contact participation metrics (events attended,
  invitations, posts) calculated automatically.
- **Attendee** — event attendance records from Blackthorn.
- **GAU / GAU Allocations** — which fund each donation is designated to.
- **Partnership Deliverables** — what POW and each partner owe each other;
  each entry must be either a POW deliverable or a partner action, not both
  (the system enforces this).
- **Alliance Reviews / Alliance Surveys** — Alliance member performance
  and survey data.
- **L2 Data / Ballot Ready** — voter file and voter-engagement data.

---

## 3. How Your Programs Work

### Team POW Membership (custom-built — the most important thing to know)

POW's membership program is fully custom. A person is a **current Team POW
member** if they did ANY of the following **in the last 365 days**:

1. Donated (any kind, including recurring)
2. Opted in via the POW website
3. Opted in via a partner website (Ikon, Aspen, etc.)
4. Bought POW merchandise
5. Attended a POW event
6. Took an advocacy action

How it works behind the scenes:
- Each qualifying action updates the contact's **Last Membership Date**
  automatically.
- **Membership Status** flips between Current and Expired based purely on
  whether that date is within 365 days. **Membership End Date** is always
  the last action plus 365 days.
- **Initial / Most Recent Entry Point** record how each member first joined
  and most recently engaged (Donation, Advocacy Action, Event Attendee,
  Merchandise Purchase, Partner Opt In, POW Opt In).

**What staff need to know:** membership fields update themselves — a set of
automations watches donations, event attendance, advocacy actions, and
opt-ins. Hand-editing membership dates or status will be overwritten and
can put a member in the wrong state. If a member's status looks wrong,
report it (§9) rather than correcting the field directly. Contacts can opt
out entirely via **Membership Opt Out**.

### Donor Levels

Levels are assigned automatically from each contact's **18-month giving
total**:

| Level | 18-month giving |
|-------|----------------|
| Ally | under $1,000 |
| Advocate | $1,000 – $4,999 |
| Enthusiast | $5,000 – $9,999 |
| Champion | $10,000 – $24,999 |
| Titan | $25,000+ |

**Previous Donor Level** keeps the prior level for spotting upgrades and
downgrades. Recurring donors also get automatic stewardship tasks (30/90
day check-ins), and donations of $500–999 trigger a follow-up task to the
opportunity owner.

Separately from levels, every contact has a **Stage** (Current / Lapsed)
based on an 18-month donation window, refreshed daily.

### Partner Program

Partner accounts carry contract terms, a partner level, and a stage that
tracks giving recency automatically. **Partnership Deliverables** records
track commitments in both directions. Thirty days before a contract
renewal date, the account owner gets a task automatically.

### Alliance Program

Alliance members (athletes, scientists, creatives) have their own record
type, page layouts, captain hierarchy (by sport: Bike, Climb, Creative,
Run, Science, Ski, Snowboard), review scoring, surveys, and a prospect
pipeline that tracks recruitment from scouting through onboarding. New
alliance registrations alert the group captain automatically.

### Advocacy

Advocacy actions flow in from the CiviClick (Phone2Action) platform and
count toward Team POW membership. Contacts carry voter-engagement data and
a Voter Rating (Great Voter / Likely Voter / Nonvoter) assigned
automatically.

---

## 4. What Runs Automatically

Your Salesforce updates itself constantly. The complete picture, by area —
and what to know so you work *with* it:

| Area | What happens automatically | What staff should know |
|------|---------------------------|----------------------|
| Membership | All membership fields update from donations, events, advocacy, opt-ins, merch | Never hand-edit membership fields |
| Giving totals | Household and contact giving rollups (NPSP), engagement counts, soft credits | Calculated fields will overwrite manual edits |
| Donor stewardship | Tasks created for $500+ gifts, recurring donor check-ins, first gifts | Complete the task rather than deleting it |
| Account stages | Partner/foundation stages flip Current → Lapsed → Lost on giving recency | A "Lost" partner just means no gift in 2 years |
| Contract renewals | Task to account owner 30 days before partner renewal | — |
| Case routing | Website inquiries assigned by category with email alerts | Pick the right category when creating cases manually |
| Data quality | Names auto-capitalized; state filled from zip code; country/state values normalized | — |
| Email audiences | POW / POW Action Fund fields sync contacts to Mailchimp audiences; legislator contacts are kept off email lists automatically | Changing these fields changes who gets emailed |
| Recurring donations | Cancelled recurring donors have their future pledged donations closed automatically; amount changes create a review task | — |
| Events | Attendance recorded from Blackthorn; attendee counts roll up to engagement records | — |
| Grants | Reminder tasks created 28 days before grant deadlines | — |
| Data retention | See §5 | — |

A note on history: some of this automation runs on older Salesforce
technology (workflow rules) that predates current best practice. It works,
but it's on the modernization roadmap — if an automation behaves oddly,
report it rather than assuming it's correct.

---

## 5. Data Hygiene & Retention

Two systems keep your data clean, and staff should know they exist:

- **Duplicate prevention (in Salesforce):** when you create or edit a
  contact, matching rules check email, name, phone, and address and warn
  you about likely duplicates.
- **Cloudingo (weekly, automatic):** merges duplicate contacts matching on
  email + name. Alliance members and legislator contacts are never
  auto-merged.

**Retention policy (what gets archived or deleted):**
- Contacts with no gifts, no affiliations, no membership, no advocacy, no
  event attendance, who opted out of email and are 3+ years old are marked
  **Archived** weekly (not deleted).
- Empty campaigns older than 90 days are deleted (event, Classy, and
  advocacy campaigns are never auto-deleted).
- Mailchimp email activity older than 30 days is removed from contact
  records. Gmail messages are kept forever.
- Form submissions older than 3 years are deleted (except Alliance forms);
  data already on the contact record is kept.

---

## 6. Your Integrations

| System | What it does | Data direction | If it looks wrong, check… |
|--------|-------------|----------------|---------------------------|
| Classy | Online fundraising; donations and recurring gifts sync in | Classy → Salesforce | The donation in Classy first; sync issues show as missing/duplicate Classy-type opportunities |
| Blackthorn Events | Event registration, ticketing, attendance | Both directions | The event in Blackthorn; attendance drives membership, so missing attendees → wrong membership status |
| Stripe (via Blackthorn) | Payment processing for tickets and merch | Stripe → Salesforce | Payment records on the opportunity; payouts are reconciled monthly by Resin |
| Shopify | Merchandise store; orders become Merchandise opportunities with an Order ID | Shopify → Salesforce | The order in Shopify admin; the Order ID field links the two |
| Mailchimp (via SyncApps) | Email marketing; audiences driven by the POW / POW Action Fund contact fields | Both directions | The contact's POW/POW AF fields and Mailchimp audience membership |
| CiviClick (Phone2Action) | Advocacy actions; drives membership and advocacy data | CiviClick → Salesforce | The action in CiviClick; arrives via webhook |
| Formstack | Forms — opt-ins, registrations | Formstack → Salesforce | The submission record; opt-in forms drive membership |
| 360MatchPro | Corporate matching gift identification | Both directions | Matching Gift opportunities |
| DonorSearch | Wealth screening on prospects | DonorSearch → Salesforce | Prospect data transfers when a lead converts |
| KnowWho | Legislator contact data | KnowWho → Salesforce | Legislator records; these are kept off email lists automatically |
| Cloudingo | Duplicate merging + retention cleanup | Operates on Salesforce | §5 |
| Google Ads | Lead capture from ads | Google → Salesforce | Recent leads |

---

## 7. Reports & Dashboards

Key dashboards:

- **POW Development Forecasting** — expected revenue and progress toward
  fundraising goals (forward-looking).
- **POW Development Analysis** — historical giving trends, donor
  retention, campaign effectiveness.
- **Membership Dashboard** — membership growth, renewal rates, churn.

The system has 38 custom report types covering donations (including
recurring and Classy-specific views), campaign membership, event
attendance, Alliance surveys, partner deliverables, form submissions,
voter engagement, and duplicate monitoring. If you need a report that
doesn't exist, request it (§9) — new reports are quick to build.

---

## 8. Recent Changes & Decisions

*Changes made through the managed pipeline. This section accumulates
automatically; the full history is always available on request.*

| Date | Change | Why |
|------|--------|-----|
| Apr 15, 2026 | Added **Preferred Communication Method** picklist to Contact (Email / Phone / Mail / Text, defaults to Email) with staff access | Lets staff personalize outreach across fundraising, events, and advocacy |

**Standing design decisions staff should know:**

- **Membership is custom, not NPSP-standard.** Team POW membership counts
  six kinds of engagement, not just donations, so it was built as custom
  automation rather than NPSP's donation-only membership. Consequence:
  membership fields are system-maintained (§3).
- **Donor levels use an 18-month window** rather than calendar-year
  giving, so levels reflect sustained engagement rather than resetting
  every January.
- **Alliance members are deliberately walled off** from bulk data
  operations (merging, archiving) because their records carry program
  history that automated cleanup could damage.

---

## 9. Getting Help

- **Request a change or new feature:** contact Joe Bouchard (Resin LLC).
  Requests are tracked, specified, built in a test environment, and
  reviewed before going live — typical turnaround for simple changes is
  days, not weeks.
- **Something looks broken or a number looks wrong:** report it to Joe
  with the record link and what you expected to see. Don't hand-correct
  calculated fields (membership, levels, giving totals) — the fix will be
  overwritten and the underlying cause stays hidden.
- **Membership email queue:** memberships@protectourwinters.org routes to
  the Communications case queue automatically.
