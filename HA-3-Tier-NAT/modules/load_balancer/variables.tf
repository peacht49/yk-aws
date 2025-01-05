variable "vpc_id" {
  type = string
}

# List used as we want more subnets across diff AZ
variable "subnets" {
  type = list(string)
}

variable "lb_name" {
  type = string
  default = "applb"
}

variable "tg_name" {
  type = string
  default = "app-tg"
}
