module "cost_anomaly_detection" {
  source                        = "./modules/ce_anomaly_detection"
  notification_email_address    = var.cost_anomaly_notification_email_address
  weekly_schedule_threshold     = var.cost_anomaly_weekly_schedule_threshold
  immediate_schedule_threshold  = var.cost_anomaly_immediate_schedule_threshold
  sns_failure_feedback_role_arn = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn = aws_iam_role.sns_success_feedback.arn
  providers = {
    aws.global = aws.global
  }
}

module "aws_cost_notifier" {
  count              = local.aws_cost_anomaly_notifications_enabled ? 1 : 0
  source             = "git@github.com:ministryofjustice/opg-aws-cost-notifier.git?ref=v1.2.0"
  account_name       = var.account_name
  ecr_repository_url = data.aws_ecr_repository.cost_notifier_lambda.repository_url
  slack_channel_id   = var.aws_slack_cost_anomaly_notification_channel
  slack_secret_arn   = aws_secretsmanager_secret.aws_notifier_slack_token[0].arn
  sns_topic_arn      = module.cost_anomaly_detection.immediate_schedule_sns_topic.arn
  version_tag        = "v1.2.0"
  providers = {
    aws           = aws
    aws.us-east-1 = aws.global
  }
}

data "aws_ecr_repository" "cost_notifier_lambda" {
  name     = "shared/aws-cost-notifier"
  provider = aws.management
}
