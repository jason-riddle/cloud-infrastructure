# data "aws_availability_zones" "available" {}

# resource "aws_lightsail_instance" "lightsail_instance" {
#   name              = ""
#   availability_zone = data.aws_availability_zones.available.names[0]
#   blueprint_id      = "ubuntu_22_04"
#   bundle_id         = "medium_3_0"

#   key_pair_name = ""
# }

# output "lightsail_instance_public_ip_address" {
#   value = aws_lightsail_instance.lightsail_instance.public_ip_address
# }
