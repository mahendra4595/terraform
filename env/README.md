# Multi-Environment Terraform Setup for AWS Infrastructure

This repository provides a DRY, modular, and scalable approach for managing AWS infrastructure (ECS Fargate, VPC, ALB, ECR, etc.) across multiple environments (staging, prod, etc.) using Terraform.

## Directory Structure

```
terraform/
  main.tf           # Shared Terraform configuration (uses modules, variables, locals)
  variables.tf      # All variable definitions
  outputs.tf        # Shared outputs
  locals.tf         # Shared locals (if any)
  staging/
    backend.tf      # Backend config for staging
    staging.tfvars  # Staging-specific variables
  prod/
    backend.tf      # Backend config for prod
    prod.tfvars     # Prod-specific variables
module/
  ecr/
  vpc/
  ecs_cluster/
  ecs_task_definition/
  ecs_fargate_service/
```

## Usage Instructions

### 1. Initialize the backend for your environment

```sh
cd terraform/staging
terraform init -chdir=..
# or for production
cd terraform/prod
terraform init -chdir=..
```

### 2. Plan and apply for your environment

```sh
terraform plan -chdir=.. -var-file=staging.tfvars
terraform apply -chdir=.. -var-file=staging.tfvars
# For production
terraform plan -chdir=.. -var-file=prod.tfvars
terraform apply -chdir=.. -var-file=prod.tfvars
```

## Key Concepts
- All main Terraform code is shared in the parent (`codepipeline/`) folder.
- Each environment folder contains only `backend.tf` and its `.tfvars` file.
- Add more environments by copying the folder structure and providing new tfvars/backend config.
- Modules are referenced with relative paths (e.g., `../module/vpc`).
- Use `for_each` and maps for dynamic resource creation (e.g., ECR repos).
- All environment-specific values are managed via tfvars files.

## Example: Adding a New Environment
1. Copy the `staging/` folder to a new folder (e.g., `dev/`).
2. Update `backend.tf` and create a `dev.tfvars` file with environment-specific values.
3. Use the same plan/apply pattern as above.

---

For module details and advanced usage, see `module/README.md` and each module's `variables.tf`.
