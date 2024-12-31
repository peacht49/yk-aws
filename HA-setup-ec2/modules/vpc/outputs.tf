output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_az1_id" {
  value = aws_subnet.nodejs-az1.id
}

output "subnet_az2_id" {
  value = aws_subnet.nodejs-az2.id
}

output "security_group_id" {
  value = aws_security_group.web_sg.id
}

