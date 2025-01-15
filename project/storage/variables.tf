variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name to be used in resource naming"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "raw_tier_notifications_queue_arn" {
  description = "ARN of the SQS queue for raw tier notifications"
  type        = string
  default     = null  # Optional, in case notifications aren't needed
} 