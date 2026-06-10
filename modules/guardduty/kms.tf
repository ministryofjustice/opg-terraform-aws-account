data "aws_iam_policy_document" "findings_kms" {
  count = local.alerting_enabled ? 1 : 0
  statement {
    sid       = "EnableRootPermissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  statement {
    sid    = "AllowCloudWatchLogsEncryption"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
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
      values   = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/events/guardduty/findings"]
    }
  }
}

resource "aws_kms_key" "guardduty_findings" {
  count                   = local.alerting_enabled ? 1 : 0
  description             = "KMS key for GuardDuty findings CloudWatch log group"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.findings_kms[0].json
}

resource "aws_kms_alias" "guardduty_findings" {
  count         = local.alerting_enabled ? 1 : 0
  name          = "alias/guardduty_findings"
  target_key_id = aws_kms_key.guardduty_findings[0].key_id
}
