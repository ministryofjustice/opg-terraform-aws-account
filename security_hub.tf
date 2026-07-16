resource "aws_securityhub_account" "main" {
  count                     = local.security_hub_enabled ? 1 : 0
  auto_enable_controls      = var.auto_enable_controls
  control_finding_generator = var.control_finding_generator
  enable_default_standards  = var.enable_default_standards

  lifecycle {
    prevent_destroy = true
  }
}

locals {
  security_hub_config = {
    auto_enable_controls                           = var.auto_enable_controls
    aws_cloudwatch_log_group_cloudtrail_name       = local.cloudtrail_log_group_name
    cis_1_2_foundation_control_1_14_enabled        = var.cis_1_2_foundation_control_1_14_enabled
    cis_1_2_foundation_control_3_1_enabled         = var.cis_1_2_foundation_control_3_1_enabled
    cis_1_2_foundation_control_3_10_custom_filter  = var.cis_1_2_foundation_control_3_10_custom_filter
    cis_1_2_foundation_control_3_10_enabled        = var.cis_1_2_foundation_control_3_10_enabled
    cis_1_2_foundation_control_3_11_enabled        = var.cis_1_2_foundation_control_3_11_enabled
    cis_1_2_foundation_control_3_12_enabled        = var.cis_1_2_foundation_control_3_12_enabled
    cis_1_2_foundation_control_3_13_enabled        = var.cis_1_2_foundation_control_3_13_enabled
    cis_1_2_foundation_control_3_14_enabled        = var.cis_1_2_foundation_control_3_14_enabled
    cis_1_2_foundation_control_3_4_enabled         = var.cis_1_2_foundation_control_3_4_enabled
    cis_1_2_foundation_control_3_8_enabled         = var.cis_1_2_foundation_control_3_8_enabled
    cis_1_2_subscription_enabled                   = var.cis_1_2_subscription_enabled
    cis_3_0_subscription_enabled                   = var.cis_3_0_subscription_enabled
    cis_metric_namespace                           = var.cis_metric_namespace
    cloudtrail_enabled                             = local.cloudtrail_enabled
    control_finding_generator                      = var.control_finding_generator
    enable_default_standards                       = var.enable_default_standards
    fsbp_standard_control_elb_21_enabled           = !var.security_hub_terminate_ssl_at_alb
    fsbp_standard_control_elb_22_enabled           = !var.security_hub_terminate_ssl_at_alb
    fsbp_standard_control_elb_6_enabled            = var.fsbp_standard_control_elb_6_enabled
    fsbp_standard_control_secretsmanager_1_enabled = var.fsbp_standard_control_secretsmanager_1_enabled
    macie_enabled                                  = local.macie_enabled
    pagerduty_securityhub_integration_key          = var.pagerduty_securityhub_integration_key
    sns_failure_feedback_role_arn                  = aws_iam_role.sns_failure_feedback.arn
    sns_success_feedback_role_arn                  = aws_iam_role.sns_success_feedback.arn
  }
}
