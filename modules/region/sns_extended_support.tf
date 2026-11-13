resource "aws_sns_topic" "extended_support" {
  name                                     = "extended-support-sns-topic"
  kms_master_key_id                        = aws_kms_key.extended_support_sns_topic.key_id
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

resource "aws_kms_key" "extended_support_sns_topic" {
  description             = "KMS Key for SNS encryption for CloudWatch Extended Support Alerts "
  deletion_window_in_days = 10
  policy                  = data.aws_iam_policy_document.extended_support_sns_topic_kms.json
  enable_key_rotation     = true
}

resource "aws_kms_alias" "extended_support_sns_topic" {
  name          = "alias/extended-support-sns-topic-encryption"
  target_key_id = aws_kms_key.extended_support_sns_topic.key_id
}

data "aws_iam_policy_document" "extended_support_sns_topic_kms" {
  statement {
    sid       = "Allow Key to be used for Encryption"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*",
    ]
    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }
  }
  statement {
    sid       = "Enable Root account permissions on Key"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
      ]
    }
  }
  statement {
    sid       = "Key Administrator"
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
      "kms:CancelKeyDeletion"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/breakglass"]
    }
  }
}
