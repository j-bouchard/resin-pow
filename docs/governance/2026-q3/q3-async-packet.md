# [POW] Data Governance — Q3 2026 Async Packet

**To:** Data Governance Committee (Lindsey, Jake, Maddy, Graham, Waverley, Patrick, Stacie; Hannah as executive sponsor)
**From:** Joe Bouchard (Resin LLC)
**Responses due: one week from the date of this email.** No meeting required for any of this.

Per the July 13 check-in with Hannah, we're handling the outstanding governance items
in two tracks: this async packet (five items below), and a separate 45-minute OKR
working session (scheduled separately — not covered here). Three items need a reply;
two are read-only or default-approve. **If you only have two minutes: answer items 1
and 4.**

---

## 1. KnowWho decision — REPLY NEEDED (one word)

CiviClick has been live since January and replaced Quorum. The KnowWho legislator
dataset (~26,000 contact records) has been sitting in Salesforce awaiting a decision
since January. These records are already excluded from email lists and dedupe merges;
they cost storage and clutter and are not connected to the new advocacy stack.

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
verified as running, and it's working (storage went from 142% of allocation in Nov 2024
to 87% in Jan 2026). Five substantive edits are proposed:

1. An explicit **donor-protection statement** (never archive/delete donors — formalizes
   what the criteria already do)
2. Campaign deletion exclusions updated for **CiviClick** (Quorum's replacement)
3. A new **L2 Voter Data** section (formalizes the January 2025 export decision)
4. A new **integration-owned data** section (CiviClick, Higher Logic)
5. Oversight cadence updated to **quarterly written snapshots** (async OK) instead of
   quarterly meetings

**Reply "Approved as redlined" or comment on the specific numbered items.**
*(Attachment: Data Retention Policy — 2026 Annual Review Redline)*

## 3. Data health snapshot — READ-ONLY, no reply needed

One page: storage, record counts, email opt-out trend, address completeness.
Two items flagged "to watch" in January — email opt-outs and incomplete addresses —
are both still climbing with no owner. The snapshot shows the numbers; the ownership
question is part of the OKR working session (data ownership agenda item), not this
packet.
*(Attachment: Data Health Snapshot — August 2026)*

## 4. Membership structure changes — REPLY NEEDED (one word)

The 2026 plan scoped membership structure changes (paid model / intake form /
"Outdoor State" concepts) for February. It's now August and the status is unclear.

**Reply with one of:**

- **ACTIVE** — still a 2026 initiative; we'll schedule a scoping conversation
- **SHELVED** — not happening in 2026; Resin stops holding design scope for it
  (it can be revived any time, this just clears the books)

## 5. System documentation (user manual) — default-approve

System documentation was a March deliverable; the Salesforce User Manual still has nine
chapters that exist as headers only. The attached proposal finishes it in three phases —
Aug 29 / Sep 19 / Oct 9 — with only ~1 hour of POW time required (User Training chapter
input, late September).

**No response within a week = approved as proposed and we start Phase 1.** If you want
a chapter dropped, reprioritized, or a different reviewer, say so now.
*(Attachment: User Manual Completion Proposal)*

---

### Summary of what each person needs to do

| Item | Action | Who |
|------|--------|-----|
| 1. KnowWho | Reply KEEP / ARCHIVE / DROP | Anyone using it; otherwise Hannah decides |
| 2. Retention policy | "Approved as redlined" or comments | All committee members |
| 3. Health snapshot | Read (no reply) | All |
| 4. Membership changes | Reply ACTIVE / SHELVED | Hannah / Erin |
| 5. User manual | Silence = approve; comments welcome | Hannah |

Thanks — one week, no meeting, and the governance backlog from January is clear.
