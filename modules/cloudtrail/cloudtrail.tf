resource "aws_cloudtrail" "cloudtrail" {
  name                          = var.trail_name
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail.arn
  enable_log_file_validation    = true
  include_global_service_events = true
  is_multi_region_trail         = true
  kms_key_id                    = aws_kms_key.cloudtrail_s3.arn
  s3_bucket_name                = aws_s3_bucket.cloudtrail.bucket

  event_selector {
    include_management_events = true
    read_write_type           = "All"

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3"]
    }

    data_resource {
      type   = "AWS::Lambda::Function"
      values = ["arn:aws:lambda"]
    }
  }

  insight_selector {
    insight_type = "ApiCallRateInsight"
  }

  insight_selector {
    insight_type = "ApiErrorRateInsight"
  }
}

resource "aws_cloudtrail" "s3_vpce_access_denied" {
  count                         = var.s3_vpc_endpoint_access_denied_logging_enabled ? 1 : 0
  name                          = "${var.trail_name}-s3-vpce-access-denied"
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail.arn
  enable_log_file_validation    = true
  include_global_service_events = false
  is_multi_region_trail         = true
  kms_key_id                    = aws_kms_key.cloudtrail_s3.arn
  s3_bucket_name                = aws_s3_bucket.cloudtrail.bucket
  s3_key_prefix                 = "s3-vpce-access-denied"

  advanced_event_selector {
    name = "S3 VPC endpoint access denied network activity events"
    field_selector {
      field  = "eventCategory"
      equals = ["NetworkActivity"]
    }
    field_selector {
      field  = "eventSource"
      equals = ["s3.amazonaws.com"]
    }
    field_selector {
      field  = "errorCode"
      equals = ["VpceAccessDenied"]
    }
  }

  depends_on = [aws_s3_bucket_policy.cloudtrail]
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name = var.trail_name
}

resource "aws_iam_role" "cloudtrail" {
  name               = var.trail_name
  assume_role_policy = data.aws_iam_policy_document.cloudtrail_role_assume_role_policy.json
}

data "aws_iam_policy_document" "cloudtrail_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "cloudtrail" {
  name   = var.trail_name
  role   = aws_iam_role.cloudtrail.id
  policy = data.aws_iam_policy_document.cloudtrail_role_policy.json
}

data "aws_iam_policy_document" "cloudtrail_role_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]

    resources = ["*"]
    effect    = "Allow"
  }
}
