resource "aws_lb" "backend_alb" {
  depends_on         = [aws_subnet.public_subnets, aws_subnet.private_subnets]
  name               = "${var.app_name}-backend-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.asg_backend_lb_access_sg.id]
  subnets            = [for subnet in aws_subnet.private_subnets : subnet.id]

  tags = {
    Name = "${var.app_name}-backend-lb"
  }
}

# ALB target groups 
#----------------------------------------
# HTTP
resource "aws_lb_target_group" "backend_alb_tg_http" {
  depends_on = [aws_lb.backend_alb]
  name       = "${var.app_name}-backend-server-tg-http"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.vpc.id
}

# ALB listeners
#----------------------------------------
# HTTP
resource "aws_lb_listener" "backend_alb_listener_http" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_alb_tg_http.arn
  }
}