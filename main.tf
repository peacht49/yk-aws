# 1. Networking vpc and subet
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "main-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id =  aws_vpc.main.id  # explain .id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet1" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Networking needs vpc,subnet,gateway, routetable and routable association
# Route table association is the arrow pointing subnet to routetable (Hence subnet id and route table id as para)

# 2. Storage
resource "aws_s3_bucket" "data"{
  bucket = "unique-bucket-8430067c"
}

# 3. Compute ec2 for each loop for multiple ports
resource "aws_security_group" "allow_ssh"{
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {  # ingress is default iterator name when dynamic is used
    for_each = var.ingress_ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
      protocol = "tcp"
    } 
  }
}
/*
  ingress {
    from_port = 22 # To and from refers to port range
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Combined with -1 refers to all ports and any ip
  }
}
*/

resource "aws_instance" "web" {
  ami = "ami-0ac0e4288aa341886"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = "yk-key"
  associate_public_ip_address = true
}

# Compute needs security group (subnet + ingress&egress) + instance itself
# ec2 needs 5 things: ami, subnet, instance type, ssh key, security group
