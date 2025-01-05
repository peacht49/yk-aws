resource "aws_security_group" "mariadb-sg" {
  name = "mariadb-sg"
  description = "security group for MariaDB instances ASG"
  vpc_id = var.vpc_id

  # Allow mariadb port 3306 and SSH port 22
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["10.0.2.0/24","10.0.1.0/24"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "mariadb_launch_template" {
  name_prefix = "mariadb-launch-template-replicas"
  image_id = var.ami-mariadb
  instance_type = var.instance_type
  
  network_interfaces {
    security_groups = [aws_security_group.mariadb-sg.id]
  }
  key_name = var.key_name

  tags = {
    Name = "mariadb-instance"
  }

  user_data = base64encode(<<-EOT
          #!/bin/bash
          # Update packages
          sudo yum update -y

          # Install MariaDB
          sudo dnf install -y mariadb105-server

          # Start MariaDB service
          systemctl start mariadb
          systemctl enable mariadb

          EOT
          )
}
