variable "vpc_cidr" {
  description = "cidr block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "web-vpc"
}

variable "subnet_az1_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "subnet_az2_cidr" {
  type = string
  default = "10.0.2.0/24"
}

variable "az1" {
  type = string
  default = "us-east-1a"
}

variable "az2" {
  type = string
  default = "us-east-1b"
}

