#!/usr/bin/env bash
# SessionStart hook — authenticate to Salesforce orgs at session start.
#
# Cloud routine environments do NOT expose user-defined env vars to the
# setup script (setup scripts run before Claude Code launches). They ARE
# available to SessionStart hooks, which run after launch. We do the
# `sf org login client-credentials` here rather than in cloud-routines/setup.sh
# so the SF_*/SF_PROD_* env vars are actually present.
#
# Locally, users authenticate via `sf org login web` once — this hook
# detects an existing auth and skips re-login if present.
set -uo pipefail

# Skip entirely if SF CLI isn't installed (e.g. a non-Salesforce context)
command -v sf >/dev/null 2>&1 || exit 0

auth_org() {
  local alias="$1" client_id_var="$2" client_secret_var="$3" instance_url_var="$4"
  local client_id="${!client_id_var:-}"
  local client_secret="${!client_secret_var:-}"
  local instance_url="${!instance_url_var:-}"

  # Skip if creds not provided for this alias
  if [[ -z "$client_id" || -z "$client_secret" || -z "$instance_url" ]]; then
    return 0
  fi

  # Skip if already authenticated (local development case)
  if sf org display --target-org "$alias" >/dev/null 2>&1; then
    return 0
  fi

  sf org login client-credentials \
    --client-id     "$client_id" \
    --client-secret "$client_secret" \
    --instance-url  "$instance_url" \
    --alias         "$alias" >/dev/null 2>&1 || {
      echo "WARN: sf org login failed for alias $alias" >&2
      return 0  # Do not block the session; commands will fail at their own auth step with a clearer error.
    }
}

auth_org sandbox    SF_CLIENT_ID      SF_CLIENT_SECRET      SF_INSTANCE_URL
auth_org production SF_PROD_CLIENT_ID SF_PROD_CLIENT_SECRET SF_PROD_INSTANCE_URL

exit 0
