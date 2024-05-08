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
    cloudwatch_reportng = [aws_iam_user.reporting_ci_user.arn]
    operation           = data.aws_iam_group.operators.users[*].arn
    view                = data.aws_iam_group.viewers.users[*].arn
    billing             = data.aws_iam_group.billing.users[*].arn
  }
}

# Description: This module configures an AWS account with some security controls turned off for production purposes.
module "production" {
  source                                    = "git@github.com:ministryofjustice/opg-terraform-aws-account.git?ref=v5.2.0"
  account_name                              = "production"
  aws_s3_account_block_public_access_enable = true
  aws_security_hub_enabled                  = true
  aws_config_enabled                        = true
  cloudtrail_bucket_name                    = "cloudtrail.production.example.opg.service.justice.gov.uk"
  cloudtrail_trail_name                     = "example-production"
  cost_anomaly_notification_email_address   = "opg-team+example-prod@digital.justice.gov.uk"
  product                                   = "example"
  enable_cloudwatch_reporting_role          = true
  user_arns                                 = local.user_arns
  providers = {
    aws           = aws.production_eu_west_1
    aws.eu-west-2 = aws.production_eu_west_2
    aws.global    = aws.production_global
  }
}
