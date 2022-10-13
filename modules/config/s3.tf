data "aws_region" "current" {}

resource "aws_s3_bucket" "config" {
  bucket        = "config.${data.aws_region.current.name}.${var.account_name}.${var.product}.opg.justice.gov.uk"
  acl           = "private"
  force_destroy = true
  logging {
    target_bucket = var.s3_access_logging_bucket_name
    target_prefix = "log/config.${data.aws_region.current.name}.${var.account_name}.${var.product}.opg.justice.gov.uk/"
  }

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    expiration {
      days = 490
    }

    noncurrent_version_expiration {
      days = 10
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "config" {
  bucket = aws_s3_bucket.config.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_policy" "config_bucket" {
  bucket = aws_s3_bucket_public_access_block.config.bucket
  policy = data.aws_iam_policy_document.config_bucket.json
}

data "aws_iam_policy_document" "config_bucket" {
  policy_id = "PutObjPolicy"

  statement {
    sid    = "AWSConfigBucketPermissionsCheck"
    effect = "Allow"

    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.config.arn]
  }

  statement {
    sid     = "AWSConfigBucketExistenceCheck"
    effect  = "Allow"
    actions = ["s3:ListBucket"]
    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }
    resources = [aws_s3_bucket.config.arn]
  }

  statement {
    sid    = "AWSConfigBucketDelivery"
    effect = "Allow"

    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.config.arn}/*"]

    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }

  statement {
    sid     = "DenyNoneSSLRequests"
    effect  = "Deny"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.config.arn,
      "${aws_s3_bucket.config.arn}/*"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = [false]
    }

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }

}
