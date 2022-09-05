variable "notification_email_address" {
  type        = string
  description = "Email address to use to send anomaly alerts to"
}

variable "weekly_schedule_threshold" {
  type        = number
  default     = 100
  description = "The dollar value that triggers a weekly notification if the threshold is exceeded."
}

variable "daily_schedule_threshold" {
  type        = number
  default     = 10
  description = "The dollar value that triggers a daily notification if the threshold is exceeded."
}
