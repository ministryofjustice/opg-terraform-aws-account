output "sns_topic" {
  description = "SNS topic for GuardDuty finding alerts."
  value       = length(aws_sns_topic.guardduty_findings) > 0 ? aws_sns_topic.guardduty_findings[0] : null
}
