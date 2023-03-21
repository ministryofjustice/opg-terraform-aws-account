resource "aws_sns_topic" "custom_cloudwatch_alarms" {
  name                                     = "custom_cloudwatch_alarms"
  kms_master_key_id                        = aws_kms_key.custom_cloudwatch_alarms_sns.key_id
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

resource "aws_kms_key" "custom_cloudwatch_alarms_sns" {
  description             = "KMS Key for custom cloudwatch alarms related SNS Encryption"
  deletion_window_in_days = 10
  policy                  = data.aws_iam_policy_document.custom_cloudwatch_alarms_sns_kms.json
  enable_key_rotation     = true
}

resource "aws_kms_alias" "custom_cloudwatch_alarms_sns" {
  name          = "alias/cis-aws-foundations-standard-sns"
  target_key_id = aws_kms_key.custom_cloudwatch_alarms_sns.key_id
}

data "aws_iam_policy_document" "custom_cloudwatch_alarms_sns_kms" {
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
