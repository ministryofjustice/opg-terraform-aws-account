moved {
  from = module.cloudtrail
  to   = module.cloudtrail[0]
}

locals {
  cloudtrail_log_group_name = local.cloudtrail_enabled ? module.cloudtrail[0].cloudtrail_log_group_name : data.aws_cloudwatch_log_group.cloudtrail_log_group_vendored[0].name
}

module "cloudtrail" {
  count                         = local.cloudtrail_enabled ? 1 : 0
  source                        = "./modules/cloudtrail"
  trail_name                    = var.cloudtrail_trail_name
  bucket_name                   = var.cloudtrail_bucket_name
  s3_access_logging_bucket_name = module.eu-west-1.access_logging_bucket.bucket
  sns_failure_feedback_role_arn = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn = aws_iam_role.sns_success_feedback.arn
}

module "cloudwatch_loginsights_cis_queries_provisioned" {
  count                     = local.cloudtrail_enabled ? 0 : 1
  source                    = "./modules/cis_queries"
  cloudtrail_log_group_name = local.cloudtrail_log_group_name
  providers = {
    aws = aws.eu-west-2
  }
}

module "cloudwatch_loginsights_cis_queries_opg" {
  count                     = local.cloudtrail_enabled ? 1 : 0
  source                    = "./modules/cis_queries"
  cloudtrail_log_group_name = local.cloudtrail_log_group_name
}

data "aws_cloudwatch_log_group" "cloudtrail_log_group_vendored" {
  count    = local.cloudtrail_enabled ? 0 : 1
  name     = "cloudtrail"
  provider = aws.eu-west-2
}
