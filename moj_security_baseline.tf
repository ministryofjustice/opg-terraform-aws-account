module "aws_config" {
  source       = "./config"
  count        = var.baseline_security_enabled ? 1 : 0
  account_name = var.account_name
  product      = var.product
  tags         = local.mandatory_moj_tags
}

module "security_hub" {
  source                                   = "./security_hub"
  count                                    = var.baseline_security_enabled ? 1 : 0
  account_name                             = var.account_name
  product                                  = var.product
  cis_metric_namespace                     = var.cis_metric_namespace
  aws_cloudwatch_log_group_cloudtrail_name = var.cloudtrail_trail_name
  cis_foundation_control_3_4_enabled       = var.cis_foundation_control_3_4_enabled
  cis_foundation_control_3_8_enabled       = var.cis_foundation_control_3_8_enabled
  cis_foundation_control_3_10_enabled      = var.cis_foundation_control_3_10_enabled
  cis_foundation_control_3_11_enabled      = var.cis_foundation_control_3_11_enabled
  cis_foundation_control_3_12_enabled      = var.cis_foundation_control_3_12_enabled
  cis_foundation_control_3_13_enabled      = var.cis_foundation_control_3_13_enabled
  cis_foundation_control_3_14_enabled      = var.cis_foundation_control_3_14_enabled
  tags                                     = local.mandatory_moj_tags
}
