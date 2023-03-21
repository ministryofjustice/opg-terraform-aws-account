module "custom_cloudwatch_alarms" {
  source                                       = "./modules/custom_cloudwatch_alarms"
  sns_failure_feedback_role_arn                = var.sns_failure_feedback_role_arn
  sns_success_feedback_role_arn                = var.sns_success_feedback_role_arn
  product                                      = var.product
  account_name                                 = var.account_name
  cloudtrail_log_group_name                    = module.cloudtrail.cloudtrail_log_group_name
  custom_alarms_breakglass_login_alarm_enabled = var.custom_alarms_breakglass_login_alarm_enabled
  providers = {
    aws = aws
  }
}
