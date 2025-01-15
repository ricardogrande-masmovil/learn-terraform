# Create the developers group
resource "aws_iam_group" "developers" {
  name = var.developers_group_name
}

# Attach policy to the group
resource "aws_iam_group_policy_attachment" "developer_policy_attach" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.developer_policy.arn
}

# Create IAM users
resource "aws_iam_user" "developers" {
  for_each = toset(var.developer_users)
  name     = each.value
}

# Add users to the developers group
resource "aws_iam_user_group_membership" "developers" {
  for_each = toset(var.developer_users)
  user     = aws_iam_user.developers[each.key].name
  groups   = [aws_iam_group.developers.name]
}

# Create access keys for users
resource "aws_iam_access_key" "developer_keys" {
  for_each = toset(var.developer_users)
  user     = aws_iam_user.developers[each.key].name
}
