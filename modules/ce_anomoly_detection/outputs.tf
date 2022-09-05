output "daily_schedule_sns_topic" {
  value = aws_sns_topic.daily_cost_anomaly_updates
}
