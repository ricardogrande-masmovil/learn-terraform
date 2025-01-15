variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "raw_tier_bucket_arn" {
  description = "ARN of the raw tier S3 bucket"
  type        = string
} 