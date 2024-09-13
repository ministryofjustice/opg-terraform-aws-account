module "global_multiregion_resources" {
  source = "./modules/global"
  providers = {
    aws.eu_west_1 = aws.eu_west_1
    aws.eu_west_2 = aws.eu_west_2
    aws.global    = aws.global
  }
}
