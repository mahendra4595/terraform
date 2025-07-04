output "alb_dns" {
  description = "Public DNS of the ALB"
  value       = aws_lb.app_alb.dns_name
}

output "ecs_service_name" {
  value = module.ecs_service.service_name
}

output "ecs_service_arn" {
  value = module.ecs_service.service_arn
}

output "ecs_service_task_definition" {
  value = module.ecs_service.task_definition
}