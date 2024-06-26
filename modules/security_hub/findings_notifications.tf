locals {
  security_hub_pagerduty_integration_enabled = var.pagerduty_securityhub_integration_key != null ? true : false
  security_hub_sns_topic_arn                 = try(aws_sns_topic.security_hub[0].arn, "default")
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
        "RecordState" : ["ACTIVE"],
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
  count      = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  name       = "SecurityHub-to-PagerDuty-${var.account_name}"
  fifo_topic = false
}

resource "aws_sns_topic_subscription" "security_hub" {
  count     = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  topic_arn = aws_sns_topic.security_hub[0].arn
  protocol  = "https"
  endpoint  = "https://events.pagerduty.com/integration/${var.pagerduty_securityhub_integration_key}/enqueue"
}

resource "aws_sns_topic_policy" "security_hub_topic_policy" {
  count  = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  arn    = aws_sns_topic.security_hub[0].arn
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
    resources = [local.security_hub_sns_topic_arn]
  }

  statement {
    sid    = "default_securityhub_findings"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SNS:GetTopicAttributes",
      "SNS:SetTopicAttributes",
      "SNS:AddPermission",
      "SNS:RemovePermission",
      "SNS:DeleteTopic",
      "SNS:Subscribe",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive"
    ]

    resources = [local.security_hub_sns_topic_arn]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "AWS:SourceOwner"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}
