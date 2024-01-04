data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = tolist(data.aws_availability_zones.available.names)[count.index]

  # When instance is launched, IP will be set to instance.
  map_public_ip_on_launch = var.auto_ipv4

  tags = {
    Name   = "Public-Subnet-${count.index + 1}"
    Subnet = "Public"

  }

}

# deploy the private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = tolist(data.aws_availability_zones.available.names)[count.index]

  tags = {
    Name   = "Private-Subnet-${count.index + 1}"
    Subnet = "Private"

  }

}