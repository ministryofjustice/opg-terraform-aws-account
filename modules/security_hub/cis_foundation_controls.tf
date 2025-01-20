resource "aws_securityhub_standards_control" "cis_1_14_ensure_hardware_mfa_is_enabled_for_the_root_account" {
  standards_control_arn = "${local.cis_standard_controls_arn_path}/1.14"
  control_status        = var.cis_foundation_control_1_14_enabled ? "ENABLED" : "DISABLED"
  disabled_reason       = var.cis_foundation_control_1_14_enabled ? null : "See ADR https://docs.opg.service.justice.gov.uk/documentation/adrs/adr-004.html#adr-004-no-hardware-mfa-key-for-root-account"
  depends_on = [
    aws_securityhub_account.main
  ]
}
locals {
  cis_standard_controls_arn_path             = "arn:aws:securityhub:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:control/cis-aws-foundations-benchmark/v/1.2.0"
  cis_foundation_control_3_10_custom_enabled = var.cis_foundation_control_3_10_custom_filter == "" ? false : true
  cis_controls = {
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
      control_status        = "DISABLED"
      pattern               = "{($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\") && ($.userIdentity.type = \"IAMUser\") && ($.responseElements.ConsoleLogin = \"Success\") }"
      alarm_description     = "IAM user console sign in without mfa count"
      alarm_threshold       = 1
    }
    cis_3_4_iam_policy_changes = {
      metric_name           = "CIS-3.4-IAMPolicyChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.4"
      actions_enabled       = var.cis_foundation_control_3_4_enabled
      control_status        = var.cis_foundation_control_3_4_enabled ? "ENABLED" : "DISABLED"
      pattern               = "{($.eventName=DeleteGroupPolicy) || ($.eventName=DeleteRolePolicy) || ($.eventName=DeleteUserPolicy) || ($.eventName=PutGroupPolicy) || ($.eventName=PutRolePolicy) || ($.eventName=PutUserPolicy) || ($.eventName=CreatePolicy) || ($.eventName=DeletePolicy) || ($.eventName=CreatePolicyVersion) || ($.eventName=DeletePolicyVersion) || ($.eventName=AttachRolePolicy) || ($.eventName=DetachRolePolicy) || ($.eventName=AttachUserPolicy) || ($.eventName=DetachUserPolicy) || ($.eventName=AttachGroupPolicy) || ($.eventName=DetachGroupPolicy)}"
      alarm_description     = "iam policy changes count"
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
      actions_enabled       = var.cis_foundation_control_3_8_enabled
      control_status        = var.cis_foundation_control_3_8_enabled ? "ENABLED" : "DISABLED"
      pattern               = "{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}"
      alarm_description     = "s3 bucket policy changes count"
      alarm_threshold       = 1
    }
    cis_3_9_aws_config_configuration_changes = {
      metric_name           = "CIS-3.9-AWSConfigChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.9"
      actions_enabled       = true
      control_status        = "ENABLED"
      pattern               = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
      alarm_description     = "aws config configuration changes count"
      alarm_threshold       = 1
    }
    cis_3_10_security_group_changes = {
      metric_name           = "CIS-3.10-SecurityGroupChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.10"
      actions_enabled       = var.cis_foundation_control_3_10_enabled || local.cis_foundation_control_3_10_custom_enabled ? true : false
      control_status        = var.cis_foundation_control_3_10_enabled && !local.cis_foundation_control_3_10_custom_enabled ? "ENABLED" : "DISABLED"
      pattern               = local.cis_foundation_control_3_10_custom_enabled ? var.cis_foundation_control_3_10_custom_filter : "{($.eventName=AuthorizeSecurityGroupIngress) || ($.eventName=AuthorizeSecurityGroupEgress) || ($.eventName=RevokeSecurityGroupIngress) || ($.eventName=RevokeSecurityGroupEgress) || ($.eventName=CreateSecurityGroup) || ($.eventName=DeleteSecurityGroup)}"
      alarm_description     = "aws config configuration changes count"
      alarm_threshold       = 1
    }
    cis_3_11_changes_to_network_access_control_lists = {
      metric_name           = "CIS-3.11-NetworkACLChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.11"
      actions_enabled       = var.cis_foundation_control_3_11_enabled
      control_status        = var.cis_foundation_control_3_11_enabled ? "ENABLED" : "DISABLED"
      pattern               = "{($.eventName=CreateNetworkAcl) || ($.eventName=CreateNetworkAclEntry) || ($.eventName=DeleteNetworkAcl) || ($.eventName=DeleteNetworkAclEntry) || ($.eventName=ReplaceNetworkAclEntry) || ($.eventName=ReplaceNetworkAclAssociation)}"
      alarm_description     = "aws config configuration changes count"
      alarm_threshold       = 1
    }
    cis_3_12_changes_to_network_gateways = {
      metric_name           = "CIS-3.12-NetworkGatewayChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.12"
      actions_enabled       = var.cis_foundation_control_3_12_enabled
      control_status        = var.cis_foundation_control_3_12_enabled ? "ENABLED" : "DISABLED"
      pattern               = "{($.eventName=CreateCustomerGateway) || ($.eventName=DeleteCustomerGateway) || ($.eventName=AttachInternetGateway) || ($.eventName=CreateInternetGateway) || ($.eventName=DeleteInternetGateway) || ($.eventName=DetachInternetGateway)}"
      alarm_description     = "aws config configuration changes count"
      alarm_threshold       = 1
    }
    cis_3_13_changes_to_route_tables = {
      metric_name           = "CIS-3.13-RouteTableChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.13"
      actions_enabled       = var.cis_foundation_control_3_13_enabled
      control_status        = var.cis_foundation_control_3_13_enabled ? "ENABLED" : "DISABLED"
      pattern               = "{($.eventName=CreateRoute) || ($.eventName=CreateRouteTable) || ($.eventName=ReplaceRoute) || ($.eventName=ReplaceRouteTableAssociation) || ($.eventName=DeleteRouteTable) || ($.eventName=DeleteRoute) || ($.eventName=DisassociateRouteTable)}"
      alarm_description     = "aws config configuration changes count"
      alarm_threshold       = 1
    }
    cis_3_14_vpc_changes = {
      metric_name           = "CIS-3.14-VPCChanges"
      standards_control_arn = "${local.cis_standard_controls_arn_path}/3.14"
      actions_enabled       = var.cis_foundation_control_3_14_enabled
      control_status        = var.cis_foundation_control_3_14_enabled ? "ENABLED" : "DISABLED"
      pattern               = "{($.eventName=CreateVpc) || ($.eventName=DeleteVpc) || ($.eventName=ModifyVpcAttribute) || ($.eventName=AcceptVpcPeeringConnection) || ($.eventName=CreateVpcPeeringConnection) || ($.eventName=DeleteVpcPeeringConnection) || ($.eventName=RejectVpcPeeringConnection) || ($.eventName=AttachClassicLinkVpc) || ($.eventName=DetachClassicLinkVpc) || ($.eventName=DisableVpcClassicLink) || ($.eventName=EnableVpcClassicLink)}"
      alarm_description     = "vpc changes count"
      alarm_threshold       = 1
    }
  }
  cis_metrics_only = {
    root_account_usage = {
      metric_name       = "CIS-1.1-RootAccountUsage"
      actions_enabled   = true
      pattern           = "{$.userIdentity.type=\"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType !=\"AwsServiceEvent\"}"
      alarm_description = "root login usage count"
      alarm_threshold   = 1
    }
  }
  cis_controls_only = {
    cis_2_5_config_service_role_used = {
      standards_control_arn = "${local.cis_standard_controls_arn_path}/2.5"
      control_status        = var.cis_foundation_control_2_5_enabled ? "ENABLED" : "DISABLED"
    }
  }
}


