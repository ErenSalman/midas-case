resource "aws_autoscaling_group" "web_server_asg" {
  depends_on          = [aws_subnet.public_subnets, aws_subnet.private_subnets, aws_lb.web_alb]
  name                = "${var.app_name}-web-server-asg"
  min_size            = 2
  max_size            = 3
  vpc_zone_identifier = [for subnet in aws_subnet.private_subnets : subnet.id]
  target_group_arns   = [aws_lb_target_group.web_alb_tg_http.arn]

  launch_template {
    id      = aws_launch_template.web_server.id
  }

  tag {
    key                 = "Name"
    value               = "${var.app_name}-web-server-asg"
    propagate_at_launch = true
  }
}

# Scaling policy
resource "aws_autoscaling_policy" "web_server_asg" {
  name                   = "${var.app_name}-asg-scaling-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.web_server_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75
  }
}