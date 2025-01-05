# modules/ec2/outputs.tf

output "web_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web_instance[*].id
  # * because instance in main.tf has count set
}

output "web_instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.web_instance[*].public_ip
}

output "web_instance_private_ip" {
  description = "The private IP of the EC2 instance"
  value       = aws_instance.web_instance[*].private_ip
}

output "subnet_id" {
  description = "Subnet ID of web instance"
  value = aws_instance.web_instance[*].subnet_id
}

output "web_launch_template" {
  description = "Launch template for web app ASG"
  value = aws_launch_template.web-ASG-LT
}