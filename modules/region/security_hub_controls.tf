module "security_hub_controls" {
  source                         = "./modules/security_hub_controls"
  account_name                   = var.account_name
  security_hub_config            = var.security_hub_config
  extended_support_sns_topic_arn = var.extended_support_sns_topic_arn

}
