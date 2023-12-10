## Terraform Cloud

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

## N8n

# https://github.com/cloudposse/terraform-aws-iam-system-user/blob/main/examples/complete/main.tf
# module "n8n_cloud_infrastructure_system_user" {
#   source  = "cloudposse/iam-system-user/aws"
#   version = "~> 1.0"
#   enabled = false

#   name = "n8n-cloud-infrastructure-system-user"

#   policy_arns_map = {
#     admin = "arn:aws:iam::aws:policy/AdministratorAccess"
#   }
# }
