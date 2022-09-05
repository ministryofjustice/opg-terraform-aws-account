
module "cost_anomaly_detection_development" {
  source                     = "./modules/ce_anomoly_detection"
  notification_email_address = var.cost_anomaly_notification_email_address
  weekly_schedule_threshold  = var.cost_anomaly_weekly_schedule_threshold
  daily_schedule_threshold   = var.cost_anomaly_weekly_schedule_threshold
  providers = {
    aws.global = aws.global
  }
}
