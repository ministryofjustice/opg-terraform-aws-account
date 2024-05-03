locals {
  security_hub_pagerduty_integration_enabled = var.pagerduty_securityhub_integration_key != null ? true : false
}

resource "aws_cloudwatch_event_rule" "security_hub" {
  count       = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  name        = "securityhub_findings"
  description = "Findings from SecurityHub"

  event_pattern = jsonencode({
    "source" : ["aws.securityhub"],
    "detail-type" : ["Security Hub Findings - Imported"],
    "detail" : {
      "findings" : {
        "Severity" : {
          "Label" : ["HIGH", "CRITICAL"]
        },
        "Workflow" : {
          "Status" : ["NEW"]
        }
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "sns" {
  count = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  arn   = aws_sns_topic.security_hub[0].arn
  rule  = aws_cloudwatch_event_rule.security_hub[0].name
}

resource "aws_sns_topic" "security_hub" {
  count             = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  name              = "SecurityHub-to-PagerDuty-${var.account_name}"
  fifo_topic        = false
  kms_master_key_id = aws_kms_key.security_hub_sns.arn
}

resource "aws_sns_topic_subscription" "security_hub" {
  count     = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  topic_arn = aws_sns_topic.security_hub[0].arn
  protocol  = "https"
  endpoint  = "https://events.pagerduty.com/integration/${var.pagerduty_securityhub_integration_key}/enqueue"
}

resource "aws_sns_topic_policy" "security_hub_topic_policy" {
  count = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  arn   = aws_sns_topic.security_hub[0].arn

  policy = data.aws_iam_policy_document.security_hub_sns_topic.json
}

data "aws_iam_policy_document" "security_hub_sns_topic" {
  statement {
    sid    = "AWSEvents_securityhub_findings_${var.account_name}"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.security_hub[0].arn]
  }
}

resource "aws_kms_key" "security_hub_sns" {
  description = "KMS Key for Security Hub to SNS"
  policy      = data.aws_iam_policy_document.security_hub_sns_key.json
}

data "aws_iam_policy_document" "security_hub_sns_key" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["kms:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  statement {
    sid    = "AllowEventBridgeDecrypt"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*",
    ]
    resources = [aws_sns_topic.security_hub[0].arn]
  }

  statement {
    sid       = "Allow access for Key Administrators"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ci"]
    }
  }
}
