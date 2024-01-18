variable "account_name" {
  type = string
}

variable "aws_config_enabled" {
  type = bool
}

variable "aws_cost_anomaly_notifications_enabled" {
  type = bool
}

variable "aws_health_notifications_enabled" {
  type = bool
}

variable "aws_security_hub_enabled" {
  type = bool
}

variable "aws_slack_cost_anomaly_notification_channel" {
  type = string
}

variable "aws_slack_health_notification_channel" {
  type = string
}

variable "cost_anomaly_sns_topic_arn" {
  type = string
}

variable "sns_failure_feedback_role_arn" {
  type = string
}

variable "sns_success_feedback_role_arn" {
  type = string
}
