# Resin AI Pipeline — Product Requirements Document v2

## Autonomous Salesforce Consulting via Claude Code

**Author:** Joe Bouchard, Resin LLC
**Version:** 4.0
**Date:** April 15, 2026
**Status:** Draft — Ready for Claude Code Implementation

---

## 1. What This Is

Resin LLC is a boutique Salesforce consulting firm serving ~8 environmental nonprofits. Today, Joe handles client conversations, extracts requirements, tracks tasks, manages contractors, and builds or reviews Salesforce work. This pipeline replaces the entire middle layer with Claude Code — reducing Joe's role to two activities: **client conversations** and **approving pull requests**.

### The Pipeline

```
Client conversations (calls, email, Slack)
        ↓
[INTAKE] — Extracts requirements → ClickUp tasks
        ↓
[ORG SNAPSHOT] — Queries org → generates living documentation
        ↓
Joe reviews tasks in ClickUp → moves to "Ready to Build"
        ↓
[BUILD] — Reads ClickUp task + org manual → builds in sandbox → opens GitHub PR
        ↓
Joe reviews the PR diff on GitHub → merges or requests changes
        ↓
[DEPLOY] — On PR merge → deploys to production → updates ClickUp + org manual
```

### Design Principles

- **ClickUp for humans, GitHub for code.** Joe and Kayla manage work in ClickUp. GitHub holds the SFDX project, PRs, and deployment history. The pipeline bridges the two — you never need to create GitHub Issues or manage a GitHub Projects board.
- **Cloud-autonomous, locally-testable.** Every routine prompt works identically as a local Claude Code session or a cloud routine. Build and test locally first, then flip to cloud when ready.
- **Org manual before anything else.** Claude can't build reliably in an org it doesn't understand. The generated org documentation is the foundation everything else depends on.
- **Sandbox always, production never direct.** Claude writes metadata and deploys to sandbox. Production only happens through merged PRs.

---

## 2. System Architecture

### 2.1 Technology Stack

| Component | Technology | Notes |
|-----------|-----------|-------|
| Orchestration | Claude Code (local sessions → cloud routines) | Cloud routines for autonomy once stable |
| Salesforce (local) | SF DX MCP Server (`@salesforce/mcp`) | 60+ structured tools, local only |
| Salesforce (cloud) | SF CLI via bash | `sf` commands in routine cloud environment |
| Source control | GitHub (1 repo per client org) | SFDX projects, PRs, code review, deployment |
| Task management | ClickUp (existing workspace) | Human-facing tasks, client visibility, Kayla's workflow |
| Communication | Slack (notifications) + Gmail (intake) | Via connectors in routines |
| Transcription | TBD (Fireflies recommended) | Webhook → routine API endpoint |
| Claude plan | Max (15 routines/day) | Sufficient for multi-org; overage available |

### 2.2 Why Two Salesforce Interfaces

**Local (SF DX MCP):** The official Salesforce DX MCP Server provides 60+ structured tools — `deploy_metadata`, `retrieve_metadata`, SOQL queries, Apex test running, code analysis, and more. It returns structured data Claude can reason about cleanly. It requires the Salesforce CLI installed locally and uses encrypted auth files on your machine. Use this during development and testing.

**Cloud (SF CLI via bash):** Cloud routines can't run local MCP servers. Instead, the routine's setup script installs SF CLI, authenticates via OAuth Client Credentials (non-interactive), and Claude runs `sf` commands through bash. Less structured than MCP, but fully functional for deploying metadata, running tests, and querying orgs. The org manual (committed to the repo) compensates for the lack of structured querying — Claude reads the docs instead of querying live.

**The transition:** Start building and testing with local SF DX MCP. Once the workflow is solid, copy the same prompts into cloud routines. The org manual ensures Claude has the same context in both environments.

### 2.3 Multi-Org Architecture

Each client org gets:
- A dedicated GitHub repository (`resin-llc/resin-{client-slug}`)
- A sandbox for Claude to build against
- Org-specific credentials (GitHub secrets for cloud, local SF CLI auth for local)
- A generated org manual in the repo that Claude reads before every build
- A ClickUp Space/List (existing) where Joe manages tasks and Kayla has visibility

### 2.4 Repository Structure (Per Client)

```
resin-{client-slug}/
├── .claude/
│   ├── CLAUDE.md                        # Project instructions for Claude Code
│   ├── settings.json                    # Permissions, model preferences
│   └── commands/
│       ├── snapshot-org.md              # /snapshot-org — regenerate org manual
│       ├── build-issue.md               # /build-issue — build from a GitHub issue
│       ├── validate-sandbox.md          # /validate-sandbox — check sandbox state
│       └── deploy-prod.md              # /deploy-prod — deploy merged PR to prod
├── .github/
│   └── workflows/
│       ├── notify-pr.yml               # Slack notification when PR opens
│       └── post-merge-snapshot.yml     # Trigger org snapshot after merge
├── force-app/
│   └── main/
│       └── default/
│           ├── classes/                 # Apex classes + test classes
│           ├── triggers/                # Apex triggers
│           ├── flows/                   # Flow metadata XML
│           ├── objects/                 # Custom objects, fields, record types
│           ├── layouts/                 # Page layouts
│           ├── reports/                 # Report metadata
│           ├── dashboards/              # Dashboard metadata
│           ├── permissionsets/           # Permission sets
│           └── lwc/                     # Lightning Web Components (if needed)
├── knowledge/
│   ├── org-context.md                   # Manual org context (integrations,
│   │                                    # contacts, conventions, constraints)
│   ├── ORG_SCHEMA.md                    # AUTO-GENERATED: objects + fields
│   ├── ORG_AUTOMATION.md                # AUTO-GENERATED: flows + apex + rules
│   ├── ORG_SECURITY.md                  # AUTO-GENERATED: profiles + perms
│   ├── ORG_REPORTS.md                   # AUTO-GENERATED: reports + dashboards
│   └── decisions/                       # Architecture decision records
│       └── ADR-001-example.md
├── sfdx-project.json
├── package.xml
└── README.md
```

