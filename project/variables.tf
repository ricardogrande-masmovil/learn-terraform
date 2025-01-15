variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "learning-terraform"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default = {
    Terraform = "true"
    Owner     = "your-team"
  }
} 