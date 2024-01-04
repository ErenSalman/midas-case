resource "aws_internet_gateway" "igw-new" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app_name}-igw-new"
  }
}

resource "aws_eip" "eip" {
}

resource "aws_nat_gateway" "nat_gw" {
  depends_on    = [aws_internet_gateway.igw-new]
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.app_name}-nat"
  }
}