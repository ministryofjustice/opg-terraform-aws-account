module "macie" {
  count                            = var.aws_macie2_status == "DISABLED" ? 0 : 1
  source                           = "../macie_regional"
  account_name                     = var.account_name
  finding_publishing_frequency     = var.aws_macie2_finding_publishing_frequency
  macie_findings_s3_bucket_kms_key = var.macie_findings_s3_bucket_kms_key
  product                          = var.product
  s3_access_logging_bucket_name    = aws_s3_bucket.s3_access_logging.bucket
  status                           = var.aws_macie2_status
  providers = {
    aws.region = aws
  }
}
