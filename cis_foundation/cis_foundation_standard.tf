data "aws_cloudwatch_log_group" "cloudtrail" {
  name = var.aws_cloudwatch_log_group_cloudtrail_name
}

resource "aws_cloudwatch_log_metric_filter" "root_account_usage" {
  name           = "CIS-1.1-RootAccountUsage"
  pattern        = "{$.userIdentity.type=\"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType !=\"AwsServiceEvent\"}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "CIS-1.1-RootAccountUsag"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "root_account_usage" {
  actions_enabled     = true
  alarm_name          = "CIS-1.1-RootAccountUsage"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "root login usage count"
  namespace           = "CISLogMetrics"
  metric_name         = "CIS-1.1-RootAccountUsag"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "unauthorised_api_calls" {
  name           = "CIS-3.1-UnauthorizedAPICalls"
  pattern        = "{($.errorCode=\"*UnauthorizedOperation\") || ($.errorCode=\"AccessDenied*\")}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "CIS-3.1-UnauthorizedAPICalls"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "unauthorised_api_calls" {
  actions_enabled     = true
  alarm_name          = "CIS-3.1-UnauthorizedAPICalls"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "unauthorised api call"
  namespace           = "CISLogMetrics"
  metric_name         = "CIS-3.1-UnauthorizedAPICalls"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Average"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "console_sign_in_without_mfa" {
  name           = "CIS-3.2-ConsoleSigninWithoutMFA"
  pattern        = "{($.eventName=\"ConsoleLogin\") && ($.additionalEventData.MFAUsed !=\"Yes\")}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "CIS-3.2-ConsoleSigninWithoutMFA"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "console_sign_in_without_mfa" {
  actions_enabled     = true
  alarm_name          = "CIS-3.2-ConsoleSigninWithoutMFA"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "console sign in without mfa count"
  namespace           = "CISLogMetrics"
  metric_name         = "CIS-3.2-ConsoleSigninWithoutMFA"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "console_authentication_failure" {
  name           = "CIS-3.6-ConsoleAuthenticationFailure"
  pattern        = "{($.eventName=ConsoleLogin) && ($.errorMessage=\"Failed authentication\")}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "CIS-3.6-ConsoleAuthenticationFailure"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "console_authentication_failure" {
  actions_enabled     = true
  alarm_name          = "CIS-3.6-ConsoleAuthenticationFailure"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "console sign in without mfa count"
  namespace           = "CISLogMetrics"
  metric_name         = "CIS-3.6-ConsoleAuthenticationFailure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "cloudtrail_configuration_changes" {
  name           = "CIS-3.5-CloudTrailChanges"
  pattern        = "{($.eventName=CreateTrail) || ($.eventName=UpdateTrail) || ($.eventName=DeleteTrail) || ($.eventName=StartLogging) || ($.eventName=StopLogging)}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "CIS-3.5-CloudTrailChanges"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "cloudtrail_configuration_changes" {
  actions_enabled     = true
  alarm_name          = "CIS-3.5-CloudTrailChanges"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "cloudtrail configuration changes count"
  namespace           = "CISLogMetrics"
  metric_name         = "CIS-3.5-CloudTrailChanges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "aws_config_configuration_changes" {
  name           = "CIS-3.9-AWSConfigChanges"
  pattern        = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "CIS-3.9-AWSConfigChanges"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "aws_config_configuration_changes" {
  actions_enabled     = true
  alarm_name          = "CIS-3.9-AWSConfigChanges"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "aws config configuration changes count"
  namespace           = "CISLogMetrics"
  metric_name         = "CIS-3.9-AWSConfigChanges"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "disabling_or_scheduled_deletion_of_cmk" {
  name           = "CIS-3.7-DisableOrDeleteCMK"
  pattern        = "{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "CIS-3.7-DisableOrDeleteCMK"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "disabling_or_scheduled_deletion_of_cmk" {
  actions_enabled     = true
  alarm_name          = "CIS-3.7-DisableOrDeleteCMK"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "disabling or scheduled deletion of customer managed keys count"
  namespace           = "CISLogMetrics"
  metric_name         = "CIS-3.7-DisableOrDeleteCMK"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}
