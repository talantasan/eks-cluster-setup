resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.project1_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project1_igw.id
  }

  tags = {
    "Name" = "project1-public-rt"
  }
}

resource "aws_route_table" "rt_private1" {
  vpc_id = aws_vpc.project1_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat1.id

  }

  tags = {
    "Name" = "project1-private1-rt"
  }
}

resource "aws_route_table" "rt_private2" {
  vpc_id = aws_vpc.project1_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat2.id
  }

  tags = {
    "Name" = "project1-private2-rt"
  }
}