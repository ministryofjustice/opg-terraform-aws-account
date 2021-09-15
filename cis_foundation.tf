module "cis_foundation" {
  count                                    = var.cis_foundation_alarms_enabled ? 1 : 0
  source                                   = "./cis_foundation"
  account_name                             = var.account_name
  cis_metric_namespace                     = var.cis_metric_namespace
  aws_cloudwatch_log_group_cloudtrail_name = var.cloudtrail_trail_name
  controls_enabled                         = var.cis_controls_enabled
  tags                                     = local.mandatory_moj_tags
}
