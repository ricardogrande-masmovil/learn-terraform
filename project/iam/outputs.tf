output "developer_access_keys" {
  value = {
    for user in var.developer_users : user => {
      access_key_id     = aws_iam_access_key.developer_keys[user].id
      secret_access_key = aws_iam_access_key.developer_keys[user].secret
    }
  }
  sensitive = true
}

output "group_arn" {
  value = aws_iam_group.developers.arn
}
