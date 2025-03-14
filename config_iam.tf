# resource "aws_iam_role" "config" {
#   count              = local.config_enabled ? 1 : 0
#   name               = "aws-config-${var.product}-${var.account_name}"
#   path               = "/service-role/"
#   assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
# }

resource "aws_iam_service_linked_role" "config" {
  count            = local.config_enabled ? 1 : 0
  aws_service_name = "config.amazonaws.com"
}

# data "aws_iam_policy_document" "assume_role_policy" {
#   statement {
#     sid     = "AllowAWSConfigAssumeRole"
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["config.amazonaws.com"]
#     }

#     effect = "Allow"
#   }
# }

# resource "aws_iam_role_policy_attachment" "managed_policy" {
#   count      = local.config_enabled ? 1 : 0
#   role       = aws_iam_service_linked_role.config[0].name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
# }
