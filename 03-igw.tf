resource "aws_internet_gateway" "project1_igw" {
  vpc_id = aws_vpc.project1_vpc.id

  tags = {
    "Name" = "project1_igw"
  }
}