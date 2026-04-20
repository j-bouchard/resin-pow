# Protect Our Winters Org Context

> **TODO:** Fill in this file before running /build-issue for the first time.
> Or run /ingest-docs with existing docs to generate this automatically.
> Run /snapshot-org to auto-generate ORG_SCHEMA.md, ORG_AUTOMATION.md,
> ORG_SECURITY.md, and ORG_REPORTS.md — those complement this file.

## Org Overview

- **Client:** Protect Our Winters (POW)
- **Salesforce Edition:** TODO (Enterprise / Professional / Nonprofit)
- **NPSP Installed:** TODO (yes/no + version if known)
- **Production URL:** TODO (e.g. https://pow.my.salesforce.com)
- **Sandbox URL:** TODO
- **Org went live:** TODO

## Installed Packages

- **NPSP** — TODO (version; any known quirks or important config)
- TODO (other packages: Classy, FundraiseUp, Higher Logic, Blackthorn, etc.)

## Naming Conventions

- **Custom Objects:** `ClientName_ObjectName__c` (e.g. `POW_ProjectPhase__c`)
- **Custom Fields:** `Context_FieldName__c`
- **Flows:** `ObjectName_TriggerType_Description` (e.g. `Contact_AfterUpdate_SyncMembership`)
- **Apex Classes:** `PascalCase`, trigger handlers suffixed with `TriggerHandler`
- **Permission Sets:** `Role_FunctionalArea` (e.g. `Admin_FullAccess`)

## Key Objects & Purpose

TODO: Document the core objects this org uses and what they represent.

| Object | Purpose | Notes |
|--------|---------|-------|
| Contact | TODO | |
| Account | TODO | |
| Opportunity | TODO | |
| Campaign | TODO | |

## Key Contacts

TODO: Client staff and their roles. Helps Claude understand who uses what and
what language to use in PR descriptions and comments.

| Name | Role | Notes |
|------|------|-------|
| TODO | TODO | TODO |

## Integrations

TODO: List all third-party integrations (payment processor, email platform, etc.)

| System | Direction | Objects Affected | Sync Frequency | Notes |
|--------|-----------|-----------------|----------------|-------|
| TODO | | | | |

## Automation Constraints

TODO: Things Claude must not touch or must be careful around — NPSP-owned
fields, package-managed automation, fragile triggers, etc.

- TODO

## Things That Break

TODO: Past incidents, known bugs, integration edge cases that have caused
problems. These are the most valuable things to document — don't leave blank.

- TODO

## Data Retention & Compliance

TODO: Data retention requirements, GDPR/CCPA obligations, PII fields.

- TODO

## Org Health Notes

TODO: Known technical debt, customizations to avoid touching, etc.

- TODO
