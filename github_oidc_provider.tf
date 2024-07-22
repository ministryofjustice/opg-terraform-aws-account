module "github_oidc_provider" {
  count  = local.github_oidc_enabled ? 1 : 0
  source = "./modules/github_oidc_provider"

  s3_access_logging_bucket_names = [
    module.eu-west-1.access_logging_bucket.bucket,
    module.eu-west-2.access_logging_bucket.bucket
  ]
}
