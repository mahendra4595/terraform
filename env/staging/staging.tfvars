aws_region = "eu-west-3"
environment = "stage"
project     = "cyprusays"

vpc_cidr_block = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

container_image = "nginx:latest"
container_port  = 80
container_name  = "cyprusays"

alb_name     = "cyprusays-stage-alb"
tg_name      = "cyprusays-stage-tg"
listener_name = "cyprusays-stage-listener"
ecs_sg_name  = "cyprusays-stage-ecs-sg"
ecs_cluster_name = "cyprusays-stage-cluster"
ecs_task_family  = "cyprusays-app"
ecs_service_name = "cyprusays-stage-service"
ecs_service_desired_count = 1

# ecr_repositories = {
#   app1 = { name = "cyprusays-app1", 
#   tags = { Environment = "stage" } }

#   app2 = { name = "cyprusays-app2", 
#   tags = { Environment = "stage" } }
# }