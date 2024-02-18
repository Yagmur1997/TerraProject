resource "aws_iam_policy" "ec2_admin_policy" {
  name        = "EC2AdminPolicy"
  description = "Full EC2 Admin Policy"

  policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "ec2:*",
          "Resource": "*"
        }
      ]
    }
  EOF
}

resource "aws_iam_instance_profile" "BH_profile" {
  name = "role_profile"
  role = aws_iam_role.BH_role.name
}

resource "aws_iam_role" "BH_role" {
  name = "BastionHostRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_ec2_admin_policy" {
  policy_arn = aws_iam_policy.ec2_admin_policy.arn
  role       = aws_iam_role.BH_role.name
}