module "macie" {
  source                               = "./modules/macie"
  account_finding_publishing_frequency = var.aws_macie2_account_finding_publishing_frequency
  status                               = var.aws_macie2_status
  account_name                         = var.account_name
  product                              = var.product
  s3_access_logging_bucket_name        = module.eu-west-1.access_logging_bucket.bucket
}
