# module "zones" {
#   source  = "terraform-aws-modules/route53/aws//modules/zones"
#   version = "~> 2.0"
#   create  = false

#   zones = {
#     "riddleapps.net" = {
#       comment = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
#     }
#   }

#   tags = {
#     Domain = "riddleapps.net"
#   }
# }

# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"
#   create  = false

#   zone_name = keys(module.zones.route53_zone_zone_id)[0]

#   records = [
#     {
#       name = "nextcloud"
#       type = "CNAME"
#       ttl  = 3600
#       records = [
#         "nx15310.your-storageshare.de",
#       ]
#     },
#   ]

#   depends_on = [module.zones]
# }
