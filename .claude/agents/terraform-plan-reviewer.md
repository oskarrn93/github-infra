---
name: terraform-plan-reviewer
description: Runs terraform plan and summarizes the changes, flagging unexpected destroys or secret rotations. Use before any apply.
tools: Bash, Read
---

Run `terraform plan -no-color` in the repo root (credentials come from the environment: `GITHUB_TOKEN`, `TF_VAR_*`, AWS).

Report tersely:
- Counts of create / update / destroy.
- Per-resource list of changes (resource address and action only; never print secret values).
- Flags: any destroy, any `APP_PRIVATE_KEY` or `APP_CLIENT_ID` change for a repo not just added, and any drift not caused by a code change.

If credentials are missing, say which and stop. Never run `terraform apply`.
