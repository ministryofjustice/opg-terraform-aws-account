resource "aws_s3_account_public_access_block" "block_all" {
  count                   = var.aws_s3_account_block_public_access_enable == true ? 1 : 0
  block_public_acls       = var.aws_s3_account_block_public_acls
  block_public_policy     = var.aws_s3_account_block_public_policy
  ignore_public_acls      = var.aws_s3_account_ignore_public_acls
  restrict_public_buckets = var.aws_s3_account_restrict_public_buckets
}
