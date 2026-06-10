resource "aws_securityhub_standards_subscription" "resource_tagging" {
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.region}::standards/aws-resource-tagging-standard/v/1.0.0"
  timeouts {
    create = "10m"
    delete = "10m"
  }
}
