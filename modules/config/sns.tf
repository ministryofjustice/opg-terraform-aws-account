resource "aws_sns_topic" "config" {
  name              = local.config_name
  kms_master_key_id = aws_kms_key.config_sns.key_id
}

resource "aws_sns_topic_policy" "config" {
  arn    = aws_sns_topic.config.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
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
      values   = [data.aws_caller_identity.current.account_id]
    }
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [aws_sns_topic.config.arn]
    sid       = "DefaultSNSPolicy"
  }

  statement {
    actions = ["SNS:Publish"]
    effect  = "Allow"
    principals {
      type        = "AWS"
      identifiers = [var.config_iam_role.arn]
    }
    resources = [aws_sns_topic.config.arn]
    sid       = "AWSConfigSNSPolicyAllowRole"
  }
}

data "aws_caller_identity" "current" {}
