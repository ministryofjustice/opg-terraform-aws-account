resource "aws_iam_service_linked_role" "config" {
  count            = local.config_enabled ? 1 : 0
  aws_service_name = "config.amazonaws.com"
  provider         = aws.global
}
