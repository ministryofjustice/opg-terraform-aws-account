variable "account_name" {
  description = "Account Name"
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

locals {
  create_cloudtrail_alarms  = (var.security_hub_config.cloudtrail_enabled && data.aws_region.current.region == "eu-west-1") || (!var.security_hub_config.cloudtrail_enabled && data.aws_region.current.region == "eu-west-2")
  cloudtrail_log_group_name = var.security_hub_config.cloudtrail_enabled ? var.security_hub_config.aws_cloudwatch_log_group_cloudtrail_name : "cloudtrail"
}
