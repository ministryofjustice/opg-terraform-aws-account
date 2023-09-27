variable "notification_email_address" {
  description = "Email address to use to send anomaly alerts to"
  type        = string
}

variable "weekly_schedule_threshold" {
  description = "The value that triggers a weekly notification if the threshold is exceeded. By default, an absolute dollar value, but changing `threshold_expression_type` changes this to percentage."
  type        = number
}

variable "immediate_schedule_threshold" {
  description = "The value that triggers an immediate notification if the threshold is exceeded. By default, an absolute dollar value, but changing `threshold_expression_type` changes this to percentage."
  type        = number
}

variable "threshold_expression_type" {
  type        = string
  default     = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
  description = "Setting passed to the threshold_expression to determine if the value (weekly_schedule_threshold|immediate_schedule_threshold) is an absolute (ANOMALY_TOTAL_IMPACT_ABSOLUTE) or percentage (ANOMALY_TOTAL_IMPACT_PERCENTAGE)"
}

variable "sns_failure_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}

variable "sns_success_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}
