data "tfe_ip_ranges" "addresses" {}

data "tfe_organization" "org" {
  name = "org-jasonriddle"
}

data "tfe_workspace" "workspace" {
  name         = "cloud-infrastructure"
  organization = data.tfe_organization.org.name
}
