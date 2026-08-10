# Salesforce User Manual — Completion Scope & Timeline Proposal

**August 2026 — for Hannah / Data Governance Committee approval (async).**
Prepared by Resin LLC. System documentation was a March 2026 deliverable; this proposal
closes it out with a concrete scope and dates.

## Where the manual stands

The manual (v1, January 2025, maintained as a Google Doc) has substantial completed
content: Introduction, Org Overview, Data Model, Household Model, Donations Management,
the full Membership Program chapter, Custom Automation inventory, Custom Integrations
(Higher Logic, Shopify), Data Retention Policy, and Duplicate Management.

**Nine chapters exist as headers only (~28 stub subsections):**

| # | Chapter | Stub subsections |
|---|---------|------------------|
| 1 | Custom Reports and Dashboards | Key Reports (LYBUNT/SYBUNT), Dashboards, Custom Report Types |
| 2 | Security and Access Control | Profiles, Roles, Sharing Rules, Permission Sets |
| 3 | Data Management (partial) | Data Import & Export Processes, Data Validation Rules |
| 4 | Engagement and Communication | Email Templates, Campaign Hierarchies, Engagement Plans, Email Alerts |
| 5 | User Training and Adoption | User Roles, Training Materials, Feature Guides, Support Loops |
| 6 | System Maintenance and Governance | Backup/Restore, Health Checks, Audit Trail, Release Management |
| 7 | Technical Debt and Cleanup | Debt Overview, Reduction Plans, Custom Code Purpose |
| 8 | Future Enhancements | Upgrades, Additional Features, Roadmap |
| 9 | Appendix | Glossary, Resources, Key Contacts |

**Plus cleanup items found during this review:**

- The Higher Logic Integration chapter appears **twice** (duplicated content) — needs de-duplication.
- A leftover `woocommerce????!` placeholder in the Integration Overview (the org now uses Shopify — the WooCommerce reference should be resolved or removed).
- Five automation entries have names but no descriptions (Engagement Record Creation, Engagement - Attendee, Engagement - Emails, Engagement - Campaign Member, Grant Tasks).
- "Grant Management Overview" listed in the table of contents but never written.

## Why this is now cheap to finish

Resin's pipeline auto-generates current-state documentation from the org itself
(reports & dashboards inventory, permission sets & field-level security, automation
inventory, full schema). Most of the unwritten chapters are *descriptions of what
exists*, which we can draft directly from those snapshots and edit for a client-facing
audience. Only User Training and Adoption genuinely requires POW input.

## Proposed scope and timeline

| Phase | Content | Source | Done by |
|-------|---------|--------|---------|
| **1. Org-derived chapters** | Reports & Dashboards; Security & Access Control; Data Management (Import/Export, Validation Rules) | Generated from org snapshot, edited by Resin | **Aug 29** |
| **2. Narrative chapters + cleanup** | Engagement & Communication; System Maintenance & Governance; Technical Debt; Future Enhancements; Appendix; de-dupe Higher Logic; fix placeholders and blank automation descriptions | Resin drafts from knowledge base + 2026 roadmap | **Sep 19** |
| **3. POW-input chapter + publish** | User Training and Adoption (needs ~1 hour with Hannah or dept leads on roles/training reality); final review pass; publish as **v2** | Joint | **Oct 9** |

Total Resin effort is drafting + editing; the only POW time required is one ~1-hour
conversation (Phase 3) and a review pass per phase (async comments in the Google Doc,
1 week per phase).

## What we need from you

1. **Approve or adjust the scope** — if any chapter should be dropped or deprioritized
   (e.g., Future Enhancements could be folded into the annual planning doc instead),
   say so now.
2. **Approve or adjust the dates.**
3. **Name the reviewer** per phase (default: Hannah).
4. Confirm a ~1-hour slot in late September for the User Training chapter input.

No response within a week = approved as proposed, and we start Phase 1.
