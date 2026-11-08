resource "github_actions_variable" "app_client_id" {
  for_each = var.app_repositories

  repository    = each.key
  variable_name = "APP_CLIENT_ID"
  value         = var.github_app_client_id
}

resource "github_actions_secret" "app_private_key" {
  for_each = var.app_repositories

  repository  = each.key
  secret_name = "APP_PRIVATE_KEY"
  value       = var.github_app_private_key
}
