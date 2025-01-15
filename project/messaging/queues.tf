# SQS Queue for S3 notifications
resource "aws_sqs_queue" "raw_tier_notifications" {
  name = "${var.project_name}-raw-tier-notifications-${var.environment}"

  # Queue configuration
  visibility_timeout_seconds = 30
  message_retention_seconds = 345600  # 4 days
  delay_seconds             = 0
  max_message_size         = 262144  # 256KB
  receive_wait_time_seconds = 0

  # Enable server-side encryption
  sqs_managed_sse_enabled = true

  tags = var.tags
}

# SQS Queue Policy to allow S3 to send messages
resource "aws_sqs_queue_policy" "raw_tier_notifications" {
  queue_url = aws_sqs_queue.raw_tier_notifications.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = "sqs:SendMessage"
        Resource = aws_sqs_queue.raw_tier_notifications.arn
        Condition = {
          StringEquals = {
            "aws:SourceAccount": data.aws_caller_identity.current.account_id
          }
          ArnLike = {
            "aws:SourceArn": var.raw_tier_bucket_arn
          }
        }
      }
    ]
  })
}

# Get current AWS account ID
data "aws_caller_identity" "current" {} 