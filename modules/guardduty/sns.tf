data "aws_iam_policy_document" "findings_sns" {
  count = local.alerting_enabled ? 1 : 0

  statement {
    sid    = "AllowCloudWatchAlarmsPublish"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.guardduty_findings[0].arn]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

  statement {
    sid    = "EnableRootPermissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["sns:*"]
    resources = [aws_sns_topic.guardduty_findings[0].arn]
  }
}

resource "aws_sns_topic" "guardduty_findings" {
  count             = local.alerting_enabled ? 1 : 0
  name              = "guardduty-findings-${var.alert_minimum_severity}-and-above"
  kms_master_key_id = aws_kms_key.guardduty_findings[0].key_id
}

resource "aws_sns_topic_policy" "guardduty_findings" {
  count  = local.alerting_enabled ? 1 : 0
  arn    = aws_sns_topic.guardduty_findings[0].arn
  policy = data.aws_iam_policy_document.findings_sns[0].json
}
