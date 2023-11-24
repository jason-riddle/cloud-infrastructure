resource "aws_route53_zone" "jasonriddle_com" {
  count = 0

  name          = "jasonriddle.com"
  comment       = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
  force_destroy = true
}

resource "aws_route53_record" "www_jasonriddle_com" {
  zone_id = aws_route53_zone.jasonriddle_com[*].zone_id
  name    = "www"
  type    = "A"
  ttl     = 300
  records = ["185.212.71.169"]
}

output "jasonriddle_com_name_servers" {
  value = aws_route53_zone.jasonriddle_com[*].name_servers
}
