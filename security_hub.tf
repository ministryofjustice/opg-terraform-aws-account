module "security_hub" {
  source                                    = "./modules/security_hub"
  count                                     = local.security_hub_enabled ? 1 : 0
  account_name                              = var.account_name
  product                                   = var.product
  cis_metric_namespace                      = var.cis_metric_namespace
  aws_cloudwatch_log_group_cloudtrail_name  = local.cloudtrail_log_group_name
  cis_foundation_control_1_14_enabled       = var.cis_foundation_control_1_14_enabled
  cis_foundation_control_3_4_enabled        = var.cis_foundation_control_3_4_enabled
  cis_foundation_control_3_8_enabled        = var.cis_foundation_control_3_8_enabled
  cis_foundation_control_3_10_custom_filter = var.cis_foundation_control_3_10_custom_filter
  cis_foundation_control_3_10_enabled       = var.cis_foundation_control_3_10_enabled
  cis_foundation_control_3_11_enabled       = var.cis_foundation_control_3_11_enabled
  cis_foundation_control_3_12_enabled       = var.cis_foundation_control_3_12_enabled
  cis_foundation_control_3_13_enabled       = var.cis_foundation_control_3_13_enabled
  cis_foundation_control_3_14_enabled       = var.cis_foundation_control_3_14_enabled
  fsbp_standard_control_elb_6_enabled       = var.fsbp_standard_control_elb_6_enabled
  macie_enabled                             = local.macie_enabled
  sns_failure_feedback_role_arn             = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn             = aws_iam_role.sns_success_feedback.arn
  pagerduty_securityhub_integration_key     = var.pagerduty_securityhub_integration_key

  control_finding_generator = var.control_finding_generator
  auto_enable_controls      = var.auto_enable_controls
  enable_default_standards  = var.enable_default_standards
}
