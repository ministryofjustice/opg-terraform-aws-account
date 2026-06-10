data "aws_iam_policy_document" "log_group_resource_policy" {
  count = local.alerting_enabled ? 1 : 0
  statement {
    sid    = "AllowEventBridgeToPutLogs"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com", "delivery.logs.amazonaws.com"]
    }
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.guardduty_findings[0].arn}:*"]
  }
}

resource "aws_cloudwatch_log_group" "guardduty_findings" {
  count             = local.alerting_enabled ? 1 : 0
  name              = "/aws/events/guardduty/findings"
  retention_in_days = 90
  kms_key_id        = aws_kms_key.guardduty_findings[0].arn
}

resource "aws_cloudwatch_log_resource_policy" "guardduty_findings" {
  count           = local.alerting_enabled ? 1 : 0
  policy_document = data.aws_iam_policy_document.log_group_resource_policy[0].json
  policy_name     = "guardduty-findings-eventbridge"
}

resource "aws_cloudwatch_event_rule" "guardduty_findings" {
  count       = local.alerting_enabled ? 1 : 0
  name        = "guardduty-findings"
  description = "Capture all GuardDuty findings from the default event bus"

  event_pattern = jsonencode({
    source      = ["aws.guardduty"]
    detail-type = ["GuardDuty Finding"]
  })
}

resource "aws_cloudwatch_event_target" "guardduty_findings_log_group" {
  count = local.alerting_enabled ? 1 : 0
  rule  = aws_cloudwatch_event_rule.guardduty_findings[0].name
  arn   = aws_cloudwatch_log_group.guardduty_findings[0].arn
}

resource "aws_cloudwatch_log_metric_filter" "guardduty_findings" {
  count          = local.alerting_enabled ? 1 : 0
  name           = "guardduty-findings"
  pattern        = "{ $.detail.severity >= ${local.alert_threshold} }"
  log_group_name = aws_cloudwatch_log_group.guardduty_findings[0].name

  metric_transformation {
    name      = "GuardDutyFindingCount"
    namespace = "GuardDuty"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "guardduty_findings" {
  count               = local.alerting_enabled ? 1 : 0
  alarm_name          = "guardduty-findings"
  alarm_description   = "GuardDuty finding at or above ${var.alert_minimum_severity} severity detected"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "GuardDutyFindingCount"
  namespace           = "GuardDuty"
  period              = 300
  statistic           = "Sum"
  threshold           = 1
  treat_missing_data  = "ignore"
  alarm_actions       = [aws_sns_topic.guardduty_findings[0].arn]
}
