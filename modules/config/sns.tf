resource "aws_sns_topic" "config" {
  name                                     = "aws-config-${local.config_name}"
  kms_master_key_id                        = aws_kms_key.config_sns.key_id
  application_failure_feedback_role_arn    = var.sns_failure_feedback_role_arn
  application_success_feedback_role_arn    = var.sns_success_feedback_role_arn
  application_success_feedback_sample_rate = 100
  firehose_failure_feedback_role_arn       = var.sns_failure_feedback_role_arn
  firehose_success_feedback_role_arn       = var.sns_success_feedback_role_arn
  firehose_success_feedback_sample_rate    = 100
  http_failure_feedback_role_arn           = var.sns_failure_feedback_role_arn
  http_success_feedback_role_arn           = var.sns_success_feedback_role_arn
  http_success_feedback_sample_rate        = 100
  lambda_failure_feedback_role_arn         = var.sns_failure_feedback_role_arn
  lambda_success_feedback_role_arn         = var.sns_success_feedback_role_arn
  lambda_success_feedback_sample_rate      = 100
  sqs_failure_feedback_role_arn            = var.sns_failure_feedback_role_arn
  sqs_success_feedback_role_arn            = var.sns_success_feedback_role_arn
  sqs_success_feedback_sample_rate         = 100
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
