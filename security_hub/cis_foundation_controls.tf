variable "cis_3_8_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.8. When false, sets standard control to disabled."
}

variable "cis_3_14_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.14. When false, sets standard control to disabled."
}

locals {
  cis_toggled_controls = {
    cis_1_1_root_account_usage = {
      metric_name           = "CIS-1.1-RootAccountUsage"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/1.1"
      actions_enabled       = true
      control_status        = "ENABLED"
      pattern               = "{$.userIdentity.type=\"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType !=\"AwsServiceEvent\"}"
      alarm_description     = "root login usage count"
      alarm_threshold       = 1
    }
    cis_3_1_unauthorised_api_calls = {
      metric_name           = "CIS-3.1-UnauthorizedAPICalls"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.1"
      actions_enabled       = true
      control_status        = "ENABLED"
      pattern               = "{($.errorCode=\"*UnauthorizedOperation\") || ($.errorCode=\"AccessDenied*\")}"
      alarm_description     = "unauthorised api call"
      alarm_threshold       = 3
    }
    cis_3_2_console_sign_in_without_mfa = {
      metric_name           = "CIS-3.2-ConsoleSigninWithoutMFA"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.2"
      actions_enabled       = true
      control_status        = "ENABLED"
      pattern               = "{($.eventName=\"ConsoleLogin\") && ($.additionalEventData.MFAUsed !=\"Yes\")}"
      alarm_description     = "console sign in without mfa count"
      alarm_threshold       = 1
    }
    cis_3_5_cloudtrail_configuration_changes = {
      metric_name           = "CIS-3.5-CloudTrailChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.5"
      actions_enabled       = true
      control_status        = "ENABLED"
      pattern               = "{($.eventName=CreateTrail) || ($.eventName=UpdateTrail) || ($.eventName=DeleteTrail) || ($.eventName=StartLogging) || ($.eventName=StopLogging)}"
      alarm_description     = "cloudtrail configuration changes count"
      alarm_threshold       = 1
    }
    cis_3_6_console_authentication_failure = {
      metric_name           = "CIS-3.6-ConsoleAuthenticationFailure"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.6"
      actions_enabled       = true
      control_status        = "ENABLED"
      pattern               = "{($.eventName=ConsoleLogin) && ($.errorMessage=\"Failed authentication\")}"
      alarm_description     = "console authentication failure count"
      alarm_threshold       = 1
    }
    cis_3_7_disabling_or_scheduled_deletion_of_cmk = {
      metric_name           = "CIS-3.7-DisableOrDeleteCMK"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.6"
      actions_enabled       = true
      control_status        = "ENABLED"
      pattern               = "{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}"
      alarm_description     = "disabling or scheduled deletion of customer managed keys count"
      alarm_threshold       = 1
    }
    cis_3_8_s3_bucket_policy_changes = {
      metric_name           = "CIS-3.8-S3BucketPolicyChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.8"
      actions_enabled       = var.cis_3_8_enabled
      control_status        = var.cis_3_8_enabled ? "ENABLED" : "DISABLED"
      pattern               = "{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}"
      alarm_description     = "s3 bucket policy changes count"
      alarm_threshold       = 1
    }
    cis_3_9_aws_config_configuration_changes = {
      metric_name           = "CIS-3.9-AWSConfigChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.9"
      actions_enabled       = var.cis_3_8_enabled
      control_status        = var.cis_3_8_enabled ? "ENABLED" : "DISABLED"
      pattern               = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
      alarm_description     = "aws config configuration changes count"
      alarm_threshold       = 1
    }
    cis_3_14_vpc_changes = {
      metric_name           = "CIS-3.14-VPCChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.14"
      actions_enabled       = var.cis_3_14_enabled
      control_status        = var.cis_3_14_enabled ? "ENABLED" : "DISABLED"
      pattern               = "{($.eventName=CreateVpc) || ($.eventName=DeleteVpc) || ($.eventName=ModifyVpcAttribute) || ($.eventName=AcceptVpcPeeringConnection) || ($.eventName=CreateVpcPeeringConnection) || ($.eventName=DeleteVpcPeeringConnection) || ($.eventName=RejectVpcPeeringConnection) || ($.eventName=AttachClassicLinkVpc) || ($.eventName=DetachClassicLinkVpc) || ($.eventName=DisableVpcClassicLink) || ($.eventName=EnableVpcClassicLink)}"
      alarm_description     = "vpc changes count"
      alarm_threshold       = 1
    }
  }
}


resource "aws_securityhub_standards_control" "toggled_control" {
  for_each              = local.cis_toggled_controls
  standards_control_arn = each.value.standards_control_arn
  control_status        = each.value.control_status
  disabled_reason       = each.value.actions_enabled ? null : "Not appropriate for our usage"
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
  actions_enabled     = each.value.actions_enabled
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
  threshold           = each.value.alarm_threshold
  treat_missing_data  = "notBreaching"
}
