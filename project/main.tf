terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

locals {
  tags = merge(
    var.default_tags,
    {
      Environment = var.environment
      Project     = var.project_name
    }
  )
}

module "iam" {
  source = "./iam"
}

module "storage" {
  source = "./storage"

  project_name = var.project_name
  environment  = var.environment
  tags         = local.tags
  raw_tier_notifications_queue_arn = module.messaging.raw_tier_notifications_queue_arn
}

module "messaging" {
  source = "./messaging"

  project_name       = var.project_name
  environment        = var.environment
  tags              = local.tags
  raw_tier_bucket_arn = module.storage.raw_tier_bucket_arn
}

module "lambda" {
  source = "./lambda"

  project_name = var.project_name
  environment  = var.environment
  tags         = local.tags
  queue_arn    = module.messaging.raw_tier_notifications_queue_arn
}
