module "cloudtrail" {
  source                        = "./modules/cloudtrail"
  trail_name                    = var.cloudtrail_trail_name
  bucket_name                   = var.cloudtrail_bucket_name
  s3_access_logging_bucket_name = module.eu-west-1.access_logging_bucket.bucket
  sns_failure_feedback_role_arn = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn = aws_iam_role.sns_success_feedback.arn
}
