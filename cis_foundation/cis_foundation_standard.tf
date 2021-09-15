data "aws_cloudwatch_log_group" "cloudtrail" {
  name = var.aws_cloudwatch_log_group_cloudtrail_name
}

resource "aws_cloudwatch_log_metric_filter" "root_account_usage" {
  count          = var.controls_enabled.root_account_usage ? 1 : 0
  name           = "CIS-1.1-RootAccountUsage"
  pattern        = "{$.userIdentity.type=\"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType !=\"AwsServiceEvent\"}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "EventCount"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "root_account_usage" {
  count               = var.controls_enabled.root_account_usage ? 1 : 0
  actions_enabled     = true
  alarm_name          = "CIS-1.1-RootAccountUsage"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "root login usage count"
  namespace           = "CISLogMetrics"
  metric_name         = "EventCount"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}
