
data "aws_iam_group" "breakglass" {
  group_name = "breakglass"
  provider   = aws.identity
}

data "aws_iam_group" "breakglass_product" {
  group_name = "modernising-lpa-breakglass"
  provider   = aws.identity
}

data "aws_iam_group" "operators" {
  group_name = "modernising-lpa-operators"
  provider   = aws.identity
}

data "aws_iam_group" "viewers" {
  group_name = "viewers"
  provider   = aws.identity
}

data "aws_iam_group" "onboarding" {
  group_name = "onboarding"
  provider   = aws.identity
}

locals {
  user_arns = {
    breakglass  = concat(data.aws_iam_group.breakglass.users[*].arn, data.aws_iam_group.breakglass_product.users[*].arn)
    ci          = [aws_iam_user.ci_user.arn]
    operation   = data.aws_iam_group.operators.users[*].arn
    data_access = data.aws_iam_group.operators.users[*].arn
    onboarding  = data.aws_iam_group.onboarding.users[*].arn
    view        = data.aws_iam_group.viewers.users[*].arn
  }
}





# Description: This module configures an AWS account with some security controls turned off for development purposes.
module "development" {
  source                                    = "git@github.com:ministryofjustice/opg-terraform-aws-account.git?ref=v5.2.0"
  account_name                              = "development"
  aws_config_enabled                        = true
  aws_macie2_status                         = "ENABLED"
  aws_s3_account_block_public_access_enable = true
  aws_security_hub_enabled                  = true
  cis_foundation_control_3_10_enabled       = false
  cis_foundation_control_3_4_enabled        = false
  cloudtrail_bucket_name                    = "cloudtrail.development.example.opg.service.justice.gov.uk"
  cloudtrail_trail_name                     = "example-development"
  cost_anomaly_notification_email_address   = "opg-team+example-dev@digital.justice.gov.uk"
  data_access_custom_policy_json            = data.aws_iam_policy_document.data_access.json
  fsbp_standard_control_elb_6_enabled       = false
  has_onboarding_role                       = true
  operator_base_policy_arn                  = "arn:aws:iam::aws:policy/AdministratorAccess"
  product                                   = "example"
  user_arns                                 = local.user_arns

  providers = {
    aws           = aws.development_eu_west_1
    aws.eu-west-2 = aws.development_eu_west_2
    aws.global    = aws.development_global
  }
}
