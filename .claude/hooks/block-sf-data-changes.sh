#!/usr/bin/env bash
# block-sf-data-changes.sh
#
# PreToolUse hook for Bash. Rejects any Salesforce CLI command that would
# manipulate data records. Pipeline is allowed to deploy METADATA only.
#
# Strategy: strip quoted strings and heredoc bodies from the command before
# pattern-matching, so we only inspect the shell-structural part — never
# embedded text like a git commit message that happens to mention "sf data".
#
# Exits 0 = allow, 2 = block (Claude sees stderr as the reason).

set -uo pipefail

input=$(cat)
cmd=$(echo "$input" | jq -r '.tool_input.command // ""')

if [ -z "$cmd" ]; then
  exit 0
fi

export PIPELINE_CMD="$cmd"

# Use Python to strip strings/heredocs and tokenize for inspection.
python3 <<'PYEOF'
import os
import re
import sys

cmd = os.environ.get("PIPELINE_CMD", "")
if not cmd:
    sys.exit(0)

# Strip heredoc bodies: <<-? '?WORD'? body WORD
def strip_heredocs(s):
    pattern = re.compile(r"<<-?\s*'?(\w+)'?\s*\n.*?^\1\s*$", re.DOTALL | re.MULTILINE)
    return pattern.sub("", s)

stripped = strip_heredocs(cmd)
# Strip single-quoted strings
stripped = re.sub(r"'[^']*'", "", stripped)
# Strip double-quoted strings (allow escaped quotes)
stripped = re.sub(r'"(?:[^"\\]|\\.)*"', "", stripped)

# Split into command-position segments
segments = re.split(r'(?:&&|\|\||;|\||\n|\$\(|\))', stripped)

danger_data_re = re.compile(
    r'^\s*sf\s+data\s+(delete|update|upsert|create|import|tree|bulk)(\s|$)',
    re.IGNORECASE,
)
apex_run_re = re.compile(r'^\s*sf\s+apex\s+run', re.IGNORECASE)

dml_re = re.compile(
    r'\b(insert|update|delete|upsert|merge|undelete)\b|Database\.(insert|update|delete|upsert|merge|undelete|emptyRecycleBin|executeBatch|query[Ll]ocator)',
    re.IGNORECASE,
)
# Record objects: standard + common NPSP + catch-all for any custom object
# with __c suffix (over-triggers on read-only queries, but those are allowed
# via `sf data query` which doesn't hit this branch — apex_run is the gate).
record_obj_re = re.compile(
    r'\b(Contact|Account|Opportunity|Campaign|CampaignMember|Lead|Task|Event|User|OpportunityContactRole|AccountContactRelation|OpportunityLineItem|Asset|Contract|Quote|Order)\b'
    r'|\bnpe\d*__\w+__c\b'
    r'|\bnpsp__\w+__c\b'
    r'|\bnpo\d+__\w+__c\b'
    r'|\b\w+__c\b'
)

# Detect prod-deploy commands from non-deploy-prod contexts. The /deploy-prod
# command sets RESIN_ALLOW_PROD_DEPLOY=1 before invoking `sf project deploy`;
# all other commands (build-issue, snapshot-org, validate-sandbox, reconcile)
# must not touch production.
prod_deploy_re = re.compile(
    r'^\s*sf\s+project\s+deploy\s+(start|quick|validate).*(--target-org|--?o)\s+production',
    re.IGNORECASE,
)

allow_prod = os.environ.get("RESIN_ALLOW_PROD_DEPLOY") == "1"

for seg in segments:
    if not allow_prod and prod_deploy_re.search(seg):
        sys.stderr.write("""BLOCKED: production deploy attempted outside /deploy-prod context.

Only the /deploy-prod command is authorized to run `sf project deploy ... --target-org production`.
Other commands (build-issue, snapshot-org, validate-sandbox, reconcile) must
target sandbox only. If /deploy-prod is the caller, it sets RESIN_ALLOW_PROD_DEPLOY=1.
""")
        sys.exit(2)

    if danger_data_re.search(seg):
        sys.stderr.write("""BLOCKED: 'sf data delete/update/upsert/create/import/tree' is forbidden by repo policy.

The Resin AI Pipeline is metadata-only. It must never insert, update, or delete
Salesforce records (Contacts, Opportunities, Accounts, etc.). Use metadata
deployments via 'sf project deploy start' instead.

If you genuinely need to modify data (data fix, migration), that requires
explicit human approval and should be done outside this pipeline.
""")
        sys.exit(2)
    if apex_run_re.search(seg):
        # For apex run, check the FULL original command since the actual Apex
        # body may have been inside a stripped quoted string.
        if dml_re.search(cmd) and record_obj_re.search(cmd):
            sys.stderr.write("""BLOCKED: 'sf apex run' contains DML against a standard or NPSP record object.

Detected DML keyword (insert/update/delete/upsert/merge/undelete or
Database.* method) and a record object reference (Contact, Account,
Opportunity, Campaign, Lead, Task, Event, User, or NPSP data objects).

The pipeline is metadata-only and cannot modify records. For read-only
inspection, use 'sf data query' with SOQL instead.
""")
            sys.exit(2)

sys.exit(0)
PYEOF
