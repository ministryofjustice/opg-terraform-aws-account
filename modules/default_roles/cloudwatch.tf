locals {
  account_id   = data.aws_caller_identity.current.account_id
  account_name = var.account_name
}

data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_log_metric_filter" "role_assume_metric" {
  count          = var.create_assume_alarm ? 1 : 0
  name           = "BreakGlassConsoleLogin"
  pattern        = "{ ($.eventType = \"AwsConsoleSignIn\") && ($.userIdentity.arn = \"arn:aws:sts::${local.account_id}:assumed-role/${aws_iam_role.role.name}/*\") }"
  log_group_name = var.aws_cloudwatch_log_group_cloudtrail_name

  metric_transformation {
    name      = "EventCount"
    namespace = "${var.aws_cloudwatch_namespace_prefix}/Cloudtrail"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "role_assume_alarm" {
  count               = var.create_assume_alarm ? 1 : 0
  alarm_name          = "${local.account_name} ${aws_iam_role.role.name} console login check"
  actions_enabled     = var.create_assume_alarm ? true : false
  alarm_actions       = var.create_assume_alarm ? [var.alarm_sns_topic_arn] : []
  ok_actions          = var.create_assume_alarm ? [var.alarm_sns_topic_arn] : []
  alarm_description   = "number of ${aws_iam_role.role.name} assume attempts"
  namespace           = "${var.aws_cloudwatch_namespace_prefix}/Cloudtrail"
  metric_name         = "EventCount"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  threshold           = 1
  treat_missing_data  = "notBreaching"
}