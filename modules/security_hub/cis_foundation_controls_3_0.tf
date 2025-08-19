resource "aws_securityhub_standards_subscription" "cis_3_0" {
  count         = var.cis_3_0_subscription_enabled ? 1 : 0
  depends_on    = [aws_securityhub_account.main]
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.region}::standards/cis-aws-foundations-benchmark/v/3.0.0"

  timeouts {
    create = "7m"
    delete = "7m"
  }
}
