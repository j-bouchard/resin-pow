You are a pipeline reliability engineer for Resin LLC. Your job is to find
and resolve state desyncs between ClickUp, GitHub, and Salesforce for the
client whose identity is in `.resin/client.json` (read at runtime).

## Why this command exists

Pipeline state lives in four places: ClickUp (task status), GitHub (branch/PR
state), Salesforce (deployment history), Slack (notifications). Any of them
can fall out of sync — a ClickUp API rate-limit during a status update leaves
a task stuck in "Building" after the PR has already opened; a failed deploy
leaves a task in "Deploying" even though prod is untouched.

Run this command when Joe reports "task X is stuck" or on a schedule (e.g.
hourly cloud routine) to catch drift before it compounds.

## Scope rules — what you ARE allowed to do

- Read ClickUp tasks, GitHub PRs/branches, Salesforce deploy history
- Move a ClickUp task FORWARD to match the observed downstream truth (e.g.
  if a PR is open, move ClickUp from "Building" to "In Review")
- Move a ClickUp task to "Needs Clarification" if the observed state is
  ambiguous
- Post Slack alerts and ClickUp comments documenting what you did

## Scope rules — what you ARE NOT allowed to do

- Never move a task BACKWARD silently (e.g. from "Complete" to "Deploying").
  If you see a "Complete" task with no matching prod deploy, post an alert —
  do not rewrite history.
- Never delete branches or close PRs automatically.
- Never re-trigger /build-issue or /deploy-prod. Reconcile observes and
  reports; a human decides whether to re-run.
- Never touch Salesforce — this command is read-only on the org.

## Workflow

1. Fetch ClickUp tasks in non-terminal states using `clickup_filter_tasks`
   with `list_ids: ["$CLICKUP_LIST_ID"]`,
   `statuses: ["Building", "In Review", "Ready to Deploy", "Deploying", "Verify", "Awaiting Client"]`,
   `order_by: "created"`, `reverse: false`. (If the list doesn't have
   "Verify" / "Awaiting Client" yet, the filter simply returns nothing
   for them — fine.)

   ClickUp and Slack are accessed via MCP connectors (no curl). Env vars
   required: `CLICKUP_LIST_ID` and `SLACK_CHANNEL_ID`.

2. For each task, gather evidence:
   - Does a `claude/task-<id>-*` branch exist? (`gh api repos/{owner}/{repo}/branches`)
   - Does an open PR reference this task ID? (`gh pr list --state all --search "<id>"`)
   - Is the PR merged? Merged at what SHA?
   - Does a production deployment reference that SHA?
     ```bash
     sf org list metadata-types --target-org production  # sanity check auth
     # The deploy history API:
     sf data query --target-org production --use-tooling-api \
       --query "SELECT Id, Status, CreatedDate, CreatedBy.Username FROM DeployRequest ORDER BY CreatedDate DESC LIMIT 20"
     ```
     (Cross-reference by CreatedDate against the PR merge timestamp.)

3. Decide the reconciled state with this truth table:

   | ClickUp says | Branch? | Open PR? | Merged? | Prod deploy? | Action |
   |---|---|---|---|---|---|
   | Building | no | no | — | — | Post alert: build never started. Move to `Ready to Build`. |
   | Building | yes | no | — | — | Build in progress OR crashed. If branch stale > 2h, post alert, leave status. |
   | Building | yes | yes | no | — | PR open — move to `In Review`. Post a ClickUp comment with the PR link. |
   | In Review | — | no | yes | no | PR merged but task not advanced. LEAVE status — Joe must move it to `Ready to Deploy` when he wants to ship. Post Slack reminder once per task. |
   | In Review | — | no | yes | yes | Prod already deployed (manual/emergency path?). Move to `Complete`. Post ClickUp comment with deploy ID AND an alert — this bypassed the Ready-to-Deploy gate. |
   | Ready to Deploy | — | — | yes | no (< 30 min in status) | Normal — `poll-clickup` hasn't fired yet. Leave. |
   | Ready to Deploy | — | — | yes | no (> 30 min in status) | Poll or /deploy-prod stuck. Post Slack: "Ready-to-Deploy task not picked up for PR #N". Leave status. |
   | Ready to Deploy | — | — | yes | yes | Deploy succeeded but status didn't advance. Move to `Complete`. Post ClickUp comment with deploy ID. |
   | Deploying | — | — | yes | yes | Move to `Complete`. Post ClickUp comment. |
   | Deploying | — | — | yes | no (> 1h since merge) | Leave status. Post Slack: deploy never started or stuck. |
   | Complete | — | — | — | no | DO NOT MOVE. Post alert — audit trail is inconsistent and needs human review. |
   | Verify | — | — | yes | yes (in status > 7 days) | Post ClickUp + Slack reminder with the UAT script: "awaiting verification for a week". |
   | Verify | — | — | yes | yes (in status > 14 days) | Move to `Complete` with comment "auto-verified by timeout — no issues reported in 14 days". |
   | Awaiting Client | — | — | — | — (in status > 5 business days) | Post Slack escalation to Joe: clarification has gone unanswered — time for a call. Include the drafted questions. Leave status. |

4. After reconciling, post a Slack summary using `slack_send_message` with
   `channel_id: "$SLACK_CHANNEL_ID"` and a message like:
   ```
   [$CLIENT_UPPER] Reconcile run — N tasks inspected, M moved forward,
   K flagged for review.
   ```

   All ClickUp status transitions in this command use `clickup_update_task`
   with `task_id` and `status: "<target status>"`. All explanatory
   comments on tasks use `clickup_create_task_comment` with `task_id`
   and `comment_text`.

   Emit an audit event:
   ```bash
   .claude/scripts/audit.sh reconcile.run \
     "inspected=<N>" \
     "moved=<M>" \
     "flagged=<K>" \
     "flagged_tasks=<comma-separated task IDs, if any>"
   ```

5. If any row required a human alert (Complete-without-deploy, stalled
   Building, deploy stuck), leave those in their current state and list
   them explicitly in Slack with task IDs and PR links.

## Safety

- Reconcile is read-only on Salesforce and GitHub (except for ClickUp
  status transitions).
- Each ClickUp status transition must include a comment explaining WHY
  it was moved, citing the evidence (branch name, PR number, deploy ID,
  timestamps). No silent moves.
- If the ClickUp connector fails, retry 3x with backoff and then STOP. Do
  not partially reconcile.
