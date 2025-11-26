data "aws_region" "current" {}

resource "aws_s3_bucket" "config" {
  bucket        = "config-${data.aws_region.current.name}-${var.account_name}-${var.product}-opg"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "config" {
  bucket = aws_s3_bucket.config.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "config" {
  bucket = aws_s3_bucket.config.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_logging" "config" {
  bucket        = aws_s3_bucket.config.id
  target_bucket = var.s3_access_logging_bucket_name
  target_prefix = "log/config-${data.aws_region.current.name}-${var.account_name}-${var.product}-opg"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "config" {
  bucket = aws_s3_bucket.config.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "config" {
  bucket = aws_s3_bucket.config.id

  rule {
    status = "Enabled"
    id     = "expire-after-490-days"

    noncurrent_version_expiration {
      noncurrent_days = 10
    }

    expiration {
      days = 490
    }
  }

  rule {
    id = "abort-incomplete-multipart-upload"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }

    status = "Enabled"
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
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
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
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
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
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
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

module "s3_event_notifications" {
  source = "../s3_bucket_event_notifications"
  s3_bucket_event_types = [
    "s3:ObjectRemoved:*",
    "s3:ObjectAcl:Put",
  ]
  s3_bucket_id                  = aws_s3_bucket.config.id
  sns_failure_feedback_role_arn = var.sns_failure_feedback_role_arn
  sns_success_feedback_role_arn = var.sns_success_feedback_role_arn
}
