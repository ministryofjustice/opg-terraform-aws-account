# This will alarm when breakglass role is assumed via an API call (such as from the cli)
resource "aws_cloudwatch_log_metric_filter" "breakglass_assume_role_metric" {
  count          = var.custom_alarms_breakglass_assume_role_alarm_enabled ? 1 : 0
  name           = "BreakGlassAssumeRole"
  pattern        = "{ ($.eventName = \"AssumeRole\") && ($.requestParameters.roleArn = \"arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/breakglass*\") }"
  log_group_name = var.cloudtrail_log_group_name

  metric_transformation {
    name      = "BreakglassAssumeRoleCount"
    namespace = "${var.product}/Cloudtrail"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "breakglass_assume_role_alarm" {
  count               = var.custom_alarms_breakglass_assume_role_alarm_enabled ? 1 : 0
  actions_enabled     = true
  alarm_name          = "${var.account_name} breakglass console assume_role check"
  alarm_actions       = [aws_sns_topic.custom_cloudwatch_alarms.arn]
  alarm_description   = "number of breakglass assume role occurrences"
  namespace           = "${var.product}/Cloudtrail"
  metric_name         = "BreakglassAssumeRoleCount"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 300
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  threshold           = 1
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_query_definition" "breakglass_assume_role_alarm" {
  count           = var.custom_alarms_breakglass_assume_role_alarm_enabled ? 1 : 0
  name            = "Custom Cloudwatch Alarms/Breakglass Assume Role"
  log_group_names = [var.cloudtrail_log_group_name]
  query_string    = <<EOF
fields @timestamp, sourceIPAddress, eventType, eventName
| filter requestParameters.roleArn like "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/breakglass"
| filter eventName = "AssumeRole"
| sort @timestamp desc
EOF
}
