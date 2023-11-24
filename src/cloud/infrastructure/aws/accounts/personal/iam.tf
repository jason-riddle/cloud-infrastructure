# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-github-oidc-provider
# module "iam_github_oidc_provider" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
#   version = "5.32.0"
#   create  = true
# }

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-github-oidc-role
# module "iam_github_oidc_role" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
#   version = "5.32.0"
#   create  = true
# }

module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 5.0"

  name = "vasya.pupkin4"

  create_iam_access_key         = false
  create_iam_user_login_profile = false
}

# module "iam_group" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-assumable-roles-policy"
#   version = "~> 5.0"

#   name = "test-admins"

#   group_users = [
#     module.iam_user.iam_user_name,
#   ]
# }
