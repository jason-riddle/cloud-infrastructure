# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user
module "iam_hass_system_user" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-user"
  version     = "~> 5.0"
  create_user = true

  name = "hass-system-user"

  create_iam_access_key         = true
  create_iam_user_login_profile = false
  password_reset_required       = false

  policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}

output "iam_hass_system_user_access_key_id" {
  value     = module.iam_hass_system_user.iam_access_key_id
  sensitive = true
}

output "iam_hass_system_user_access_key_secret" {
  value     = module.iam_hass_system_user.iam_access_key_secret
  sensitive = true
}
