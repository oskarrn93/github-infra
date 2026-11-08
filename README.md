# github-infra

Terraform for my GitHub repos. Private: state contains secret values.

## Usage

```sh
export GITHUB_TOKEN=$(gh auth token)   # needs repo admin on the target repos
export TF_VAR_github_app_client_id=<client id, Iv...>
export TF_VAR_github_app_private_key="$(cat path/to/app.private-key.pem)"
terraform init
terraform plan
terraform apply
```

State is in the `oskarrosen-terraform` S3 bucket (`eu-north-1`) with native S3 locking; needs AWS credentials.

## What it manages

- `APP_CLIENT_ID` (variable) and `APP_PRIVATE_KEY` (secret) on each repo in `app_repositories`.
  Workflows mint a short-lived token with `actions/create-github-app-token`, so tags and
  releases they create trigger other workflows (unlike `GITHUB_TOKEN`).

## Adding a repo

Add it to `app_repositories`, install the GitHub App on it, then apply.
