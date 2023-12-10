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
  create  = false

  name = "terraform-cloud-infrastructure-gh-actions-iam-oidc-role"

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

module "iam_terraform_cloud_oidc_role" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version     = "~> 5.0"
  create_role = true

  role_name = "terraform-iam-terraform-cloud-oidc-role"

  create_custom_role_trust_policy = true
  custom_role_trust_policy        = data.aws_iam_policy_document.policy.json
  custom_role_policy_arns         = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:${local.partition}:iam::${local.aws_account_id}:oidc-provider/app.terraform.io"]
    }

    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"
      values   = ["aws.workload.identity"]
    }

    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"
      values   = ["organization:org-jasonriddle:project:*:workspace:*:run_phase:*"]
    }
  }
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
module "iam_cli_user" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-user"
  version     = "~> 5.0"
  create_user = true

  name = "jason.riddle@awscli"

  create_iam_access_key         = true
  create_iam_user_login_profile = false
  password_reset_required       = false

  policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}

output "iam_cli_user_access_key_id" {
  value     = module.iam_cli_user.iam_access_key_id
  sensitive = true
}

output "iam_cli_user_access_key_secret" {
  value     = module.iam_cli_user.iam_access_key_secret
  sensitive = true
}

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user
module "iam_console_user" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-user"
  version     = "~> 5.0"
  create_user = true

  name = "jason.riddle@console"

  create_iam_access_key         = false
  create_iam_user_login_profile = true
  password_reset_required       = false

  policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user
module "iam_system_user" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-user"
  version     = "~> 5.0"
  create_user = true

  name = "terraform-cloud-infrastructure-system-user"

  create_iam_access_key         = true
  create_iam_user_login_profile = false
  password_reset_required       = false

  policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}

output "iam_system_user_access_key_id" {
  value     = module.iam_system_user.iam_access_key_id
  sensitive = true
}

output "iam_system_user_access_key_secret" {
  value     = module.iam_system_user.iam_access_key_secret
  sensitive = true
}
