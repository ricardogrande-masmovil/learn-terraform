# Policy document for developers group
data "aws_iam_policy_document" "developer_policy" {
  # S3 permissions
  statement {
    effect = "Allow"
    actions = [
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutBucketPolicy",
      "s3:GetBucketPolicy"
    ]
    resources = [
      "arn:aws:s3:::*",
      "arn:aws:s3:::*/*"
    ]
  }

  # SQS permissions
  statement {
    effect = "Allow"
    actions = [
      "sqs:CreateQueue",
      "sqs:DeleteQueue",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListQueues",
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage"
    ]
    resources = ["arn:aws:sqs:*:*:*"]
  }

  # Lambda permissions
  statement {
    effect = "Allow"
    actions = [
      "lambda:CreateFunction",
      "lambda:DeleteFunction",
      "lambda:GetFunction",
      "lambda:InvokeFunction",
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionConfiguration",
      "lambda:ListFunctions",
      "lambda:PublishLayerVersion",
      "lambda:DeleteLayerVersion",
      "lambda:GetLayerVersion",
      "lambda:ListLayerVersions"
    ]
    resources = ["arn:aws:lambda:*:*:*"]
  }
}

# Create the policy
resource "aws_iam_policy" "developer_policy" {
  name        = "developer_access_policy"
  description = "Policy for developers to manage S3, SQS, and Lambda"
  policy      = data.aws_iam_policy_document.developer_policy.json
}
