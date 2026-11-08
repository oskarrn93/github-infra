variable "github_app_client_id" {
  description = "Client ID (Iv...) of the GitHub App that workflows use to mint tokens"
  type        = string
}

variable "github_app_private_key" {
  description = "PEM private key of the GitHub App"
  type        = string
  sensitive   = true
}

variable "app_repositories" {
  description = "Repositories that get the App credentials as Actions secrets"
  type        = set(string)
  default     = ["iptv-client", "github-actions", "claude-plugins"]
}
