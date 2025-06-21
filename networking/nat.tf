resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet1.id  # NAT GW in a public subnet

  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id

  depends_on = [aws_nat_gateway.nat_gw]
}

resource "aws_route_table_association" "private_subnet1_assoc" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_subnet2_assoc" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_rt.id
}
