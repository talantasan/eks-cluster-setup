data "aws_iam_policy_document" "oidc_assume_role_policy_test" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    effect = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:aws-test"]
    }

    principals {
        identifiers = [aws_iam_openid_connect_provider.eks.arn]
        type        = "Federated"
    }

  }
}

resource "aws_iam_role" "test_oidc"{
    assume_role_policy = data.aws_iam_policy_document.oidc_assume_role_policy_test.json
    name               = "talant-oidc-sa-role" 
}

resource "aws_iam_policy" "s3_reader_test" {
    name = "talant-s3-reader-policy"
    policy = jsonencode({
        Statement = [{
            Action = [
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation"
            ]
            Effect = "Allow"
            Resource = "arn:aws:s3:::*"
        }]
        Version = "2012-10-17"
    })
}


resource "aws_iam_policy_attachment" "oidc_policy_attachement" {
  name       = "oidc-role-attachement"
  roles      = [aws_iam_role.test_oidc.name]
  policy_arn = aws_iam_policy.s3_reader_test.arn
}

output "oidc_role_arn" {
  value       = aws_iam_role.test_oidc.arn
}
