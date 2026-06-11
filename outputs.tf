output "aws_sns_topic_cis_aws_foundations_standard" {
  value = var.cis_foundation_alarms_enabled && local.security_hub_enabled ? module.eu-west-1.aws_sns_topic_cis_aws_foundations_standard : null
}

output "aws_sns_topic_cis_aws_foundations_standard_eu_west_1" {
  value = var.cis_foundation_alarms_enabled && local.security_hub_enabled ? module.eu-west-1.aws_sns_topic_cis_aws_foundations_standard : null
}

output "aws_sns_topic_cis_aws_foundations_standard_eu-west_2" {
  value = var.cis_foundation_alarms_enabled && local.security_hub_enabled ? module.eu-west-2.aws_sns_topic_cis_aws_foundations_standard : null
}

output "aws_sns_topic_ce_detection_immediate_schedule" {
  value = module.cost_anomaly_detection.immediate_schedule_sns_topic
}

output "aws_sns_topic_custom_cloudwatch_alarms" {
  value = var.modernisation_platform_account ? module.custom_cloudwatch_alarms_vendored[0].aws_sns_topic_custom_cloudwatch_alarms : module.custom_cloudwatch_alarms[0].aws_sns_topic_custom_cloudwatch_alarms
}

output "aws_sns_topic_slack_notification_failures" {
  value = var.aws_slack_notifications_enabled ? module.slack_notifications[0].slack_notification_failures : null
}

output "aws_sns_topic_guardduty_findings" {
  value = local.guardduty_enabled ? module.guardduty[0].sns_topic : null
}

output "ci_iam_role" {
  value = length(var.user_arns.ci) > 0 && var.ci_classic_enabled ? module.ci[0].aws_iam_role : null
}

output "ci_iam_role_boundaried" {
  value = length(var.user_arns.ci) > 0 && var.ci_boundaried_enabled ? module.ci_boundaried[0].aws_iam_role : null
}
