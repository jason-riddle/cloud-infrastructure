## Terraform Cloud

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user
# module "iam_system_user" {
#   source      = "terraform-aws-modules/iam/aws//modules/iam-user"
#   version     = "~> 5.0"
#   create_user = true

#   name = "terraform-cloud-infrastructure-system-user"

#   create_iam_access_key         = true
#   create_iam_user_login_profile = false
#   password_reset_required       = false

#   policy_arns = [
#     "arn:aws:iam::aws:policy/AdministratorAccess"
#   ]
# }

# output "iam_system_user_access_key_id" {
#   value     = module.iam_system_user.iam_access_key_id
#   sensitive = true
# }

# output "iam_system_user_access_key_secret" {
#   value     = module.iam_system_user.iam_access_key_secret
#   sensitive = true
# }

## N8n

# https://github.com/cloudposse/terraform-aws-iam-system-user/blob/main/examples/complete/main.tf
# module "n8n_cloud_system_user" {
#   source  = "cloudposse/iam-system-user/aws"
#   version = "~> 1.0"
#   enabled = true

#   name = "n8n-cloud-system-user"

#   ssm_enabled = false

#   create_iam_access_key = true

#   policy_arns_map = {
#     admin = "arn:aws:iam::aws:policy/AdministratorAccess"
#   }
# }

# output "n8n_cloud_system_user_access_key_id" {
#   value     = module.n8n_cloud_system_user.access_key_id
#   sensitive = true
# }

output "n8n_cloud_system_user_secret_access_key" {
  value     = module.n8n_cloud_system_user.secret_access_key
  sensitive = true
}
