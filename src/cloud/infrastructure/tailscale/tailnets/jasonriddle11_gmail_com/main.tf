locals {
  timestamp = formatdate("MMM-YYYY", "2018-01-02T23:12:01Z")
}

data "tailscale_devices" "devices" {}

# Ephemeral

resource "tailscale_tailnet_key" "github_actions_ansible_role_tailscale_authkey" {
  count = 1

  description = "${local.timestamp} Ansible Role Tailscale Authkey"

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

  description = "${local.timestamp} Homelab Authkey"

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
