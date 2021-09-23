locals {
  cis_standard_controls_arn_path = "arn:aws:securityhub:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:control/cis-aws-foundations-benchmark/v/1.2.0"
}

resource "aws_securityhub_standards_control" "ensure_hardware_mfa_is_enabled_for_the_root_account" {
  standards_control_arn = "${local.cis_standard_controls_arn_path}/1.14"
  control_status        = var.cis_1_14_control_status
  disabled_reason       = var.cis_1_14_disabled_reason
  depends_on = [
    aws_securityhub_account.main
  ]
}
