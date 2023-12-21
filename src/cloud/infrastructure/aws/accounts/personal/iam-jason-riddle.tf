# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user
module "jason_riddle_awscli" {
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

output "jason_riddle_awscli_access_key_id" {
  value     = module.jason_riddle_awscli.iam_access_key_id
  sensitive = true
}

output "jason_riddle_awscli_access_key_secret" {
  value     = module.jason_riddle_awscli.iam_access_key_secret
  sensitive = true
}

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user
# module "iam_console_user" {
#   source      = "terraform-aws-modules/iam/aws//modules/iam-user"
#   version     = "~> 5.0"
#   create_user = true

#   name = "jason.riddle@console"

#   create_iam_access_key         = false
#   create_iam_user_login_profile = true
#   password_reset_required       = false

#   policy_arns = [
#     "arn:aws:iam::aws:policy/AdministratorAccess"
#   ]
# }
