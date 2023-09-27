module "cost_anomaly_detection" {
  source                        = "./modules/ce_anomaly_detection"
  notification_email_address    = var.cost_anomaly_notification_email_address
  weekly_schedule_threshold     = var.cost_anomaly_weekly_schedule_threshold
  immediate_schedule_threshold  = var.cost_anomaly_immediate_schedule_threshold
  threshold_expression_type     = var.cost_anomaly_threshold_expression_type
  sns_failure_feedback_role_arn = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn = aws_iam_role.sns_success_feedback.arn
  providers = {
    aws.global = aws.global
  }
}
