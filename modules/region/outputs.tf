output "access_logging_bucket" {
  value = aws_s3_bucket.s3_access_logging
}

output "aws_sns_topic_cis_aws_foundations_standard" {
  value = module.security_hub_controls.aws_sns_topic_cis_aws_foundations_standard
}
