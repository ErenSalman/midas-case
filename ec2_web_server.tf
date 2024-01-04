resource "aws_launch_template" "web_server" {
  name                   = "${var.app_name}-web-server"
  image_id               = "ami-024f768332f080c5e"
  instance_type          = "t2.micro"
  user_data              = filebase64("${path.module}/web_server.sh")
#   key_name               = "ws-key-name"
  vpc_security_group_ids = [aws_security_group.asg_web_access_sg.id]

  tags = {
    "Name" = "${var.app_name}-web-server"
  }
}
