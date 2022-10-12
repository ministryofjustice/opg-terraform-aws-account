variable "notification_email_address" {
  description = "Email address to use to send anomaly alerts to"
  default     = ""
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

locals {
  weekly_email_enabled = var.notification_email_address == "" ? 0 : 1
}
