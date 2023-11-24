resource "aws_route53_zone" "riddleproperty_com" {
  count = 1

  name          = "riddleproperty.com"  # Set your domain name
  comment       = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
  force_destroy = true
}

output "riddleproperty_com_name_servers" {
  value = aws_route53_zone.riddleproperty_com[*].name_servers
}
