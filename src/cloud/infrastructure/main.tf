module "aws" {
  source = "./aws/accounts/personal"
}

output "aws_oidc_github_iam_role_arn" {
  value     = module.aws.aws_oidc_github_iam_role_arn
  sensitive = true
}

module "gh_homelab" {
  source = "./github/repos/homelab"
}

module "ts_jasonriddle11_gmail_com" {
  source = "./tailscale/tailnets/jasonriddle11_gmail_com"
}
