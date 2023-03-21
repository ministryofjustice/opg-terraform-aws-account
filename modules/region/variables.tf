variable "account_name" {
  description = "Account Name"
  type        = string
}

variable "aws_config_enabled" {
  description = "Enable AWS Config"
  type        = bool
  default     = false
}

variable "config_iam_role" {
  description = "Iam role object for the config role."
}

variable "product" {
  description = "Name of the product"
  type        = string
}

variable "sns_failure_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}

variable "sns_success_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}
