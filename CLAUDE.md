# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Small Terraform root module (`.terraform-version` pins the CLI; `versions.tf` requires `>= 1.6`; provider `integrations/github ~> 6.0`) that manages GitHub Actions credentials for the `oskarrn93` account. For each repo in `var.app_repositories` it sets the `APP_CLIENT_ID` Actions variable and the `APP_PRIVATE_KEY` Actions secret (a GitHub App's credentials), so workflows can mint tokens with `actions/create-github-app-token`.

## Commands

```sh
# one-off setup
brew install direnv gh
brew install --cask 1password-cli
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc   # then restart the shell
# 1Password app: Settings > Developer > "Integrate with 1Password CLI"
direnv allow   # .envrc loads credentials
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

`.envrc` exports `GITHUB_TOKEN` (from `gh auth token`; needs repo admin on target repos) and reads the App client ID and private key from the 1Password `github-infra` vault via `op read`. It needs `direnv`, the 1Password CLI, and `claude` launched from this directory. `Bash(op:*)` is denied for Claude.

There are no tests. State lives in S3 (`oskarrosen-terraform`, `eu-north-1`, native `use_lockfile` locking), so AWS credentials are required even for `plan`.

## Notes

- The repo is private because state contains the secret values. Keep key material out of git: `.gitignore` excludes `*.pem`, `*.tfvars`, `.env*` and state, and CI runs gitleaks over the full history (`.github/workflows/gitleaks.yml`).
- Secrets are passed only via `TF_VAR_*` env vars; there are no committed `.tfvars`.
- To add a repo: add it to `app_repositories` in `variables.tf` (default list), install the GitHub App on that repo, then apply.
- CI (`.github/workflows/`): `terraform.yml` and `actionlint.yml` call shared workflows in `oskarrn93/github-actions`, pinned by commit SHA; `gitleaks.yml` is local.
- `.terraform-version` is read by tfenv (`tfenv install` to fetch the pinned version); Terraform itself ignores it.
