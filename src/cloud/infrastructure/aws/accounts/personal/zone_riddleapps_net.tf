resource "aws_route53_zone" "riddleapps_net" {
  count = 1

  name          = "riddleapps.net"  # Set your domain name
  comment       = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
  force_destroy = true
}

output "riddleapps_net_name_servers" {
  value = aws_route53_zone.riddleapps_net[*].name_servers
}
