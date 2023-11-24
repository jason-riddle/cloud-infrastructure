locals {
  enable_zone = true
}

resource "aws_route53_zone" "zone" {
  count = local.enable_zone ? 1 : 0

  name          = "riddleapps.net"
  comment       = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
  force_destroy = true
}

resource "aws_route53_record" "nextcloud" {
  count = local.enable_zone ? 1 : 0

  zone_id = one(aws_route53_zone.zone[*].zone_id)
  name    = "nextcloud"
  type    = "CNAME"
  ttl     = 300
  records = ["nx15310.your-storageshare.de"]
}

output "zone_name_servers" {
  value = local.enable_zone ? aws_route53_zone.zone[*].name_servers : null
}
