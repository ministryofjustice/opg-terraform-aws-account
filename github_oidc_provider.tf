module "github_oidc_provider" {
  count  = var.github_oidc_enabled ? 1 : 0
  source = "./modules/github_oidc_provider"

  cloudtrail_trail_name = var.cloudtrail_trail_name

}
