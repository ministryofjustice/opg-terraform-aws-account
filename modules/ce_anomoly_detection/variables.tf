variable "notification_email_address" {
  type        = string
  description = "Email address to use to send anomaly alerts to"
}

variable "weekly_schedule_threshold" {
  type        = number
  description = "The dollar value that triggers a weekly notification if the threshold is exceeded."
}

variable "immediate_schedule_threshold" {
  type        = number
  description = "The dollar value that triggers an immediate notification if the threshold is exceeded."
}
