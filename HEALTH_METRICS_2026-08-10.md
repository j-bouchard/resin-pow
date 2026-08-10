# POW Production — Data Health Metrics

**Collected:** 2026-08-10 (read-only; REST limits API, recordCount API, and SOQL `COUNT()` queries against the `production` org)

## Collection notes / failures

- The SessionStart auth hook failed twice in this environment: (1) the `sf` CLI resolved to a Node 20 shim whose bundled `undici` crashes (`webidl.util.markAsUncloneable is not a function`), and (2) the hook pipes the access token via stdin, which `sf org login access-token` rejected. Workaround: ran the CLI under `/opt/node22/bin/node` (real Node 22) and passed the client-credentials token via the `SF_ACCESS_TOKEN` env var. Auth to `production` then succeeded (`joe@protectourwinters.org`, org `00D4P000001dRZ9UAM`).
- No queries timed out. All queries completed and returned counts.
- No Mailchimp activity object exists in the org (no MC4SF/Mailchimp package objects; 0 Tasks with "Mailchimp" in the subject). Mailchimp syncs via Cazoomi SyncApps and does not store activity records in Salesforce.

## Storage

| Metric | Max (MB) | Remaining (MB) | Used (MB) | % Used |
|---|---|---|---|---|
| Data Storage | 10,980 | −1,816 | 12,796 | **116.5% — OVER LIMIT** |
| File Storage | 89,716 | 74,766 | 14,950 | 16.7% |

## Record counts (recordCount API, approximate)

| Object | Count |
|---|---|
| Contact | 421,162 |
| Account | 402,673 |
| Opportunity | 259,821 |
| CampaignMember | 991,000 |
| Campaign | 2,196 |
| Task | 3,409,716 |
| Lead | 10,373 |

Largest storage consumers org-wide (for context): TaskRelation 9,083,800 · Task 3,409,716 · DeleteEvent 1,165,700 · CampaignMember 991,000 · EmailMessageRelation 326,400 · OpportunityHistory 307,800.

## Contact quality (exact SOQL counts)

| Metric | Count | % of Contacts |
|---|---|---|
| Opted out of email (`HasOptedOutOfEmail = true`) | 160,914 | 38.2% |
| Incomplete mailing address (street, city, state, or zip null) | 227,248 | 54.0% |
| No mailing address at all (street AND city AND zip null) | 72,237 | 17.2% |
| Name contains "Unknown" | 25,894 | 6.1% |
| Archived (`Archived__c = true`) | 81,850 | 19.4% |
| Alliance Member record type | 602 | 0.1% |
| KnowWho contacts | 30,904 | 7.3% |

KnowWho derivation: no single "KnowWho" record type exists; the org uses six record types prefixed `KW - ` (Member/Officer/Staffer × Record/Former). `RecordType.Name LIKE 'KW %'` → 30,904; cross-check `kw__KnowWhoIdNew__c != null` → 30,904 (exact match).

## Opportunities

| Metric | Count |
|---|---|
| Missing fund designation (`Fund_Designation__c = null`) | 0 |

## Integration / form objects

| Object | Count |
|---|---|
| VisualAntidote__Submission__c (Formstack) | 224,644 |
| VisualAntidote__Form_Submission__c (Formstack) | 178,979 |
| conference360__Event_Registration_Submission__c | 21,687 |
| bt_stripe__Checkout_Submission__c | 20,348 |
| L2_Data__c | 9,599 |
| conference360__Form_Submission__c | 6,496 |
| Mailchimp activity | none — not stored in Salesforce |

## Follow-up: email opt-out investigation

The 38.2% opt-out rate was investigated (all read-only). Summary:

- **Not an active incident.** Opt-out count was stable at 160,914 across the day despite the Cazoomi sync user (`sync@protectourwinters.org`) bulk-touching 45k contacts on 2026-08-10 (81.5k on 08-07, 22.5k on 08-03) — those jobs touch already-opted-out records, they are not flipping flags.
- **Accumulation since 2020.** Opt-out rate by contact creation year: 2020: 42% (83,315 of 196,577) · 2021: 41% · 2022: 33% · 2023: 31% · 2024: 38% · 2025: 21% · 2026: 8%. Classic aging-list churn concentrated in the 2020 migration cohort; unsubscribed contacts are never deleted.
- **Half are archived.** 81,827 of the opt-outs (51%) are `Archived__c = true` — 99.97% of all archived contacts. The weekly `Contact_Archive_Scheduled_Flow` uses opt-out as an archive criterion, so the archive is largely a graveyard of unsubscribes.
- **Active-contact rate is normal-ish:** among non-archived contacts, 79,087 / 339,312 = 23.3% opted out.
- Ruled out: bounce miscoding (only 10 opted-out contacts have a bounce date); record-type skew (160,618 of 160,914 are the plain "Contact" record type).
- Caveat: field history tracking is OFF for `HasOptedOutOfEmail` (0 ContactHistory rows), so historical flip dates cannot be reconstructed.
