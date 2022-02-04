resource "aws_securityhub_account" "main" {}

data "aws_cloudwatch_log_group" "cloudtrail" {
  name = var.aws_cloudwatch_log_group_cloudtrail_name
}

data "aws_caller_identity" "current" {
}

data "aws_region" "current" {}
