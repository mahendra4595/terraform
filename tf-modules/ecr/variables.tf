variable "name" {
  description = "Name for the ECR repository."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the ECR repository."
  type        = map(string)
  default     = {}
}
