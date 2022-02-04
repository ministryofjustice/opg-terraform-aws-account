module "aws_config" {
  source       = "../config"
  count        = var.baseline_security_enabled ? 1 : 0
  account_name = var.account_name
  config_iam_role = var.config_iam_role
  product      = var.product
}
