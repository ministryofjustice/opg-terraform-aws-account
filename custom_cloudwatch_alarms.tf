moved {
  from = module.custom_cloudwatch_alarms
  to   = module.custom_cloudwatch_alarms[0]
}
module "custom_cloudwatch_alarms" {
  count                                        = var.modernisation_platform_account ? 0 : 1
  source                                       = "./modules/custom_cloudwatch_alarms"
  sns_failure_feedback_role_arn                = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn                = aws_iam_role.sns_success_feedback.arn
  product                                      = var.product
  account_name                                 = var.account_name
  cloudtrail_log_group_name                    = local.cloudtrail_log_group_name
  custom_alarms_breakglass_login_alarm_enabled = var.custom_alarms_breakglass_login_alarm_enabled
  providers = {
    aws = aws
  }
}

module "custom_cloudwatch_alarms_vendored" {
  count                                        = var.modernisation_platform_account ? 1 : 0
  source                                       = "./modules/custom_cloudwatch_alarms"
  sns_failure_feedback_role_arn                = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn                = aws_iam_role.sns_success_feedback.arn
  product                                      = var.product
  account_name                                 = var.account_name
  cloudtrail_log_group_name                    = local.cloudtrail_log_group_name
  custom_alarms_breakglass_login_alarm_enabled = var.custom_alarms_breakglass_login_alarm_enabled
  providers = {
    aws = aws.eu-west-2
  }
}
