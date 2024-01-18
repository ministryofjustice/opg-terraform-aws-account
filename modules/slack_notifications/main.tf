module "aws_cost_notifier" {
  count                     = var.aws_cost_anomaly_notifications_enabled ? 1 : 0
  source                    = "git@github.com:ministryofjustice/opg-aws-cost-notifier.git"
  account_name              = var.account_name
  ecr_repository_url        = data.aws_ecr_repository.cost_notifier_lambda.repository_url
  failed_invocation_sns_arn = aws_sns_topic.slack_notification_failures.arn
  slack_channel_id          = var.aws_slack_cost_anomaly_notification_channel
  slack_secret_arn          = aws_secretsmanager_secret.aws_notifier_slack_token.arn
  sns_topic_arn             = var.cost_anomaly_sns_topic_arn
  version_tag               = data.aws_ssm_parameter.cost_notifier_lambda_version.value
  providers = {
    aws           = aws
    aws.us-east-1 = aws.global
  }
}

module "aws_health_notifier" {
  count                     = var.aws_health_notifications_enabled ? 1 : 0
  source                    = "git@github.com:ministryofjustice/opg-aws-health-notifier.git"
  account_name              = var.account_name
  ecr_repository_url        = data.aws_ecr_repository.health_notifier_lambda.repository_url
  failed_invocation_sns_arn = aws_sns_topic.slack_notification_failures.arn
  slack_channel_id          = var.aws_slack_health_notification_channel
  slack_secret_arn          = aws_secretsmanager_secret.aws_notifier_slack_token.arn
  version_tag               = data.aws_ssm_parameter.health_notifier_lambda_version.value
  providers = {
    aws           = aws
    aws.eu-west-2 = aws.eu-west-2
    aws.us-east-1 = aws.global
  }
}
