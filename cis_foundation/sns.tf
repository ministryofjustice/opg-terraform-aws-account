resource "aws_sns_topic" "cis_aws_foundations_standard" {
  name              = "cis_aws_foundations_standard"
  kms_master_key_id = aws_kms_key.cis_aws_foundations_standard_sns.key_id
}

output "aws_sns_topic_cis_aws_foundations_standard" {
  value = aws_sns_topic.cis_aws_foundations_standard
}

resource "aws_kms_key" "cis_aws_foundations_standard_sns" {
  description             = "KMS Key for CiS Foundation Standards related SNS Encryption"
  deletion_window_in_days = 10
  policy                  = data.aws_iam_policy_document.cis_aws_foundations_standard_sns_kms.json
  enable_key_rotation     = true
}

resource "aws_kms_alias" "cis_aws_foundations_standard_sns" {
  name          = "alias/cis-aws-foundations-standard-sns"
  target_key_id = aws_kms_key.cis_aws_foundations_standard_sns.key_id
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "cis_aws_foundations_standard_sns_kms" {
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
