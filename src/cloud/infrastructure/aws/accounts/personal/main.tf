locals {
  aws_account_id = data.aws_caller_identity.current.account_id
  partition      = data.aws_partition.current.partition
}

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
