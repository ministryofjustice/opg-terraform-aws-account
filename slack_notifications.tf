module "aws_cost_notifier" {
  count              = local.aws_cost_anomaly_notifications_enabled ? 1 : 0
  source             = "git@github.com:ministryofjustice/opg-aws-cost-notifier.git"
  account_name       = var.account_name
  ecr_repository_url = data.aws_ecr_repository.cost_notifier_lambda.repository_url
  slack_channel_id   = var.aws_slack_cost_anomaly_notification_channel
  slack_secret_arn   = aws_secretsmanager_secret.aws_notifier_slack_token[0].arn
  sns_topic_arn      = module.cost_anomaly_detection.immediate_schedule_sns_topic.arn
  version_tag        = data.aws_ssm_parameter.cost_notifier_lambda_version.value
  providers = {
    aws           = aws
    aws.us-east-1 = aws.global
  }
}

module "aws_health_notifier" {
  count              = local.aws_health_notifications_enabled ? 1 : 0
  source             = "git@github.com:ministryofjustice/opg-aws-health-notifier.git"
  account_name       = var.account_name
  ecr_repository_url = data.aws_ecr_repository.health_notifier_lambda.repository_url
  slack_channel_id   = var.aws_slack_health_notification_channel
  slack_secret_arn   = aws_secretsmanager_secret.aws_notifier_slack_token[0].arn
  version_tag        = data.aws_ssm_parameter.health_notifier_lambda_version.value
  providers = {
    aws           = aws
    aws.eu-west-2 = aws.eu-west-2
    aws.us-east-1 = aws.global
  }
}

data "aws_ecr_repository" "cost_notifier_lambda" {
  name     = "shared/aws-cost-notifier"
  provider = aws.management
}

data "aws_ecr_repository" "health_notifier_lambda" {
  name     = "shared/aws-health-notifier"
  provider = aws.management
}

data "aws_ssm_parameter" "cost_notifier_lambda_version" {
  name     = "/shared/aws-cost-notifier-lambda-version"
  provider = aws.management

  lifecycle {
    postcondition {
      condition     = can(regex("^[v][1][.]", self.value))
      error_message = "Cost Notifier Version Must Be v1.x.x"
    }
  }
}

data "aws_ssm_parameter" "health_notifier_lambda_version" {
  name     = "/shared/aws-health-notifier-lambda-version"
  provider = aws.management

  lifecycle {
    postcondition {
      condition     = can(regex("^[v][1][.]", self.value))
      error_message = "Healthgitst Notifier Version Must Be v1.x.x"
    }
  }
}


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
