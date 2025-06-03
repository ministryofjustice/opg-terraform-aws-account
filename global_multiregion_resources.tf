module "global_multiregion_resources" {
  source        = "./modules/global"
  account_name  = var.account_name
  macie_enabled = local.macie_enabled
  providers = {
    aws.eu_west_1 = aws
    aws.eu_west_2 = aws.eu-west-2
    aws.global    = aws.global
  }
}
