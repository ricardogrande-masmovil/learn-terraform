variable "developer_users" {
  description = "List of developer usernames to create"
  type        = list(string)
  default     = ["ricardo", "jorge"]
}

variable "developers_group_name" {
  description = "Name of the developers group"
  type        = string
  default     = "developers"
}
