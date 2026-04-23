#!/usr/bin/env bash
# audit.sh — append a single JSONL event to the central Resin audit log.
#
# Usage:
#   .claude/scripts/audit.sh <event_type> [key=value ...]
#
# Example:
#   .claude/scripts/audit.sh build.start \
#     "clickup_task=abc123" "branch=claude/task-abc123-foo"
#
# Sink:
#   Appends to github.com/$AUDIT_REPO:audit/<YYYY-MM>/<client-slug>.jsonl
#   One event per line. Never mutates existing lines — append-only.
#
# Env contract:
#   AUDIT_REPO     — e.g. "j-bouchard/resin-audit" (required; no-op if unset)
#   GH_TOKEN       — provided by gh CLI auth (required)
#   CLIENT_SLUG    — client short name, set by bootstrap/render step
#
# Failure policy:
#   Audit MUST NOT block pipeline operations. If the sink is unreachable or
#   the write fails, log to stderr and exit 0 so the caller continues. The
#   caller should NOT check the exit code.

set -u

event_type="${1:-}"
shift || true

if [ -z "$event_type" ]; then
  echo "audit.sh: missing event_type" >&2
  exit 0
fi

if [ -z "${AUDIT_REPO:-}" ]; then
  # Audit not configured for this client — silent no-op.
  exit 0
fi

client="${CLIENT_SLUG:-}"
if [ -z "$client" ] && [ -f .resin/client.json ]; then
  client=$(jq -r .slug .resin/client.json 2>/dev/null || echo "")
fi
client="${client:-unknown}"
ts="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
month="$(date -u +%Y-%m)"
path="audit/${month}/${client}.jsonl"

# Build the event JSON with the kv pairs
event_kv="{}"
for kv in "$@"; do
  key="${kv%%=*}"
  val="${kv#*=}"
  event_kv=$(jq -cn --argjson base "$event_kv" --arg k "$key" --arg v "$val" '$base + {($k): $v}')
done

# Compose the full record
record=$(jq -cn \
  --arg ts "$ts" \
  --arg client "$client" \
  --arg event "$event_type" \
  --argjson data "$event_kv" \
  --arg cwd "$(pwd)" \
  --arg user "${USER:-cloud-routine}" \
  '{ts:$ts, client:$client, event:$event, user:$user, cwd:$cwd, data:$data}')

# Append to remote JSONL file. GitHub Contents API requires read-modify-write
# because it's file-level, not append. We use the Git Data API for an
# atomic append: fetch the blob, append, write a new commit.
#
# For simplicity at Resin's volume (low writes/sec per client) we use the
# Contents API read-then-write pattern. If concurrent writes become a
# problem, migrate to the Git Data API blob + tree + commit pattern.

owner_repo="$AUDIT_REPO"

# Fetch current file (if it exists)
existing=$(gh api "repos/$owner_repo/contents/$path" 2>/dev/null || echo "")
sha_arg=""
existing_content=""
if [ -n "$existing" ]; then
  sha=$(echo "$existing" | jq -r '.sha')
  sha_arg="-f sha=$sha"
  existing_content=$(echo "$existing" | jq -r '.content' | base64 -d 2>/dev/null || echo "")
fi

new_content="${existing_content}${record}
"
encoded=$(printf '%s' "$new_content" | base64 | tr -d '\n')

if ! gh api --method PUT "repos/$owner_repo/contents/$path" \
  -f message="audit: $event_type for $client" \
  -f content="$encoded" \
  $sha_arg >/dev/null 2>&1; then
  echo "audit.sh: write failed for $event_type ($owner_repo:$path) — continuing" >&2
fi

exit 0
