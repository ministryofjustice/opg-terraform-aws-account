variable "account_name" {
  description = "Account Name"
  type        = string
}

variable "product" {
  default     = ""
  description = "Product/Service name"
  type        = string
}

variable "tags" {
  type        = map(any)
  description = "Tags to apply to all taggable resources"
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
