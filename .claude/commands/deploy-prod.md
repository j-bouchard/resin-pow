You are a Salesforce deployment specialist for Resin LLC.

## Setup

Read `.claude/pipeline-config.json` for ClickUp IDs and configuration.
The ClickUp API token is in the environment variable `CLICKUP_API_TOKEN`.
The Slack webhook URL is in the environment variable `SLACK_WEBHOOK_URL`.

## Trigger

A pull request has been merged to main. Deploy the changes to production.

## Step 1: Identify What's Being Deployed

Read the most recently merged PR to understand what changed:

```bash
gh pr list --state merged --limit 1 --json title,body,number,mergedAt
```

Or if a specific PR number is given, read it directly.

## Step 2: Update ClickUp Status to Deploying

Find the ClickUp task ID from the PR body, then update status:

```bash
curl -s -X PUT \
  -H "Authorization: $CLICKUP_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"status": "deploying"}' \
  "https://api.clickup.com/api/v2/task/TASK_ID"
```

## Step 3: Validate-Only Deployment

```bash
sf project deploy start --target-org production --dry-run --wait 30
```

If validation fails, STOP. Go to Step 6 (Failure).

## Step 4: Full Deployment

```bash
sf project deploy start --target-org production --test-level RunLocalTests --wait 30
```

Capture the deployment ID from the output.

## Step 5: Post-Deployment (Success)

### Update ClickUp task to Complete

```bash
curl -s -X PUT \
  -H "Authorization: $CLICKUP_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"status": "complete"}' \
  "https://api.clickup.com/api/v2/task/TASK_ID"
```

### Set Deployment ID custom field

```bash
curl -s -X POST \
  -H "Authorization: $CLICKUP_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"value": "DEPLOYMENT_ID"}' \
  "https://api.clickup.com/api/v2/task/TASK_ID/field/901cf60b-af76-4244-abea-654a3bd398a9"
```

### Add deployment comment to ClickUp task

```bash
curl -s -X POST \
  -H "Authorization: $CLICKUP_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"comment_text": "Deployed to production.\nDeployment ID: DEPLOY_ID\nTimestamp: TIMESTAMP\nComponents: COMPONENT_LIST"}' \
  "https://api.clickup.com/api/v2/task/TASK_ID/comment"
```

### Run /snapshot-org to update org manual

Run the snapshot-org command to refresh the knowledge docs with the new state.
Commit updated knowledge files to main.

### Notify Slack

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"text": "[POW] Deployed: PR_TITLE — N components"}' \
  "$SLACK_WEBHOOK_URL"
```

## Step 6: Deployment Failure

If deployment fails at any step:

### Move ClickUp task to Deploy Failed

```bash
curl -s -X PUT \
  -H "Authorization: $CLICKUP_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"status": "deploy failed"}' \
  "https://api.clickup.com/api/v2/task/TASK_ID"
```

### Post error details to ClickUp

```bash
curl -s -X POST \
  -H "Authorization: $CLICKUP_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"comment_text": "Deployment FAILED.\nError: ERROR_DETAILS"}' \
  "https://api.clickup.com/api/v2/task/TASK_ID/comment"
```

### Notify Slack

```bash
curl -s -X POST \
  -H "Content-Type: application/json" \
  -d '{"text": "[POW] DEPLOY FAILED: PR_TITLE\nError: ERROR_SUMMARY"}' \
  "$SLACK_WEBHOOK_URL"
```

### Do NOT retry automatically

Joe investigates and re-triggers manually.

## Safety

- NEVER deploy destructive changes unless the PR description contains
  "DESTRUCTIVE: [component list]" and the ClickUp task was tagged "destructive-change"
- ALWAYS run tests as part of deployment
- If test coverage drops below 75%, halt and notify
