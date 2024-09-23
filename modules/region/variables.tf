variable "account_name" {
  description = "Account Name"
  type        = string
}

variable "product" {
  description = "Name of the product"
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

variable "config_continuous_resource_recording" {
  description = "Should the configuration recorder scan constantly or daily (set to false in dev accounts)"
  type        = bool
  default     = true
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

variable "aws_macie2_account_finding_publishing_frequency" {
  default = "SIX_HOURS"
  type    = string
  validation {
    condition     = contains(["FIFTEEN_MINUTES", "ONE_HOUR", "SIX_HOURS"], var.account_finding_publishing_frequency)
    error_message = "Invalid value for account_finding_publishing_frequency"
  }
}

variable "aws_macie2_status" {
  default = "ENABLED"
  type    = string
  validation {
    condition     = contains(["ENABLED", "PAUSED"], var.status)
    error_message = "Invalid value for status"
  }
}

variable "macie_findings_s3_bucket_kms_key" {
  description = "The KMS key to use for the Macie findings bucket"
  type        = any
}
