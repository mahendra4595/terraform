# ECS Cluster module

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
  Name        = var.name
  Environment = var.environment
  Project     = var.project
  ManagedBy   = var.managed_by
}
}