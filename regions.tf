module "eu-west-1" {
    source = "./modules/region"
    account_name = var.account_name
    baseline_security_enabled = var.baseline_security_enabled
    config_iam_role = aws_iam_role.config
    product = var.product
    providers = {
        aws = aws
    }
}

moved {
    from = aws_s3_bucket.s3_access_logging 
    to   = module.eu-west-1.aws_s3_bucket.s3_access_logging
}

moved {
    from = aws_s3_bucket_policy.s3_access_logging
    to   = module.eu-west-1.aws_s3_bucket_policy.s3_access_logging
}

moved {
    from = aws_s3_bucket_public_access_block.s3_access_logging
    to   = module.eu-west-1.aws_s3_bucket_public_access_block.s3_access_logging
}

module "eu-west-2" {
    source = "./modules/region"
    account_name = var.account_name
    baseline_security_enabled = var.baseline_security_enabled
    config_iam_role = aws_iam_role.config
    product = var.product
    providers = {
        aws = aws.eu-west-2
    }
}