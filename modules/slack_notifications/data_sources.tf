data "aws_caller_identity" "current" {
}

data "aws_ecr_repository" "cost_notifier_lambda" {
  name     = "shared/aws-cost-notifier"
  provider = aws.management
}

data "aws_ecr_repository" "health_notifier_lambda" {
  name     = "shared/aws-health-notifier"
  provider = aws.management
}

data "aws_secretsmanager_secret" "central_aws_notifier_slack_token" {
  name     = "shared/aws-notifier-slack-bot-token"
  provider = aws.management
}

data "aws_secretsmanager_secret_version" "central_aws_notifier_slack_token" {
  secret_id = data.aws_secretsmanager_secret.central_aws_notifier_slack_token.id
  provider  = aws.management
}

resource "aws_secretsmanager_secret" "aws_notifier_slack_token" {
  name        = "org-infra/aws-notifier-slack-bot-token"
  description = "Secret from management account, managed by org-infra. To be used by aws slack notifier lambdas."
}

resource "aws_secretsmanager_secret_version" "aws_notifier_slack_token" {
  secret_id     = aws_secretsmanager_secret.aws_notifier_slack_token.id
  secret_string = data.aws_secretsmanager_secret_version.central_aws_notifier_slack_token.secret_string
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
      error_message = "Health Notifier Version Must Be v1.x.x"
    }
  }
}
