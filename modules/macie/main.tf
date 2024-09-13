resource "aws_macie2_account" "main" {
  finding_publishing_frequency = var.account_finding_publishing_frequency
  status                       = var.status
}

resource "aws_macie2_classification_export_configuration" "main" {
  depends_on = [
    aws_macie2_account.main,
  ]
  s3_destination {
    bucket_name = aws_s3_bucket.bucket.bucket
    kms_key_arn = module.macie_findings.eu_west_1_kms_key_arn
  }
}
