data "aws_iam_policy_document" "ssm_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ssm" {
  name               = "ssm"
  assume_role_policy = data.aws_iam_policy_document.ssm_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core_policy_attachment" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_ssm_activation" "activation" {
  depends_on = [aws_iam_role_policy_attachment.ssm_managed_instance_core_policy_attachment]

  name        = "test_ssm_activation"
  description = "Test"

  expiration_date = timeadd(timestamp(), "24h")

  registration_limit = "1000"

  iam_role = aws_iam_role.ssm.id
}

output "ssm_activation_id" {
  value     = aws_ssm_activation.activation.id
  sensitive = true
}

output "ssm_activation_code" {
  value     = aws_ssm_activation.activation.activation_code
  sensitive = true
}
