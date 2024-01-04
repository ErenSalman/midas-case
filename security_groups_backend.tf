# Backend server Load Balancer ASG access security group
resource "aws_security_group" "asg_backend_lb_access_sg" {
  name        = "${var.app_name}-asg-backend-lb-access-sg"
  description = "Allow http traffic from ASG-BACKEND-LB"
  vpc_id      = aws_vpc.vpc.id

  # allow http 80 port
  ingress {
    description     = "allow http traffic from asg-backend-lb sg"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.asg_web_access_sg.id]
  }
  # Can be used https rules

  # allow all ports for outbound
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  timeouts {
    delete = "3m"
  }

  tags = {
    Name = "${var.app_name}-asg_web-access-sg"
  }
}

# Backend server ASG access security group
resource "aws_security_group" "asg_backend_access_sg" {
  name        = "${var.app_name}-asg-backend-access-sg"
  description = "Allow http traffic from ASG-BACKEND"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "ssh from IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow http 80 port
  ingress {
    description     = "allow http traffic from asg-backend sg"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.asg_backend_lb_access_sg.id]
  }

  # allow all ports for outbound
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  timeouts {
    delete = "3m"
  }

  tags = {
    Name = "${var.app_name}-asg_web-access-sg"
  }
}