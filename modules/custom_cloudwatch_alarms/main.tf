resource "aws_cloudwatch_log_metric_filter" "breakglass_metric" {
  count          = var.custom_alarms_breakglass_login_alarm_enabled ? 1 : 0
  name           = "BreakGlassConsoleLogin"
  pattern        = "{ ($.eventType = \"AwsConsoleSignIn\") && ($.userIdentity.arn = \"arn:aws:sts::${data.aws_caller_identity.current.account_id}:assumed-role/breakglass/*\") }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "EventCount"
    namespace = "${var.product}/Cloudtrail"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "account_breakglass_login_alarm" {
  count               = var.custom_alarms_breakglass_login_alarm_enabled ? 1 : 0
  actions_enabled     = true
  alarm_name          = "${var.account_name} breakglass console login check"
  alarm_actions       = [aws_sns_topic.custom_cloudwatch_alarms.arn]
  ok_actions          = [aws_sns_topic.custom_cloudwatch_alarms.arn]
  alarm_description   = "number of breakglass logins"
  namespace           = "${var.product}/Cloudtrail"
  metric_name         = "EventCount"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  threshold           = 1
  treat_missing_data  = "notBreaching"
}
