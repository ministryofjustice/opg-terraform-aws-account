variable "sns_failure_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}

variable "sns_success_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}

variable "product" {
  type = string
}

variable "account_name" {
  default     = ""
  description = "Account Name"
  type        = string
}

variable "breakglass_login_alarm_enabled" {
  default     = true
  description = "Enable or disable the breakglass login alarm"
  type        = bool
}

variable "cloudtrail_log_group_name" {
  type = string
}

data "aws_caller_identity" "current" {
  provider = aws.global
}
