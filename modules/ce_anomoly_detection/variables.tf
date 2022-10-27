variable "notification_email_address" {
  description = "Email address to use to send anomaly alerts to"
  type        = string
}

variable "weekly_schedule_threshold" {
  description = "The dollar value that triggers a weekly notification if the threshold is exceeded."
  type        = number
}

variable "immediate_schedule_threshold" {
  description = "The dollar value that triggers an immediate notification if the threshold is exceeded."
  type        = number
}

variable "sns_failure_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}

variable "sns_success_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}
