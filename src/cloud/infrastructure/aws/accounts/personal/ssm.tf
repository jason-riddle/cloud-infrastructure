data "aws_iam_role" "ec2_run_command_role" {
  name = "AmazonEC2RunCommandRoleForManagedInstances"
}

resource "aws_ssm_activation" "activation" {
  name        = "test_ssm_activation"
  description = "Test"

  registration_limit = "1000"

  iam_role = data.aws_iam_role.ec2_run_command_role.id
}

output "ssm_activation_id" {
  value     = aws_ssm_activation.activation.id
  sensitive = true
}

output "ssm_activation_code" {
  value     = aws_ssm_activation.activation.activation_code
  sensitive = true
}
