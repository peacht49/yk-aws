output "mariadb_launch_template" {
  value = aws_launch_template.mariadb_launch_template
}

output "mariadb_SG" {
  value = aws_security_group.mariadb-sg.id
}
