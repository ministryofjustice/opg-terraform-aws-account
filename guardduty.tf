resource "aws_guardduty_detector" "main" {
  count  = local.guardduty_enabled ? 1 : 0
  enable = true
}
