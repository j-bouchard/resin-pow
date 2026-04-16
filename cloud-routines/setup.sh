#!/usr/bin/env bash
# Cloud routine setup script — runs before every INTAKE/BUILD/DEPLOY routine.
#
# The `sf` CLI has no first-class `client-credentials` login command, so we
# exchange client credentials for an access token ourselves (OAuth 2.0 token
# endpoint) and hand the token to `sf org login access-token`.
#
# Required env vars (set per routine at claude.ai/code/routines):
#   SF_CLIENT_ID, SF_CLIENT_SECRET, SF_INSTANCE_URL            (sandbox)
#   SF_PROD_CLIENT_ID, SF_PROD_CLIENT_SECRET, SF_PROD_INSTANCE_URL  (production, optional)
#
# Production auth is skipped if SF_PROD_CLIENT_ID is unset — useful during
# Phase 3a when BUILD is running autonomously but DEPLOY is still local.

set -euo pipefail

npm install -g @salesforce/cli

login_via_client_credentials() {
  local alias="$1"
  local instance_url="$2"
  local client_id="$3"
  local client_secret="$4"

  local token
  token=$(curl -sS -X POST "${instance_url}/services/oauth2/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "grant_type=client_credentials" \
    -d "client_id=${client_id}" \
    -d "client_secret=${client_secret}" \
    | jq -r '.access_token // empty')

  if [ -z "$token" ]; then
    echo "ERROR: failed to obtain access token for ${alias} (${instance_url})" >&2
    exit 1
  fi

  SF_ACCESS_TOKEN="$token" sf org login access-token \
    --instance-url "$instance_url" \
    --alias "$alias" \
    --no-prompt
}

login_via_client_credentials "sandbox" \
  "$SF_INSTANCE_URL" "$SF_CLIENT_ID" "$SF_CLIENT_SECRET"

if [ -n "${SF_PROD_CLIENT_ID:-}" ]; then
  login_via_client_credentials "production" \
    "$SF_PROD_INSTANCE_URL" "$SF_PROD_CLIENT_ID" "$SF_PROD_CLIENT_SECRET"
else
  echo "Skipping production auth (SF_PROD_CLIENT_ID not set)"
fi

sf org list
