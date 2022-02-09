resource "aws_iam_policy" "config_policy" {
  name   = "aws-config-${var.product}-${var.account_name}-${data.aws_region.current.name}-policy"
  policy = data.aws_iam_policy_document.config_policy.json
}

resource "aws_iam_role_policy_attachment" "config_policy" {
  role       = var.config_iam_role.name
  policy_arn = aws_iam_policy.config_policy.arn
}

data "aws_iam_policy_document" "config_policy" {
  policy_id = "PutObjPolicy"
  statement {
    sid       = "AWSConfigBucketPermissionsCheck"
    effect    = "Allow"
    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.config.arn]
  }

  statement {
    sid       = "AWSConfigBucketExistenceCheck"
    effect    = "Allow"
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.config.arn]
  }

  statement {
    sid       = "AWSPublish"
    effect    = "Allow"
    actions   = ["SNS:Publish"]
    resources = ["*"]
  }

  statement {
    sid       = "AWSConfigBucketDelivery"
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.config.arn}/*"]
    condition {
      test     = "StringLike"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }
}
