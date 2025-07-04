# VPC module for ECS Fargate

data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.name}-${var.environment}-vpc"
    Environment = var.environment
    Project     = var.project
    ManagedBy = var.managed_by
  }
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name        = "${var.name}-${var.environment}-public-subnet-${count.index}"
    Environment = var.environment
    Project     = var.project
    ManagedBy = var.managed_by
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets[count.index]
  map_public_ip_on_launch = false
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name        = "${var.name}-${var.environment}-private-subnet-${count.index}"
    Environment = var.environment
    Project     = var.project
    ManagedBy = var.managed_by
  }
}