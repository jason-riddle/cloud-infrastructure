module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  zones = {
    "riddleapps.net" = {
      comment = "riddleapps.net"
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_name = keys(module.zones.route53_zone_zone_id)[0]

#   records = [
#     {
#       name    = "nextcloud"
#       type    = "CNAME"
#       ttl     = 3600
#       records = [
#         "nx15310.your-storageshare.de",
#       ]
#     },
#   ]

#   depends_on = [module.zones]
# }
