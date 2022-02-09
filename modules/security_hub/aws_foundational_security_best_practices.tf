locals {
  fsbp_standard_controls_arn_path = "arn:aws:securityhub:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:control/aws-foundational-security-best-practices/v/1.0.0"
}

resource "aws_securityhub_standards_control" "iam_6_hardware_mfa_should_be_enabled_for_the_root_user" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/IAM.6"
  control_status        = "DISABLED"
  disabled_reason       = "See ADR https://docs.opg.service.justice.gov.uk/documentation/adrs/adr-004.html#adr-004-no-hardware-mfa-key-for-root-account"
  depends_on = [
    aws_securityhub_account.main
  ]
}

resource "aws_securityhub_standards_control" "elb_6_application_load_balancer_deletion_protection_should_be_enabled" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/ELB.6"
  control_status        = var.fsbp_standard_control_elb_6_enabled ? "ENABLED" : "DISABLED"
  disabled_reason       = var.fsbp_standard_control_elb_6_enabled ? null : "Non-production accounts contain ephemeral environments."
  depends_on = [
    aws_securityhub_account.main
  ]
}
