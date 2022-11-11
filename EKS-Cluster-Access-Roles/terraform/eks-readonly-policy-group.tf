resource "aws_iam_role_policy" "eks_ro_policy" {
  name = "eks_iam_role_read_only"
  role = aws_iam_role.eks_ro_role.id
  policy = file("./eks-ro-policy.json")
}

resource "aws_iam_role" "eks_ro_role" {
  name = "eks_readonly_role"

  assume_role_policy = file("./assume-role.json")
}