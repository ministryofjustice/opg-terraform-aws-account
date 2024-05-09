module "slack_notifications" {
  count                                       = var.aws_slack_notifications_enabled ? 1 : 0
  source                                      = "./modules/slack_notifications"
  account_name                                = var.account_name
  aws_cost_anomaly_notifications_enabled      = local.aws_cost_anomaly_notifications_enabled
  aws_health_notifications_enabled            = local.aws_health_notifications_enabled
  aws_security_hub_enabled                    = var.aws_security_hub_enabled
  aws_slack_cost_anomaly_notification_channel = var.aws_slack_cost_anomaly_notification_channel
  aws_slack_health_notification_channel       = var.aws_slack_health_notification_channel
  cost_anomaly_sns_topic_arn                  = module.cost_anomaly_detection.immediate_schedule_sns_topic.arn
  sns_failure_feedback_role_arn               = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn               = aws_iam_role.sns_success_feedback.arn
  providers = {
    aws            = aws
    aws.eu-west-2  = aws.eu-west-2
    aws.global     = aws.global
    aws.management = aws.management
  }
}

moved {
  from = module.aws_cost_notifier[0]
  to   = module.slack_notifications[0].module.aws_cost_notifier[0]
}

moved {
  from = module.aws_health_notifier[0]
  to   = module.slack_notifications[0].module.aws_health_notifier[0]
}

moved {
  from = aws_secretsmanager_secret.aws_notifier_slack_token[0]
  to   = module.slack_notifications[0].aws_secretsmanager_secret.aws_notifier_slack_token
}

moved {
  from = aws_secretsmanager_secret_version.aws_notifier_slack_token[0]
  to   = module.slack_notifications[0].aws_secretsmanager_secret_version.aws_notifier_slack_token
}
