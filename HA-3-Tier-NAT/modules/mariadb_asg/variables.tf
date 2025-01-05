variable "ami-mariadb" {
  default = "ami-0453ec754f44f9a4a"
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "vpc_id" {
  type = string
}

variable "security_group_id" {
 type = list(string)
 default = []
}

variable "key_name" {
  type = string
  default = "ykwong_ce9"
}
