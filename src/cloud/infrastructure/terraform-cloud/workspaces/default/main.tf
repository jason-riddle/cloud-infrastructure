locals {
  create = true
}

data "tfe_ip_ranges" "addresses" {}

data "tfe_organization" "org" {
  count = local.create ? 1 : 0

  name = "org-jasonriddle"
}

data "tfe_workspace" "workspace" {
  count = local.create ? 1 : 0

  name         = "cloud-infrastructure"
  organization = data.tfe_organization.org[0].name
}

resource "tfe_variable" "tfc_aws_provider_auth" {
  count = local.create ? 1 : 0

  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = var.tfc_aws_provider_auth
  category     = "env"
  workspace_id = data.tfe_workspace.workspace[0].id
  sensitive    = false
}

resource "tfe_variable" "tfc_aws_run_role_arn" {
  count = local.create ? 1 : 0

  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = var.tfc_aws_run_role_arn
  category     = "env"
  workspace_id = data.tfe_workspace.workspace[0].id
  sensitive    = false
}
