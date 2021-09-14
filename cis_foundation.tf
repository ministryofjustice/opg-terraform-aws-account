module "cis_foundation" {
  source                                   = "./cis_foundation"
  account_name                             = var.account_name
  cis_metric_namespace                     = var.cis_metric_namespace
  aws_cloudwatch_log_group_cloudtrail_name = var.cloudtrail_trail_name
  tags                                     = local.mandatory_moj_tags
}
