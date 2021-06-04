resource "aws_cloudtrail" "cloudtrail" {
  name                          = var.trail_name
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail.arn
  enable_log_file_validation    = true
  include_global_service_events = true
  is_multi_region_trail         = true
  kms_key_id                    = aws_kms_key.cloudtrail_s3.arn
  s3_bucket_name                = aws_s3_bucket.cloudtrail.bucket
  tags                          = var.tags

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
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name = var.trail_name
  tags = var.tags
}

resource "aws_iam_role" "cloudtrail" {
  name               = var.trail_name
  assume_role_policy = data.aws_iam_policy_document.cloudtrail_role_assume_role_policy.json
  tags               = var.tags
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
