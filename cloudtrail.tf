module "cloudtrail" {
  source      = "./cloudtrail"
  trail_name  = var.cloudtrail_trail_name
  bucket_name = var.cloudtrail_bucket_name
  tags        = local.mandatory_moj_tags
}
