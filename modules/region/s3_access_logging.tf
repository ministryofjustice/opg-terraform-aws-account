resource "aws_s3_bucket" "s3_access_logging" {
  bucket = "s3-access-logs-opg-${var.product}-${var.account_name}-${data.aws_region.current.name}"
}

resource "aws_s3_bucket_versioning" "s3_access_logging" {
  bucket = aws_s3_bucket.s3_access_logging.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_access_logging" {
  bucket = aws_s3_bucket.s3_access_logging.id

  rule {
    status = "Enabled"
    id     = "expire-after-490-days"

    transition {
      days          = 30
      storage_class = "GLACIER"
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

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_access_logging" {
  bucket = aws_s3_bucket.s3_access_logging.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# See AWS bucket change - https://aws.amazon.com/about-aws/whats-new/2022/12/amazon-s3-automatically-enable-block-public-access-disable-access-control-lists-buckets-april-2023/
resource "aws_s3_bucket_ownership_controls" "s3_access_logging" {
  bucket = aws_s3_bucket.s3_access_logging.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3_access_logging" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_access_logging]
  bucket     = aws_s3_bucket.s3_access_logging.id
  acl        = "log-delivery-write"
}



resource "aws_s3_bucket_public_access_block" "s3_access_logging" {
  bucket                  = aws_s3_bucket.s3_access_logging.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_policy" "s3_access_logging" {
  bucket = aws_s3_bucket.s3_access_logging.bucket
  policy = data.aws_iam_policy_document.s3_access_logging.json
}

data "aws_iam_policy_document" "s3_access_logging" {
  statement {
    sid     = "DenyNoneSSLRequests"
    effect  = "Deny"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.s3_access_logging.arn,
      "${aws_s3_bucket.s3_access_logging.arn}/*"
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
  s3_bucket_id                  = aws_s3_bucket.s3_access_logging.id
  sns_failure_feedback_role_arn = var.sns_failure_feedback_role_arn
  sns_success_feedback_role_arn = var.sns_success_feedback_role_arn
}
