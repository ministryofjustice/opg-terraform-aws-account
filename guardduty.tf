module "guardduty" {
  count                  = local.guardduty_enabled ? 1 : 0
  source                 = "./modules/guardduty"
  alert_minimum_severity = var.guardduty_alert_minimum_severity
}

moved {
  from = aws_guardduty_detector.main[0]
  to   = module.guardduty[0].aws_guardduty_detector.main
}
