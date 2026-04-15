# Resin AI Pipeline — Connected App Setup

This guide covers the per-org setup for the Resin AI Pipeline Connected App.
The app definition is deployed via SFDX metadata. The manual steps below
configure the runtime settings that are org-specific.

## Step 1: Deploy the Connected App

```bash
sf project deploy start \
  --source-dir force-app/main/default/connectedApps \
  --target-org <org-alias>
```

Or deploy the full project which includes it:
```bash
sf project deploy start --manifest package.xml --target-org <org-alias>
```

## Step 2: Create the Integration User (one-time per org)

1. Setup -> Users -> New User
2. Fill in:
   - First Name: `Resin`
   - Last Name: `Pipeline`
   - Email: `joe@resinllc.com` (or your preferred notification address)
   - Username: `resin-pipeline@<client-slug>.resinllc.com`
   - Profile: **System Administrator** (or a custom profile with full metadata API access)
3. Save and activate the user

## Step 3: Configure OAuth Policies

1. Setup -> App Manager
2. Find "Resin AI Pipeline" -> click dropdown -> **Manage**
3. Under **OAuth Policies**:
   - Permitted Users: **Admin approved users are pre-authorized**
   - IP Relaxation: **Enforce IP restrictions** (or relax if needed for cloud)
4. Click Save

## Step 4: Authorize the Integration User

1. Still on the Connected App management page
2. Scroll to **Profiles** or **Permission Sets** section
3. Click **Manage Profiles** -> add **System Administrator**
   (or the specific profile assigned to the integration user)
4. Click Save

## Step 5: Get the Consumer Credentials

1. Setup -> App Manager
2. Find "Resin AI Pipeline" -> click dropdown -> **View**
3. Under **API (Enable OAuth Settings)**:
   - Copy the **Consumer Key** (Client ID)
   - Click **Manage Consumer Details** -> verify identity -> copy the **Consumer Secret**

## Step 6: Store Credentials

### For cloud routines (environment variables)

```
SF_PROD_CLIENT_ID=<consumer key from Step 5>
SF_PROD_CLIENT_SECRET=<consumer secret from Step 5>
SF_PROD_INSTANCE_URL=https://<your-domain>.my.salesforce.com
```

For sandboxes, use the `SF_CLIENT_ID` / `SF_CLIENT_SECRET` / `SF_INSTANCE_URL` vars.

### For local sessions

```bash
sf org login client-credentials \
  --client-id "<consumer key>" \
  --client-secret "<consumer secret>" \
  --instance-url "https://<your-domain>.my.salesforce.com" \
  --alias production
```

## Step 7: Verify Authentication

```bash
sf org display --target-org production
```

You should see the org details including Org ID, username, and instance URL.

## Repeat for Each Org

Deploy the same Connected App metadata to each client org (sandbox + production).
Each org generates its own unique Consumer Key/Secret. Store per-org credentials
as separate environment variables in the cloud routine configuration.

| Client | Prod Alias | Sandbox Alias |
|--------|-----------|---------------|
| POW | `pow-prod` | `pow-sandbox` |
| Bears Ears | `bears-ears-prod` | `bears-ears-sandbox` |
| People for Bikes | `pfb-prod` | `pfb-sandbox` |
| Evergreen | `evergreen-prod` | `evergreen-sandbox` |
| TDLT | `tdlt-prod` | `tdlt-sandbox` |
| RE Sources | `resources-prod` | `resources-sandbox` |
| BYLT | `bylt-prod` | `bylt-sandbox` |
