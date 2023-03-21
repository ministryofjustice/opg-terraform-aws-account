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

variable "custom_alarms_breakglass_login_alarm_enabled" {
  default     = true
  description = "Enable or disable the breakglass login alarm"
  type        = bool
}

variable "cloudtrail_log_group_name" {
  description = "Name of the cloudtrail log group"
  type        = string
}
