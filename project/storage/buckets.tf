# Data Lake Raw Tier
resource "aws_s3_bucket" "raw_tier" {
  bucket = "${var.project_name}-datalake-raw-${var.environment}"
  tags   = var.tags

  # Prevent accidental deletion of this bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "raw_tier" {
  bucket = aws_s3_bucket.raw_tier.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Data Lake Bronze Tier
resource "aws_s3_bucket" "bronze_tier" {
  bucket = "${var.project_name}-datalake-bronze-${var.environment}"
  tags   = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "bronze_tier" {
  bucket = aws_s3_bucket.bronze_tier.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Lambda Artifacts Bucket
resource "aws_s3_bucket" "lambda_artifacts" {
  bucket = "${var.project_name}-lambda-artifacts-${var.environment}"
  tags   = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "lambda_artifacts" {
  bucket = aws_s3_bucket.lambda_artifacts.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Common security settings for all buckets
resource "aws_s3_bucket_public_access_block" "raw_tier" {
  bucket = aws_s3_bucket.raw_tier.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "bronze_tier" {
  bucket = aws_s3_bucket.bronze_tier.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "lambda_artifacts" {
  bucket = aws_s3_bucket.lambda_artifacts.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Server-side encryption for all buckets
resource "aws_s3_bucket_server_side_encryption_configuration" "raw_tier" {
  bucket = aws_s3_bucket.raw_tier.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bronze_tier" {
  bucket = aws_s3_bucket.bronze_tier.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "lambda_artifacts" {
  bucket = aws_s3_bucket.lambda_artifacts.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Lifecycle rules for data lake buckets
resource "aws_s3_bucket_lifecycle_configuration" "raw_tier" {
  bucket = aws_s3_bucket.raw_tier.id

  rule {
    id     = "transition_to_ia"
    status = "Enabled"

    transition {
      days          = 120
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bronze_tier" {
  bucket = aws_s3_bucket.bronze_tier.id

  rule {
    id     = "transition_to_ia"
    status = "Enabled"

    transition {
      days          = 120
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }
  }
}

# Lifecycle rules for lambda artifacts
resource "aws_s3_bucket_lifecycle_configuration" "lambda_artifacts" {
  bucket = aws_s3_bucket.lambda_artifacts.id

  rule {
    id     = "cleanup_old_versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}

# Enable access logging for data lake buckets
resource "aws_s3_bucket_logging" "raw_tier" {
  bucket = aws_s3_bucket.raw_tier.id

  target_bucket = aws_s3_bucket.raw_tier.id
  target_prefix = "log/raw_tier/"
}

resource "aws_s3_bucket_logging" "bronze_tier" {
  bucket = aws_s3_bucket.bronze_tier.id

  target_bucket = aws_s3_bucket.bronze_tier.id
  target_prefix = "log/bronze_tier/"
}

# CORS configuration for lambda artifacts bucket
resource "aws_s3_bucket_cors_configuration" "lambda_artifacts" {
  bucket = aws_s3_bucket.lambda_artifacts.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
} 