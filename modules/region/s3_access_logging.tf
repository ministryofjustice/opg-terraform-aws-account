resource "aws_s3_bucket" "s3_access_logging" {
  bucket = "s3-access-logs-opg-${var.product}-${var.account_name}-${data.aws_region.current.name}"
  acl    = "log-delivery-write"
  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "log"
    enabled = true

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
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
