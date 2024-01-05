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