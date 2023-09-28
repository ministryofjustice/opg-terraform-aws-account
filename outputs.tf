output "aws_sns_topic_cis_aws_foundations_standard" {
  value = var.cis_foundation_alarms_enabled && local.security_hub_enabled ? module.security_hub[0].aws_sns_topic_cis_aws_foundations_standard : null
}

output "aws_sns_topic_ce_detection_immediate_schedule" {
  value = module.cost_anomaly_detection.immediate_schedule_sns_topic
}

output "aws_sns_topic_custom_cloudwatch_alarms" {
  value = module.custom_cloudwatch_alarms.aws_sns_topic_custom_cloudwatch_alarms
}
