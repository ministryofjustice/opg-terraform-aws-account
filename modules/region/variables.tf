variable "account_name" {
  description = "Account Name"
  type        = string
}

variable "aws_config_enabled" {
  description = "Enable AWS Config"
  type        = bool
  default     = false
}

variable "aws_macie2_finding_publishing_frequency" {
  type = string
  validation {
    condition     = contains(["FIFTEEN_MINUTES", "ONE_HOUR", "SIX_HOURS"], var.aws_macie2_finding_publishing_frequency)
    error_message = "Invalid value for aws_macie2_finding_publishing_frequency"
  }
}

variable "aws_macie2_status" {
  type = string
  validation {
    condition     = contains(["ENABLED", "PAUSED", "DISABLED"], var.aws_macie2_status)
    error_message = "Invalid value for aws_macie2_status"
  }
}

variable "config_continuous_resource_recording" {
  description = "Should the configuration recorder scan constantly or daily (set to false in dev accounts)"
  type        = bool
  default     = true
}

variable "config_iam_role" {
  description = "Iam role object for the config role."
}

variable "macie_findings_s3_bucket_kms_key" {
  description = "The KMS key to use for the Macie findings bucket"
  type        = any
}

variable "product" {
  description = "Name of the product"
  type        = string
}

variable "security_hub_config" {
  description = "Regional Configuration for Security Hub"
  type = object({
    auto_enable_controls                          = bool
    aws_cloudwatch_log_group_cloudtrail_name      = string
    cis_1_2_foundation_control_1_14_enabled       = bool
    cis_1_2_foundation_control_3_1_enabled        = bool
    cis_1_2_foundation_control_3_10_custom_filter = string
    cis_1_2_foundation_control_3_10_enabled       = bool
    cis_1_2_foundation_control_3_11_enabled       = bool
    cis_1_2_foundation_control_3_12_enabled       = bool
    cis_1_2_foundation_control_3_13_enabled       = bool
    cis_1_2_foundation_control_3_14_enabled       = bool
    cis_1_2_foundation_control_3_4_enabled        = bool
    cis_1_2_foundation_control_3_8_enabled        = bool
    cis_1_2_subscription_enabled                  = bool
    cis_3_0_subscription_enabled                  = bool
    cis_metric_namespace                          = string
    cloudtrail_enabled                            = bool
    control_finding_generator                     = string
    enable_default_standards                      = bool
    fsbp_standard_control_elb_6_enabled           = bool
    macie_enabled                                 = bool
    pagerduty_securityhub_integration_key         = string
    sns_failure_feedback_role_arn                 = string
    sns_success_feedback_role_arn                 = string
  })
}

variable "sns_failure_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}

variable "sns_success_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}
