resource "aws_route53_zone" "zone" {
  count = 1

  name          = "riddleapps.net"
  comment       = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
  force_destroy = true
}

resource "aws_route53_record" "nextcloud" {
  zone_id = aws_route53_zone.zone[*].zone_id
  name    = "nextcloud"
  type    = "CNAME"
  ttl     = 300
  records = ["nx15310.your-storageshare.de"]
}

output "zone_name_servers" {
  value = aws_route53_zone.zone[*].name_servers
}
