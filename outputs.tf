output "aws_sns_topic_cis_aws_foundations_standard" {
  value = var.cis_foundation_alarms_enabled == true ? module.cis_foundation[0].aws_sns_topic_cis_aws_foundations_standard : null
}
