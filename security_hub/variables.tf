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
