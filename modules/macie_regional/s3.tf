resource "aws_s3_bucket" "bucket" {
  bucket        = "macie-${data.aws_region.current.name}-${var.account_name}-${var.product}-opg"
  force_destroy = true
  provider      = aws.region
}

resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
  provider = aws.region
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket   = aws_s3_bucket.bucket.id
  acl      = "private"
  provider = aws.region
}

resource "aws_s3_bucket_logging" "bucket" {
  bucket        = aws_s3_bucket.bucket.id
  target_bucket = var.s3_access_logging_bucket_name
  target_prefix = "log/${aws_s3_bucket.bucket.id}"
  provider      = aws.region
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.macie_findings_s3_bucket_kms_key.target_key_id
    }
  }
  provider = aws.region
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

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
  provider = aws.region
}


resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket                  = aws_s3_bucket.bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  provider                = aws.region
}

resource "aws_s3_bucket_policy" "config_bucket" {
  bucket   = aws_s3_bucket_public_access_block.bucket.bucket
  policy   = data.aws_iam_policy_document.bucket.json
  provider = aws.region
}

#need a policy document for macie to write to the bucket
data "aws_iam_policy_document" "bucket" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectVersionAcl",
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}/*",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/service-role/AmazonMacieServiceRole",
      ]
    }
  }
  provider = aws.region
}
