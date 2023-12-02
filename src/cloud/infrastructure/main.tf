## AWS

module "aws" {
  source = "./aws/accounts/personal"
}

### AWS - IAM System User

# output "iam_system_user_access_key_id" {
#   value     = module.aws.iam_system_user_access_key_id
#   sensitive = true
# }

# output "iam_system_user_access_key_secret" {
#   value     = module.aws.iam_system_user_access_key_secret
#   sensitive = true
# }

### AWS - IAM - GitHub - OIDC - Outputs

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

### AWS - IAM - Terraform Cloud - OIDC - Outputs

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

## GitHub

module "gh_cloud_infrastructure" {
  source = "./github/repos/cloud-infrastructure"
}

module "gh_homelab" {
  source = "./github/repos/homelab"
}

## Tailscale

module "ts_jasonriddle11_gmail_com" {
  source = "./tailscale/tailnets/jasonriddle11_gmail_com"
}

## Terraform Cloud

module "tf_cloud" {
  source = "./terraform-cloud/workspaces/default"

  tfc_aws_provider_auth = true
  tfc_aws_run_role_arn  = module.aws.iam_terraform_cloud_oidc_role_arn
}
