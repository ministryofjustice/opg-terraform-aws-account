output "aws_sns_topic_cis_aws_foundations_standard" {
  value = var.cis_foundation_alarms_enabled ? module.security_hub[0].aws_sns_topic_cis_aws_foundations_standard : null
}
