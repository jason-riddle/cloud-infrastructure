module "aws" {
  source = "./aws/accounts/personal"
}

output "iam_github_oidc_role_arn" {
  value     = module.aws.iam_github_oidc_role_arn
  sensitive = true
}

output "iam_github_oidc_role_name" {
  value     = module.aws.iam_github_oidc_role_name
  sensitive = true
}

output "iam_github_oidc_role_path" {
  value     = module.aws.iam_github_oidc_role_path
  sensitive = true
}

output "iam_github_oidc_role_unique_id" {
  value     = module.aws.iam_github_oidc_role_unique_id
  sensitive = true
}

output "iam_terraform_cloud_oidc_role_arn" {
  value     = module.aws.iam_terraform_cloud_oidc_role_arn
  sensitive = true
}

output "iam_terraform_cloud_oidc_role_name" {
  value     = module.aws.iam_terraform_cloud_oidc_role_name
  sensitive = true
}

output "iam_terraform_cloud_oidc_role_path" {
  value     = module.aws.iam_terraform_cloud_oidc_role_path
  sensitive = true
}

output "iam_terraform_cloud_oidc_role_unique_id" {
  value     = module.aws.iam_terraform_cloud_oidc_role_unique_id
  sensitive = true
}

# output "oidc_github_iam_role_arn" {
#   value     = module.aws.oidc_github_iam_role_arn
#   sensitive = true
# }

# output "oidc_github_iam_role_name" {
#   value     = module.aws.oidc_github_iam_role_name
#   sensitive = true
# }

# output "oidc_github_oidc_provider_arn" {
#   value     = module.aws.oidc_github_oidc_provider_arn
#   sensitive = true
# }

# output "zone_name_servers" {
#   value = module.aws.zone_name_servers
# }

module "gh_cloud_infrastructure" {
  source = "./github/repos/cloud-infrastructure"
}

module "gh_homelab" {
  source = "./github/repos/homelab"
}

module "ts_jasonriddle11_gmail_com" {
  source = "./tailscale/tailnets/jasonriddle11_gmail_com"
}

module "tf_cloud" {
  source = "./terraform-cloud/workspaces/default"
}
