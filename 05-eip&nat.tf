resource "aws_eip" "nat1_eip" {
  depends_on = [
    aws_internet_gateway.project1_igw
  ]
}

resource "aws_eip" "nat2_eip" {
  depends_on = [
    aws_internet_gateway.project1_igw
  ]
}

resource "aws_nat_gateway" "nat1" {
  subnet_id = aws_subnet.subnet_public1.id
  allocation_id = aws_eip.nat1_eip.id

  tags = {
    "Name" = "project1-NAT1"
  }
}

resource "aws_nat_gateway" "nat2" {
  subnet_id = aws_subnet.subnet_public2.id
  allocation_id = aws_eip.nat2_eip.id

  tags = {
    "Name" = "project1-NAT2"
  }
}