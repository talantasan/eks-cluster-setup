resource "aws_iam_role" "eks_role" {
  name               = "talant-eks-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": 
      {
        "Service": "eks.amazonaws.com"
        },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_role.name
}


resource "aws_eks_cluster" "eks" {
  name = "talant-eks"
  role_arn = aws_iam_role.eks_role.arn 
  
  #K8s master version
  version = "1.22"

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true

    subnet_ids = [
        aws_subnet.subnet_public1.id,
        aws_subnet.subnet_public2.id,
        aws_subnet.subnet_private1.id,
        aws_subnet.subnet_private2.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}


resource "null_resource" "set-kubeconfig" {
 depends_on = [
   aws_eks_cluster.eks
 ]
 triggers = {
   always_run = "${timestamp()}"
 }
 
 provisioner "local-exec" {
   command = "aws eks --region us-east-1 update-kubeconfig --name ${aws_eks_cluster.eks.name} --profile project1"
 }
}
