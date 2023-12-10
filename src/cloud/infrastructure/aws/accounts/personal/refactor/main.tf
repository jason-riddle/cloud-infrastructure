## IAM

# https://github.com/cloudposse/terraform-aws-iam-role/blob/0.19.0/examples/complete/main.tf
module "terraform_cloud_iam_oidc_role" {
  source  = "cloudposse/iam-role/aws"
  version = "~> 0.0"
  enabled = false
}

# https://github.com/cloudposse/terraform-aws-iam-user/blob/main/examples/complete/main.tf
# module "jason_riddle" {
#   source  = "cloudposse/iam-user/aws"
#   version = "~> 0.0"
#   enabled = false

#   name      = "jack"
#   user_name = "jack@companyname.com"
#   pgp_key   = ""
#   groups    = ["admins"]
# }

# https://github.com/cloudposse/terraform-aws-iam-system-user/blob/main/examples/complete/main.tf
module "terraform_cloud_infrastructure_system_user" {
  source  = "cloudposse/iam-system-user/aws"
  version = "~> 1.0"
  enabled = false

  name = "terraform-cloud-infrastructure-system-user"

  policy_arns_map = {
    admin = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
}
