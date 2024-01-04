resource "aws_launch_template" "backend_server" {
  name                   = "${var.app_name}-backend-server"
  image_id               = "ami-024f768332f080c5e"
  instance_type          = "t2.micro"
  user_data              = filebase64("${path.module}/backend_server.sh")
  vpc_security_group_ids = [aws_security_group.asg_backend_access_sg.id]

  tags = {
    "Name" = "${var.app_name}-backend-server"
  }
}