---

## 3. Foundation: The Org Snapshot

**Build this first. Everything else depends on it.**

The org snapshot is a Claude Code command (`/snapshot-org`) that queries a Salesforce org and generates comprehensive documentation. This is what allows Claude to build reliably — it knows what objects exist, what fields are on them, what automation is already running, and what security model is in place.

### 3.1 What Gets Generated

**ORG_SCHEMA.md** — The data model.
```markdown
# POW Org Schema
Generated: 2026-04-15T14:30:00Z | Org: 00D...

## Contact
Standard object | Record Types: Default, Board Member, Volunteer

### Custom Fields
| API Name | Label | Type | Description |
|----------|-------|------|-------------|
| Donor_Tier__c | Donor Tier | Picklist | Friend, Supporter, Partner, Champion |
| Total_Lifetime_Giving__c | Total Lifetime Giving | Currency | NPSP rollup |
| Engagement_Score__c | Engagement Score | Number | Higher Logic sync |
...

## Opportunity
Standard object (used as Donations) | Record Types: Donation, Grant, In-Kind
...
```

**ORG_AUTOMATION.md** — Everything that runs automatically.
```markdown
# POW Org Automation
Generated: 2026-04-15T14:30:00Z

## Active Flows
| Name | Type | Object | Description |
|------|------|--------|-------------|
| Donor_Welcome_Email | Record-Triggered | Opportunity | Fires on Closed Won... |
| Lapsed_Donor_Alert | Scheduled | Contact | Runs daily, checks... |
...

## Apex Classes (18 total)
| Name | Lines | Test Coverage | Description |
|------|-------|--------------|-------------|
| DonorTierHandler | 142 | 89% | Calculates tier from giving... |
...

## Apex Triggers (4 total)
...

## Validation Rules (12 total)
...
```

**ORG_SECURITY.md** — Who can see and do what.
```markdown
# POW Org Security
Generated: 2026-04-15T14:30:00Z

## Permission Sets (8 total)
| Name | Assigned To | Key Permissions |
|------|------------|-----------------|
| Development_Director | Sarah M. | Edit Opportunities, Run Reports... |
...

## Field-Level Security Summary
| Object.Field | System Admin | Development Director | Program Staff |
|--------------|-------------|---------------------|---------------|
| Contact.Donor_Tier__c | Read/Write | Read/Write | Read Only |
...
```

**ORG_REPORTS.md** — Existing reporting landscape.
```markdown
# POW Reports & Dashboards
Generated: 2026-04-15T14:30:00Z

## Report Folders
- Development Team Reports (12 reports)
- Executive Dashboard Reports (6 reports)
- Event Reports (4 reports)

## Key Reports
| Name | Folder | Type | Description |
|------|--------|------|-------------|
| LYBUNT Donors | Development Team | Contact | Last year but not this year... |
...
```

### 3.2 SOQL Queries for Org Discovery

The snapshot command runs these queries via SF DX MCP (local) or `sf data query` (cloud). The approach is **filter first, then drill in** — query the object index to find what's customized, then only pull field details for objects that have custom fields or record types. This avoids unnecessary API calls and keeps the snapshot fast even on large orgs.

**Step 1: Identify which objects to document**
```sql
-- Objects that have custom fields (worth documenting)
SELECT EntityDefinition.QualifiedApiName, COUNT(Id) CustomFieldCount
FROM FieldDefinition
WHERE IsCustom = true
AND EntityDefinition.IsCustomizable = true
GROUP BY EntityDefinition.QualifiedApiName
ORDER BY EntityDefinition.QualifiedApiName

-- Always include these key NPSP objects even if they have zero custom fields:
-- Contact, Account, Opportunity, Campaign, Lead,
-- npe03__Recurring_Donation__c, npsp__General_Accounting_Unit__c,
-- npe01__OppPayment__c, npe5__Affiliation__c
```

**Step 2: Pull field details only for identified objects**
```sql
-- Custom fields per object (run ONLY for objects from Step 1)
SELECT QualifiedApiName, Label, DataType, Description,
       InlineHelpText, IsRequired
FROM FieldDefinition
WHERE EntityDefinition.QualifiedApiName = '{object_name}'
AND IsCustom = true
ORDER BY QualifiedApiName

-- Picklist values (run only for Picklist/MultiselectPicklist fields)
SELECT Value, Label, IsActive
FROM PicklistValueInfo
WHERE EntityParticle.EntityDefinition.QualifiedApiName = '{object}'
  AND EntityParticle.QualifiedApiName = '{field}'
  AND IsActive = true

-- Record types (single query covers all objects)
SELECT DeveloperName, Name, Description, IsActive, SobjectType
FROM RecordType
WHERE IsActive = true
ORDER BY SobjectType, Name
```

