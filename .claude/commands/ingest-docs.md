You are a Salesforce org documentation specialist for Resin LLC. Your job is
to read a set of existing documents about a client org and generate a
comprehensive `knowledge/org-context.md` that captures institutional
knowledge — the *why* behind how the org is set up.

## What this command does

The auto-generated ORG_*.md files (from /snapshot-org) capture *what exists*
in the org right now. This command captures *why things exist*, *how the
client works*, and *what Claude needs to know that isn't queryable* — sourced
from existing documentation rather than requiring Joe to write it from scratch.

## Input

Joe will provide one or more of the following (paste inline or provide file
paths to read):

- Google Drive specs or scoping documents from past projects
- ClickUp task descriptions from completed work (contain implementation details)
- Call notes or meeting transcripts that mention org decisions
- Integration setup notes (field mappings, known quirks, sync schedules)
- Monthly reports or status updates referencing recent changes
- Email threads discussing constraints or requirements
- Any other documentation Joe has about this client

Read all provided materials before writing anything.

## What to extract

From the documents, identify and structure:

1. **Org details** — Edition, NPSP version, sandbox/production URLs, org ID
   if mentioned, key dates (e.g., when NPSP was installed, when org went live)

2. **Installed packages** — NPSP and any others (Classy, FundraiseUp, Higher
   Logic, Blackthorn, Engaging Networks, EveryAction, Zapier, etc.) — include
   version if mentioned and any known quirks

3. **Key integrations** — For each: what system, what direction data flows,
   what objects/fields are affected, sync frequency, known issues or edge cases

4. **Key contacts** — Client staff names, roles, and what they care about
   (e.g., "Sarah - Development Director, cares about major donor reporting")
   and Resin contacts who know this org

5. **Naming conventions** — How custom fields, objects, Flows, and Apex are
   named. Extract from any component names mentioned in documents.

6. **Known constraints** — Things that can't be changed, fragile automation,
   fields owned by packages, permission restrictions, data volume concerns

7. **Things that break** — Past incidents, known bugs, automation conflicts,
   integration edge cases that caused problems. These are the most valuable
   things to document.

8. **Architecture decisions** — Why things were built a certain way (Apex
   instead of Flow, custom object instead of using standard, etc.)

## Output

Write `knowledge/org-context.md` using this structure:

```markdown
# Protect Our Winters — Org Context
Last updated: {date}

## Org Details
- **Org ID:** {18-char ID or "TBD"}
- **Edition:** {e.g., Nonprofit Enterprise Edition}
- **NPSP Version:** {e.g., 3.229 or "installed, version TBD"}
- **Production URL:** {https://xxx.my.salesforce.com or "TBD"}
- **Sandbox URL:** {https://xxx.sandbox.my.salesforce.com or "TBD"}
- **Org went live:** {date or "unknown"}

## Installed Packages
- **NPSP** — {version if known}. {Any known quirks or important config.}
- {Other packages} — {purpose and any quirks}

## Key Integrations
### {Integration Name}
- **Direction:** {e.g., Classy → Salesforce}
- **Sync frequency:** {real-time / nightly / manual}
- **Objects affected:** {Contact, Opportunity, Campaign, etc.}
- **Key field mappings:** {if documented}
- **Known issues:** {any edge cases or things to avoid}

## Key Contacts
| Name | Role | Notes |
|------|------|-------|
| {Name} | {Role} | {What they care about, communication style} |

## Naming Conventions
- **Custom objects:** {pattern, e.g., Descriptive_Name__c}
- **Custom fields:** {pattern}
- **Flows:** {pattern, e.g., Object_TriggerType_Description}
- **Apex classes:** {pattern, e.g., PascalCase, TriggerHandler suffix}
- **Permission sets:** {pattern}

## Known Constraints & Tech Debt
- {Constraint or tech debt item}

## Things That Break
- {Known fragile automation, integration edge cases, past incidents}

## Architecture Decisions
- {Why something was built a certain way}
```

Fill in every section from the documents provided. For anything not covered
in the source documents, write "TBD — confirm with Joe" rather than guessing.

## After writing org-context.md

1. Tell Joe which sections have "TBD" items that need his input
2. Suggest running `/snapshot-org` next to generate the auto-documented
   ORG_SCHEMA.md, ORG_AUTOMATION.md, ORG_SECURITY.md, and ORG_REPORTS.md
   files, which will complement this manual context file
3. Commit the file to the repo with message:
   `docs: seed org-context.md from {source description}`
