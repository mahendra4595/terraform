# ECR repositories (dynamic, using for_each)
module "ecr" {
  source   = "../module/ecr"
  for_each = var.ecr_repositories
  name     = each.value.name
  # tags removed: not supported by module
}
# Main VPC for the environment
module "vpc_main" {
  source          = "../module/vpc"
  name            = var.project
  cidr_block      = var.vpc_cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  environment     = var.environment
  project         = var.project
}

# ECS Cluster for the environment
module "ecs_cluster" {
  source      = "../module/ecs_cluster"
  name        = var.ecs_cluster_name
  environment = var.environment
  project     = var.project
  vpc_id      = module.vpc_main.vpc_id
}

# ECS Task Definition for the application
module "ecs_task" {
  source          = "../module/ecs_task_definition"
  family          = var.ecs_task_family
  container_name  = var.container_name
  image           = var.container_image
  container_port  = var.container_port
}

# ECS Fargate Service for the application
module "ecs_service" {
  source               = "../module/ecs_fargate_service"
  name                 = var.ecs_service_name
  cluster_id           = module.ecs_cluster.ecs_cluster_id
  task_definition      = module.ecs_task.task_definition_arn
  desired_count        = var.ecs_service_desired_count
  subnet_ids           = module.vpc_main.public_subnet_ids
  security_group_ids   = [aws_security_group.ecs_sg.id]
  alb_target_group_arn = aws_lb_target_group.app_tg.arn
  container_name       = var.container_name
  container_port       = var.container_port
  depends_on           = [aws_lb_listener.app_listener]
}

# Security group for ECS tasks
resource "aws_security_group" "ecs_sg" {
  name        = var.ecs_sg_name
  description = "Allow HTTP"
  vpc_id      = module.vpc_main.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}
# Application Load Balancer
resource "aws_lb" "app_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_sg.id]
  subnets            = module.vpc_main.public_subnet_ids

  tags = local.tags
}
# Target group for the ALB
resource "aws_lb_target_group" "app_tg" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTPS"
  vpc_id   = module.vpc_main.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }

  tags = local.tags
}
# Listener for the ALB
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  tags = local.tags
}
