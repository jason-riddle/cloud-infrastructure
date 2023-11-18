module "oidc_github" {
  source  = "unfunco/oidc-github/aws"
  version = "1.7.1"
  enabled = false

  attach_admin_policy     = true
  attach_read_only_policy = false

  iam_role_name = "terraform-cloud-infrastructure-oidc-github"

  github_repositories = [
    "jason-riddle/cloud-infrastructure",
  ]
}

output "oidc_github_iam_role_arn" {
  value     = module.oidc_github.iam_role_arn
  sensitive = true
}

output "oidc_github_iam_role_name" {
  value     = module.oidc_github.iam_role_name
  sensitive = true
}

output "oidc_github_oidc_provider_arn" {
  value     = module.oidc_github.oidc_provider_arn
  sensitive = true
}