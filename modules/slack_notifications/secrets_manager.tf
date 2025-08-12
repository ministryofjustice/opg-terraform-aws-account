resource "aws_secretsmanager_secret" "aws_notifier_slack_token" {
  name                           = "org-infra/aws-notifier-slack-bot-token"
  description                    = "Secret from management account, managed by org-infra. To be used by aws slack notifier lambdas."
  force_overwrite_replica_secret = true
  replica {
    region = "eu-west-2"
  }
}

resource "aws_secretsmanager_secret_version" "aws_notifier_slack_token" {
  secret_id     = aws_secretsmanager_secret.aws_notifier_slack_token.id
  secret_string = data.aws_secretsmanager_secret_version.central_aws_notifier_slack_token.secret_string
}
