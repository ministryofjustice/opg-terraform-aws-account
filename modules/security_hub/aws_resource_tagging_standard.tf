resource "aws_securityhub_standards_subscription" "resource_tagging" {
  depends_on    = [aws_securityhub_account.main]
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-resource-tagging-standard/v/1.0.0"
  timeouts {
    create = "10m"
    delete = "10m"
  }
}
