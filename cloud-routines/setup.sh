#!/usr/bin/env bash
# Cloud routine setup script — runs before every INTAKE/BUILD/DEPLOY routine.
# Installs SF CLI and authenticates to this client's sandbox and production orgs
# via Client Credentials flow (headless — no interactive browser login).
#
# Required environment variables (set per routine at claude.ai/code/routines):
#   SF_CLIENT_ID, SF_CLIENT_SECRET, SF_INSTANCE_URL            (sandbox)
#   SF_PROD_CLIENT_ID, SF_PROD_CLIENT_SECRET, SF_PROD_INSTANCE_URL  (production)
#
# See cloud-routines/.env.example for the full list.

set -euo pipefail

npm install -g @salesforce/cli

sf org login client-credentials \
  --client-id "$SF_CLIENT_ID" \
  --client-secret "$SF_CLIENT_SECRET" \
  --instance-url "$SF_INSTANCE_URL" \
  --alias sandbox \
  --set-default

sf org login client-credentials \
  --client-id "$SF_PROD_CLIENT_ID" \
  --client-secret "$SF_PROD_CLIENT_SECRET" \
  --instance-url "$SF_PROD_INSTANCE_URL" \
  --alias production

sf org list
