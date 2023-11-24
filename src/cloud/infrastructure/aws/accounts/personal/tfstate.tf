# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "tfstate_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.3.0"
  enabled = false

  name = "terraform-cloud-infrastructure-tfstate-backend"

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = false
}