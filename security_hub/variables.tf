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

variable "cis_1_14_control_status" {
  type        = string
  default     = "DISABLED"
  description = "The control status could be ENABLED or DISABLED. You have to specify disabled_reason argument for DISABLED control status."
}
variable "cis_1_14_disabled_reason" {
  type        = string
  default     = "See ADR https://docs.opg.service.justice.gov.uk/documentation/adrs/adr-004.html#adr-004-no-hardware-mfa-key-for-root-account"
  description = "A description of the reason why you are disabling a security standard control. If you specify this attribute, control_status will be set to DISABLED automatically."
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
