terraform {
  required_version = ">= 1.0.0"

  cloud {
    organization = "org-jasonriddle"

    workspaces {
      name = "cloud-infrastructure"
    }
  }

  required_providers {
    # DOCS: https://registry.terraform.io/providers/tailscale/tailscale/latest/docs
    # ENVS: TAILSCALE_OAUTH_CLIENT_ID, TAILSCALE_OAUTH_CLIENT_SECRET
    # CRED: https://login.tailscale.com/admin/settings/oauth -> terraform-cloud-infrastructure
    tailscale = {
      source = "tailscale/tailscale"
    }
  }
}
