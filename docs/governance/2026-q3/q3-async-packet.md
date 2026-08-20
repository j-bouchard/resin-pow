# [POW] Data Governance — Q3 2026 Async Packet

**To:** Data Governance Committee (Lindsey, Jake, Maddy, Graham, Waverley, Patrick, Stacie; Hannah as executive sponsor)
**From:** Joe Bouchard (Resin LLC)
**Responses due: one week from the date of this email.** No meeting required for any of this.

Per the July 13 check-in with Hannah, we're handling the outstanding governance items
in two tracks: this async packet (five items below), and a separate 45-minute OKR
working session (scheduled separately — not covered here). Three items need a reply;
two are informational. **If you only have two minutes: answer items 1
and 4.**

---

## 1. KnowWho decision — REPLY NEEDED (one word)

CiviClick has been live since January and replaced Quorum. The KnowWho legislator
dataset (30,904 contact records — **still growing**, the sync is still active) has been
sitting in Salesforce awaiting a decision since January. These records are already
excluded from email lists and dedupe merges; they cost storage and clutter and are not
connected to the new advocacy stack.

**Reply with one of:**

- **KEEP** — someone actively uses KnowWho legislator data in Salesforce (tell us who/how)
- **ARCHIVE** — export to Google Drive for reference, then remove from Salesforce
  (same pattern we used for L2 voter data)
- **DROP** — remove from Salesforce, no export

*Resin's recommendation: ARCHIVE. It frees the storage and clutter with zero data loss.
If we archive or drop, we will also deactivate the KnowWho sync so records don't
recreate, and the removal will be run as a documented, committee-visible operation.*

## 2. Data Retention Policy — annual review redline — REPLY NEEDED (approve or comment)

The policy requires annual review; the last version is January 2025, so we're overdue.
The attached redline is **mostly confirmation** — every enforcement mechanism has been
verified as running, and the data it covers has stayed clean. Six substantive edits are
proposed:

1. An explicit **donor-protection statement** (never archive/delete donors — formalizes
   what the criteria already do)
2. Campaign deletion exclusions updated for **CiviClick** (Quorum's replacement)
3. A new **L2 Voter Data** section (formalizes the January 2025 export decision)
4. A new **integration-owned data** section (CiviClick, Higher Logic)
5. A new **activity records** section flagging Tasks as a policy gap (they're now the
   largest storage consumer — options come at the next review, nothing decided today)
6. Oversight cadence updated to **quarterly written snapshots** (async OK) instead of
   quarterly meetings

**Reply "Approved as redlined" or comment on the specific numbered items.**
*(Attachment: Data Retention Policy — 2026 Annual Review Redline)*

## 3. Data health snapshot — READ-ONLY, no reply needed

One page: storage, record counts, email opt-out trend, address completeness.
Three things to know: **storage is over allocation again** (116.5% — driven by activity
records the retention policy doesn't cover; Resin brings a remediation proposal in
September, no action needed from you now). The two items flagged "to watch" in January —
email opt-outs and incomplete addresses — are both still climbing with no owner, though
the opt-out number looks worse than it is (half of it is archived contacts; the
active-contact rate is 23%). The ownership question is part of the OKR working session
(data ownership agenda item), not this packet.
*(Attachment: Data Health Snapshot — August 2026)*

## 4. Membership structure changes — REPLY NEEDED (one word)

The 2026 plan scoped membership structure changes (paid model / intake form /
"Outdoor State" concepts) for February. It's now August and the status is unclear.

**Reply with one of:**

- **ACTIVE** — still a 2026 initiative; we'll schedule a scoping conversation
- **SHELVED** — not happening in 2026; Resin stops holding design scope for it
  (it can be revived any time, this just clears the books)

## 5. System documentation (user manual) — DONE, no action needed

The Salesforce User Manual is complete. The nine chapters outstanding since March are
written, and v1's duplicated/placeholder content is cleaned up. Comments welcome any
time — it's a living document.
*(Attachment: Salesforce User Manual v2, August 2026)*

---

### Summary of what each person needs to do

| Item | Action | Who |
|------|--------|-----|
| 1. KnowWho | Reply KEEP / ARCHIVE / DROP | Anyone using it; otherwise Hannah decides |
| 2. Retention policy | "Approved as redlined" or comments | All committee members |
| 3. Health snapshot | Read (no reply) | All |
| 4. Membership changes | Reply ACTIVE / SHELVED | Hannah / Erin |
| 5. User manual v2 | None — done; comments welcome | All |

Thanks — one week, no meeting, and the governance backlog from January is clear.
