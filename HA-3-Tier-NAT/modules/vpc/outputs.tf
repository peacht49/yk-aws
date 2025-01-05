output "vpc_id" {
  description = "Main VPC for the region"
  value = aws_vpc.main.id
}

output "subnet_az1_id" {
  description = "Public subnet 1 for web instance ASG"
  value = aws_subnet.nodejs-az1.id
}

output "subnet_az2_id" {
  description = "Public subnet 2 for web instance ASG"
  value = aws_subnet.nodejs-az2.id
}

output "security_group_id" {
  description = "Security group for public facing web instance ASG"
  value = aws_security_group.web_sg.id
}

output "private_subnet_az1_id" {
  description = "Private subnet 1 for mariadb ASG"
  value = aws_subnet.mariadb-az1.id
}

output "private_subnet_az2_id" {
  description = "Private subnet 2 for mariadb ASG"
  value = aws_subnet.mariadb-az2.id
}


output "nat_gateway_id" {
  value = aws_nat_gateway.main_nat.id
}
