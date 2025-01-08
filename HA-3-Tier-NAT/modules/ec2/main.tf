# Define security group for EC2
resource "aws_security_group" "ec2_sg" {
  name = "ec2-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web_instance" {
  ami = var.ami
  instance_type = var.instance_type
  count = var.instance_count
  subnet_id = var.subnet_id[count.index]

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
  
  tags = {
    Name = "web-instance"
  }
  key_name = var.key_name

  network_interfaces { 
    associate_public_ip_address = true
    security_groups = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(var.user_data)
}

