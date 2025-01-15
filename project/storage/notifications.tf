resource "aws_s3_bucket_notification" "raw_tier" {
  bucket = aws_s3_bucket.raw_tier.id

  queue {
    queue_arn = var.raw_tier_notifications_queue_arn
    events    = ["s3:ObjectCreated:*"]
  }
} 