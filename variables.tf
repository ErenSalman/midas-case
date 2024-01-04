# This is for turkey geo, aim is minimum latency
variable "aws_region" {
  type    = string
  default = "eu-central-1"
}
# naming vars
#---------------------------------------
variable "app_name" {
  type        = string
  description = "app name prefix for naming"
  default     = "caseapp"
}

# vpc vars
#----------------------------------------
variable "vpc_cidr" {
  type        = string
  description = "VPC cidr block"
  default     = "10.0.0.0/16"
}

# private subnet vars (ha )
#----------------------------------------
# variable "private_subnets" {
#   default = {
#     "private-subnet-a" = 0
#     "private-subnet-b" = 1
#     "private-subnet-c" = 2
#   }
# }

# # public subnet vars
# #----------------------------------------
# variable "public_subnets" {
#   default = {
#     "public-subnet-a" = 0
#     "public-subnet-b" = 1
#     "public-subnet-c" = 2
#   }
# }

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "auto_ipv4" {
  type        = bool
  description = "enable auto-assign ipv4"
  default     = true
}

# common cidrs
#----------------------------------------
variable "all_traffic" {
  type        = string
  description = "all all traffic"
  default     = "0.0.0.0/0"
}

variable "NAT_subnet" {
  type        = string
  description = "subnet location for NAT"
  default     = "us"
}

variable "web_access_sg" {
  type        = map(any)
  description = "web access security group vars "
  default = {
    "create_before_destroy" = true
    "timeout_delete"        = "2m"
  }
}

variable "alb_access_sg" {
  type        = map(any)
  description = "alb instance security group vars "
  default = {
    "create_before_destroy" = true
    "timeout_delete"        = "2m"
  }
}


# ec2 vars
#----------------------------------------
variable "web_server_name" {
  type    = string
  default = "web-server"
}
variable "web_server_ami" {
  type        = string
  description = "Instance AMI: Amazon Linux 2"
  default     = "ami-024f768332f080c5e"
}
variable "web_server_type" {
  type    = string
  default = "t2.micro"
}

variable "key_pair" {
  type        = string
  description = "ec2 key pair"
  default     = "webServer_key"
}

variable "user_data_file" {
  type        = string
  description = "user data file path"
  default     = "install_httpd.sh"
}

# ASG vars
#----------------------------------------
variable "web_asg_capacity" {
  type        = map(any)
  description = "min, max, and desired instance capacity"
  default = {
    "min" = 2
    "max" = 5
  }
}
variable "web_asg_health_check_type" {
  type        = string
  description = "health check type"
  default     = "ELB"
}
variable "web_asg_scaling_policy" {
  type        = map(any)
  description = "scaling policy"
  default = {
    "policy_type"  = "TargetTrackingScaling"
    "metric_type"  = "ASGAverageCPUUtilization"
    "target_value" = 75.0
  }
}

# ALB vars
#----------------------------------------
variable "load_balancer_name" {
  type        = string
  description = "load balancer name"
  default     = "web-alb"
}

variable "load_balancer_internal" {
  type        = bool
  description = "Is looad balancer internal facing?"
  default     = false
}

variable "load_balancer_type" {
  type        = string
  description = "load balancer"
  default     = "application"
}

# ALB target group vars
#----------------------------------------
variable "web_alb_tg_http" {
  type        = map(any)
  description = "http target group vars"
  default = {
    "name"     = "web-server-tg-http"
    "port"     = 80
    "protocol" = "HTTP"

  }
}

variable "web_alb_tg_https" {
  type        = map(any)
  description = "https target group vars"
  default = {
    "name"     = "web-server-tg-https"
    "port"     = 443
    "protocol" = "HTTPS"

  }
}

# ALB listener vars
#----------------------------------------
variable "web_alb_listener_http" {
  type        = map(any)
  description = "http listener vars"
  default = {
    "port"        = 80
    "protocol"    = "HTTP"
    "action_type" = "forward"
  }
}

variable "web_alb_listener_https" {
  type        = map(any)
  description = "https listener vars"
  default = {
    "port"        = 443
    "protocol"    = "HTTPS"
    "action_type" = "forward"
  }
}