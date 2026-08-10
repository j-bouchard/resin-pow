# POW Org Health Review — August 2026 (internal)

Resin-internal assessment, prepared alongside the Q3 governance packet. This is the
"how is the org actually doing" view for Joe — the committee-facing version is the
one-page data health snapshot.

## What's healthy

- **Storage recovered and stable.** 142% over allocation (Nov 2024) → 87% (Jan 2026).
  All four retention-policy enforcement mechanisms (1 scheduled flow + 3 Cloudingo
  filters) verified active.
- **Fund designation cleanup held.** 97,185 missing → 0. The biggest financial-data
  completeness gap from the 2024 audit is closed and has stayed closed.
- **The technical build is on track.** CiviClick migration done (January), Higher Logic
  integration built and documented, Shopify integration live and documented. The
  stall is governance decisions, not delivery.
- **Record growth is steady** (~1,400 contacts/month) with dedupe layers (4 SF duplicate
  rules + Cloudingo weekly merges) operating.

## Red flags

1. **Email opt-outs: 124,590 → 151,495 (+22% in 14 months).** ~1 in 3 contacts
   unreachable by email. Unowned since flagged in January.
2. **Incomplete addresses: 136,959 → 208,335 (+52% in 14 months).** Growing 3x faster
   than the contact base — new records are arriving address-poor. Unowned.
3. **Governance layer stalled since Jan 21.** Six-month-old open decisions: KnowWho,
   membership structure, OKR definitions, executive directive, data ownership. The Q3
   packet + OKR working session is the recovery plan; if the packet gets no responses,
   that's an escalation signal for Hannah, not a redo-the-packet signal.

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
| Refresh org snapshot (`/snapshot-org`) + org-context.md | Resin pipeline | This week |
| Address-completeness validation/enrichment proposal (pairs with owner assignment) | Resin, after OKR session assigns owner | Sept |
| Opt-out decomposition report (real loss vs. mechanical) | Resin | Sept |
| Obsolete/draft Flow cleanup task | Resin (ClickUp task) | Q4 |
| Workflow Rule → Flow migration plan | Resin proposal | 2027 planning |
