resource "aws_config_config_rule" "cloudtrail_enabled" {
  name        = "${local.config_name}-cloudtrail-enabled"
  description = "Ensure CloudTrail is enabled"

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }

  maximum_execution_frequency = var.config_max_execution_frequency

  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}


resource "aws_config_config_rule" "ec2_instance_public_ip" {
  name        = "${local.config_name}-ec2-no-public-ip"
  description = "Ensure there is not any direct public access to any EC2 instances"

  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_NO_PUBLIC_IP"
  }

  scope {
    compliance_resource_types = ["EC2:Instance"]
  }

  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "guardduty_enabled" {
  name        = "${local.config_name}-guardduty-enabled"
  description = "Checks whether Amazon GuardDuty is enabled in your AWS account and region."

  source {
    owner             = "AWS"
    source_identifier = "GUARDDUTY_ENABLED_CENTRALIZED"
  }

  maximum_execution_frequency = var.config_max_execution_frequency

  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "iam_inactive_users" {
  name        = "${local.config_name}-iam-inactive-users"
  description = "Checks whether your AWS Identity and Access Management (IAM) users have passwords or active access keys that have not been used within 30 days"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_UNUSED_CREDENTIALS_CHECK"
  }

  input_parameters            = jsonencode({ maxCredentialUsageAge = "90" })
  maximum_execution_frequency = var.config_max_execution_frequency

  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "iam_mfa_enabled" {
  name        = "${local.config_name}-iam-mfa-enabled"
  description = "Checks whether the AWS Identity and Access Management users have multi-factor authentication (MFA) enabled."

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }

  maximum_execution_frequency = var.config_max_execution_frequency

  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "iam_root_access_key_check" {
  name        = "${local.config_name}-iam-root-access-key-check"
  description = "Checks that there is no root access key."

  source {
    owner             = "AWS"
    source_identifier = "IAM_ROOT_ACCESS_KEY_CHECK"
  }

  maximum_execution_frequency = var.config_max_execution_frequency

  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "s3_buckets_encrypted" {
  name        = "${local.config_name}-s3-sse-enabled"
  description = "Ensure all S3 Buckets are Server Side Encrypted"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "s3_buckets_public_read" {
  name                        = "${local.config_name}-s3-public-read-prohibited"
  description                 = "Ensure all S3 Buckets are not Public Readable"
  maximum_execution_frequency = var.config_max_execution_frequency

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "s3_buckets_public_write" {
  name                        = "${local.config_name}-s3-public-write-prohibited"
  description                 = "Ensure all S3 Buckets are not Public Writable"
  maximum_execution_frequency = var.config_max_execution_frequency

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "securityhub_enabled" {
  name                        = "${local.config_name}-security-hub-enabled"
  description                 = "Ensure Security Hub is Enabled"
  maximum_execution_frequency = var.config_max_execution_frequency

  source {
    owner             = "AWS"
    source_identifier = "SECURITYHUB_ENABLED"
  }

  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "tagged_resources" {
  name        = "${local.config_name}-tagged-resourses"
  description = "Checks whether all resources have mandatory tags in your AWS account and region."

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  input_parameters = jsonencode(
    {
      tag1Key   = "application",
      tag2Key   = "business-unit",
      tag2Value = "OPG",
      tag3Key   = "environment-name",
      tag4Key   = "is-production",
      tag5Key   = "owner",
    }
  )

  scope {
    compliance_resource_types = [
      "AWS::ACM::Certificate",
      "AWS::AutoScaling::AutoScalingGroup",
      "AWS::CloudFormation::Stack",
      "AWS::CodeBuild::Project",
      "AWS::DynamoDB::Table",
      "AWS::EC2::CustomerGateway",
      "AWS::EC2::Instance",
      "AWS::EC2::InternetGateway",
      "AWS::EC2::NetworkAcl",
      "AWS::EC2::NetworkInterface",
      "AWS::EC2::RouteTable",
      "AWS::EC2::SecurityGroup",
      "AWS::EC2::Subnet",
      "AWS::EC2::VPC",
      "AWS::EC2::VPNConnection",
      "AWS::EC2::VPNGateway",
      "AWS::EC2::Volume",
      "AWS::ElasticLoadBalancing::LoadBalancer",
      "AWS::ElasticLoadBalancingV2::LoadBalancer",
      "AWS::RDS::DBInstance",
      "AWS::RDS::DBSecurityGroup",
      "AWS::RDS::DBSnapshot",
      "AWS::RDS::DBSubnetGroup",
      "AWS::RDS::EventSubscription",
      "AWS::Redshift::Cluster",
      "AWS::Redshift::ClusterParameterGroup",
      "AWS::Redshift::ClusterSecurityGroup",
      "AWS::Redshift::ClusterSnapshot",
      "AWS::Redshift::ClusterSubnetGroup",
      "AWS::S3::Bucket",
    ]
  }
  tags = var.tags

  depends_on = [aws_config_configuration_recorder.main]
}
