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

## Step 2: Create a Dedicated Integration User (optional but recommended)

1. Setup -> Users -> New User
2. Fill in:
   - First Name: `Resin`
   - Last Name: `Pipeline`
   - Email: `joe@resinllc.com`
   - Username: `resin-pipeline@<client-slug>.resinllc.com`
   - Profile: **System Administrator** (or custom profile with full metadata API access)
3. Save and activate
4. Go back to the External Client App and set this as the Run As User

## Step 3: Get the Consumer Credentials

1. From the External Client App page, find the **Consumer Key** (Client ID)
2. Copy the **Consumer Secret**
3. Note your instance URL (e.g. `https://pow.my.salesforce.com`)

## Step 4: Authenticate via CLI

```bash
sf org login client-credentials \
  --client-id "<consumer key>" \
  --client-secret "<consumer secret>" \
  --instance-url "https://<your-domain>.my.salesforce.com" \
  --alias production
```

Verify:
```bash
sf org display --target-org production
```

## Step 5: Store Credentials for Cloud Routines

Environment variables (per client, stored in routine config):

```
SF_PROD_CLIENT_ID=<consumer key>
SF_PROD_CLIENT_SECRET=<consumer secret>
SF_PROD_INSTANCE_URL=https://<your-domain>.my.salesforce.com
```

For sandboxes, use `SF_CLIENT_ID` / `SF_CLIENT_SECRET` / `SF_INSTANCE_URL`.

## Repeat for Each Org

Create the same External Client App in each client org (sandbox + production).
Each org generates its own unique Consumer Key/Secret.

| Client | Prod Alias | Sandbox Alias |
|--------|-----------|---------------|
| POW | `pow-prod` | `pow-sandbox` |
| Bears Ears | `bears-ears-prod` | `bears-ears-sandbox` |
| People for Bikes | `pfb-prod` | `pfb-sandbox` |
| Evergreen | `evergreen-prod` | `evergreen-sandbox` |
| TDLT | `tdlt-prod` | `tdlt-sandbox` |
| RE Sources | `resources-prod` | `resources-sandbox` |
| BYLT | `bylt-prod` | `bylt-sandbox` |
