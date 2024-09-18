#TODO: make these resources in the root or a global module.
module "macie_findings_encryption_key" {
  source                  = "../kms_key_multi_region"
  encrypted_resource      = "Macie S3 bucket"
  kms_key_alias_name      = "${data.aws_default_tags.current.tags.application}-macie-findings-s3-bucket-encryption"
  enable_key_rotation     = true
  enable_multi_region     = true
  deletion_window_in_days = 10
  kms_key_policy          = var.account_name == "development" ? data.aws_iam_policy_document.macie_findings_merged.json : data.aws_iam_policy_document.macie_findings.json
  providers = {
    aws.eu_west_1 = aws.eu_west_1
    aws.eu_west_2 = aws.eu_west_2
  }
}

#TODO: make this key policy specific for Macie
# See the following link for further information
# https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html

data "aws_iam_policy_document" "macie_findings_merged" {
  provider = aws.global
  source_policy_documents = [
    data.aws_iam_policy_document.macie_findings.json,
    data.aws_iam_policy_document.macie_findings_development_account_operator_admin.json
  ]
}

data "aws_iam_policy_document" "macie_findings" {
  provider = aws.global

  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "kms:*",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid    = "Allow Key to be used for Encryption by Macie"
    effect = "Allow"
    resources = [
      "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
    ]
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/service-role/AmazonMacieServiceRole",
      ]
    }
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"

      values = [
        "s3.*.amazonaws.com"
      ]
    }
  }

  statement {
    sid    = "General View Access"
    effect = "Allow"
    resources = [
      "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
    ]
    actions = [
      "kms:DescribeKey",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:List*",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }
  }

  statement {
    sid    = "Key Administrator"
    effect = "Allow"
    resources = [
      "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
    ]
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
      "kms:ReplicateKey",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/breakglass",
      ]
    }
  }
}

data "aws_iam_policy_document" "macie_findings_development_account_operator_admin" {
  provider = aws.global
  statement {
    sid    = "Dev Account Key Administrator"
    effect = "Allow"
    resources = [
      "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
    ]
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
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/operator"
      ]
    }
  }
}
