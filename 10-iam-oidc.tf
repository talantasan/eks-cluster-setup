# https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html
/*
Applications in a pod’s containers can use an AWS SDK or the AWS CLI to make API requests to 
AWS services using AWS Identity and Access Management (IAM) permissions. 
Applications must sign their AWS API requests with AWS credentials. 
IAM roles for service accounts provide the ability to manage credentials for your applications, 
similar to the way that Amazon EC2 instance profiles provide credentials to Amazon EC2 instances. 
Instead of creating and distributing your AWS credentials to the containers or 
using the Amazon EC2 instance’s role, you associate an IAM role with a Kubernetes service account and 
configure your pods to use the service account. You can't use IAM roles for service accounts with 
local clusters for Amazon EKS on AWS Outposts.
*/

data "tls_certificate" "eks" {
    url = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  url = aws_eks_cluster.eks.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
}