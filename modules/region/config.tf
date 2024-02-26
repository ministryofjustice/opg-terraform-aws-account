module "aws_config" {
  source                               = "../config"
  count                                = var.aws_config_enabled ? 1 : 0
  account_name                         = var.account_name
  config_iam_role                      = var.config_iam_role
  config_continuous_resource_recording = var.config_continuous_resource_recording
  s3_access_logging_bucket_name        = aws_s3_bucket.s3_access_logging.id
  product                              = var.product
  sns_failure_feedback_role_arn        = var.sns_failure_feedback_role_arn
  sns_success_feedback_role_arn        = var.sns_success_feedback_role_arn
}