**Step 3: Query automation**
```sql
-- Active Flows
SELECT DeveloperName, ActiveVersionId, Description,
       ProcessType, TriggerType, TriggerObjectOrEventLabel
FROM FlowDefinition
WHERE ActiveVersionId != null
ORDER BY DeveloperName

-- NPSP Trigger Handlers (critical — these fire alongside custom automation)
SELECT npsp__Object__c, npsp__Class__c, npsp__Load_Order__c,
       npsp__Active__c, npsp__Asynchronous__c
FROM npsp__Trigger_Handler__c
WHERE npsp__Active__c = true
ORDER BY npsp__Object__c, npsp__Load_Order__c

-- Apex Classes (Tooling API — excludes managed package classes)
SELECT Name, Status, LengthWithoutComments
FROM ApexClass
WHERE NamespacePrefix = null
ORDER BY Name

-- Apex Triggers (Tooling API)
SELECT Name, TableEnumOrId, Status
FROM ApexTrigger
WHERE NamespacePrefix = null
ORDER BY Name

-- Active Validation Rules (Tooling API)
SELECT FullName, Metadata
FROM ValidationRule
WHERE Metadata.active = true
```

**Step 4: Query security**
```sql
-- Custom Permission Sets (excludes NPSP/package sets)
SELECT Name, Label, Description
FROM PermissionSet
WHERE IsCustom = true AND IsOwnedByProfile = false
ORDER BY Name

-- Profiles
SELECT Name FROM Profile WHERE UserType = 'Standard' ORDER BY Name
```

**Step 5: Query reports & dashboards**
```sql
-- Reports (excludes deleted)
SELECT Name, DeveloperName, FolderName, Description, Format
FROM Report
WHERE IsDeleted = false
ORDER BY FolderName, Name

-- Dashboards
SELECT Title, DeveloperName, FolderName, Description
FROM Dashboard
WHERE IsDeleted = false
ORDER BY FolderName, Title
```

**API call budget:** For a typical nonprofit org with 30-40 custom objects, this uses roughly 50-80 API calls total — well under the 100,000/day limit on Enterprise Edition.

### 3.3 When the Snapshot Runs

- **On initial setup** — baseline documentation for each client org
- **After every production deployment** — the post-merge GitHub Action triggers it
- **On demand** — run `/snapshot-org` anytime to refresh
- **Weekly scheduled** — catch any direct org changes made outside the pipeline

### 3.4 The Manual Org Context File

The auto-generated files cover *what exists*. The manual `org-context.md` covers *why things are the way they are* and *what Claude should know* that isn't queryable.

**Seeding from existing documentation:** Most client orgs already have partial documentation — Google Drive specs, ClickUp task descriptions from past builds, Slack threads explaining decisions, project scoping docs, even Joe's own notes. Before writing `org-context.md` from scratch, feed Claude whatever exists and let it extract the qualitative layer:

- Requirements docs from past projects (e.g., the TDLT Donor Moves Management spec, the Bears Ears sandbox build scope)
- Integration setup notes (what syncs where, known quirks, field mappings)
- Client call notes or transcripts that mention "don't touch X" or "we tried Y and it broke"
- Monthly reports (contain recent change history and context)
- ClickUp task descriptions from completed work (contain implementation details)

Claude reads these and generates a structured `org-context.md` that captures institutional knowledge that would otherwise live only in Joe's head. The `/ingest-docs` command handles this (see commands).

**Template for `org-context.md`:**
```markdown
# {Client Name} — Org Context

## Org Details
- Org ID: {18-char ID}
- Edition: Nonprofit Enterprise Edition
- NPSP Version: 3.x
- Sandbox Name: {name}
- Production URL: https://{domain}.my.salesforce.com

## Installed Packages
- NPSP (Nonprofit Success Pack) — core donation management
- {Other: Classy, Blackthorn, FundraiseUp, Higher Logic, etc.}

## Key Integrations
- {Name}: {direction, frequency, what it syncs, known quirks}

## Key Contacts
- {Name}: {Role} — {what they care about, communication style}

## Naming Conventions
- Custom fields: no namespace prefix, descriptive names
- Flows: {Pattern, e.g., Object_Action_Description}
- Apex: {Pattern, e.g., trigger handler pattern, test data factory}

## Known Constraints & Tech Debt
- {Anything Claude should avoid or be aware of}

## Things That Break
- {Known fragile automation, integration edge cases, etc.}
```

---

## 4. Pipeline Stages

### 4.1 Stage 1: INTAKE (Requirements Extraction)

**Trigger:** Webhook from transcription tool → routine API endpoint. Or manually by Joe posting a transcript/email.

**What it does:**
1. Receives a client conversation (transcript, email thread, or Slack thread)
2. Identifies the client org from context
3. Extracts structured Salesforce requirements
4. Creates ClickUp tasks in the client's Space/List with structured specs
5. Tags tasks by type and complexity
6. Posts a Slack summary

**ClickUp Task Structure (created by the intake routine):**

Task fields:
- **Title:** Action-oriented requirement name
- **Description:** Structured spec (see template below)
- **Status:** "Requirements Review" (Joe reviews before build)
- **Custom Fields:**
  - `Requirement Type`: declarative | flow | apex | report | dashboard | integration
  - `Complexity`: S | M | L | XL
  - `Priority`: P0 | P1 | P2
  - `GitHub PR`: URL (populated later by BUILD routine)
  - `Deployment ID`: text (populated later by DEPLOY routine)
- **Tags:** type label, complexity label, `needs-clarification` if applicable

