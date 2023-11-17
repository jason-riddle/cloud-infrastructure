# TF VARS: https://app.terraform.io/app/org-jasonriddle/workspaces/cloud-infrastructure/variables

terraform {
  required_version = ">= 1.0.0"

  cloud {
    organization = "org-jasonriddle"

    workspaces {
      name = "cloud-infrastructure"
    }
  }

  required_providers {
    # DOCS: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
    # ENVS: AWS_REGION, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
    # CRED: https://us-east-1.console.aws.amazon.com/iamv2/home?region=us-east-1#/users/details/terraform-cloud-infrastructure?section=permissions
    # NAME: terraform-cloud-infrastructure
    # PERM: AdministratorAccess
    # PREF: AKIAR42
    aws = {
      source = "hashicorp/aws"
    }

    # DOCS: https://registry.terraform.io/providers/integrations/github/latest/docs
    # ENVS: GITHUB_TOKEN
    # CRED: https://github.com/settings/tokens
    # NAME: terraform-cloud-infrastructure
    # PERM: ''
    # PREF: ghp_pwq
    github = {
      source = "integrations/github"
    }

    # DOCS: https://registry.terraform.io/providers/tailscale/tailscale/latest/docs
    # ENVS: TAILSCALE_OAUTH_CLIENT_ID, TAILSCALE_OAUTH_CLIENT_SECRET
    # CRED: https://login.tailscale.com/admin/settings/oauth
    # NAME: terraform-cloud-infrastructure
    # PERM: scopes:all
    # PREF: ktxGCS
    tailscale = {
      source = "tailscale/tailscale"
    }
  }
}
