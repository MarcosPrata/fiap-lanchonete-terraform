# Private route table
resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    { "Name" : "${var.project_name}-private-route-table-a" }
  )
}

resource "aws_route_table_association" "private_route_table_a_private_subnet_a_association" {
  route_table_id = aws_route_table.private_route_table_a.id
  subnet_id      = aws_subnet.private_subnet_a.id
}

resource "aws_route" "private_route_table_a_nat_gateway_a_route_association" {
  route_table_id         = aws_route_table.private_route_table_a.id
  nat_gateway_id         = aws_nat_gateway.nat_public_a.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table" "private_route_table_b" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    { "Name" : "${var.project_name}-private-route-table-b" }
  )
}

resource "aws_route_table_association" "private_route_table_b_private_subnet_b_association" {
  route_table_id = aws_route_table.private_route_table_b.id
  subnet_id      = aws_subnet.private_subnet_b.id
}

resource "aws_route" "private_route_table_b_nat_gateway_b_route_association" {
  route_table_id         = aws_route_table.private_route_table_b.id
  nat_gateway_id         = aws_nat_gateway.nat_public_b.id
  destination_cidr_block = "0.0.0.0/0"
}



# Public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    { "Name" : "${var.project_name}-public-route-table" }
  )

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet_a_route" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_b_route" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}
