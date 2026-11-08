terraform {
  backend "s3" {
    bucket       = "oskarrosen-terraform"
    key          = "github-infra/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}
