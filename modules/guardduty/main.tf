locals {
  alerting_enabled = var.alert_minimum_severity != null

  severity_thresholds = {
    low      = 1
    medium   = 4
    high     = 7
    critical = 9
  }

  alert_threshold = local.alerting_enabled ? local.severity_thresholds[var.alert_minimum_severity] : null
}

resource "aws_guardduty_detector" "main" {
  enable = true
}
