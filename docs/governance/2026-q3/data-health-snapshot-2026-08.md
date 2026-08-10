# POW Salesforce Data Health Snapshot — August 2026

**One page, read-only, for Data Governance Committee awareness. No action required.**
Prepared by Resin LLC. Sources: November 2024 Data Quality Audit, January 2026 Q1
committee review, live production queries August 10, 2026.

## ⚠️ Storage — over allocation again

| | Nov 2024 | Jan 2026 | Aug 2026 |
|---|---|---|---|
| Data storage used | **142%** (over limit) | 87% (9.1 GB) | **116.5%** (12.8 GB of 10.98 GB) |

The 2025 retention policy work brought storage from 42% over to comfortably under —
but it has climbed back over the limit this year. The growth is **not** in the data the
policy covers (contacts, campaigns, Mailchimp, forms — all still enforced and verified
active); it's in **activity records**: Tasks (3.4M), their system-generated relation
records (9.1M), and deleted-record tracking (1.2M). Resin will bring a remediation
proposal (activity retention options + recycle-bin purge check) in September — no
committee action needed in this packet. File storage is fine (17%).

## Record counts

| Object | Nov 2024 | Jan 2026 | Aug 2026 |
|---|---|---|---|
| Contacts | 391,912 | ~414,000 | 421,162 |
| Accounts | 377,137 | ~397,000 | 402,673 |
| Opportunities | 215,378 | ~248,000 | 259,821 |
| Campaign Members | 939,678 | ~982,000 | 991,000 |

Growth is steady and healthy (~1,400 new contacts/month).

## ⚠️ The two watch items (flagged January, still climbing, still unowned)

| Metric | Nov 2024 | Jan 2026 | Aug 2026 | Trend since Nov 2024 |
|---|---|---|---|---|
| **Email opt-outs** | 124,590 | 151,495 | 160,914 (38.2%) | **+29%** (slowing: +6% last 7 mo) |
| **Incomplete addresses** | 136,959 | 208,335 | 227,248 (54.0%) | **+66%** (still rising) |

- **Opt-outs, decomposed (new analysis):** the headline 38% is inflated by history.
  Half the opted-out contacts (81,850) are already **archived** under the retention
  policy — a graveyard of old unsubscribes, concentrated in the 2020 migration cohort
  (42% opt-out rate) — and unsubscribed contacts are never deleted, so the number can
  only grow. Among **active (non-archived) contacts the rate is 23.3%**, and contacts
  created in 2025–26 opt out at only 8–21%. Verified: no active incident, no
  integration flipping flags. Real but structural, not a fire.
- **Incomplete addresses:** 54% of contacts; 72,237 have no address at all. Growth
  continues to outpace contact growth ~3x — new records arrive address-poor (advocacy
  and import sources), and nothing at entry enforces address completeness. This caps
  direct-mail reach and skews state-level reporting.

Neither metric has an owner. Data ownership is on the OKR working-session agenda —
these two belong to whoever takes contact data.

## Data quality (context metrics)

| Metric | Nov 2024 | Aug 2026 | |
|---|---|---|---|
| Opportunities missing fund designation | 97,185 | **0** | ✅ fixed and stayed fixed |
| Contacts named "Unknown" | 26,259 | 25,894 | flat |
| L2 voter data records in Salesforce | 438,645 | 9,599 | ✅ export-and-remove completed |
| KnowWho records | 25,927 | 30,904 | ⚠️ still growing — decision is packet item 1 |

## Bottom line

Financial data quality is excellent (fund designation stayed at zero) and the 2025
retention machinery is all still running. Three things need attention: **storage is
over allocation again** (activity records — Resin remediation proposal coming in
September), and the two January watch items — **opt-outs** (structural, less alarming
once decomposed, but unowned) and **incomplete addresses** (genuinely worsening,
unowned). Owner assignment for contact data is already on the OKR session agenda.