Task description template:
```markdown
## Requirement: {Title}

**Type:** {type}
**Complexity:** {complexity}
**Priority:** {priority}

### Description
{What needs to be built, in Salesforce terms}

### Acceptance Criteria
- [ ] {Criterion 1}
- [ ] {Criterion 2}

### Dependencies
- {Other tasks this depends on, or "None"}

### Open Questions
- {Anything ambiguous that Joe should clarify with client}

### Source
{Link to transcript/email/conversation}
```

**Prompt (for routine or local session):**

```
You are a senior Salesforce consultant specializing in nonprofit orgs (NPSP/
Nonprofit Cloud). You work for Resin LLC serving environmental nonprofits.

You have received a client conversation. Your job:

1. IDENTIFY which client org this relates to from the conversation context.
   Clients: POW, People for Bikes, Evergreen, TDLT, RE Sources, Bears Ears, BYLT.

2. EXTRACT all Salesforce-related requirements. Distinguish between:
   - EXPLICIT: "We need a field for donor tier"
   - IMPLICIT: "We want to better track major donors" → implies fields,
     automation, possibly reports
   - QUESTIONS: Ambiguous requests needing clarification before building

3. For each requirement, CREATE a ClickUp task in the client's list using
   the structured template. Include:
   - Clear title (action-oriented)
   - Type, complexity, and priority in custom fields
   - Detailed description with acceptance criteria
   - Dependencies on other requirements
   - Open questions (if any)
   - Set status to "Requirements Review"

4. If there are open questions, tag the task "needs-clarification" so
   Joe knows to follow up with the client before building.

5. Post a summary to Slack #resin-pipeline:
   "[CLIENT] {N} new tasks created from {source}. {M} need clarification."

CONTEXT:
- These are nonprofit orgs using NPSP. Opportunities = Donations.
- Common integrations: Classy/GoFundMe Pro, Engaging Networks, Higher Logic,
  Blackthorn, FundraiseUp, CiviClick, EveryAction, Zapier
- Read the client's org-context.md before extracting requirements to understand
  their specific setup, naming conventions, and constraints.
```

### 4.2 Stage 2: BUILD (Salesforce Development)

**Trigger:** Joe moves a ClickUp task to "Ready to Build" status. For cloud routines: scheduled nightly scan for tasks in that status, or API trigger.

**What it does:**
1. Reads the ClickUp task description (the requirement spec) and any linked/dependent tasks
2. Reads the org manual (`ORG_SCHEMA.md`, `ORG_AUTOMATION.md`, `ORG_SECURITY.md`, `org-context.md`)
3. Plans the implementation
4. Writes metadata files to the SFDX project
5. Deploys to sandbox and validates
6. Runs Apex tests
7. Commits to a feature branch and opens a PR
8. Posts the PR link back to the ClickUp task as a comment
9. Moves the ClickUp task status to "In Review"

**Prompt (for routine or local session):**

```
You are a senior Salesforce developer and admin for Resin LLC, specializing in
nonprofit Salesforce orgs (NPSP/Nonprofit Cloud).

BEFORE BUILDING ANYTHING:
1. Read knowledge/org-context.md — understand the org's setup, conventions,
   integrations, and constraints.
2. Read knowledge/ORG_SCHEMA.md — understand what objects and fields exist.
3. Read knowledge/ORG_AUTOMATION.md — understand what automation already runs
   so you don't create conflicts.
4. Read knowledge/ORG_SECURITY.md — understand permission sets and FLS so
   you set security correctly on new components.

YOUR TASK:
Read the ClickUp task assigned to you (status: "Ready to Build"). Build the
requested Salesforce configuration/code.

WORKFLOW:
1. Read the ClickUp task description for the full requirement spec
2. Create a feature branch: claude/task-{clickup-id}-{short-description}
3. Write all metadata to force-app/main/default/ following SFDX structure
4. Deploy to the client's sandbox:
   - Local: use SF DX MCP deploy_metadata tool
   - Cloud: run `sf project deploy start --target-org {sandbox-alias}`
5. Run Apex tests:
   - Local: use SF DX MCP run_apex_tests tool
   - Cloud: run `sf apex run test --target-org {sandbox-alias} --wait 10`
6. If deploy or tests fail, fix and retry (up to 3 attempts)
7. Open a Pull Request with:
   - Title: "[{CLIENT}] {ClickUp task title}"
   - Body containing:
     - Summary of what was built and why
     - List of all metadata components created/modified
     - Test results (pass/fail, coverage %)
     - Any manual steps needed post-deploy (if applicable)
     - Any assumptions made
     - Link to the ClickUp task
8. Post the PR link as a comment on the ClickUp task
9. Move the ClickUp task status to "In Review"

BUILD STANDARDS:
- Declarative first. Flows over Apex for automation. Apex only when Flow
  limitations require it (batch processing, complex integrations, recursive
  logic, performance-critical high-volume triggers). If you choose Apex over
  Flow, document WHY in the PR description.
- Flows (default for automation):
  - Simple Flows (record-triggered with a few actions, scheduled with basic
    criteria): generate Flow metadata XML directly.
  - Complex Flows (multi-branch, loops, subflows, many decision elements):
    these are built by Joe in Flow Builder manually. Claude retrieves the
    metadata with `sf project retrieve start`, commits it to the repo, and
    handles deployment and version control. Do NOT attempt to generate
    complex Flow XML from scratch.
  - All Flows: use subflows for reusable logic, add fault paths on every DML
    element, use custom labels for hardcoded values or thresholds.
  - Screen Flows are the right choice for user-facing interactive processes
    (guided data entry, intake forms, multi-step wizards).
- NPSP conflict check (CRITICAL — all client orgs run NPSP):
  - Before creating ANY automation on Contact, Account, Opportunity, or
    Campaign, check ORG_AUTOMATION.md for NPSP trigger handlers on that
    object. NPSP uses TDTM (Table-Driven Trigger Management) and its
    handlers fire alongside custom automation.
  - Never update fields that NPSP rollups write to (e.g., npe01__* fields,
    npsp__* rollup fields). Your automation will conflict with NPSP's
    recalculations.
  - Document any potential NPSP interaction in the PR description.
- Apex (only when Flows can't do it):
  - Bulkified, trigger handler pattern, no logic in triggers.
  - Separate TestDataFactory class for all test data.
  - Minimum 85% coverage with meaningful assertions (not just coverage).
- Fields: Always populate Description and Help Text. Set FLS on all relevant
  permission sets (check ORG_SECURITY.md for which ones).
- Page layouts: Organize logically with sections. Match existing layout
  patterns in the org.
- Reports: Place in appropriate folder (check ORG_REPORTS.md). Include
  meaningful description.
- Naming: Follow conventions in org-context.md. Default to descriptive
  names with __c suffix, no namespace prefix.

SAFETY RULES:
- NEVER modify production directly. Sandbox only.
- NEVER delete metadata unless the ClickUp task explicitly requests it and is
  tagged "destructive-change."
- NEVER insert, update, or delete records. Metadata only.
- If org-wide test coverage would drop below 75%, stop and report.
- If you're unsure about something, add it as a comment on the ClickUp task
  rather than guessing.

ERROR HANDLING:
- If a deploy fails, classify the error before retrying:
  - SELF-FIXABLE (missing field reference, syntax error, wrong API name):
    fix and retry, up to 3 attempts.
  - MANAGED PACKAGE CONFLICT (error references npsp__, npe01__, npe03__,
    or any managed namespace): STOP. Do not retry. Escalate to Joe via
    ClickUp comment with the full error.
  - TEST FAILURE: check whether the failing test is yours or pre-existing.
    Run tests BEFORE your changes to establish a baseline. Only fix tests
    you wrote.
```

