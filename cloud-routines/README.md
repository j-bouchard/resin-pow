# Cloud Routines — POW

Paste-ready config for the three cloud routines at
[claude.ai/code/routines](https://claude.ai/code/routines). These enable the
pipeline to run without Joe's laptop being online (Phase 3 of the PRD).

| File | Routine | Trigger |
|------|---------|---------|
| `intake.prompt.md` | `resin-pow-intake` | Webhook (Fireflies / Slack / email) |
| `build.prompt.md` | `resin-pow-build` | Schedule (every 15 min) or API |
| `deploy.prompt.md` | `resin-pow-deploy` | GitHub `pull_request.closed` + `merged: true` |
| `setup.sh` | All three | Runs before each routine to install SF CLI + auth |
| `.env.example` | All three | Copy values into routine env config (NOT committed) |

## Prerequisites

1. External Client App created in POW sandbox **and** POW production — see
   `docs/CONNECTED_APP_SETUP.md`. You need the Consumer Key / Consumer
   Secret from each.
2. ClickUp personal API token + POW list ID.
3. Slack incoming webhook URL for `#resin-pipeline`.
4. GitHub fine-grained PAT scoped to `j-bouchard/resin-pow` with
   `contents:write` + `pull_requests:write`.

## Creating a routine

1. Go to https://claude.ai/code/routines and click "New routine".
2. Repo: `j-bouchard/resin-pow`, branch: `main`.
3. Environment: paste the contents of `setup.sh` into the setup script field.
4. Env vars: paste the values from your filled-in `.env` (see `.env.example`).
5. Prompt: paste the contents of the relevant `*.prompt.md` file.
6. Trigger: configure per the table above.
7. Click "Run now" to smoke-test.

## Keeping prompts in sync

The `build.prompt.md` and `deploy.prompt.md` files mirror
`.claude/commands/build-issue.md` and `.claude/commands/deploy-prod.md` so the
same logic runs whether Joe invokes a slash command locally or a cloud routine
fires autonomously. When either side changes, update the other.
