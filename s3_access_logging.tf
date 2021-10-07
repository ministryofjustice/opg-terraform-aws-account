
resource "aws_s3_bucket" "s3_access_logging" {
  bucket = "s3-access-logs.${var.account_name}.${var.product}.opg.service.justice.gov.uk"
  acl    = "log-delivery-write"
  tags   = local.mandatory_moj_tags
  versioning {
    enabled = true
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
