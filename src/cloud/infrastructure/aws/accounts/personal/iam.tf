## AWS - IAM - GitHub - OIDC

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-github-oidc-provider
module "iam_github_oidc_provider" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
  version = "~> 5.0"
  create  = true
}

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-github-oidc-role
module "iam_github_oidc_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
  version = "~> 5.0"
  create  = true

  name = "terraform-iam-github-oidc-role"

  subjects = [
    # You can prepend with `repo:` but it is not required
    "jason-riddle/cloud-infrastructure"
    # "repo:jason-riddle/cloud-infrastructure"
    # "repo:jason-riddle/cloud-infrastructure:pull_request",
    # "repo:jason-riddle/cloud-infrastructure:ref:refs/heads/main",
  ]

  policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
}

### AWS - IAM - GitHub - OIDC - Outputs

output "iam_github_oidc_role_arn" {
  value     = module.iam_github_oidc_role.arn
  sensitive = true
}

output "iam_github_oidc_role_name" {
  value     = module.iam_github_oidc_role.name
  sensitive = true
}

output "iam_github_oidc_role_path" {
  value     = module.iam_github_oidc_role.path
  sensitive = true
}

output "iam_github_oidc_role_unique_id" {
  value     = module.iam_github_oidc_role.unique_id
  sensitive = true
}

## AWS - IAM - Terraform Cloud - OIDC

data "tls_certificate" "app_terraform_io" {
  count = 1

  url = "https://app.terraform.io"
}

resource "aws_iam_openid_connect_provider" "app_terraform_io" {
  count = 1

  url             = "https://app.terraform.io"
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = data.tls_certificate.app_terraform_io[0].certificates[*].sha1_fingerprint
}

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-assumable-role-with-oidc
module "iam_terraform_cloud_oidc_role" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version     = "~> 5.0"
  create_role = true

  role_name = "terraform-iam-terraform-cloud-oidc-role"

  allow_self_assume_role = false

  provider_url = "app.terraform.io"

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]

  oidc_fully_qualified_audiences = ["aws.workload.identity"]
  oidc_fully_qualified_subjects  = ["organization:org-jasonriddle:project:*:workspace:*:run_phase:*"]
}

### AWS - IAM - Terraform Cloud - OIDC - Outputs

output "iam_terraform_cloud_oidc_role_arn" {
  value     = module.iam_terraform_cloud_oidc_role.iam_role_arn
  sensitive = true
}

output "iam_terraform_cloud_oidc_role_name" {
  value     = module.iam_terraform_cloud_oidc_role.iam_role_name
  sensitive = true
}

output "iam_terraform_cloud_oidc_role_path" {
  value     = module.iam_terraform_cloud_oidc_role.iam_role_path
  sensitive = true
}

output "iam_terraform_cloud_oidc_role_unique_id" {
  value     = module.iam_terraform_cloud_oidc_role.iam_role_unique_id
  sensitive = true
}

## AWS - IAM - Users

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user
module "iam_user" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-user"
  version     = "~> 5.0"
  create_user = true

  name = "jason.riddle"

  create_iam_access_key         = false
  create_iam_user_login_profile = false
}

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user
module "system_user" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-user"
  version     = "~> 5.0"
  create_user = true

  name = "terraform-cloud-infrastructure-system-user"

  create_iam_access_key         = true
  create_iam_user_login_profile = false
}

output "iam_access_key_id" {
  value     = module.system_user.iam_access_key_id
  sensitive = true
}

output "iam_access_key_secret" {
  value     = module.system_user.iam_access_key_secret
  sensitive = true
}

## AWS - IAM - Groups

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-group-with-policies
module "iam_group" {
  source       = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version      = "~> 5.0"
  create_group = true

  name = "admins"
  # name = "super-administrators"

  enable_mfa_enforcement = false

  attach_iam_self_management_policy      = false
  iam_self_management_policy_name_prefix = "testing-"

  group_users = [
    module.iam_user.iam_user_name,
    module.system_user.iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}
