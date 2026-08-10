# POW Salesforce Data Health Snapshot — August 2026

**One page, read-only, for Data Governance Committee awareness. No action required.**
Prepared by Resin LLC. Sources: November 2024 Data Quality Audit, January 2026 Q1
committee review, live production queries August 10, 2026.

## Storage

| | Nov 2024 | Jan 2026 | Aug 2026 |
|---|---|---|---|
| Data storage used | **142%** of 10.7 GB (over limit) | 87% (9.1 GB) | ⏳ |

The retention policy (Jan 2025) took storage from 42% over allocation to comfortably
under it — Mailchimp activity trimming, campaign cleanup, and contact archiving are
doing their job.

## Record counts

| Object | Nov 2024 | Jan 2026 | Aug 2026 |
|---|---|---|---|
| Contacts | 391,912 | ~414,000 | ⏳ |
| Accounts | 377,137 | ~397,000 | ⏳ |
| Opportunities | 215,378 | ~248,000 | ⏳ |
| Campaign Members | 939,678 | ~982,000 | ⏳ |

Growth is steady and healthy (~1,400 new contacts/month).

## ⚠️ The two watch items (flagged January, still climbing, still unowned)

| Metric | Nov 2024 | Jan 2026 | Aug 2026 | Trend |
|---|---|---|---|---|
| **Email opt-outs** | 124,590 | 151,495 | ⏳ | **+22% in 14 months** |
| **Incomplete addresses** | 136,959 | 208,335 | ⏳ | **+52% in 14 months** |

- **Opt-outs:** roughly 1 in 3 contacts can no longer be emailed. Some growth is
  mechanical (list hygiene, archived contacts are opted out by definition), but nobody
  has decomposed the number to say how much is real audience loss.
- **Incomplete addresses:** the +71k jump since Nov 2024 outpaces contact growth by 3x —
  new records are arriving address-poor (likely from advocacy/import sources). This
  caps direct-mail reach and skews state-level reporting.

Neither metric has an owner. Data ownership is on the agenda for the OKR working
session — these two belong to whoever takes contact data.

## Data quality (context metrics)

| Metric | Nov 2024 | Jan 2026 | Aug 2026 |
|---|---|---|---|
| Opportunities missing fund designation | 97,185 | **0** ✅ | ⏳ |
| Contacts named "Unknown" | 26,259 | 26,014 | ⏳ |
| KnowWho records awaiting decision | 25,927 | ~26,000 | ⏳ (packet item 1) |

Fund designation went from the single biggest completeness gap to zero — that
workstream is done and stayed done.

## Bottom line

Storage and financial data quality are in the best shape they've been since the 2024
audit. The two long-flagged contact-quality trends (opt-outs, addresses) continue to
worsen without an owner — they are the snapshot's only red flags, and assigning them
a named owner is already on the OKR working-session agenda.
