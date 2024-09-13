module "macie" {
  source                               = "./modules/macie"
  account_finding_publishing_frequency = var.aws_macie2_account_finding_publishing_frequency
  status                               = var.aws_macie2_status
}
