resource "aws_route_table_association" "rt_assoc_public1" {
  subnet_id = aws_subnet.subnet_public1.id

  route_table_id = aws_route_table.rt_public
}

resource "aws_route_table_association" "rt_assoc_public2" {
  subnet_id = aws_subnet.subnet_public2.id

  route_table_id = aws_route_table.rt_public
}

resource "aws_route_table_association" "rt_assoc_private1" {
  subnet_id = aws_subnet.subnet_private1.id

  route_table_id = aws_route_table.rt_private1.id
}

resource "aws_route_table_association" "rt_assoc_private2" {
  subnet_id = aws_subnet.subnet_private1.id

  route_table_id = aws_route_table.rt_private2.id
}