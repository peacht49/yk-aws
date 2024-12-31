terraform {
   required_version = ">= 1.4.0"
   required_providers {
     aws = {
       source  = "hashicorp/aws"
       version = ">= 5.0.0"
     }
   }
 }

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}


# (Left) ec2's own variable name, (right) passing vpc module output's value path
module "ec2" {
  source = "./modules/ec2"
  subnet_id = [module.vpc.subnet_az1_id,module.vpc.subnet_az2_id]
  security_group_ids = [module.vpc.security_group_id] # Defined as string in VPC, but list of string in EC2
  # As we want to have option of more than 1 security group for ec2, so pass this as a list [ ]
}


module "load_balancer" {
  source = "./modules/load_balancer"
  vpc_id = module.vpc.vpc_id
  subnets = [module.vpc.subnet_az1_id, module.vpc.subnet_az2_id]
}

# Note: Always reference module output in root main.tf

# Define ASG
resource "aws_autoscaling_group" "web-ASG" {
  desired_capacity = 2
  min_size = 1
  max_size = 3
  vpc_zone_identifier = [module.vpc.subnet_az1_id, module.vpc.subnet_az2_id]

  launch_template {
    id = module.ec2.web_launch_template.id
    version = "$Latest"
  }

  health_check_type = "EC2"
  health_check_grace_period = 300
}

# Output display name 
output "web-ASG" {
  value = aws_autoscaling_group.web-ASG
}