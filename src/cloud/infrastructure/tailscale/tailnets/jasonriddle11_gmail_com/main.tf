locals {
  timestamp = formatdate("MMM-YYYY", timestamp())
}

data "tailscale_devices" "devices" {}

## GitHub Actions

resource "tailscale_tailnet_key" "github_actions_ansible_role_tailscale_authkey" {
  count = 1

  description = "${local.timestamp} -GHA- Ansible Role Tailscale Authkey"

  reusable      = true
  ephemeral     = true
  preauthorized = true
  expiry        = 7776000 # 90 Days
  tags          = ["tag:github-actions"]
}

output "github_actions_ansible_role_tailscale_authkey" {
  value     = tailscale_tailnet_key.github_actions_ansible_role_tailscale_authkey[0].key
  sensitive = true
}

resource "tailscale_tailnet_key" "github_actions_homelab_authkey" {
  count = 1

  description = "${local.timestamp} -GHA- Homelab Authkey"

  reusable      = true
  ephemeral     = true
  preauthorized = true
  expiry        = 7776000 # 90 Days
  tags          = ["tag:github-actions"]
}

output "github_actions_homelab_authkey" {
  value     = tailscale_tailnet_key.github_actions_homelab_authkey[0].key
  sensitive = true
}

## Homelab

resource "tailscale_tailnet_key" "homelab_authkey" {
  count = 1

  description = "${local.timestamp} Homelab Authkey"

  reusable      = true
  ephemeral     = false
  preauthorized = true
  expiry        = 7776000 # 90 Days
  tags          = ["tag:homelab"]
}

output "homelab_authkey" {
  value     = tailscale_tailnet_key.homelab_authkey[0].key
  sensitive = true
}
