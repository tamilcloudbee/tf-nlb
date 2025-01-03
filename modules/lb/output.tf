output "lb_arn" {
  description = "ARN of the Load Balancer"
  value       = aws_lb.lb.arn
}

output "lb_dns_name" {
  description = "DNS name of the Load Balancer"
  value       = aws_lb.lb.dns_name
}

output "target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.tg.arn
}
