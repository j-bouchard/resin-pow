#!/usr/bin/env bash
# Cloud routine setup script for resin-pow
# Runs before every routine execution in the cloud environment.
# Installs SF CLI and authenticates to client orgs via OAuth Client Credentials.
set -euo pipefail

echo "--> Installing Salesforce CLI..."
npm install -g @salesforce/cli --silent

echo "--> Authenticating orgs..."

# Authenticate sandbox (skip if credentials not provided — snapshot-weekly
# only needs production)
if [[ -n "${SF_CLIENT_ID:-}" ]]; then
  sf org login client-credentials \
    --client-id     "$SF_CLIENT_ID" \
    --client-secret "$SF_CLIENT_SECRET" \
    --instance-url  "$SF_INSTANCE_URL" \
    --alias         sandbox
  echo "    sandbox: ok"
fi

# Authenticate production
sf org login client-credentials \
  --client-id     "$SF_PROD_CLIENT_ID" \
  --client-secret "$SF_PROD_CLIENT_SECRET" \
  --instance-url  "$SF_PROD_INSTANCE_URL" \
  --alias         production
echo "    production: ok"

echo "--> Setup complete."