resource "aws_securityhub_standards_control" "toggled_control" {
  for_each              = merge(local.cis_controls, local.cis_controls_only)
  standards_control_arn = each.value.standards_control_arn
  control_status        = each.value.control_status
  disabled_reason       = each.value.control_status == "ENABLED" ? null : "Not appropriate for our usage"
  depends_on = [
    aws_securityhub_account.main
  ]
}

resource "aws_cloudwatch_log_metric_filter" "toggled_control" {
  for_each       = merge(local.cis_controls, local.cis_metrics_only)
  name           = each.value.metric_name
  pattern        = each.value.pattern
  log_group_name = var.aws_cloudwatch_log_group_cloudtrail_name
  metric_transformation {
    name      = each.value.metric_name
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "toggled_control" {
  for_each            = merge(local.cis_controls, local.cis_metrics_only)
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
  threshold           = each.value.alarm_threshold
  treat_missing_data  = "notBreaching"
}

moved {
  from = aws_cloudwatch_log_metric_filter.toggled_control["cis_1_1_root_account_usage"]
  to   = aws_cloudwatch_log_metric_filter.toggled_control["root_account_usage"]
}

moved {
  from = aws_cloudwatch_metric_alarm.toggled_control["cis_1_1_root_account_usage"]
  to   = aws_cloudwatch_metric_alarm.toggled_control["root_account_usage"]
}
