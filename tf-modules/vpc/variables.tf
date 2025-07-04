variable "name" {
  description = "Prefix for naming resources (typically project name)."
  type        = string
}
variable "cidr_block" {
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

variable "environment" {
  description = "Environment name (e.g., dev, stage, prod)."
  type        = string
}

variable "project" {
  description = "Project name."
  type        = string
}

variable "region" {
  description = "AWS region where the VPC will be created."
  type        = string
  default     = "eu-west-3"  # Default to Paris region, can be overridden
}

variable "managed_by" {
  description = "Indicates who manages the resource."
  type        = string
  default     = "Terraform"
}