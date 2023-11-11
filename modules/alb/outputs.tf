output "alb_arn" {
  value = aws_lb.ecs_alb.arn
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.ecs_target_group.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.alb_listener.arn
}
