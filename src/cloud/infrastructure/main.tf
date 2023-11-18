module "aws" {
  source = "./aws/accounts/personal"
}

output "oidc_github_iam_role_arn" {
  value     = module.aws.oidc_github_iam_role_arn
  sensitive = true
}

output "oidc_github_iam_role_name" {
  value     = module.aws.oidc_github_iam_role_name
  sensitive = true
}

output "oidc_github_oidc_provider_arn" {
  value     = module.aws.oidc_github_oidc_provider_arn
  sensitive = true
}

module "gh_homelab" {
  source = "./github/repos/homelab"
}

module "ts_jasonriddle11_gmail_com" {
  source = "./tailscale/tailnets/jasonriddle11_gmail_com"
}
