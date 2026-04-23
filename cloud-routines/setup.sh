#!/usr/bin/env bash
# Cloud routine setup script — runs before every routine execution.
# Installs SF CLI and authenticates to client orgs via OAuth Client Credentials.
# Reads client identity from .resin/client.json at runtime.
set -euo pipefail

if [[ ! -f .resin/client.json ]]; then
  echo "ERROR: .resin/client.json not found in $(pwd)" >&2
  echo "This repo is not configured for the Resin pipeline." >&2
  exit 1
fi

export CLIENT_SLUG="$(jq -r .slug .resin/client.json)"
export CLIENT_NAME="$(jq -r .name .resin/client.json)"
export CLIENT_UPPER="$(jq -r .upper .resin/client.json)"
echo "--> Client: $CLIENT_NAME ($CLIENT_UPPER)"

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
