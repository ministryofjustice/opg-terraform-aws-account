module "cloudtrail" {
  source                        = "./cloudtrail"
  trail_name                    = var.cloudtrail_trail_name
  bucket_name                   = var.cloudtrail_bucket_name
  s3_access_logging_bucket_name = aws_s3_bucket.s3_access_logging.id
  tags                          = local.mandatory_moj_tags
}
