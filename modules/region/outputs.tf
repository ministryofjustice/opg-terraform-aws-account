output "access_logging_bucket" {
  value = aws_s3_bucket.s3_access_logging
}

output "aws_sns_topic_custom_cloudwatch_alarms" {
  value = module.custom_cloudwatch_alarms.aws_sns_topic_custom_cloudwatch_alarms
}
