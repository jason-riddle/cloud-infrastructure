# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user
module "jason_at_jasons_mac_mini" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-user"
  version     = "~> 5.0"
  create_user = true

  name = "jason@Jasons-Mac-Mini"

  create_iam_access_key         = true
  create_iam_user_login_profile = false
  password_reset_required       = false

  policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}

output "jason_at_jasons_mac_mini_access_key_id" {
  value     = module.jason_at_jasons_mac_mini.iam_access_key_id
  sensitive = true
}

output "jason_at_jasons_mac_mini_access_key_secret" {
  value     = module.jason_at_jasons_mac_mini.iam_access_key_secret
  sensitive = true
}

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user
module "jason_at_console" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-user"
  version     = "~> 5.0"
  create_user = true

  name = "jason@Console"

  create_iam_access_key         = false
  create_iam_user_login_profile = true
  password_reset_required       = false

  policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}
