module "aws_config" {
  source                        = "../config"
  count                         = var.baseline_security_enabled ? 1 : 0
  account_name                  = var.account_name
  config_iam_role               = var.config_iam_role
  s3_access_logging_bucket_name = aws_s3_bucket.s3_access_logging.id
  product                       = var.product
  sns_failure_feedback_role_arn = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn = aws_iam_role.sns_success_feedback.arn
}