### 4.3 Stage 3: DEPLOY (Production Deployment)

**Trigger:** PR merge to `main` branch. For cloud routines: GitHub trigger on `pull_request.closed` with `merged: true`. For local: run `/deploy-prod` after merging.

**What it does:**
1. Reads the merged PR to understand what's being deployed
2. Runs a check-only deployment (validation) against production
3. If validation passes, runs the full deployment with tests
4. Verifies deployment succeeded
5. Triggers an org snapshot refresh (updates the org manual)
6. Posts deployment confirmation to Slack

**Prompt:**

```
You are a Salesforce deployment specialist for Resin LLC.

A pull request has been merged to main. Deploy the changes to production.

WORKFLOW:
1. Read the PR description to understand what's being deployed.

2. Run a validate-only deployment first:
   - Local: use SF DX MCP deploy_metadata with checkOnly flag
   - Cloud: `sf project deploy start --target-org {prod-alias} --dry-run`

3. If validation passes, run the full deployment:
   - Local: use SF DX MCP deploy_metadata
   - Cloud: `sf project deploy start --target-org {prod-alias} --test-level RunLocalTests`

4. Verify deployment:
   - Confirm status is "Succeeded"
   - Check test results — all must pass

5. Post-deployment:
   - Run /snapshot-org to update the org manual with new state
   - Commit updated org manual files to main
   - Move the linked ClickUp task status to "Complete"
   - Add a comment to the ClickUp task with deployment ID, timestamp,
     and component list
   - Post to Slack: "[CLIENT] Deployed: {PR title} — {component count} components"

6. If deployment FAILS:
   - Do NOT retry automatically
   - Move the ClickUp task status to "Deploy Failed"
   - Add error details as a comment on the ClickUp task
   - Post error details to Slack with full error messages
   - Add a comment to the merged PR with failure details
   - Joe investigates and re-triggers manually

SAFETY:
- NEVER deploy destructive changes (deletions) unless the PR description
  contains "DESTRUCTIVE: [component list]" and the ClickUp task was tagged
  "destructive-change"
- ALWAYS run tests as part of deployment
- If test coverage drops below 75%, halt and notify
- ROLLBACK: If a deployed change causes issues after the fact, run
  `git revert <merge-commit>` on main and redeploy the reverted state
```

---

## 5. Cloud Routine Configuration

### 5.1 Cloud Environment Setup

Each routine needs a cloud environment configured at `claude.ai/code/routines`:

**Setup Script** (runs before every routine execution):
```bash
# Install Salesforce CLI
npm install -g @salesforce/cli

# Authenticate to sandbox (Client Credentials flow)
sf org login client-credentials \
  --client-id "$SF_CLIENT_ID" \
  --client-secret "$SF_CLIENT_SECRET" \
  --instance-url "$SF_INSTANCE_URL" \
  --alias sandbox

# Authenticate to production
sf org login client-credentials \
  --client-id "$SF_PROD_CLIENT_ID" \
  --client-secret "$SF_PROD_CLIENT_SECRET" \
  --instance-url "$SF_PROD_INSTANCE_URL" \
  --alias production
```

**Environment Variables** (per client, stored in routine config):
```
SF_CLIENT_ID=<sandbox connected app client id>
SF_CLIENT_SECRET=<sandbox connected app client secret>
SF_INSTANCE_URL=https://<domain>.sandbox.my.salesforce.com
SF_PROD_CLIENT_ID=<production connected app client id>
SF_PROD_CLIENT_SECRET=<production connected app client secret>
SF_PROD_INSTANCE_URL=https://<domain>.my.salesforce.com
```

