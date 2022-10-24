resource "aws_iam_role" "eks_role" {
  name               = "talant-eks-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": [
      {
        "Service": "eks.amazonaws.com"
        },
      "Action": "sts:AssumeRole"
      ]
    }
  ]
}
POLICY
}
