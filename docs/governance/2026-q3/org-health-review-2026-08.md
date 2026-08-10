# POW Org Health Review — August 2026 (internal)

Resin-internal assessment, prepared alongside the Q3 governance packet. This is the
"how is the org actually doing" view for Joe — the committee-facing version is the
one-page data health snapshot.

## What's healthy

- **Retention machinery all running.** All four enforcement mechanisms (1 scheduled
  flow + 3 Cloudingo filters) verified active; 81,850 contacts archived to date. The
  L2 export-and-remove action from January 2025 is complete (438,645 → 9,599 records).
- **Fund designation cleanup held.** 97,185 missing → 0 (verified live Aug 10). The
  biggest financial-data completeness gap from the 2024 audit is closed and stayed closed.
- **The technical build is on track.** CiviClick migration done (January), Higher Logic
  integration built and documented, Shopify integration live and documented. The
  stall is governance decisions, not delivery.
- **Record growth is steady** (~1,400 contacts/month) with dedupe layers (4 SF duplicate
  rules + Cloudingo weekly merges) operating.

## Red flags

1. **Storage is over allocation again: 116.5% (12.8 GB of 10.98 GB) as of Aug 10.**
   It was 87% in January. The growth is NOT in retention-policy-covered data — it's
   activity records: Task (3.4M rows), TaskRelation (9.1M — largest object in the org),
   and DeleteEvent (1.2M — recycle-bin/delete tracking, plausibly residue of Cloudingo's
   own mass deletes). Two-step response: (a) quick win — verify and purge the recycle
   bin / DeleteEvent backlog; (b) September remediation proposal for activity-record
   retention (needs committee approval — Gmail "never delete" is a standing committee
   decision). File storage is fine (17%).
2. **Incomplete addresses: 136,959 → 208,335 → 227,248 (+66% since Nov 2024).** 54% of
   contacts; 72,237 have no address at all. Growing ~3x faster than the contact base.
   Only 1 validation rule exists org-wide — nothing enforces address quality at entry.
   Unowned.
3. **Email opt-outs: 124,590 → 160,914 (38.2%).** Decomposed on Aug 10 (read-only
   investigation): half the opt-outs are archived contacts (the retention policy uses
   opt-out as an archive criterion, so the archive is a graveyard of old unsubscribes,
   concentrated in the 2020 migration cohort at 42%); the **active-contact rate is
   23.3%**, and 2025–26 cohorts opt out at 8–21%. No active incident — the Cazoomi sync
   was ruled out, and growth has slowed to +6% in 7 months. Structural, not a fire —
   but still unowned, and field history is off for the opt-out flag, so trend
   forensics are impossible until an owner turns tracking on.
4. **Governance layer stalled since Jan 21.** Six-month-old open decisions: KnowWho
   (records still syncing — now 30,904, up from 25,927), membership structure, OKR
   definitions, executive directive, data ownership. The Q3 packet + OKR working
   session is the recovery plan; if the packet gets no responses, that's an escalation
   signal for Hannah, not a redo-the-packet signal.

## Maintenance debt (not urgent, should be scheduled)

- **71 active Workflow Rules.** Salesforce has ended Workflow Rule enhancement;
  migration to Flow is inevitable. Recommend a phased migration plan as a 2027
  initiative — case routing (×8) and account-stage rules are the natural first tranche.
- **13 obsolete + 8 draft Flows** sitting in the org. Cheap cleanup, reduces
  naming-collision risk for new builds.
- **1 validation rule org-wide.** Effectively no declarative input validation — related
  to the incomplete-address trend (nothing enforces address completeness at entry).
- **1 remaining Process Builder** (DonorSearch lead conversion) — same retirement story
  as Workflow Rules.

## Repo/knowledge-base drift (Resin-side actions)

- **ORG_*.md snapshots are dated 2026-04-15 (~4 months stale).** Run `/snapshot-org`
  to refresh — the org has changed since (CiviClick live, Higher Logic live, Shopify).
- **`knowledge/org-context.md` predates the 2026 integration wave.** It still lists
  WooCommerce (with the manual's `????!` marker), Quorum as active, and doesn't mention
  CiviClick, Higher Logic, Shopify, or GoFundMe. Refresh after /snapshot-org.
- **The repo-root manual PDF is the January 2025 version** — superseded by the living
  Google Doc; consider removing it from the repo or replacing per /generate-manual.

## Recommended next actions

| Action | Owner | When |
|---|---|---|
| Send Q3 async packet (this branch's docs) | Joe | This week |
| Verify + purge recycle bin / DeleteEvent backlog (storage quick win) | Joe/Resin | This week |
| Refresh org snapshot (`/snapshot-org`) + org-context.md | Resin pipeline | This week |
| Storage remediation proposal (activity-record retention options) | Resin → committee | Sept |
| Address-completeness validation/enrichment proposal (pairs with owner assignment) | Resin, after OKR session assigns owner | Sept |
| Turn on field history tracking for `HasOptedOutOfEmail` (prereq for trend forensics) | Resin (with owner) | Sept |
| Obsolete/draft Flow cleanup task | Resin (ClickUp task) | Q4 |
| Workflow Rule → Flow migration plan | Resin proposal | 2027 planning |

## Pipeline infrastructure note (Resin-internal)

The cloud environment's Salesforce auth hook (`session-start-sf-auth.sh`) failed on
both of its paths during this review's metrics run: the `sf` CLI resolves to a Node 20
shim whose bundled `undici` crashes, and the hook pipes the access token via stdin,
which `sf org login access-token` rejected. The metrics session worked around it
(Node 22 + `SF_ACCESS_TOKEN` env var). Fix belongs in `resin-infrastructure` (pipeline
files are not edited in client repos) — worth doing before the next scheduled routine
run, since routines depend on that hook.

*(The opt-out decomposition originally planned for September was completed during this
review — results are in the snapshot.)*
