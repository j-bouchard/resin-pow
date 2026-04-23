# Resin AI Pipeline — External Client App Setup

This guide covers the per-org setup for the Resin AI Pipeline authentication.
Salesforce requires External Client Apps (not legacy Connected Apps) for new
OAuth configurations. Each org needs its own app created in Setup.

## Step 1: Create the External Client App

1. Setup -> **External Client App Manager** -> **New External Client App**
2. Name: `Resin AI Pipeline`
3. Description: `Headless auth for Resin AI Pipeline (Claude Code routines)`
4. Configure OAuth settings:
   - Callback URL: `https://localhost:1717/OauthRedirect`
   - Scopes: **Manage user data via APIs (api)**, **Perform requests at any time (refresh_token)**
5. Enable **Client Credentials Flow**
6. Run As User: your admin user (or a dedicated integration user — see Step 2)
7. Save

## Step 2: Create a Dedicated Integration User (required, not optional)

The pipeline must NOT run as System Administrator. System Admin has Modify
All Data, which means any prompt-injection or malformed command has
unlimited blast radius over donor records. Use a custom profile scoped to
the metadata API surface.

### Create the profile

1. Setup -> Profiles -> clone **Minimum Access - Salesforce** as
   `Resin Pipeline Integration`
2. Grant these system permissions only:
   - API Enabled
   - Apex REST Services
   - Author Apex
   - Customize Application
   - Modify Metadata Through Metadata API Functions
   - Deploy Change Sets
   - Manage Profiles and Permission Sets
   - View Setup and Configuration
   - Run Tests (Apex)
3. Object permissions: Read-only on standard objects. No Create/Edit/Delete
   on Contact, Account, Opportunity, Campaign, Lead, Task, Event, or any
   NPSP object.
4. Do NOT grant: Modify All Data, View All Data, Manage Users, Password
   Never Expires.

### Create the user

1. Setup -> Users -> New User
2. Fill in:
   - First Name: `Resin`
   - Last Name: `Pipeline`
   - Email: `joe@resinllc.com`
   - Username: `resin-pipeline@<slug>.resinllc.com` (substitute the slug from `.resin/client.json`)
   - Profile: `Resin Pipeline Integration`
   - User License: `Salesforce` (or `Salesforce Integration` if licensing allows)
3. Save and activate
4. Go back to the External Client App and set this as the Run As User

### If /snapshot-org fails with permission errors

Add the specific View permission (View All on that object, or field-level
Read) — never upgrade the whole profile back to System Administrator.

## Step 3: Get the Consumer Credentials

1. From the External Client App page, find the **Consumer Key** (Client ID)
2. Copy the **Consumer Secret**
3. Note your instance URL (e.g. `https://<your-domain>.my.salesforce.com`)

## Step 4: Authenticate via CLI

```bash
# Production
sf org login client-credentials \
  --client-id "<SF_PROD_CLIENT_ID>" \
  --client-secret "<SF_PROD_CLIENT_SECRET>" \
  --instance-url "https://<your-prod-domain>.my.salesforce.com" \
  --alias production

# Sandbox
sf org login client-credentials \
  --client-id "<SF_CLIENT_ID>" \
  --client-secret "<SF_CLIENT_SECRET>" \
  --instance-url "https://<your-sandbox-domain>.sandbox.my.salesforce.com" \
  --alias sandbox
```

Verify:
```bash
sf org display --target-org production
sf org display --target-org sandbox
```

## Step 5: Store Credentials for Cloud Routines

Set the following GitHub repository secrets (Settings → Secrets → Actions):

| Secret | Value |
|--------|-------|
| `SF_PROD_CLIENT_ID` | Consumer Key from production org |
| `SF_PROD_CLIENT_SECRET` | Consumer Secret from production org |
| `SF_PROD_INSTANCE_URL` | `https://<prod-domain>.my.salesforce.com` |
| `SF_CLIENT_ID` | Consumer Key from sandbox org |
| `SF_CLIENT_SECRET` | Consumer Secret from sandbox org |
| `SF_INSTANCE_URL` | `https://<sandbox-domain>.sandbox.my.salesforce.com` |
| `SLACK_WEBHOOK_URL` | Slack incoming webhook URL — used ONLY by `.github/workflows/notify-pr.yml` + `post-merge-snapshot.yml` (GitHub Actions, not the cloud routines). |
| `SLACK_CHANNEL_ID` | Slack channel ID — used by cloud routines via the Slack MCP connector. See CLIENT_ONBOARDING.md §5. |
| `CLICKUP_LIST_ID` | ClickUp list ID for this client's tasks. |

ClickUp auth is handled by the ClickUp MCP connector attached to the cloud-routine
environment — there is no `CLICKUP_API_KEY` GitHub secret.

## Repeat for Each Org

Create the same External Client App in both the sandbox and production orgs.
Each org generates its own unique Consumer Key/Secret.
