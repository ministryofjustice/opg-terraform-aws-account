resource "aws_securityhub_account" "main" {
  control_finding_generator = var.control_finding_generator
  auto_enable_controls      = var.auto_enable_controls
  enable_default_standards  = var.enable_default_standards

  lifecycle {
    prevent_destroy = true
  }
}

data "aws_caller_identity" "current" {
}

data "aws_region" "current" {}
