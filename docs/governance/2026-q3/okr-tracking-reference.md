# POW OKR Tracking in Salesforce — Reference

**Version 1 — August 20, 2026.** Prepared by Resin LLC for the Data Governance Committee.
This document states, for every objective and key result in the 2025–2029 Strategic Plan,
exactly how it is (or isn't) tracked in Salesforce today: what counts, where the number
lives, and what still needs a decision. Sources: the January 2026 OKR worksheet and a
live, read-only inventory of the production org run August 20, 2026. Maintained by Resin;
updated whenever tracking changes.

## The building blocks

Four structures carry all OKR data in Salesforce:

| Structure | What it captures | Key fields |
|---|---|---|
| **Campaigns** | Trainings, mobilizations, advocacy actions, grants, Higher Logic events | OKR Type (Recruit/Train/Mobilize/Fundraise/Support/Validation), Alliance Training checkbox, Alliance Mobilization Type, CiviClick Campaign ID, HL Event ID |
| **Blackthorn Events** | Event attendance (summits, camps, skill-building) | OKR Alliance Training Type on the event; attendance status per attendee |
| **Contacts** | Who someone is and their standing | Record type (Alliance Member), Alliance Group, Alliance Member Since, Membership Status |
| **Partnership Deliverables** | Brand/CEO engagement actions | Partner Action Taken, Completed Date, linked Account |

**Where to look:** dashboards live in the *Organizational Health Dashboards* folder —
**"2025-2029 Objectives and Key Results"** (one tile per KR), **"Alliance OKRs —
Leadership View"** (training/engagement tiles), and **"Organizational Health"**
(advocacy + giving).

---

## Objective 1 — Train and Mobilize POW Alliances

| KR | What counts (+1 rule) | Where it's tracked | 2026 number | Status | Owner |
|---|---|---|---|---|---|
| **1.1** Train 150+ Alliance members annually | An Alliance Member marked **Attended** on a training campaign — campaigns are flagged with the **Alliance Training** checkbox, which is now set automatically whenever a Blackthorn event is tagged as a training | Leadership View tiles ("Total trainings", "Alliance members trained") | **71 members trained** at 15 tagged events | ✅ Tracked | Graham |
| **1.2** Mobilize 150+ Alliance members annually | An Alliance Member on a campaign with OKR Type = Mobilize | [OKR] Mobilize 150+ report; 17 mobilization campaigns in 2026 | **36 members** (32 Attended) | ✅ Tracked — "high-visibility action" for the 30-athlete sub-goal is undefined | Graham |
| **1.3** 40+ Empowerment Grants, 5–10 Advocacy & Adventure Grants | Historically: grantee added to a grant campaign (Empowerment Grants 2025: 29 members; 2026: 4 so far; three "AAA Grants" campaigns exist for Advocacy & Adventure) | [OKR] 40+ Empowerment Grants report (counts the Empowerment Grants campaign family — 32 distinct grantees to date) | 2026: 4 (Empowerment) + AAA campaigns not yet rolled up | ⚠️ **Open** — current tracking home unconfirmed | Graham / Clara |
| **1.4** Grow new sport communities (Run + Water) | Alliance Member assigned to the relevant Alliance Group, with Alliance Member Since as join date | Contact fields; "Expand POW's reach" report | Since 2025: **POW Water +9, POW Trail +4** | ⚠️ Tracked, but the folder report filters on group names that don't exist ("Run"/"Water" vs. actual "POW Trail"/"POW Water") — it renders zero; Resin will fix | Graham |
| **1.5** Engage 100+ brands & CEOs | A partner account logs a Partnership Deliverable of "Attended POW Summit" or "Attended In The Weeds training session" with a completed date | "Engage 100+ outdoor brands and CEOs" report (unique accounts) | Since 2025: **29 accounts** (Summit) + **25 accounts** (In The Weeds) | ✅ Tracked — "brand-led advocacy efforts" (5+ by 2026) has no defined tracking yet | Patrick |

*Note on 1.1:* an older report ([OKR] Training To 150+, built on event attendance) is still
on the OKR dashboard; it date-filters on when the *contact* was created rather than when
the training happened, so its number will drift from the Leadership View tiles. The
campaign-checkbox convention above is the source of truth; Resin recommends re-pointing
the dashboard tile and will bring that as a small change.

## Objective 2 — Build Community and POWer in the Outdoor State

| KR | What counts | Where it's tracked | Current number | Status | Owner |
|---|---|---|---|---|---|
| **2.1** Community Hubs (2 → 8) | Hub structure still being determined | Higher Logic sync is live: 66 Chapter Meeting campaigns and 185 linked contacts so far | — | ⚠️ **Open** — hub definition/structure decision needed before a metric can be stated | Lindsey |
| **2.2** Double grassroots membership to 200,000 | A contact whose Membership Status is Current (any membership action — donation, opt-in, merch, event, advocacy — within 365 days) | "Current Members" tile on the OKR dashboard | **19,390 current members (~10% of goal)** | ✅ Tracked — definition will change if the membership restructure (Q3 packet item 4) goes ahead | Ryan |
| **2.3** Stoke The Vote: 45M impressions, 3–4 states | Social/advertising impressions | **External** (Sprout, Meta Ads, Google Analytics); the advocacy-action side of voter work does land in Salesforce via CiviClick campaigns | — | External by design | Lindsey |

## Objective 3 — Accelerate Decarbonization

| KR | Status |
|---|---|
| **3.1** 500 MW clean power by 2026 / 1 GW by 2028 | **Not tracked in Salesforce** — no megawatt field exists anywhere in the org. Needs an attribution decision (how POW claims megawatts) before anything can be built. |
| **3.2** Defend millions of acres of public lands | **Not tracked in Salesforce** — same situation (no acreage field). Campaign wins/losses have a field (OKR Win/Loss) but it hasn't been used since 2022. |
| **3.3** Weekly climate education content | **External** (CMS, social tools, content calendar) — by design. |

If the committee wants 3.1/3.2 in Salesforce, the natural home is two fields on Campaign
(quantity + win/loss) filled in when a policy campaign closes — a small build once the
attribution rule is decided.

---

## Organizational health metrics

| Metric | How it's counted | Current number |
|---|---|---|
| Unique advocates engaged | Distinct contacts on CiviClick advocacy campaigns | **3,856** (12 campaigns, all launched 2026) |
| Repeat engagement | Contacts in 2+ CiviClick campaigns | **611 (16%)** |
| Alliance activation rate | Open — "activation" needs a definition (same as 1.2's mobilization, or broader?) | — |
| Development: revenue vs. goals | Organizational Health dashboard giving tiles (won opportunities, POW fund, by year) | on dashboard |
| Audience-to-action (petitions, click-throughs, Team POW sign-ups) | Partial — sign-ups and event RSVPs land in Salesforce; click-throughs stay in marketing tools | — |

## Open decisions (queued for the OKR working session)

1. **Training vs. engagement definitions** (blocks 1.1/1.2/1.5 edge cases — e.g., do
   podcasts and customized coaching count toward the 150 trained?) — Graham, on the record.
2. **"High-visibility action"** for the 30-athlete sub-goal of 1.2.
3. **Grants tracking home (1.3)** — confirm campaigns remain the system of record and
   whether AAA Grants roll into the same report.
4. **Community Hub structure (2.1)** — what a hub is in data terms; Higher Logic is ready.
5. **Decarbonization attribution (3.1/3.2)** — how megawatts/acres are claimed; then a
   small Salesforce build.
6. **A named data owner per KR** — one person, not a department.

## Fixes Resin will make (no decision needed)

- Repair the KR 1.4 report's group-name filter (currently returns zero).
- Align the OKR dashboard's training tile with the campaign-checkbox convention.
- Backfill start dates on CiviClick campaigns (11 of 12 have none) and ensure new
  CiviClick campaigns carry the sync flag the advocacy dashboards filter on, so
  dashboard counts don't quietly diverge.

---

*Maintained by Resin LLC. This reference is regenerated after tracking changes; the
numbers above are point-in-time as of August 20, 2026. Questions or corrections:
flag them in comments on this doc.*
