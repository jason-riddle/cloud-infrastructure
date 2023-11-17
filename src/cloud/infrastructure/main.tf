module "gh_homelab" {
  source = "./github/repos/homelab"
}

module "ts_jasonriddle11_gmail_com" {
  source = "./tailscale/tailnets/jasonriddle11_gmail_com"
}
