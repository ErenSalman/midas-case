# Web access security group 
resource "aws_security_group" "alb_access_sg" {
  name        = "${var.app_name}-alb-access-sg"
  vpc_id      = aws_vpc.vpc.id

  # allow http 80 port
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow https 443 port
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    Name = "${var.app_name}-alb-access-sg"
  }
}

# Web server ASG access security group
resource "aws_security_group" "asg_web_access_sg" {
  name        = "${var.app_name}-asg-web-access-sg"
  description = "Allow http traffic from ASG-WEB"
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
    description     = "allow http traffic from asg-web sg"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_access_sg.id]
  }
  # allow https 443 port
  ingress {
    description     = "allow https traffic from asg-web sg"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_access_sg.id]
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
    Name = "${var.app_name}-asg-web-access-sg"
  }
}
