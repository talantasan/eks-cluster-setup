resource "aws_iam_role" "worker_node_role" {
  name               = "talant-eks-worker-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": 
      {
        "Service": "ec2.amazonaws.com"
        },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.worker_node_role.name 
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.worker_node_role.name 
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.worker_node_role.name 
}

resource "aws_eks_node_group" "eks_worker_node" {
  cluster_name = aws_eks_cluster.eks.name
  node_group_name = "talant-worker-nodes"
  node_role_arn = aws_iam_role.worker_node_role.arn
  subnet_ids = [ 
    aws_subnet.subnet_private1.id,
    aws_subnet.subnet_private2.id 
    ]
  scaling_config {
    desired_size =1
    max_size = 1
    min_size = 1
  }

  ami_type = "AL2_x86_64"
  capacity_type = "ON_DEMAND"
  disk_size = 20
  force_update_version = false
  instance_types = [ "t3.small" ]

  labels = {
    "role" = "talant-worker-node"
  }
  version = "1.22"
  depends_on = [
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
    aws_iam_role_policy_attachment.amazon_eks_worker_node_cluster_policy,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy
  ]
}
