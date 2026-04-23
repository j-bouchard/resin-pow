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

log() { echo "[sf-auth-hook] $*" >&2; }

# Ensure common npm-global install paths are on PATH. Cloud routines install
# SF CLI via `npm install -g`, which may land in /usr/local/bin,
# /root/.npm-global/bin, or ~/.npm-global/bin depending on the sandbox image.
export PATH="/usr/local/bin:$HOME/.npm-global/bin:/root/.npm-global/bin:$PATH"

if ! command -v sf >/dev/null 2>&1; then
  log "sf CLI not found in PATH ($PATH). Skipping auth — commands requiring sf will fail with a clear error."
  exit 0
fi

log "sf found at: $(command -v sf)"

auth_org() {
  local alias="$1" client_id_var="$2" client_secret_var="$3" instance_url_var="$4"
  local client_id="${!client_id_var:-}"
  local client_secret="${!client_secret_var:-}"
  local instance_url="${!instance_url_var:-}"

  if [[ -z "$client_id" || -z "$client_secret" || -z "$instance_url" ]]; then
    log "$alias: SKIP (env vars $client_id_var / $client_secret_var / $instance_url_var not all set)"
    return 0
  fi

  if sf org display --target-org "$alias" >/dev/null 2>&1; then
    log "$alias: already authenticated, skipping re-login"
    return 0
  fi

  log "$alias: running client-credentials login to $instance_url"
  if sf org login client-credentials \
    --client-id     "$client_id" \
    --client-secret "$client_secret" \
    --instance-url  "$instance_url" \
    --alias         "$alias" 2>&1; then
    log "$alias: login OK"
  else
    log "$alias: login FAILED (exit $?). Check Connected App + creds."
  fi
}

auth_org sandbox    SF_CLIENT_ID      SF_CLIENT_SECRET      SF_INSTANCE_URL
auth_org production SF_PROD_CLIENT_ID SF_PROD_CLIENT_SECRET SF_PROD_INSTANCE_URL

# Final state: what orgs are actually authenticated?
log "Authenticated orgs after hook:"
sf org list 2>&1 | sed 's/^/[sf-auth-hook]   /' >&2 || true

exit 0