### 5.2 Salesforce Connected App Setup (Per Client Org)

Required for cloud routines to authenticate without interactive login.

**In each sandbox and production org:**
1. Setup → App Manager → New Connected App
2. Name: "Resin AI Pipeline"
3. Enable OAuth Settings
4. Callback URL: `https://localhost:1717/OauthRedirect`
5. Scopes: `api`, `refresh_token`, `sfap_api`
6. Enable Client Credentials Flow
7. Assign a Run-As User:
   - Create a dedicated integration user: `resin-pipeline@{client}.org`
   - Assign System Administrator profile (or a custom profile with full metadata access)
   - This user appears in the audit trail for all pipeline changes
8. Under "Manage" → OAuth Policies: set "Permitted Users" to "Admin approved users are pre-authorized"
9. Add the Run-As User to the Connected App's authorized users

### 5.3 Local SF DX MCP Configuration

For local Claude Code sessions, add to `.mcp.json` in each client repo:

```json
{
  "mcpServers": {
    "salesforce": {
      "command": "npx",
      "args": [
        "-y", "@salesforce/mcp",
        "--orgs", "sandbox,production",
        "--toolsets", "orgs,metadata,data,users",
        "--tools", "run_apex_tests",
        "--allow-non-ga-tools"
      ]
    }
  }
}
```

Authenticate locally first:
```bash
sf org login web --alias sandbox --instance-url https://test.salesforce.com
sf org login web --alias production --instance-url https://login.salesforce.com
```

---

## 6. CLAUDE.md (Per Client Repo)

This file is read automatically by Claude Code at session start:

```markdown
# Resin AI Pipeline — {Client Name}

## About This Repo
This is the Salesforce DX project for {Client Name}'s org, managed by Resin LLC.
All Salesforce changes go through this repo: Issue → PR → Merge → Deploy.

## Before You Build Anything
1. Read `knowledge/org-context.md` — org setup, integrations, constraints
2. Read `knowledge/ORG_SCHEMA.md` — current objects and fields
3. Read `knowledge/ORG_AUTOMATION.md` — current Flows, Apex, validation rules
4. Read `knowledge/ORG_SECURITY.md` — permission sets and FLS
5. Read `knowledge/ORG_REPORTS.md` — existing reports and dashboards

These files are auto-generated by the /snapshot-org command and reflect the
current state of the org. If something seems wrong, run /snapshot-org to refresh.

## Build Standards
- Declarative first. Flows over Apex for automation unless Flow limitations require code.
- Flows: default for all automation. Simple Flows → generate metadata directly.
  Complex Flows → build in sandbox UI, then retrieve metadata.
  Always add fault paths on DML, use subflows for reuse, custom labels for constants.
- Apex: only when Flows can't handle it (batch, complex integrations, recursion).
  Trigger handler pattern, bulkified, 85%+ coverage, TestDataFactory class.
  Document in the PR why Apex was chosen over Flow.
- Fields: always set Description, Help Text, and FLS.
- Follow naming conventions in org-context.md.

## Branch Rules
- Feature branches: `claude/task-{clickup-id}-{description}`
- PRs target `main`. Main always reflects production state.
- Never push directly to main.
- Always link PRs back to the ClickUp task by posting the PR URL as a comment.

## Deployment
- Sandbox: deploy freely for testing.
- Production: only through merged PRs via /deploy-prod.
- Never delete metadata unless issue is tagged "destructive-change."

## This Is a Nonprofit Org
- Uses NPSP (Nonprofit Success Pack)
- Opportunities = Donations (not sales pipeline)
- Contacts = Donors, volunteers, board members
- Campaigns = Events, appeals, programs
- Think fundraising, not sales. Language matters.
```

---

## 7. ClickUp & GitHub Configuration

### 7.1 ClickUp Task Statuses (Pipeline-Aware)

Update each client's ClickUp List to include these statuses:

```
Requirements Review → Ready to Build → Building → In Review → Deploying → Complete
                 ↘ Needs Clarification                           ↘ Deploy Failed
```

### 7.2 ClickUp Custom Fields

Add these custom fields to pipeline tasks (can be added at Space or List level):

| Field | Type | Values |
|-------|------|--------|
| Requirement Type | Dropdown | declarative, flow, apex, report, dashboard, integration |
| Complexity | Dropdown | S, M, L, XL |
| GitHub PR | URL | Auto-populated by BUILD routine |
| Deployment ID | Short Text | Auto-populated by DEPLOY routine |
| Source | URL | Link to transcript/email/conversation |

### 7.3 Slack Notifications

GitHub Action (`.github/workflows/notify-pr.yml`):
```yaml
name: Notify Slack on PR
on:
  pull_request:
    types: [opened, ready_for_review]
jobs:
  notify:
    runs-on: ubuntu-latest
    steps:
      - uses: slackapi/slack-github-action@v2
        with:
          webhook: ${{ secrets.SLACK_WEBHOOK_URL }}
          payload: |
            {
              "text": "🔧 *${{ github.repository }}* — PR ready for review\n*${{ github.event.pull_request.title }}*\n${{ github.event.pull_request.html_url }}"
            }
```

### 7.4 How the Two Systems Stay in Sync

