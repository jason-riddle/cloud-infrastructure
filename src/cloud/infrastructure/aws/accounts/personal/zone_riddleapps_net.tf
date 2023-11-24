resource "aws_route53_zone" "riddleapps_net" {
  count = 1

  name          = "riddleapps.net"  # Set your domain name
  comment       = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
  force_destroy = true
}

resource "aws_route53_record" "nextcloud_riddleapps_net" {
  zone_id = aws_route53_zone.jasonriddle_com[*].zone_id
  name    = "nextcloud"  # Set the subdomain
  type    = "CNAME"
  ttl     = 300    # Set the Time to Live (TTL) in seconds
  records = ["nx15310.your-storageshare.de"]  # Set the target domain or endpoint
}

output "riddleapps_net_name_servers" {
  value = aws_route53_zone.riddleapps_net[*].name_servers
}
