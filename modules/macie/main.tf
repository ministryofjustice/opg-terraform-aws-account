resource "aws_macie2_account" "main" {
  finding_publishing_frequency = var.account_finding_publishing_frequency
  status                       = var.status
}