| Event | ClickUp | GitHub |
|-------|---------|--------|
| New requirement extracted | Task created in "Requirements Review" | Nothing |
| Joe approves requirement | Joe moves task to "Ready to Build" | Nothing |
| BUILD routine starts | Task moves to "Building" | Feature branch created |
| Build completes | Task moves to "In Review," PR link added as comment | PR opened |
| Joe approves build | Nothing (Joe acts on GitHub) | Joe merges PR |
| Deploy succeeds | Task moves to "Complete," deployment details added | Org manual updated on main |
| Deploy fails | Task moves to "Deploy Failed," error details added | Error comment on PR |

Joe's daily workflow: **check ClickUp** for task status, **check GitHub** only when a PR needs review (Slack notifies you). You never create anything in GitHub directly.

---

## 8. Client Org Registry

| Client | Slug | Sandbox | Org Edition | Priority |
|--------|------|---------|-------------|----------|
| Protect Our Winters | `pow` | Yes | Nonprofit Enterprise | High (pilot) |
| Bears Ears Partnership | `bears-ears` | Yes | Nonprofit Enterprise | High (pilot) |
| People for Bikes | `pfb` | Yes | Nonprofit Enterprise | Medium |
| Evergreen Collaborative | `evergreen` | Yes | Nonprofit Enterprise | Medium |
| Truckee Donner Land Trust | `tdlt` | Yes | Nonprofit Enterprise | Medium |
| RE Sources | `resources` | Yes | Nonprofit Enterprise | Medium |
| Bear Yuba Land Trust | `bylt` | Yes | Nonprofit Enterprise | Low |

---

## 9. Implementation Phases

### Phase 0: Repository & ClickUp Setup (Days 1-2)

- [ ] Create GitHub repos for POW and Bears Ears (`resin-llc/resin-pow`, `resin-llc/resin-bears-ears`)
- [ ] Initialize SFDX project structure in each repo
- [ ] Authenticate SF CLI to both sandboxes and production orgs locally
- [ ] Pull baseline metadata from production into each repo (`sf project retrieve start`)
- [ ] Commit baseline to `main`
- [ ] Add `.claude/CLAUDE.md`, settings, and command stubs
- [ ] Add ClickUp custom fields (Requirement Type, Complexity, GitHub PR, Deployment ID, Source) to POW and Bears Ears lists
- [ ] Add pipeline statuses to ClickUp lists (Requirements Review, Ready to Build, Building, In Review, Deploying, Complete, Needs Clarification, Deploy Failed)
- [ ] Create `#resin-pipeline` Slack channel + webhook
- [ ] Add `.mcp.json` with SF DX MCP configuration

### Phase 1: Org Discovery & Documentation (Days 2-5)

