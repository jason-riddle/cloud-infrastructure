data "aws_partition" "current" {}

module "tfstate_backend" {
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.3.0"
  enabled = true

  name = "terraform-cloud-infrastructure-tfstate-backend"

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = false
}
