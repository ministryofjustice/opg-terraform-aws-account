data "aws_caller_identity" "guardduty" {}
data "aws_region" "guardduty" {}

resource "aws_guardduty_detector" "main" {
  count  = local.guardduty_enabled ? 1 : 0
  enable = true
}

data "aws_iam_policy_document" "guardduty_findings_kms" {
  count = local.guardduty_enabled ? 1 : 0

  statement {
    sid       = "EnableRootPermissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.guardduty.account_id}:root"]
    }
  }

  statement {
    sid    = "AllowCloudWatchLogsEncryption"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.guardduty.name}.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = ["*"]
    condition {
      test     = "ArnEquals"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws:logs:${data.aws_region.guardduty.name}:${data.aws_caller_identity.guardduty.account_id}:log-group:/aws/events/guardduty/findings"]
    }
  }
}

resource "aws_kms_key" "guardduty_findings" {
  count                   = local.guardduty_enabled ? 1 : 0
  description             = "KMS key for GuardDuty findings CloudWatch log group"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.guardduty_findings_kms[0].json
}

resource "aws_kms_alias" "guardduty_findings" {
  count         = local.guardduty_enabled ? 1 : 0
  name          = "alias/guardduty_findings"
  target_key_id = aws_kms_key.guardduty_findings[0].key_id
}

resource "aws_cloudwatch_log_group" "guardduty_findings" {
  count             = local.guardduty_enabled ? 1 : 0
  name              = "/aws/events/guardduty/findings"
  retention_in_days = 90
  kms_key_id        = aws_kms_key.guardduty_findings[0].arn
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
