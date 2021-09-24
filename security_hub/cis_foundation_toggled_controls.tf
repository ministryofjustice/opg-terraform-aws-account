variable "cis_3_8_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.8. When false, sets standard control to disabled."
}

variable "cis_3_14_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.8. When false, sets standard control to disabled."
}

locals {
  cis_toggled_controls = {
    cis_3_8_s3_bucket_policy_changes = {
      metric_name           = "CIS-3.8-S3BucketPolicyChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.8"
      actions_enabled       = var.cis_3_8_enabled
      control_status        = var.cis_3_8_enabled ? "DISABLED" : "ENABLED"
      pattern               = "{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}"
      alarm_description     = "s3 bucket policy changes count"
    }
    cis_3_14_vpc_changes = {
      metric_name           = "CIS-3.14-VPCChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.14"
      actions_enabled       = var.cis_3_14_enabled
      control_status        = var.cis_3_14_enabled ? "DISABLED" : "ENABLED"
      pattern               = "{($.eventName=CreateVpc) || ($.eventName=DeleteVpc) || ($.eventName=ModifyVpcAttribute) || ($.eventName=AcceptVpcPeeringConnection) || ($.eventName=CreateVpcPeeringConnection) || ($.eventName=DeleteVpcPeeringConnection) || ($.eventName=RejectVpcPeeringConnection) || ($.eventName=AttachClassicLinkVpc) || ($.eventName=DetachClassicLinkVpc) || ($.eventName=DisableVpcClassicLink) || ($.eventName=EnableVpcClassicLink)}"
      alarm_description     = "vpc changes count"
    }
  }
}

resource "aws_securityhub_standards_control" "toggled_control" {
  for_each              = local.cis_toggled_controls
  standards_control_arn = each.value.standards_control_arn
  control_status        = each.value.control_status
  disabled_reason       = "Not appropriate for our usage"
  depends_on = [
    aws_securityhub_account.main
  ]
}

resource "aws_cloudwatch_log_metric_filter" "toggled_control" {
  for_each       = local.cis_toggled_controls
  name           = each.value.metric_name
  pattern        = each.value.pattern
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = each.value.metric_name
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "toggled_control" {
  for_each            = local.cis_toggled_controls
  actions_enabled     = true
  alarm_name          = each.value.metric_name
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = each.value.alarm_description
  namespace           = "CISLogMetrics"
  metric_name         = each.value.metric_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}
