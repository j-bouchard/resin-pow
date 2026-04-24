#!/usr/bin/env bash
# SessionStart hook — authenticate to Salesforce orgs at session start.
#
# Cloud routine environments do NOT expose user-defined env vars to the
# setup script (they run before Claude Code launches). They ARE available
# to SessionStart hooks, which run after launch — so we do the auth here.
#
# Authentication strategy:
#   Use OAuth 2.0 client_credentials grant directly against the org's
#   /services/oauth2/token endpoint (curl), then feed the resulting
#   access token to `sf org login access-token`. This works across all
#   @salesforce/cli versions — older versions lack the higher-level
#   `sf org login client-credentials` subcommand.
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
  log "sf CLI not found in PATH ($PATH). Skipping auth."
  exit 0
fi

log "sf at: $(command -v sf) (version: $(sf --version 2>&1 | head -1))"

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
    log "$alias: already authenticated, skipping"
    return 0
  fi

  # Use Salesforce's central login servers for the token fetch, not the
  # per-org $SF_INSTANCE_URL. The central servers (login.salesforce.com,
  # test.salesforce.com) are explicitly in the cloud-routine proxy
  # allowlist and consistently reachable; some per-org *.my.salesforce.com
  # hostnames hit proxy-side "DNS cache overflow" 503s intermittently.
  local login_host
  case "$alias" in
    sandbox)    login_host="test.salesforce.com" ;;
    production) login_host="login.salesforce.com" ;;
    *)          login_host="login.salesforce.com" ;;
  esac

  log "$alias: fetching client-credentials token from https://${login_host}/services/oauth2/token"
  local token_response http_code body access_token
  token_response=$(curl -s -w "\n%{http_code}" -X POST \
    "https://${login_host}/services/oauth2/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    --data-urlencode "grant_type=client_credentials" \
    --data-urlencode "client_id=${client_id}" \
    --data-urlencode "client_secret=${client_secret}")

  http_code=$(echo "$token_response" | tail -n1)
  body=$(echo "$token_response" | sed '$d')

  if [[ "$http_code" != "200" ]]; then
    log "$alias: token endpoint HTTP $http_code"
    log "  response: $body"
    return 0
  fi

  access_token=$(echo "$body" | jq -r '.access_token // empty')
  if [[ -z "$access_token" ]]; then
    log "$alias: no access_token in response body"
    log "  response: $body"
    return 0
  fi

  log "$alias: received access token (len ${#access_token}); running sf org login access-token"
  # sf org login access-token reads the token from stdin when piped.
  if echo "$access_token" | sf org login access-token \
    --instance-url "$instance_url" \
    --alias        "$alias" \
    --no-prompt 2>&1 | sed "s|^|[sf-auth-hook] $alias:   |" >&2; then
    log "$alias: login OK"
  else
    log "$alias: login FAILED"
  fi
}

auth_org sandbox    SF_CLIENT_ID      SF_CLIENT_SECRET      SF_INSTANCE_URL
auth_org production SF_PROD_CLIENT_ID SF_PROD_CLIENT_SECRET SF_PROD_INSTANCE_URL

log "Authenticated orgs after hook:"
sf org list 2>&1 | sed 's/^/[sf-auth-hook]   /' >&2 || true

exit 0
