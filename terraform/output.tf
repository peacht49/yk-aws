# Output ip for ansible

output "instance_public_ip" {
  description = "Public IP of server"
  value = aws_instance.web.public_ip
}