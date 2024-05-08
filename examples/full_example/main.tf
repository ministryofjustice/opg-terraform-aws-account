# Retrieve User ARNs from AWS IAM Groups
data "aws_iam_group" "billing" {
  group_name = "billing"
  provider   = aws.identity
}

data "aws_iam_group" "breakglass" {
  group_name = "breakglass"
  provider   = aws.identity
}

data "aws_iam_group" "breakglass_product" {
  group_name = "example-breakglass"
  provider   = aws.identity
}

data "aws_iam_group" "operators" {
  group_name = "example-operators"
  provider   = aws.identity
}

data "aws_iam_group" "viewers" {
  group_name = "viewers"
  provider   = aws.identity
}

locals {
  user_arns = {
    breakglass          = concat(data.aws_iam_group.breakglass.users[*].arn, data.aws_iam_group.breakglass_product.users[*].arn)
    ci                  = [aws_iam_user.ci_user.arn]
    cloudwatch_reportng = [aws_iam_user.cloudwatch_ci_user.arn]
    operation           = data.aws_iam_group.operators.users[*].arn
    view                = data.aws_iam_group.viewers.users[*].arn
    billing             = data.aws_iam_group.billing.users[*].arn

  }
}

# Description: Full confuguration of an AWS account
module "full" {
  source                                       = "git@github.com:ministryofjustice/opg-terraform-aws-account.git?ref=v5.2.0"
  account_name                                 = "full"
  aws_config_enabled                           = false
  aws_s3_account_block_public_access_enable    = true
  aws_s3_account_block_public_acls             = true
  aws_s3_account_block_public_policy           = true
  aws_s3_account_ignore_public_acls            = true
  aws_s3_account_restrict_public_buckets       = true
  aws_security_hub_enabled                     = true
  billing_base_policy_arn                      = "arn:aws:iam::aws:policy/job-function/Billing"
  billing_custom_policy_json                   = ""
  breakglass_base_policy_arn                   = "arn:aws:iam::aws:policy/AdministratorAccess"
  breakglass_create_instance_profile           = false
  breakglass_custom_policy_json                = ""
  ci_base_policy_arn                           = "arn:aws:iam::aws:policy/AdministratorAccess"
  ci_custom_policy_json                        = ""
  cis_foundation_alarms_enabled                = true
  cis_foundation_control_1_14_enabled          = true
  cis_foundation_control_3_10_custom_filter    = ""
  cis_foundation_control_3_10_enabled          = true
  cis_foundation_control_3_11_enabled          = true
  cis_foundation_control_3_12_enabled          = true
  cis_foundation_control_3_13_enabled          = true
  cis_foundation_control_3_14_enabled          = true
  cis_foundation_control_3_4_enabled           = true
  cis_foundation_control_3_8_enabled           = true
  cis_metric_namespace                         = "CISLogMetrics"
  cloudtrail_bucket_name                       = "cloudtrail.full.example.opg.service.justice.gov.uk"
  cloudtrail_trail_name                        = "example-full"
  cost_anomaly_immediate_schedule_threshold    = "10.0"
  cost_anomaly_notification_email_address      = null
  cost_anomaly_weekly_schedule_threshold       = "100.0"
  cost_anomaly_threshold_expression_type       = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
  custom_alarms_breakglass_login_alarm_enabled = true
  enable_guardduty                             = true
  fsbp_standard_control_elb_6_enabled          = true
  is_production                                = true
  operator_base_policy_arn                     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  operator_create_instance_profile             = false
  operator_custom_policy_json                  = ""
  product                                      = "full_example"
  team_email                                   = "example@email.com"
  team_name                                    = "OPG"
  user_arns                                    = local.user_arns
  viewer_base_policy_arn                       = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  viewer_custom_policy_json                    = ""
  cloudwatch_reporting_base_policy_arn         = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
  cloudwatch_reporting_custom_policy_json      = ""

  providers = {
    aws           = aws.production_eu_west_1
    aws.eu-west-2 = aws.production_eu_west_2
    aws.global    = aws.production_global
  }
}
