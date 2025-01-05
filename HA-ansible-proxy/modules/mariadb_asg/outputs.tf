output "mariadb_launch_template" {
  description = "Launch template for mariadb ASG"
  value = aws_launch_template.mariadb_launch_template
}

output "mariadb_SG" {
  description = "Security group for mariadb ASG"
  value = aws_security_group.mariadb-sg.id
}
