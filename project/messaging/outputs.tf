output "raw_tier_notifications_queue_url" {
  description = "URL of the SQS queue for raw tier notifications"
  value       = aws_sqs_queue.raw_tier_notifications.url
}

output "raw_tier_notifications_queue_arn" {
  description = "ARN of the SQS queue for raw tier notifications"
  value       = aws_sqs_queue.raw_tier_notifications.arn
} 