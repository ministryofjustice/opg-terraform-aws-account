variable "account_name" {
  description = "Account Name"
  type        = string
}

variable "product" {
  default     = ""
  description = "Product/Service name"
  type        = string
}

variable "cis_metric_namespace" {
  type        = string
  description = "The destination namespace of the CIS CloudWatch metric."
}

variable "aws_cloudwatch_log_group_cloudtrail_name" {
  type        = string
  description = "Name of the trail."
}

variable "cis_foundation_control_1_14_enabled" {
  type        = bool
  description = "When true, creates a metric filter and alarm for CIS.1.14. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_4_enabled" {
  type        = bool
  description = "When true, creates a metric filter and alarm for CIS.3.4. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_8_enabled" {
  type        = bool
  description = "When true, creates a metric filter and alarm for CIS.3.8. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_10_enabled" {
  type        = bool
  description = "When true, creates a metric filter and alarm for CIS.3.10. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_10_custom_filter" {
  type        = string
  default     = ""
  description = "When provided, creates a custom metric filter and alarm for CIS.3.10 and disables the control."
}
variable "cis_foundation_control_3_11_enabled" {
  type        = bool
  description = "When true, creates a metric filter and alarm for CIS.3.11. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_12_enabled" {
  type        = bool
  description = "When true, creates a metric filter and alarm for CIS.3.12. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_13_enabled" {
  type        = bool
  description = "When true, creates a metric filter and alarm for CIS.3.13. When false, sets standard control to disabled."
}

variable "cis_foundation_control_3_14_enabled" {
  type        = bool
  description = "When true, creates a metric filter and alarm for CIS.3.14. When false, sets standard control to disabled."
}

variable "fsbp_standard_control_elb_6_enabled" {
  type        = bool
  description = "When false, sets standard control to disabled."
}

variable "sns_failure_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}

variable "sns_success_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}
