resource "aws_securityhub_standards_control" "ensure_hardware_mfa_is_enabled_for_the_root_account" {
  standards_control_arn = "arn:aws:securityhub:::control/cis-aws-foundations-benchmark/v/1.2.0/1.14"
  control_status        = var.cis_1_14_control_status
  disabled_reason       = var.cis_1_14_diabled_reason
}

variable "cis_1_14_control_status" {
  type        = string
  default     = "DISABLED"
  description = "The control status could be ENABLED or DISABLED. You have to specify disabled_reason argument for DISABLED control status."
}
variable "cis_1_14_diabled_reason" {
  type        = string
  default     = "See ADR"
  description = "A description of the reason why you are disabling a security standard control. If you specify this attribute, control_status will be set to DISABLED automatically."
}
