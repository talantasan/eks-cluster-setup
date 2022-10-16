resource "aws_subnet" "subnet_public1" {
  vpc_id            = aws_vpc.project1_vpc.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-1a"

  # EKS requirement
  map_public_ip_on_launch = true

  tags = {
    "Name"                      = "public-us-east-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "subnet_public2" {
  vpc_id            = aws_vpc.project1_vpc.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "us-east-1b"

  # EKS requirement
  map_public_ip_on_launch = true

  tags = {
    "Name"                      = "public-us-east-1b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "subnet_private1" {
  vpc_id            = aws_vpc.project1_vpc.id
  cidr_block        = "10.0.64.0/19"
  availability_zone = "us-east-1a"

  # EKS requirement

  tags = {
    "Name"                            = "private-us-east-1a"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "subnet_private2" {
  vpc_id            = aws_vpc.project1_vpc.id
  cidr_block        = "10.0.96.0/19"
  availability_zone = "us-east-1b"

  # EKS requirement

  tags = {
    "Name"                            = "private-us-east-1b"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}