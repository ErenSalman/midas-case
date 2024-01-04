resource "aws_autoscaling_group" "backend_server_asg" {
  depends_on          = [aws_subnet.public_subnets, aws_subnet.private_subnets, aws_lb.backend_alb]
  name                = "${var.app_name}-backend-server-asg"
  min_size            = 2
  max_size            = 3
  vpc_zone_identifier = [for subnet in aws_subnet.private_subnets : subnet.id]
  target_group_arns   = [aws_lb_target_group.backend_alb_tg_http.arn]

  launch_template {
    id      = aws_launch_template.backend_server.id
  }

  tag {
    key                 = "Name"
    value               = "${var.app_name}-backend-server-asg"
    propagate_at_launch = true
  }
}

# Scaling policy
resource "aws_autoscaling_policy" "backend_server_asg" {
  name                   = "${var.app_name}-asg-scaling-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.backend_server_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 75
  }
}