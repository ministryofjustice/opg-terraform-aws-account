resource "aws_macie2_account" "main" {
  finding_publishing_frequency = var.account_finding_publishing_frequency
  status                       = var.status
  provider                     = aws.global
}

resource "aws_macie2_classification_export_configuration" "main" {
  depends_on = [
    aws_macie2_account.main,
  ]
  s3_destination {
    bucket_name = aws_s3_bucket.bucket.bucket
    kms_key_arn = aws_kms_alias.macie_findings_encryption_key_alias_global.target_key_arn
  }
  provider = aws.global
}
