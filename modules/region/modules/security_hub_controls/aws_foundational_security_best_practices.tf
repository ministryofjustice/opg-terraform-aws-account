locals {
  fsbp_standard_controls_arn_path = "arn:aws:securityhub:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:control/aws-foundational-security-best-practices/v/1.0.0"
}

resource "aws_securityhub_standards_control" "ec2_vpc_172_vpc_bpa_should_be_enabled" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/EC2.172"
  control_status        = "DISABLED"
  disabled_reason       = "We cannot enable VPC Block Public Access with Network Firewall"
}

resource "aws_securityhub_standards_control" "elb_6_application_load_balancer_deletion_protection_should_be_enabled" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/ELB.6"
  control_status        = var.security_hub_config.fsbp_standard_control_elb_6_enabled ? "ENABLED" : "DISABLED"
  disabled_reason       = var.security_hub_config.fsbp_standard_control_elb_6_enabled ? null : "Non-production accounts contain ephemeral environments."
}

resource "aws_securityhub_standards_control" "elb_22_target_group_healthchecks_should_use_tls_enabled" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/ELB.21"
  control_status        = var.security_hub_config.fsbp_standard_control_elb_21_enabled ? "ENABLED" : "DISABLED"
  disabled_reason       = var.security_hub_config.fsbp_standard_control_elb_21_enabled ? null : "We choose to terminate SSL ath the Load Balancer"
}

resource "aws_securityhub_standards_control" "elb_22_target_groups_should_use_tls_enabled" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/ELB.22"
  control_status        = var.security_hub_config.fsbp_standard_control_elb_22_enabled ? "ENABLED" : "DISABLED"
  disabled_reason       = var.security_hub_config.fsbp_standard_control_elb_22_enabled ? null : "We choose to terminate SSL ath the Load Balancer"
}

resource "aws_securityhub_standards_control" "iam_6_hardware_mfa_should_be_enabled_for_the_root_user" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/IAM.6"
  control_status        = "DISABLED"
  disabled_reason       = "See ADR https://docs.opg.service.justice.gov.uk/documentation/adrs/adr-004.html#adr-004-no-hardware-mfa-key-for-root-account"
}

resource "aws_securityhub_standards_control" "macie_1_macie_should_be_enabled" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/Macie.1"
  control_status        = var.security_hub_config.macie_enabled ? "ENABLED" : "DISABLED"
  disabled_reason       = var.security_hub_config.macie_enabled ? null : "Macie has been intentionally Disabled"
}

resource "aws_securityhub_standards_control" "macie_2_macie_should_be_enabled" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/Macie.2"
  control_status        = var.security_hub_config.macie_enabled ? "ENABLED" : "DISABLED"
  disabled_reason       = var.security_hub_config.macie_enabled ? null : "Macie has been intentionally Disabled"
}

resource "aws_securityhub_standards_control" "secretsmanager_automatic_rotation_should_be_enabled" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/SecretsManager.1"
  control_status        = var.security_hub_config.fsbp_standard_control_secretsmanager_1_enabled ? "ENABLED" : "DISABLED"
  disabled_reason       = var.security_hub_config.fsbp_standard_control_secretsmanager_1_enabled ? null : "Secrets Manager Automatic Rotation is intentionally Disabled"
}

resource "aws_securityhub_standards_control" "secretsmanager_should_be_rotated_within_a_number_of_days" {
  standards_control_arn = "${local.fsbp_standard_controls_arn_path}/SecretsManager.4"
  control_status        = "DISABLED"
  disabled_reason       = "Secrets Manager enforced rotation is not feasible for all secrets"
}
