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
