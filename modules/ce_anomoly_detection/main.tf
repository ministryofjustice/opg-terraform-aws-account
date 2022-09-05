data "aws_caller_identity" "current" {
  provider = aws.global
}

resource "aws_ce_anomaly_monitor" "service_monitor" {
  name              = "AWSServiceMonitor"
  monitor_type      = "DIMENSIONAL"
  monitor_dimension = "SERVICE"
  provider          = aws.global
}

resource "aws_ce_anomaly_subscription" "weekly" {
  name      = "Weekly Subscription"
  threshold = var.weekly_schedule_threshold
  frequency = "WEEKLY"

  monitor_arn_list = [
    aws_ce_anomaly_monitor.service_monitor.arn,
  ]

  subscriber {
    type    = "EMAIL"
    address = var.notification_email_address
  }
  provider = aws.global
}

resource "aws_ce_anomaly_subscription" "daily" {
  name      = "Daily Subscription"
  threshold = var.daily_schedule_threshold
  frequency = "DAILY"

  monitor_arn_list = [
    aws_ce_anomaly_monitor.service_monitor.arn,
  ]

  subscriber {
    type    = "SNS"
    address = aws_sns_topic.daily_cost_anomaly_updates.arn
  }

  depends_on = [
    aws_sns_topic_policy.default,
  ]
  provider = aws.global
}

resource "aws_sns_topic" "daily_cost_anomaly_updates" {
  name     = "DailyCostAnomalyUpdates"
  provider = aws.global
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    sid = "AWSAnomalyDetectionSNSPublishingPermissions"

    actions = [
      "SNS:Publish",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["costalerts.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.daily_cost_anomaly_updates.arn,
    ]
  }

  statement {
    sid = "__default_statement_ID"

    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.current.account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.daily_cost_anomaly_updates.arn,
    ]
  }
  provider = aws.global
}

resource "aws_sns_topic_policy" "default" {
  arn      = aws_sns_topic.daily_cost_anomaly_updates.arn
  policy   = data.aws_iam_policy_document.sns_topic_policy.json
  provider = aws.global
}
