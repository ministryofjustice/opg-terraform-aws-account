module "security_hub" {
  source                                    = "./modules/security_hub"
  count                                     = var.baseline_security_enabled ? 1 : 0
  account_name                              = var.account_name
  product                                   = var.product
  cis_metric_namespace                      = var.cis_metric_namespace
  aws_cloudwatch_log_group_cloudtrail_name  = var.cloudtrail_trail_name
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
}
