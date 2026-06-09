resource "aws_guardduty_detector" "main" {
  count  = local.guardduty_enabled ? 1 : 0
  enable = true
}

resource "aws_cloudwatch_log_group" "guardduty_findings" {
  count             = local.guardduty_enabled ? 1 : 0
  name              = "/aws/events/guardduty/findings"
  retention_in_days = 90
}

data "aws_iam_policy_document" "guardduty_log_group_resource_policy" {
  count = local.guardduty_enabled ? 1 : 0

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

resource "aws_cloudwatch_log_resource_policy" "guardduty_findings" {
  count           = local.guardduty_enabled ? 1 : 0
  policy_document = data.aws_iam_policy_document.guardduty_log_group_resource_policy[0].json
  policy_name     = "guardduty-findings-eventbridge"
}

resource "aws_cloudwatch_event_rule" "guardduty_findings" {
  count       = local.guardduty_enabled ? 1 : 0
  name        = "guardduty-findings"
  description = "Capture all GuardDuty findings from the default event bus"

  event_pattern = jsonencode({
    source      = ["aws.guardduty"]
    detail-type = ["GuardDuty Finding"]
  })
}

resource "aws_cloudwatch_event_target" "guardduty_findings_log_group" {
  count = local.guardduty_enabled ? 1 : 0
  rule  = aws_cloudwatch_event_rule.guardduty_findings[0].name
  arn   = aws_cloudwatch_log_group.guardduty_findings[0].arn
}
