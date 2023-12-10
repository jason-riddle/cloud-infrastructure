# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-github-oidc-provider
# module "iam_github_oidc_provider" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
#   version = "~> 5.0"
#   create  = false
# }

# https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-github-oidc-role
# module "iam_github_oidc_role" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-role"
#   version = "~> 5.0"
#   create  = false

#   name = "terraform-cloud-infrastructure-gh-actions-iam-oidc-role"

#   subjects = [
#     # You can prepend with `repo:` but it is not required
#     "jason-riddle/cloud-infrastructure"
#     # "repo:jason-riddle/cloud-infrastructure"
#     # "repo:jason-riddle/cloud-infrastructure:pull_request",
#     # "repo:jason-riddle/cloud-infrastructure:ref:refs/heads/main",
#   ]

#   policies = {
#     admin = "arn:aws:iam::aws:policy/AdministratorAccess"
#   }
# }

### AWS - IAM - GitHub - OIDC - Outputs

# output "iam_github_oidc_role_arn" {
#   value     = module.iam_github_oidc_role.arn
#   sensitive = true
# }

# output "iam_github_oidc_role_name" {
#   value     = module.iam_github_oidc_role.name
#   sensitive = true
# }

# output "iam_github_oidc_role_path" {
#   value     = module.iam_github_oidc_role.path
#   sensitive = true
# }

# output "iam_github_oidc_role_unique_id" {
#   value     = module.iam_github_oidc_role.unique_id
#   sensitive = true
# }
