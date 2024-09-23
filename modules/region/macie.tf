module "macie" {
  source                           = "./modules/macie_regional"
  finding_publishing_frequency     = var.aws_macie2_finding_publishing_frequency
  status                           = var.aws_macie2_status
  account_name                     = var.account_name
  product                          = var.product
  s3_access_logging_bucket_name    = aws_s3_bucket.s3_access_logging.bucket
  macie_findings_s3_bucket_kms_key = var.macie_findings_s3_bucket_kms_key
  providers = {
    aws.region = aws
  }
}
