resource "aws_s3_bucket" "cloudtrail" {
  bucket = var.bucket_name
  logging {
    target_bucket = var.s3_access_logging_bucket_name
    target_prefix = "log/${var.bucket_name}/"
  }

  lifecycle_rule {
    enabled = true
    id      = "archive-after-30-days"
    noncurrent_version_transition {
      days          = 30
      storage_class = "GLACIER"
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.cloudtrail_s3.key_id
      }
    }
  }
}

# See AWS bucket change - https://aws.amazon.com/about-aws/whats-new/2022/12/amazon-s3-automatically-enable-block-public-access-disable-access-control-lists-buckets-april-2023/
resource "aws_s3_bucket_ownership_controls" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "cloudtrail" {
  depends_on = [aws_s3_bucket_ownership_controls.cloudtrail]
  bucket     = aws_s3_bucket.cloudtrail.id
  acl        = "log-delivery-write"
}



resource "aws_s3_bucket_public_access_block" "cloudtrail" {
  bucket = aws_s3_bucket_policy.cloudtrail.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "cloudtrail" {
  bucket = aws_s3_bucket.cloudtrail.bucket
  policy = data.aws_iam_policy_document.cloudtrail.json
}

data "aws_iam_policy_document" "cloudtrail" {
  statement {
    sid     = "AWSCloudTrailAclCheck"
    effect  = "Allow"
    actions = ["s3:GetBucketAcl"]
    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }
    resources = [aws_s3_bucket.cloudtrail.arn]
  }

  statement {
    sid     = "AWSCloudTrailWrite"
    effect  = "Allow"
    actions = ["s3:PutObject"]
    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }
    resources = ["${aws_s3_bucket.cloudtrail.arn}/*"]
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }

  statement {
    sid     = "AWSConfigBucketExistenceCheck"
    effect  = "Allow"
    actions = ["s3:ListBucket"]
    principals {
      identifiers = ["cloudtrail.amazonaws.com"]
      type        = "Service"
    }
    resources = [aws_s3_bucket.cloudtrail.arn]
  }

  statement {
    sid     = "DenyNoneSSLRequests"
    effect  = "Deny"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.cloudtrail.arn,
      "${aws_s3_bucket.cloudtrail.arn}/*"
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
  s3_bucket_id                  = aws_s3_bucket.cloudtrail.id
  sns_failure_feedback_role_arn = var.sns_failure_feedback_role_arn
  sns_success_feedback_role_arn = var.sns_success_feedback_role_arn
}
