resource "aws_route53_zone" "jasonriddle_com" {
  count = 1

  name          = "jasonriddle.com"  # Set your domain name
  comment       = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
  force_destroy = true
}

output "jasonriddle_com_name_servers" {
  value = aws_route53_zone.jasonriddle_com[*].name_servers
}
