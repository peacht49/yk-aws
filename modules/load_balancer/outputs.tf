output "lb_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.applb.arn
}

output "tg_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.tg.arn
}

output "listener_arn" {
  description = "ARN of the listener"
  value       = aws_lb_listener.http_listen.arn
}