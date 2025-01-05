variable "ami" {
  type = string
  default = "ami-0453ec754f44f9a4a"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_count" {
  default = 0 # Set to 0 to avoid individual instances when using Autoscaling group
}

variable "subnet_id" {
  type = list(string)
  default = []
}

variable "security_group_ids" {
  description = "List of VPC security Group IDs"
  type = list(string)
  default = [] # Leaving this empty means it can be optional in root main.tf
}

variable "user_data" {
  type = string
  default = <<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install -y nodejs npm
            mkdir /home/ec2-user/app
            cd /home/ec2-user/app
            echo "const express = require('express');" > app.js
            echo "const app = express();" >> app.js
            echo "const port = 80;" >> app.js
            echo "app.get('/', (req, res) => { res.send('Hello from Node.js app running on AWS!'); });" >> app.js
            echo "app.listen(port, () => { console.log('App listening at http://localhost:{{port}}'); });" >> app.js
            sudo npm install express
            nohup node /home/ec2-user/app/app.js > /home/ec2-user/app.log 2>&1 &
            EOF
}

variable "key_name" {
  default = "ykwong_ce9"
}

variable "vpc_id" {
  type = string
}
