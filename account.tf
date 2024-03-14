resource "aws_iam_account_alias" "main" {
  account_alias = var.aws_iam_account_alias
  provider      = aws.global
}
