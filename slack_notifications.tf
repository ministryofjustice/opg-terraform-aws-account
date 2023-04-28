data "aws_secretsmanager_secret" "central_aws_notifier_slack_token" {
  count    = var.aws_slack_notifications_enabled ? 1 : 0
  name     = "shared/aws-notifier-slack-bot-token"
  provider = aws.management
}

data "aws_secretsmanager_secret_version" "central_aws_notifier_slack_token" {
  count     = var.aws_slack_notifications_enabled ? 1 : 0
  secret_id = data.aws_secretsmanager_secret.central_aws_notifier_slack_token[0].id
  provider  = aws.management
}

resource "aws_secretsmanager_secret" "aws_notifier_slack_token" {
  count       = var.aws_slack_notifications_enabled ? 1 : 0
  name        = "org-infra/aws-notifier-slack-bot-token"
  description = "Secret from management account, managed by org-infra. To be used by aws slack notifier lambdas."
}

resource "aws_secretsmanager_secret_version" "aws_notifier_slack_token" {
  count         = var.aws_slack_notifications_enabled ? 1 : 0
  secret_id     = aws_secretsmanager_secret.aws_notifier_slack_token[0].id
  secret_string = data.aws_secretsmanager_secret_version.central_aws_notifier_slack_token[0].secret_string
}
