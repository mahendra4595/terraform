variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks."
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks."
  type        = list(string)
}

variable "container_image" {
  description = "Container image URI."
  type        = string
}

variable "container_port" {
  description = "Port the container exposes."
  type        = number
}

variable "alb_name" {
  description = "Name of the Application Load Balancer."
  type        = string
}

variable "tg_name" {
  description = "Name of the Target Group."
  type        = string
}

variable "listener_name" {
  description = "Name of the Load Balancer Listener."
  type        = string
}

variable "ecs_service_desired_count" {
  description = "Desired number of ECS service tasks."
  type        = number
  default     = 1
}
variable "environment" {
  description = "Deployment environment (e.g., stage, prod)"
  type        = string
}

variable "project" {
  description = "Project name."
  type        = string
}
variable "aws_region" {
  description = "AWS region to deploy resources."
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster."
  type        = string
}
variable "ecs_service_name" {
  description = "Name of the ECS service."
  type        = string
}
variable "desired_count" {
  description = "Number of desired tasks for the ECS service."
  type        = number
  default     = 1
}
variable "ecs_sg_name" {
  description = "Name of the ECS security group."
  type        = string
  default     = "ecs_sg"
}
variable "ecs_task_family" {
  description = "Family name for the ECS task definition."
  type        = string
}
variable "container_name" {
  description = "Name of the container in the ECS task definition."
  type        = string
}

variable "ecr_repositories" {
  description = "Map of ECR repositories to create."
  type        = map(object({
    name : string
    tags : map(string)
  }))
  default     = {}
}