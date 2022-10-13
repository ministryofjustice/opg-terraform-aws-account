module "aws_config" {
  source                        = "../config"
  count                         = var.baseline_security_enabled ? 1 : 0
  account_name                  = var.account_name
  config_iam_role               = var.config_iam_role
  s3_access_logging_bucket_name = aws_s3_bucket.s3_access_logging.id
  product                       = var.product
}
