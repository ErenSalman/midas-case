resource "aws_lb" "web_alb" {
  depends_on         = [aws_subnet.public_subnets, aws_subnet.private_subnets]
  name               = "${var.app_name}-web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_access_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]

  tags = {
    Name = "${var.app_name}-web-lb"
  }
}

# ALB target groups 
#----------------------------------------
# HTTP
resource "aws_lb_target_group" "web_alb_tg_http" {
  depends_on = [aws_lb.web_alb]
  name       = "${var.app_name}-web-server-tg-http"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.vpc.id
}

# ALB listeners
#----------------------------------------
# HTTP
resource "aws_lb_listener" "web_alb_listener_http" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_tg_http.arn
  }
}