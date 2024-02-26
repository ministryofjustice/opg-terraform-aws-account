variable "account_name" {
  default     = ""
  description = "Account Name"
  type        = string
}

variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
  type        = string
}

variable "config_iam_role" {
  description = "Iam role object for the config role."
}

variable "config_max_execution_frequency" {
  description = "The maximum frequency with which AWS Config runs evaluations for a rule."
  type        = string
  default     = "TwentyFour_Hours"
}

variable "config_continuous_resource_recording" {
  description = "Should the configuration recorder scan constantly or daily (set to false in dev accounts)"
  type        = bool
  default     = true
}

variable "product" {
  default     = ""
  description = "Product/Service name"
  type        = string
}

locals {
  config_name = "${var.product}-${var.account_name}"
}

variable "s3_access_logging_bucket_name" {
  description = "The name of the bucket that will receive the log objects"
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
