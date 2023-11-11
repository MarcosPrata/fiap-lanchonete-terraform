resource "aws_eip" "eip_nat_a" {
  vpc  = true
  tags = var.tags
}

resource "aws_eip" "eip_nat_b" {
  vpc  = true
  tags = var.tags
}

resource "aws_nat_gateway" "nat_public_a" {
  allocation_id     = aws_eip.eip_nat_a.id
  subnet_id         = aws_subnet.public_subnet_a.id
  connectivity_type = "public"

  tags = merge(
    var.tags,
    { "Name" : "${var.project_name}-${var.app_env}a-nat-gateway" }
  )

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_public_b" {
  allocation_id     = aws_eip.eip_nat_b.id
  subnet_id         = aws_subnet.public_subnet_b.id
  connectivity_type = "public"

  tags = merge(
    var.tags,
    { "Name" : "${var.project_name}-${var.app_env}b-nat-gateway" }
  )

  depends_on = [aws_internet_gateway.igw]
}

