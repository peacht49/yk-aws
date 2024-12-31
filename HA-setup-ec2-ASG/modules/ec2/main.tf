resource "aws_instance" "web_instance" {
  ami = var.ami
  instance_type = var.instance_type
  count = var.instance_count
  # Dynamically select subnet ID based on count.index
  # var.subnet_ids should be a list of subnet IDs passed from root main.tf
  subnet_id = var.subnet_id[count.index]

  # VPC security groups should be a list in var
  tags = {
    Name = "web_instance-${count.index +1}"
  }

  security_groups = var.security_group_ids

  user_data = var.user_data
  key_name = var.key_name
}

resource "aws_launch_template" "web-ASG-LT" {
  name = "web-launch-template"

  image_id = var.ami
  instance_type = var.instance_type
}