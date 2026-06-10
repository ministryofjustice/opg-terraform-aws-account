output "sns_topic_arn" {
  description = "ARN of the SNS topic for GuardDuty finding alerts."
  value       = length(aws_sns_topic.guardduty_findings) > 0 ? aws_sns_topic.guardduty_findings[0].arn : null
}
