resource "aws_vpc" "project1_vpc" {
  cidr_block = "10.0.0.0/16"

  instance_tenancy = "default"

  # Required for EKS
  enable_dns_hostnames = true

  # Required for EKS
  enable_dns_support = true

  enable_classiclink_dns_support = false
  enable_classiclink = false
  assign_generated_ipv6_cidr_block = false
  
  tags = {
    "name" = "project1"
  }
}

# Useful for using in modules
output "project1_vpc_id" {
  value = aws_vpc.project1_vpc.id
  description = "project1 vpc id"
}