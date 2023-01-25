resource "aws_securityhub_account" "main" {}

data "aws_caller_identity" "current" {
}

data "aws_region" "current" {}
