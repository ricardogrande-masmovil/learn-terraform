output "raw_tier_bucket" {
  description = "Raw tier data lake bucket"
  value       = aws_s3_bucket.raw_tier.id
}

output "raw_tier_bucket_arn" {
  description = "ARN of the raw tier data lake bucket"
  value       = aws_s3_bucket.raw_tier.arn
}

output "bronze_tier_bucket" {
  description = "Bronze tier data lake bucket"
  value       = aws_s3_bucket.bronze_tier.id
}

output "lambda_artifacts_bucket" {
  description = "Lambda artifacts bucket"
  value       = aws_s3_bucket.lambda_artifacts.id
} 