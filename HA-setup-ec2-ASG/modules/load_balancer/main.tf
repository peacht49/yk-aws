resource "aws_security_group" "elb_sg" {
  vpc_id = var.vpc_id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb_sg"
  }
}

resource "aws_lb" "applb" {
  name = var.lb_name
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.elb_sg.id]
  subnets = var.subnets
  enable_deletion_protection = false

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "tg" {
  name = var.tg_name
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  tags = {
    Name = var.tg_name
  }
}

resource "aws_lb_listener" "http_listen" {
  load_balancer_arn = aws_lb.applb.arn
  port = 80
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

/*** for fixed response
  default_action {
    type = "fixed-response"
    fixed_response {
      status_code = 200
      content_type = "text/plain"
      message_body = "OK"
    }
***/