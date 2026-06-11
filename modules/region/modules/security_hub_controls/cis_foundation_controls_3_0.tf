resource "aws_securityhub_standards_subscription" "cis_3_0" {
  count         = var.security_hub_config.cis_3_0_subscription_enabled ? 1 : 0
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.region}::standards/cis-aws-foundations-benchmark/v/3.0.0"

  timeouts {
    create = "7m"
    delete = "7m"
  }
}

locals {
  cis_3_0_standard_controls_arn_path = "arn:aws:securityhub:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:control/cis-aws-foundations-benchmark/v/3.0.0"
}

resource "aws_securityhub_standards_control" "cis_3_0_iam_6_hardware_mfa_should_be_enabled_for_the_root_user" {
  count                 = var.security_hub_config.cis_3_0_subscription_enabled ? 1 : 0
  standards_control_arn = "${local.cis_3_0_standard_controls_arn_path}/1.6"
  control_status        = "DISABLED"
  disabled_reason       = "See ADR https://docs.opg.service.justice.gov.uk/documentation/adrs/adr-004.html#adr-004-no-hardware-mfa-key-for-root-account"
}
