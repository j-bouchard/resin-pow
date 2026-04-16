# External Client App Setup

This guide covers the per-org setup that enables headless authentication for
the Resin AI Pipeline cloud routines.

> Salesforce now requires **External Client Apps** for new OAuth
> configurations. Older docs (including parts of the PRD) may say "Connected
> App" — the two are functionally equivalent for our purposes, but you must
> create the new External Client App type for new orgs.

Repeat every step in **both** the POW sandbox and POW production. Each org
generates its own unique Consumer Key / Consumer Secret.

## Step 1: Create a dedicated integration user (recommended)

The app runs as a specific user, and that user appears in the audit trail for
every pipeline change. Using a dedicated user (instead of Joe's admin login)
makes deploys easy to identify and survives Joe's license changing.

1. Setup -> Users -> New User
2. Fill in:
   - First Name: `Resin`
   - Last Name: `Pipeline`
   - Email: `joe@resinllc.com` (email receipts go here)
   - Username: `resin-pipeline@pow.resinllc.com` (sandbox adds `.sandbox`
     automatically when sandbox is refreshed)
   - Profile: **System Administrator**
   - License: **Salesforce** (not Chatter Free / Identity)
3. Save and activate. Check the welcome email and set a password — you need
   the user active before the External Client App can run as it.

## Step 2: Create the External Client App

1. Setup -> **External Client App Manager** -> **New External Client App**
2. Name: `Resin AI Pipeline`
3. Description: `Headless auth for Resin AI Pipeline (Claude Code routines)`
4. Enable OAuth:
   - Callback URL: `https://localhost:1717/OauthRedirect`
   - Scopes: `Manage user data via APIs (api)`,
     `Perform requests at any time (refresh_token, offline_access)`
5. Enable **Client Credentials Flow**
6. Run As User: the `Resin Pipeline` user from Step 1
7. Save

## Step 3: Pre-authorize the app

1. Back on the External Client App page, go to **Policies** (or
   **Manage -> OAuth Policies** on legacy UI)
2. Set **Permitted Users** to `Admin approved users are pre-authorized`
3. Save
4. Under **Profiles** (or **Manage Profiles**), add the System Administrator
   profile (or whatever profile the Resin Pipeline user has)

## Step 4: Get the Consumer Key and Consumer Secret

1. Open the External Client App -> **Settings** tab
2. Click **Consumer Key and Secret**
3. Copy both values somewhere safe — you'll paste them into the routine env
   config

## Step 5: Smoke-test from your terminal

Before wiring up cloud routines, verify the credentials work locally. Use the
matching alias:

```bash
# Sandbox
sf org login client-credentials \
  --client-id "<sandbox consumer key>" \
  --client-secret "<sandbox consumer secret>" \
  --instance-url "https://resourcemedia--pow.sandbox.my.salesforce.com" \
  --alias sandbox

# Production
sf org login client-credentials \
  --client-id "<prod consumer key>" \
  --client-secret "<prod consumer secret>" \
  --instance-url "https://pow.my.salesforce.com" \
  --alias production
```

Verify:

```bash
sf org display --target-org sandbox
sf org display --target-org production
```

If both commands print org info without errors, the app is correctly
configured. Common failure modes:

| Error | Cause |
|-------|-------|
| `invalid_client` | Consumer Key or Secret wrong / not yet propagated (wait ~5 min after creating the app) |
| `invalid_grant` | Run-As User is inactive, or profile not added to the app's authorized profiles |
| `unsupported_grant_type` | Client Credentials Flow not enabled on the app |
| `redirect_uri_mismatch` | Callback URL is missing; add `https://localhost:1717/OauthRedirect` |

## Step 6: Store credentials for cloud routines

Once the smoke test passes, copy the values into the routine env config at
`claude.ai/code/routines` (see `cloud-routines/.env.example`):

```
SF_CLIENT_ID=<sandbox consumer key>
SF_CLIENT_SECRET=<sandbox consumer secret>
SF_INSTANCE_URL=https://resourcemedia--pow.sandbox.my.salesforce.com

SF_PROD_CLIENT_ID=<prod consumer key>
SF_PROD_CLIENT_SECRET=<prod consumer secret>
SF_PROD_INSTANCE_URL=https://pow.my.salesforce.com
```

Never commit these values. `.env` is gitignored; only `.env.example` is
committed.

## Org registry (for future rollout)

| Client | Prod Alias | Sandbox Alias |
|--------|-----------|---------------|
| POW | `production` | `sandbox` |
| Bears Ears | `bears-ears-prod` | `bears-ears-sandbox` |
| People for Bikes | `pfb-prod` | `pfb-sandbox` |
| Evergreen | `evergreen-prod` | `evergreen-sandbox` |
| TDLT | `tdlt-prod` | `tdlt-sandbox` |
| RE Sources | `resources-prod` | `resources-sandbox` |
| BYLT | `bylt-prod` | `bylt-sandbox` |

Per PRD §8 Client Org Registry. Each client repo gets its own External Client
Apps; credentials do not cross orgs.
