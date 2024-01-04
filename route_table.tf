# Public rt
resource "aws_default_route_table" "public_rt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = var.all_traffic
    gateway_id = aws_internet_gateway.igw-new.id
  }
  tags = {
    Name = "${var.app_name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)  
  route_table_id = aws_default_route_table.public_rt.id
  depends_on     = [aws_subnet.public_subnets]
}

# Private rt
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.all_traffic
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "${var.app_name}-private-rt"
  }
}

# Private rt assoc.
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)  
  route_table_id = aws_route_table.private_rt.id
  depends_on     = [aws_subnet.private_subnets]
}