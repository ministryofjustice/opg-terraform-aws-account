module "eu-west-1" {
  source                               = "./modules/region"
  account_name                         = var.account_name
  aws_config_enabled                   = local.config_enabled
  config_iam_role                      = local.config_enabled ? aws_iam_role.config[0] : null
  config_continuous_resource_recording = var.config_continuous_resource_recording
  product                              = var.product
  sns_failure_feedback_role_arn        = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn        = aws_iam_role.sns_success_feedback.arn
  macie_findings_s3_bucket_kms_key     = module.global_multiregion_resources.eu_west_1_macie_findings_encryption_key
  providers = {
    aws = aws
  }
}

module "eu-west-2" {
  source                               = "./modules/region"
  account_name                         = var.account_name
  aws_config_enabled                   = local.config_enabled
  config_iam_role                      = local.config_enabled ? aws_iam_role.config[0] : null
  config_continuous_resource_recording = var.config_continuous_resource_recording
  product                              = var.product
  sns_failure_feedback_role_arn        = aws_iam_role.sns_failure_feedback.arn
  sns_success_feedback_role_arn        = aws_iam_role.sns_success_feedback.arn
  macie_findings_s3_bucket_kms_key     = module.global_multiregion_resources.eu_west_1_macie_findings_encryption_key
  providers = {
    aws = aws.eu-west-2
  }
}

# Dev
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

# Preprod, Prod & Backup
moved {
  from = module.aws_config[0].aws_config_config_rule.cloudtrail_enabled
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.cloudtrail_enabled
}
moved {
  from = module.aws_config[0].aws_config_config_rule.ec2_instance_public_ip
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.ec2_instance_public_ip
}
moved {
  from = module.aws_config[0].aws_config_config_rule.guardduty_enabled
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.guardduty_enabled
}
moved {
  from = module.aws_config[0].aws_config_config_rule.iam_inactive_users
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.iam_inactive_users
}
moved {
  from = module.aws_config[0].aws_config_config_rule.iam_mfa_enabled
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.iam_mfa_enabled
}
moved {
  from = module.aws_config[0].aws_config_config_rule.iam_root_access_key_check
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.iam_root_access_key_check
}
moved {
  from = module.aws_config[0].aws_config_config_rule.s3_buckets_encrypted
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.s3_buckets_encrypted
}
moved {
  from = module.aws_config[0].aws_config_config_rule.s3_buckets_public_read
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.s3_buckets_public_read
}
moved {
  from = module.aws_config[0].aws_config_config_rule.s3_buckets_public_write
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.s3_buckets_public_write
}
moved {
  from = module.aws_config[0].aws_config_config_rule.securityhub_enabled
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.securityhub_enabled
}
moved {
  from = module.aws_config[0].aws_config_config_rule.tagged_resources
  to   = module.eu-west-1.module.aws_config[0].aws_config_config_rule.tagged_resources
}
moved {
  from = module.aws_config[0].aws_config_configuration_recorder.main
  to   = module.eu-west-1.module.aws_config[0].aws_config_configuration_recorder.main
}
moved {
  from = module.aws_config[0].aws_config_configuration_recorder_status.main
  to   = module.eu-west-1.module.aws_config[0].aws_config_configuration_recorder_status.main
}
moved {
  from = module.aws_config[0].aws_config_delivery_channel.main
  to   = module.eu-west-1.module.aws_config[0].aws_config_delivery_channel.main
}
moved {
  from = module.aws_config[0].aws_iam_policy.config_policy
  to   = module.eu-west-1.module.aws_config[0].aws_iam_policy.config_policy
}
moved {
  from = module.aws_config[0].aws_iam_role.config
  to   = aws_iam_role.config[0]
}
moved {
  from = module.aws_config[0].aws_iam_role_policy_attachment.config_policy
  to   = module.eu-west-1.module.aws_config[0].aws_iam_role_policy_attachment.config_policy
}
moved {
  from = module.aws_config[0].aws_iam_role_policy_attachment.managed_policy
  to   = aws_iam_role_policy_attachment.managed_policy[0]
}
moved {
  from = module.aws_config[0].aws_kms_key.config_sns
  to   = module.eu-west-1.module.aws_config[0].aws_kms_key.config_sns
}
moved {
  from = module.aws_config[0].aws_sns_topic.config
  to   = module.eu-west-1.module.aws_config[0].aws_sns_topic.config
}
moved {
  from = module.aws_config[0].aws_sns_topic_policy.config
  to   = module.eu-west-1.module.aws_config[0].aws_sns_topic_policy.config
}
