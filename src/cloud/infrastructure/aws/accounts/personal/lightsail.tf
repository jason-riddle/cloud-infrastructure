# data "aws_availability_zones" "available" {}

# resource "aws_lightsail_instance" "instance" {
#   name              = "drupal.ec2"
#   availability_zone = data.aws_availability_zones.available.names[0]
#   blueprint_id      = "ubuntu_22_04"
#   bundle_id         = "medium_3_0"

#   key_pair_name = aws_lightsail_key_pair.jasons_mac_mini.id
# }

# resource "aws_lightsail_key_pair" "jasons_mac_mini" {
#   name       = "jason@Jasons-Mac-Mini"
#   public_key = file("~/.ssh/id_ed25519.pub")
# }
