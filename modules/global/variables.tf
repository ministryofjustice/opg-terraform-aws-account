variable "account_name" {
  type        = string
  description = "The name of the account."
}

variable "macie_enabled" {
  type        = bool
  description = "Whether AWS Macie has been intentionally disabled in the account."
}

variable "sns_failure_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}

variable "sns_success_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}
