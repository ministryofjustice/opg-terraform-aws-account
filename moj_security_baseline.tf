module "aws_config" {
  source       = "./config"
  count        = var.baseline_security_enabled ? 1 : 0
  account_name = var.account_name
  product      = var.product
  tags         = local.mandatory_moj_tags
}

module "security_hub" {
  source       = "./security_hub"
  count        = var.baseline_security_enabled ? 1 : 0
  account_name = var.account_name
  product      = var.product
  tags         = local.mandatory_moj_tags
}
