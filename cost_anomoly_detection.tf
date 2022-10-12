
module "cost_anomaly_detection" {
  source                       = "./modules/ce_anomoly_detection"
  notification_email_address   = var.cost_anomaly_notification_email_address
  weekly_schedule_threshold    = var.cost_anomaly_weekly_schedule_threshold
  immediate_schedule_threshold = var.cost_anomaly_immediate_schedule_threshold
  providers = {
    aws.global = aws.global
  }
}
