module "slack_notifications" {
  count                                       = local.aws_health_notifications_enabled || local.aws_cost_anomaly_notifications_enabled ? 1 : 0
  source                                      = "./modules/slack_notifications"
  account_name                                = var.account_name
  aws_config_enabled                          = var.aws_config_enabled
  aws_cost_anomaly_notifications_enabled      = local.aws_cost_anomaly_notifications_enabled
  aws_health_notifications_enabled            = local.aws_health_notifications_enabled
  aws_security_hub_enabled                    = var.aws_security_hub_enabled
  aws_slack_cost_anomaly_notification_channel = var.aws_slack_cost_anomaly_notification_channel
  aws_slack_health_notification_channel       = var.aws_slack_health_notification_channel
  sns_failure_feedback_role_arn               = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn               = aws_iam_role.sns_success_feedback.arn
  providers = {
    aws            = aws
    aws.eu-west-2  = aws.eu-west-2
    aws.global     = aws.global
    aws.management = aws.management
  }
}
