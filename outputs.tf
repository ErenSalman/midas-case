output "load_balancer_dns" {
  description = "ALB public DNS"
  value       = "http://${aws_lb.web_alb.dns_name}"
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "public_subnets" {
  description = "Public subnets"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnets" {
  description = "Private subnets"
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "nat_gw_ip" {
  description = "NAT Gateway IP"
  value       = aws_nat_gateway.nat_gw.public_ip
}