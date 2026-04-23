#!/usr/bin/env bash
# Cloud routine setup script — installs Salesforce CLI.
#
# IMPORTANT: Cloud routine setup scripts run BEFORE Claude Code launches, and
# user-defined env vars are NOT available in this context. Do not put anything
# here that depends on $SF_CLIENT_ID, $CLICKUP_API_KEY, etc. — they'll be unset.
#
# Salesforce authentication happens in the SessionStart hook
# `.claude/hooks/session-start-sf-auth.sh`, which runs after Claude Code
# launches and DOES have access to env vars.
set -euo pipefail

echo "--> Installing Salesforce CLI..."
npm install -g @salesforce/cli --silent
echo "--> Setup complete."
