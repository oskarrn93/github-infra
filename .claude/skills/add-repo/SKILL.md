---
name: add-repo
description: Add a repository to app_repositories in variables.tf, validate, and commit
disable-model-invocation: true
argument-hint: <repo-name>
---

Add `$ARGUMENTS` to the `app_repositories` default list in `variables.tf`.

1. Append it to the list.
2. Run `terraform fmt -check` and `terraform validate`.
3. Commit on a new branch `feat/add-$ARGUMENTS` with `feat: add $ARGUMENTS to app credentials`.
4. Remind the user to install the GitHub App on `$ARGUMENTS` before applying.

Do not run `terraform apply`; it writes real secrets and is the user's call.
