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
