# ZIP the Lambda function code
data "archive_file" "lambda_processor" {
  type        = "zip"
  source_dir  = "${path.module}/src/processor"
  output_path = "${path.module}/dist/processor.zip"
}

# Lambda function
resource "aws_lambda_function" "processor" {
  filename         = data.archive_file.lambda_processor.output_path
  source_code_hash = data.archive_file.lambda_processor.output_base64sha256
  function_name    = "${var.project_name}-queue-processor-${var.environment}"
  role            = aws_iam_role.lambda_processor.arn
  handler         = "main.handler"
  runtime         = "python3.9"

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }

  tags = var.tags
}

# IAM role for the Lambda function
resource "aws_iam_role" "lambda_processor" {
  name = "${var.project_name}-queue-processor-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# CloudWatch Logs policy
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_processor.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# SQS policy
resource "aws_iam_role_policy" "lambda_sqs" {
  name = "sqs-policy"
  role = aws_iam_role.lambda_processor.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = [var.queue_arn]
      }
    ]
  })
}

# Lambda trigger from SQS
resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = var.queue_arn
  function_name    = aws_lambda_function.processor.arn
  batch_size       = 1  # Process one message at a time
} 