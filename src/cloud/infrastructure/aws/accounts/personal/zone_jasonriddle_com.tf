resource "aws_route53_zone" "jasonriddle_com" {
  count = 1

  name          = "jasonriddle.com"  # Set your domain name
  comment       = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
  force_destroy = true
}

resource "aws_route53_record" "www_jasonriddle_com" {
  zone_id = aws_route53_zone.jasonriddle_com[*].zone_id
  name    = "www"  # Set the subdomain
  type    = "A"
  ttl     = 300    # Set the Time to Live (TTL) in seconds
  records = ["185.212.71.169"]  # Set the target domain or endpoint
}

output "jasonriddle_com_name_servers" {
  value = aws_route53_zone.jasonriddle_com[*].name_servers
}
