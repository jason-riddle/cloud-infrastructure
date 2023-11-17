terraform {
  required_version = ">= 1.0.0"

  cloud {
    organization = "org-jasonriddle"

    workspaces {
      name = "cloud-infrastructure"
    }
  }
}
