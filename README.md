# MIDAS-CaseApp

This terraform scripts deploy an AWS infrastructure for a web application, including a vpc, subnets, security groups, load balancers, and auto scaling groups (ASGs) for frontend and backend servers. The infrastructure is designed for a high-availability and secure setup with both public and private subnets.

## Configuration
The terraform scripts includes various configuration variables that you can customize according to your requirements. Key variables include:

- aws_region: The AWS region where the infrastructure will be deployed. Default is set to "eu-central-1" (Frankfurt). Because we aim to minimum latency

- app_name: A prefix used for naming resources, default is set to "caseapp".

- vpc_cidr: The CIDR block for the VPC, default is set to "10.0.0.0/16".

- public_subnet_cidrs: CIDR blocks for public subnets. ("10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24")

- private_subnet_cidrs: CIDR blocks for private subnets. ("10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24")

## Infrastructure Components

### VPC:

The script creates a VPC with the specified CIDR block ("10.0.0.0/16").

### Subnets:

- Public subnets: Used for resources that need to be accessible from the internet. Used public_subnet_cidrs variable.
- Private subnets: Used for backend servers that should not be directly accessible from the internet. Used private_subnet_cidrs variable.

### Security Groups:

- alb_access_sg: Security group for ALB allowing HTTP (port 80) and HTTPS (port 443) traffic.

- asg_web_access_sg: Security group for web server ASG allowing SSH (port 22) and traffic from alb_access_sg.

- asg_backend_lb_access_sg: Security group for backend server LB ASG allowing traffic from asg_web_access_sg.

- asg_backend_access_sg: Security group for backend server ASG allowing SSH (port 22) and traffic from asg_backend_lb_access_sg.

### Internet Gateway:

An internet gateway is attached to the VPC to allow outbound internet traffic.

### NAT Gateway:

A NAT gateway is created for private subnets to allow outbound internet access for instances in private subnets. So backend servers fetch data from an external source. The resource name is "caseapp-nat"

### Launch Templates:

Launch templates for web and backend servers. We apply httpd process for web servers. For this example also we apply httpd for backend servers too, only for seeing to enable port in backend EC2 instances.

### Auto Scaling Groups (ASGs):

ASG for backend servers with a target tracking scaling policy based on average CPU utilization. IF CPU utilization is increased over %75, scaling up action will be processed.

### Application Load Balancer (ALB):

We have two ALB in our environment. First load balancer is to get request from outside of vpc and forward to web servers. 
The second load balancer is getting requests from web servers and routing to backend servers. And this load balancer is closed to the outside.

### Outputs
- load_balancer_dns: The DNS name of the ALB for accessing the web application.

- vpc_id: The ID of the VPC.

- public_subnets: List of IDs for public subnets.

- private_subnets: List of IDs for private subnets.

- nat_gw_ip: Public IP of the NAT gateway.

### Usage
Clone the repository and navigate to the directory containing the Terraform script.

Run the following commands:

```
terraform init
terraform plan
terraform apply
```

Once the deployment is complete, Terraform will display the outputs, including the ALB DNS name.

Access your web application using the provided ALB DNS name.

#### Example Outputs
```
Outputs:

load_balancer_dns = "http://caseapp-web-lb-450394289.eu-central-1.elb.amazonaws.com"
nat_gw_ip = "52.29.8.28"
private_subnets = [
  "subnet-06f44f86d7e9dbd37",
  "subnet-0a2a1d5ad729f4451",
  "subnet-0e27effc5763002ac",
]
public_subnets = [
  "subnet-06e1abe5bc725b0c4",
  "subnet-088b3ed51d451570e",
  "subnet-0d75912087bd67f79",
]
vpc_id = "vpc-05d42fe661107cee0"
```

Note: Ensure that you have appropriate AWS credentials configured on your machine before running Terraform commands.
