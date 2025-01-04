# Define the VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Define 1st subnet
resource "aws_subnet" "nodejs-az1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_az1_cidr
  availability_zone = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "nodejs-subnet-az1"
  }
}

# Define 2nd subnet
resource "aws_subnet" "nodejs-az2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_az2_cidr
  availability_zone = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "nodejs-subnet-az2"
  }
}

# Define 1st private subnet
resource "aws_subnet" "mariadb-az1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = var.az1
  map_public_ip_on_launch = false
  tags = {
    Name = "Private subnet-Az1"
  }
}

# Define 2nd private subnet
resource "aws_subnet" "mariadb-az2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = var.az2
  map_public_ip_on_launch = false
  tags = {
    Name = "Private subnet-Az2"
  }
}

# Define internet gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Define a route table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    Name = "main-route-table"
  }
}

# Associate route table with subnets
resource "aws_route_table_association" "main_subnet_az1" {
  subnet_id = aws_subnet.nodejs-az1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "main_subnet_az2" {
  subnet_id = aws_subnet.nodejs-az2.id
  route_table_id = aws_route_table.main.id
}

# Define security group for the VPC
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-security-group"
  }
}