**Step A — Ingest existing documentation:**
- [ ] Gather all existing docs for POW: Google Drive specs, past project scoping docs, ClickUp task descriptions from completed work, monthly reports, integration setup notes
- [ ] Feed them to Claude Code: "Read these documents and generate a comprehensive org-context.md that captures why things exist, integration details, known constraints, key contacts, and institutional knowledge"
- [ ] Review and refine the generated `org-context.md` — add anything Claude missed from your own knowledge of the org
- [ ] Repeat for Bears Ears (the sandbox build scope doc, the FundraiseUp integration notes, Molly and Ana's roles, grant management workflows)

**Step B — Run the automated org snapshot:**
- [ ] Run `/snapshot-org` against POW sandbox — verify SOQL queries work and metadata is captured
- [ ] Review `ORG_SCHEMA.md` — are all custom objects and fields documented? Do picklist values look right?
- [ ] Review `ORG_AUTOMATION.md` — are all Flows, Apex classes, and validation rules captured?
- [ ] Review `ORG_SECURITY.md` and `ORG_REPORTS.md` for completeness
- [ ] Iterate on query coverage if anything is missing
- [ ] Run snapshot against Bears Ears sandbox
- [ ] Commit org manuals to both repos

**The result:** Each repo now has a complete picture — `org-context.md` explains *why* things exist (from ingested docs + Joe's knowledge), and the `ORG_*.md` files document *what* currently exists (from live queries). Claude has everything it needs to build reliably.

### Phase 2: Local BUILD Workflow (Days 4-10)

- [ ] Create a test ClickUp task in the POW list (simple: add a custom field)
- [ ] Move it to "Ready to Build"
- [ ] Run the BUILD prompt as a local Claude Code session
- [ ] Review the PR — did Claude read the org manual? Is the metadata correct?
- [ ] Check that Claude posted the PR link back to the ClickUp task
- [ ] Iterate on the prompt until simple declarative builds are reliable
- [ ] Test progressively complex builds:
  - [ ] Modify a page layout
  - [ ] Create a report and dashboard
  - [ ] Build a simple record-triggered Flow (generate XML directly)
  - [ ] Build a complex Flow (build in sandbox UI → retrieve metadata)
  - [ ] Write an Apex class + trigger + test class (for a case where Apex is appropriate)
  - [ ] Build something that touches multiple metadata types
- [ ] Document failure patterns and add guardrails to the prompt
- [ ] Test the `/deploy-prod` command locally against POW sandbox → production
- [ ] Verify ClickUp task moves to "Complete" after successful deploy

### Phase 3: Cloud Autonomy (Days 10-15)

- [ ] Set up Salesforce Connected Apps (Client Credentials) in POW sandbox + prod
- [ ] Create cloud environment at `claude.ai/code/routines` with setup script
- [ ] Test SF CLI authentication in cloud environment
- [ ] Create INTAKE routine (scheduled daily or API-triggered)
- [ ] Create BUILD routine (API-triggered or scheduled nightly)
- [ ] Create DEPLOY routine (GitHub trigger on PR merge)
- [ ] Test full pipeline end-to-end on POW with a simple issue
- [ ] Monitor for connector bugs, CLI install failures, or auth issues
- [ ] If cloud routines are unstable, fall back to local scheduled tasks

### Phase 4: Scale + Iterate (Days 15+)

- [ ] Onboard Bears Ears to the full pipeline
- [ ] Roll out to remaining client orgs (one at a time)
- [ ] Set up transcription tool webhook → INTAKE routine
- [ ] Add Kayla as a PR reviewer for her client accounts
- [ ] Track quality metrics (deploy success rate, PR approval rate, rework rate)
- [ ] Refine prompts based on real-world patterns
- [ ] Evaluate whether contractor hours can be reduced or eliminated

---

## 10. Known Risks & Mitigations

### High Risk: Flow XML Generation

**Problem:** Salesforce Flow metadata XML is deeply nested, order-sensitive, and poorly documented. There is no API that lets you build a Flow step-by-step programmatically — the Tooling API accepts a complete FlowDefinition payload, so Claude must write the full XML regardless of approach.

**Mitigation (two-track approach):**
- **Simple Flows** (record-triggered, 1-3 nodes, straight-line execution): Claude generates XML directly. Common pitfalls: connector `targetReference` mismatches, incorrect `processType` values, missing `start` element configuration. Test this early in Phase 2 to calibrate what "simple" means in practice.
- **Complex Flows** (multi-branch, loops, screen elements, subflows): Joe builds these manually in Flow Builder. Claude retrieves the metadata with `sf project retrieve start`, commits it to the repo, and handles deployment and version control. The pipeline still adds value (source control, PR review, managed deployment) — it just doesn't generate the Flow autonomously.
- Include working Flow XML examples in `knowledge/templates/` for Claude to reference when generating simple Flows.
- During Phase 2, track which Flow types Claude can generate reliably. This informs the prompt over time.

### Medium Risk: Org State Drift

**Problem:** If someone makes changes directly in the org (you, Kayla, a client admin, an integration), the org manual becomes stale and Claude might build conflicting automation or duplicate fields.

**Mitigation:**
- Run org snapshot weekly and after every deployment
- Make the pipeline the primary change channel — minimize direct org edits
- The snapshot will catch drift within a week; the post-deploy snapshot catches pipeline changes immediately

### Medium Risk: Cloud Routine Stability

**Problem:** Routines launched April 14, 2026. There are known bugs (connector injection failure). The API surface may change.

**Mitigation:**
- Every routine prompt works identically as a local Claude Code session
- If cloud fails, run the same workflow locally with zero changes
- Monitor the Claude Code GitHub issues repo for known bugs
- Don't depend on cloud routines for anything time-critical until they stabilize

### Low Risk: Daily Routine Limits

**Problem:** Max plan allows 15 routines/day. Active work across 7-8 orgs could exceed this.

**Mitigation:**
- Prioritize which orgs get automated builds on busy days
- Batch multiple issues into single routine runs ("Build all ready-to-build issues for POW")
- Use local sessions for overflow
- Upgrade to Team plan (25/day) if needed
- Pay for overages on peak days

---

## 11. Success Metrics

| Metric | Current State | 30-Day Target | 90-Day Target |
|--------|--------------|---------------|---------------|
| Time: request → ClickUp task | 1-24 hrs (manual) | < 30 min | < 5 min (automated intake) |
| Time: approved task → sandbox build | 1-5 days | < 4 hours | < 1 hour |
| Time: PR approval → production | 1-24 hrs | < 30 min | < 15 min |
| Joe's build/admin time per week | 10-20 hrs | 5-8 hrs (review only) | 1-2 hrs |
| Build success rate (first deploy) | N/A | > 70% | > 90% |
| Contractor dependency | Required | Reduced (Kayla for complex) | Optional |

---

## 12. Getting Started

### First Session with Claude Code

```bash
# Navigate to client repo
cd ~/repos/resin-pow

# Start Claude Code
claude

# Step 1: Generate the org manual
> /snapshot-org

# Step 2: Review the generated docs
> Read knowledge/ORG_SCHEMA.md and tell me if anything looks off

# Step 3: Create a test task in ClickUp, move it to "Ready to Build",
# then tell Claude to build it
> Read the ClickUp task "{task name}" in the POW list and build it
> following the standards in CLAUDE.md. Deploy to sandbox and open a PR.
> Post the PR link back to the ClickUp task.
```

### First Cloud Routine

1. Go to `claude.ai/code/routines`
2. Click "New routine"
3. Name: `resin-pow-build`
4. Prompt: paste the BUILD prompt from Section 4.2
5. Repo: select `resin-llc/resin-pow`
6. Environment: select your configured environment with SF CLI setup script
7. Trigger: API (for now — get the endpoint URL and auth token)
8. Click "Run now" to test

### Testing the Full Pipeline

1. Create a ClickUp task in the POW list: "Add a Preferred_Communication__c picklist field to Contact with values Email, Phone, Mail, Text"
2. Set custom fields: Type = declarative, Complexity = S
3. Move the task to "Ready to Build"
4. Trigger the BUILD routine (API call or local session)
5. Check that the PR link was posted to the ClickUp task
6. Review the PR on GitHub
7. Merge the PR
8. Verify the DEPLOY routine fires, pushes to production, and moves the ClickUp task to "Complete"
9. Verify the org snapshot updates with the new field
