module "eu-west-1" {
  source                                  = "./modules/region"
  account_name                            = var.account_name
  aws_config_enabled                      = local.config_enabled
  aws_macie2_finding_publishing_frequency = var.aws_macie2_finding_publishing_frequency
  aws_macie2_status                       = var.aws_macie2_status
  config_continuous_resource_recording    = var.config_continuous_resource_recording
  config_iam_role                         = local.config_enabled ? aws_iam_service_linked_role.config[0] : null
  macie_findings_s3_bucket_kms_key        = module.global_multiregion_resources.eu_west_1_macie_findings_encryption_key
  product                                 = var.product
  security_hub_config                     = local.security_hub_config
  sns_failure_feedback_role_arn           = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn           = aws_iam_role.sns_success_feedback.arn
  providers = {
    aws = aws
  }
}

module "eu-west-2" {
  source                                  = "./modules/region"
  account_name                            = var.account_name
  aws_config_enabled                      = local.config_enabled
  aws_macie2_finding_publishing_frequency = var.aws_macie2_finding_publishing_frequency
  aws_macie2_status                       = var.aws_macie2_status
  config_continuous_resource_recording    = var.config_continuous_resource_recording
  config_iam_role                         = local.config_enabled ? aws_iam_service_linked_role.config[0] : null
  macie_findings_s3_bucket_kms_key        = module.global_multiregion_resources.eu_west_2_macie_findings_encryption_key
  product                                 = var.product
  security_hub_config                     = local.security_hub_config
  sns_failure_feedback_role_arn           = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn           = aws_iam_role.sns_success_feedback.arn
  providers = {
    aws = aws.eu-west-2
  }
}
