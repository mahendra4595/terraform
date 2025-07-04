locals {
  environment = var.environment
  project     = var.project
  tags = {
    Environment = local.environment
    Project     = local.project
    ManagedBy   = "Terraform"
  }
}
